import { PrismaClient } from '@prisma/client';
import { errorResponseHandler, responseHandler } from '../helper/error.js';
import userDecryptedId from '../helper/userDecryptedId.js';

const prisma = new PrismaClient();

export const checkIn = async (req, res) => {
  const user = req.user;
  const qrText = req.body.qrText;

  if (!user) {
    return errorResponseHandler(res, 401, 'fail', 'Unauthorized');
  }

  if (!qrText) {
    return errorResponseHandler(res, 400, 'fail', 'QR Code is required');
  }

  const email = userDecryptedId(qrText);
  try {
    const dbUser = await prisma.user.findUnique({
      where: {
        email: email,
      },
    });

    if (user.email != dbUser.email) {
      return errorResponseHandler(res, 403, 'fail', 'Forbidden');
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const existingAttendance = await prisma.attendance.findFirst({
      where: {
        userId: dbUser.id,
        checkInTime: {
          gte: today,
        },
      },
    });

    if (existingAttendance) {
      return errorResponseHandler(res, 400, 'fail', 'Attendance already marked for today');
    }

    await prisma.attendance.create({
      data: {
        userId: dbUser.id,
        checkInTime: new Date(),
        status: 'PRESENT',
      },
    });

    return responseHandler(res, 200, 'success', 'Attendance checked in', null);
  } catch (error) {
    return errorResponseHandler(res, 500, error.message);
  }
};

export const checkOut = async (req, res) => {
  const user = req.user;
  const qrText = req.body.qrText;

  if (!user) {
    return errorResponseHandler(res, 401, 'fail', 'Unauthorized');
  }

  if (!qrText) {
    return errorResponseHandler(res, 400, 'fail', 'QR Code is required');
  }

  const email = userDecryptedId(qrText);
  try {
    const dbUser = await prisma.user.findUnique({
      where: {
        email: email,
      },
    });

    if (user.email != dbUser.email) {
      return errorResponseHandler(res, 401, 'fail', 'Unauthorized');
    }

    const attendance = await prisma.attendance.findFirst({
      where: {
        userId: dbUser.id,
        checkOutTime: null,
      },
    });

    if (!attendance) {
      return errorResponseHandler(res, 400, 'fail', 'Check in first');
    }

    await prisma.attendance.update({
      where: {
        id: attendance.id,
      },
      data: {
        checkOutTime: new Date(),
        status: 'PRESENT',
      },
    });

    return responseHandler(res, 200, 'success', 'Attendance checked out', null);
  } catch (error) {
    return errorResponseHandler(res, 500, error.message);
  }
};

export const getUserAttendance = (req, res) => {
  const user = req.user;

  if (!user) {
    return errorResponseHandler(res, 401, 'fail', 'Unauthorized');
  }

  prisma.attendance
    .findMany({
      where: {
        userId: user.id,
        // checkOutTime: {
        //   not: null,
        // },
        // checkInTime: {
        //   not: null,
        // },
      },
    })
    .then((attendance) => {
      return responseHandler(
        res,
        200,
        'success',
        'User attendance',
        attendance
      );
    })
    .catch((error) => {
      return errorResponseHandler(res, 500, error.message);
    });
};
