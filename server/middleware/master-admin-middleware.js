import jwt from 'jsonwebtoken';
import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

const masterAdminMiddleware = async (req, res, next) => {
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
      .json({ status: 'fail', message: 'Access denied. No token provided.' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    //console.log(decoded);

    const masterOfficeAdmin = await prisma.masterOfficeAdmin.findUnique({
      where: { id: decoded.id.id },
    });

    //console.log(masterOfficeAdmin);

    if (!masterOfficeAdmin) {
      return res
        .status(400)
        .json({ status: 'fail', message: 'Invalid token.' });
    }

    if (masterOfficeAdmin.role !== 'MASTER_ADMIN') {
      return res
        .status(403)
        .json({
          status: 'fail',
          message: 'Access denied. You do not have the required role.',
        });
    }

    req.masterOfficeAdmin = masterOfficeAdmin;
    next();
  } catch (error) {
    next(error);
  }
};

export default masterAdminMiddleware;
