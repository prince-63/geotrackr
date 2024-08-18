import { PrismaClient } from '@prisma/client';
import { sendEmail } from '../helper/email.js';
import { hashPassword } from '../helper/auth.js';
import { errorResponseHandler, responseHandler } from '../helper/error.js';

const prisma = new PrismaClient();

export const forgotPassword = async (req, res) => {
  const { email, username } = req.body;

  if (!email && !username) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'An email or username is required'
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

  const passwordResetVerificationCode = Math.floor(
    100000 + Math.random() * 900000
  ).toString();

  try {
    await prisma.user.update({
      where: { id: user.id },
      data: {
        passwordResetVerificationCode,
      },
    });
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', error.message);
  } finally {
    await prisma.$disconnect();
  }

  const subject = 'Password Reset Verification Code';
  const message = `Your password reset verification code is ${passwordResetVerificationCode}`;

  try {
    await sendEmail({ email: user.email, subject, message });
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', error.message);
  }

  return responseHandler(
    res,
    200,
    'success',
    'Password reset verification code sent to email!',
    null
  );
};

export const resetPasswordVerification = async (req, res) => {
  const { email, username, verificationCode } = req.body;

  console.log(email, username, verificationCode);

  if (!email && !username) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'An email or username is required'
    );
  }

  if (!verificationCode) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Verification code is required'
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

  if (
    !compareVerificationCode(
      verificationCode,
      user.passwordResetVerificationCode
    )
  ) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid verification code');
  }

  try {
    await prisma.user.update({
      where: { id: user.id },
      data: {
        passwordResetVerificationCode: null,
      },
    });
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', error.message);
  } finally {
    await prisma.$disconnect();
  }

  return responseHandler(res, 200, 'success', 'Verification Successful.', null);
};

export const setNewPassword = async (req, res) => {
  const { email, username, password } = req.body;

  if (!email && !username) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'An email or username is required'
    );
  }

  if (!password) {
    return errorResponseHandler(res, 400, 'fail', 'new password is required');
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

  const hashedPassword = await hashPassword(password);

  try {
    await prisma.user.update({
      where: { id: user.id },
      data: {
        password: hashedPassword,
      },
    });
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', error.message);
  } finally {
    await prisma.$disconnect();
  }

  return responseHandler(res, 200, 'success', 'New Password Added!', null);
};

function compareVerificationCode(str1, str2) {
  return str1 === str2;
}
