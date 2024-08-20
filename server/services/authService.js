import { PrismaClient } from '@prisma/client';
import { sendEmail } from '../helper/email.js';
import { hashPassword, signToken, comparePassword } from '../helper/auth.js';
import jwt from 'jsonwebtoken';
import { promisify } from 'util';
import redisClient from '../redis/redisClient.js';
import { errorResponseHandler, responseHandler } from '../helper/error.js';
import { parseDuration } from '../helper/parseDuration.js';
import { deleteImageFromCloudinary } from './cloudinaryService.js';

const prisma = new PrismaClient();

export const signup = async (req, res) => {
  const { username, password, email } = req.body;

  if (!username) {
    return errorResponseHandler(res, 400, 'fail', 'Username is required');
  }

  if (!email) {
    return errorResponseHandler(res, 400, 'fail', 'Email is required');
  }

  if (!password) {
    return errorResponseHandler(res, 400, 'fail', 'Password is required');
  }

  if (password.length < 8) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Password must be at least 8 characters'
    );
  }

  const existingUser = await prisma.user.findUnique({
    where: { email },
  });

  if (existingUser) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'User with that email already exists'
    );
  }

  const existingUsername = await prisma.user.findUnique({
    where: { username },
  });

  let user;
  if (existingUsername) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'User with that username already exists'
    );
  }

  const hashedPassword = await hashPassword(password);

  const emailVerificationCode = Math.floor(
    100000 + Math.random() * 900000
  ).toString();

  try {
    user = await prisma.user.create({
      data: {
        username,
        email,
        password: hashedPassword,
        emailVerificationCode,
      },
    });
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', error.message);
  } finally {
    await prisma.$disconnect();
  }

  const subject = 'Email Verification Code';
  const message = `Your email verification code is ${emailVerificationCode}`;

  try {
    await sendEmail({ email, subject, message });
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', error.message);
  }

  const token = signToken(user.id);
  // Parse JWT_COOKIE_EXPIRES_IN to milliseconds
  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
  // Set the token in a cookie
  res.cookie('jwt', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });
  return responseHandler(
    res,
    200,
    'success',
    'User created. Check your email for verification code',
    { token: token, email: user.email }
  );
};

export const login = async (req, res) => {
  const { email, username, password } = req.body;

  if (!email && !username) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'An email or username is required'
    );
  }

  if (password.length < 8) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Password must be at least 8 characters'
    );
  }

  let user;
  if (username) {
    user = await prisma.user.findUnique({ where: { username } });
    if (!user) {
      return errorResponseHandler(
        res,
        404,
        'fail',
        'There is no user with that username'
      );
    }
  } else if (email) {
    user = await prisma.user.findUnique({ where: { email } });
    if (!user) {
      return errorResponseHandler(
        res,
        404,
        'fail',
        'There is no user with that email'
      );
    }
  }

  const isMatch = await comparePassword(password, user.password);
  if (isMatch) {
    const token = signToken(user.id);
    // Parse JWT_COOKIE_EXPIRES_IN to milliseconds
    const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
    // Set the token in a cookie
    res.cookie('jwt', token, {
      expires: new Date(Date.now() + cookieExpiresInMs),
      httpOnly: true,
    });
    return responseHandler(res, 200, 'success', 'Logged in', {
      token: token,
      email: user.email,
    });
  } else {
    return errorResponseHandler(res, 400, 'fail', 'Incorrect password');
  }
};

export const logout = async (req, res) => {
  try {
    if (!req.headers.authorization) {
      return errorResponseHandler(res, 401, 'fail', 'You are not logged in');
    }

    // Invalidate the token by adding it to a blacklist
    const token = req.headers.authorization.split(' ')[1];
    const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);
    const expireIn = parseDuration(process.env.JWT_EXPIRES_IN);
    await redisClient.set(`blacklist_${decoded.id}`, token, 'EX', expireIn);

    // Clear the cookie
    res.cookie('jwt', 'loggedout', {
      expires: new Date(Date.now() + 10 * 1000),
      httpOnly: true,
    });

    // Destroy the session if using sessions
    if (req.session) {
      req.session.destroy((err) => {
        if (err) {
          return errorResponseHandler(
            res,
            400,
            'fail',
            'Failed to destroy session'
          );
        }
        return responseHandler(res, 200, 'success', 'Logged out', null);
      });
    } else {
      // If no session, still return success after clearing the cookie and invalidating the token
      return responseHandler(res, 200, 'success', 'Logged out', null);
    }
  } catch (error) {
    return errorResponseHandler(res, 400, 'fail', error.message);
  }
};

export const closeAccount = async (req, res) => {
  const user = req.user;

  if (!user) {
    return errorResponseHandler(res, 401, 'fail', 'You are not logged in');
  }

  try {
    // Extract image ID from Cloudinary URL and delete image
    if (user.imageUrl) {
      const imageId = extractImageIdFromUrl(user.imageUrl);
      await deleteImageFromCloudinary(imageId);
    }

    // Delete user from database
    await prisma.user.delete({ where: { id: user.id } });

    return responseHandler(res, 200, 'success', 'Account deleted', null);
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', error.message);
  } finally {
    await prisma.$disconnect();
  }
};

// Utility function to extract image ID from Cloudinary URL
const extractImageIdFromUrl = (url) => {
  const parts = url.split('/');
  const lastPart = parts[parts.length - 1];
  const [imageId] = lastPart.split('.');
  return imageId;
};
