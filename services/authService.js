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

const prisma = new PrismaClient();

export const signup = async (req, res) => {
  try {
    const { error } = signupSchema.validate(req.body);
    if (error) {
      return res
        .status(400)
        .json({ status: 'fail', message: error.details[0].message });
    }

    const { name, password, email } = req.body;

    const hashedPassword = await hashPassword(password);
    const emailVerificationCode = Math.floor(
      100000 + Math.random() * 900000
    ).toString();

    const newUser = await prisma.user.create({
      data: {
        name,
        password: hashedPassword,
        email,
        emailVerificationCode,
      },
    });

    const subject = 'Email Verification';
    const message = `Your email verification code is ${emailVerificationCode}`;
    await sendEmail({ email, subject, message });

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
    await prisma.$disconnect();
  }
};

export const login = async (req, res) => {
  try {
    const { error } = loginSchema.validate(req.body);
    if (error) {
      return res
        .status(400)
        .json({ status: 'fail', message: error.details[0].message });
    }

    const { email, password } = req.body;

    const user = await prisma.user.findUnique({ where: { email } });

    if (!user || !(await comparePassword(password, user.password))) {
      return res
        .status(401)
        .json({ status: 'fail', message: 'Incorrect username or password' });
    }

    const token = signToken(user.id);
    res.status(200).json({ status: 'success', token });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  } finally {
    await prisma.$disconnect();
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
      return res
        .status(400)
        .json({
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
