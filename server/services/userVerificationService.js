import { PrismaClient } from '@prisma/client';
import { errorResponseHandler, responseHandler } from '../helper/error.js';
import { sendEmail } from '../helper/email.js';

const prisma = new PrismaClient();

export const verifyEmail = async (req, res) => {
  try {
    const { code } = req.body;
    const user = req.user;

    if (!code) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Verification code is required'
      );
    }

    if (!user) {
      return errorResponseHandler(res, 401, 'fail', 'User not authenticated');
    }

    if (user.emailVerificationCode === code) {
      await prisma.user.update({
        where: { id: user.id },
        data: {
          emailVerified: true,
          emailVerificationCode: null,
        },
      });
      return responseHandler(res, 200, 'success', 'Email verified', null);
    } else {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Invalid verification code'
      );
    }
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', 'Internal server error');
  } finally {
    await prisma.$disconnect();
  }
};

export const resendVerificationEmail = async (req, res) => {
  const user = req.user;

  if (!user) {
    return errorResponseHandler(res, 401, 'fail', 'User not authenticated');
  }

  if (user.emailVerified) {
    return errorResponseHandler(res, 400, 'fail', 'Email already verified');
  }

  try {
    const emailVerificationCode = Math.floor(
      100000 + Math.random() * 900000
    ).toString();

    console.log(emailVerificationCode);

    try {
      await prisma.user.update({
        where: { id: user.id },
        data: { emailVerificationCode: emailVerificationCode },
      });
    } catch (error) {
      console.log(error.message);
      return errorResponseHandler(
        res,
        500,
        'fail',
        'Failed to update email verification code'
      );
    }

    const subject = 'Email Verification';
    const message = `Your verification code is ${emailVerificationCode}`;

    // Log the user email
    console.log(`Sending email to: ${user.email}`);

    // Validate user email
    if (!user.email) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'User email is not defined'
      );
    }

    try {
      await sendEmail(user.email, subject, message);
    } catch (error) {
      console.log(error.message);
      return errorResponseHandler(res, 500, 'fail', 'Failed to send email');
    }

    return responseHandler(
      res,
      200,
      'success',
      'Verification email sent',
      null
    );
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', 'Internal server error');
  } finally {
    await prisma.$disconnect();
  }
};
