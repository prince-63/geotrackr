import userDecryptedId from '../helper/userDecryptedId.js';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const SetAttendance = async (req, res) => {
  const encodedText = req.body.encodedText;

  if (!encodedText) {
    return res.status(400).json({
      status: 'fail',
      message: 'Please provide encodedText',
    });
  }

  try {
    const decoded = userDecryptedId(encodedText);

    console.log(decoded);

    const currentUser = await prisma.user.findUnique({
      where: { email: decoded },
    });

    if (!currentUser) {
      return res.status(401).json({
        status: 'fail',
        message: 'The user belonging to this token does no longer exist.',
      });
    }

    const attendance = await prisma.attendance.create({
      data: {
        user: {
          connect: {
            id: currentUser.id,
          },
        },
        date: new Date(),
        status: 'PRESENT',
      },
    });

    res.status(200).json({
      status: 'success',
      data: {
        attendance,
      },
    });
  } catch (error) {
    res.status(401).json({ status: 'fail', message: error.message });
  }
};
