import { PrismaClient } from '@prisma/client';
import { errorResponseHandler, responseHandler } from '../helper/error.js';

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
