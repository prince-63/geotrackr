import jwt from 'jsonwebtoken';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const protect = async (req, res, next) => {
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    token = req.headers.authorization.split(' ')[1];
  }

  if (!token) {
    return res
      .status(401)
      .json({ status: 'fail', message: 'You are not logged in!' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const currentUser = await prisma.inOfficeEmployee.findUnique({
      where: { employeeId: decoded.id },
    });
    if (!currentUser) {
      return res.status(401).json({
        status: 'fail',
        message: 'The user belonging to this token does no longer exist.',
      });
    }

    console.log(currentUser);
    req.user = currentUser;
    next();
  } catch (error) {
    res.status(401).json({ status: 'fail', message: 'Invalid token!' });
  }
};
