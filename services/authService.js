import { PrismaClient } from '@prisma/client';
import { sendEmail } from '../helper/email.js';
import {
  hashPassword,
  signToken,
  comparePassword,
  createPasswordResetToken,
} from '../helper/auth.js';
import { signupSchema, loginSchema } from '../helper/validator.js';
import crypto from 'crypto';
import jwt from 'jsonwebtoken';
import { promisify } from 'util';
import redisClient from '../redis/redisClient.js';

const prisma = new PrismaClient();

export const signup = async (req, res) => {
  try {
    // Validate request body against signup schema
    const { error } = signupSchema.validate(req.body);
    if (error) {
      return res
        .status(400)
        .json({ status: 'fail', message: error.details[0].message });
    }

    const { name, password, email } = req.body;

    // Hash the user's password
    const hashedPassword = await hashPassword(password);
    // Generate a random email verification code
    const emailVerificationCode = Math.floor(
      100000 + Math.random() * 900000
    ).toString();

    // Create a new user in the database
    const newUser = await prisma.user.create({
      data: {
        name,
        password: hashedPassword,
        email,
        emailVerificationCode,
      },
    });

    // Send email verification code to the user's email
    const subject = 'Email Verification';
    const message = `Your email verification code is ${emailVerificationCode}`;
    await sendEmail({ email, subject, message });

    // Sign a JWT token for the new user
    const token = signToken(newUser.id);
    res.status(201).json({
      status: 'success',
      token,
      data: {
        email: newUser.name,
        email: newUser.email,
      },
    });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  } finally {
    // Disconnect Prisma client
    await prisma.$disconnect();
  }
};

export const login = async (req, res) => {
  try {
    // Validate request body against login schema
    const { error } = loginSchema.validate(req.body);
    if (error) {
      return res
        .status(400)
        .json({ status: 'fail', message: error.details[0].message });
    }

    const { email, password } = req.body;

    // Find user by email
    const user = await prisma.user.findUnique({ where: { email } });

    // Check if user exists and password is correct
    if (!user || !(await comparePassword(password, user.password))) {
      return res
        .status(401)
        .json({ status: 'fail', message: 'Incorrect username or password' });
    }

    // Sign a JWT token for the authenticated user
    const token = signToken(user.id);
    res.status(200).json({ status: 'success', token });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  } finally {
    // Disconnect Prisma client
    await prisma.$disconnect();
  }
};

export const logout = async (req, res) => {
  try {
    if (!req.headers.authorization) {
      return res
        .status(401)
        .json({ status: 'fail', message: 'You are not logged in' });
    }

    // Invalidate the token by adding it to a blacklist
    const token = req.headers.authorization.split(' ')[1];
    const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);
    await redisClient.set(
      `blacklist_${decoded.id}`,
      token,
      'EX',
      process.env.JWT_EXPIRES_IN
    );

    // Clear the cookie
    res.cookie('jwt', 'loggedout', {
      expires: new Date(Date.now() + 10 * 1000),
      httpOnly: true,
    });

    // Destroy the session if using sessions
    if (req.session) {
      req.session.destroy((err) => {
        if (err) {
          return res
            .status(400)
            .json({ status: 'fail', message: 'Failed to destroy session' });
        }
        return res.status(200).json({ status: 'success', token: null });
      });
    } else {
      // If no session, still return success after clearing the cookie and invalidating the token
      return res.status(200).json({ status: 'success', token: null });
    }
  } catch (error) {
    console.log(error.message);
    res.status(400).json({ status: 'fail', message: error.message });
  }
};

export const verifyEmail = async (req, res) => {
  try {
    const { code } = req.body;
    const user = req.user;

    if (!code) {
      return res
        .status(400)
        .json({ status: 'fail', message: 'Verification code is required' });
    }

    if (!user) {
      return res
        .status(401)
        .json({ status: 'fail', message: 'User not authenticated' });
    }

    if (user.emailVerificationCode === code) {
      await prisma.user.update({
        where: { id: user.id },
        data: {
          emailVerified: true,
          emailVerificationCode: null,
        },
      });
      res.status(200).json({ status: 'success', message: 'Email verified' });
    } else {
      res
        .status(400)
        .json({ status: 'fail', message: 'Invalid verification code' });
    }
  } catch (error) {
    res.status(500).json({ status: 'fail', message: 'Internal server error' });
  } finally {
    await prisma.$disconnect();
  }
};

export const forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;

    if (!email) {
      return res
        .status(400)
        .json({ status: 'fail', message: 'Email is required' });
    }

    const user = await prisma.user.findUnique({ where: { email } });

    if (!user) {
      return res.status(404).json({
        status: 'fail',
        message: 'There is no user with that email address.',
      });
    }

    const { resetToken, hashedToken, resetTokenExpires } =
      createPasswordResetToken();

    await prisma.user.update({
      where: { id: user.id },
      data: {
        passwordResetToken: hashedToken,
        passwordResetExpires: resetTokenExpires,
      },
    });

    const resetURL = `${req.protocol}://${req.get('host')}/api/v1/auth/resetPassword/${resetToken}`;
    const message = `Forgot your password? Submit a PATCH request with your new password and passwordConfirm to: ${resetURL}.\nIf you didn't forget your password, please ignore this email!`;

    await sendEmail({
      email: user.email,
      subject: 'Your password reset token (valid for 10 minutes)',
      message,
    });

    res
      .status(200)
      .json({ status: 'success', message: 'Token sent to email!' });
  } catch (error) {
    res.status(500).json({
      status: 'fail',
      message: 'There was an error sending the email. Try again later!',
    });
  }
};

export const resetPassword = async (req, res) => {
  try {
    const token = req.params.token;
    const password = req.body.password;

    if (password.length < 8 || !password) {
      return res.status(400).json({
        status: 'fail',
        message: 'Password must be at least 8 characters',
      });
    }

    if (!token) {
      return res
        .status(400)
        .json({ status: 'fail', message: 'Token is required' });
    }

    const hashedToken = crypto.createHash('sha256').update(token).digest('hex');
    const user = await prisma.user.findFirst({
      where: {
        passwordResetToken: hashedToken,
        passwordResetExpires: { gt: new Date() },
      },
    });

    if (!user) {
      return res
        .status(400)
        .json({ status: 'fail', message: 'Token is invalid or has expired' });
    }

    const hashedPassword = await hashPassword(password);

    await prisma.user.update({
      where: { id: user.id },
      data: {
        password: hashedPassword,
        passwordResetToken: null,
        passwordResetExpires: null,
      },
    });

    const newToken = signToken(user.id);
    res.status(200).json({ status: 'success', token: newToken });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};
