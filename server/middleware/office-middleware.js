import jwt from 'jsonwebtoken';
import { PrismaClient } from '@prisma/client';
import errorResponseHandler from '../handlers/error-response-handlers.js';

const prisma = new PrismaClient();

const officeMiddleware = async (req, res, next) => {
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    token = req.headers.authorization.split(' ')[1];
  }

  //console.log(token);

  if (!token) {
    return errorResponseHandler(res, 401, 'fail', 'Not authorized to access this route');
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    if (!decoded.id) {
      return errorResponseHandler(res, 401, 'fail', 'Invalid token payload');
    }

    const office = await prisma.office.findUnique({
      where: { officeId: decoded.id.id },
    });

    //console.log(office);

    if (!office) {
      return errorResponseHandler(res, 401, 'fail', 'No office found with this id');
    }

    req.office = office;
    next();
  } catch (error) {
    if (error.name === 'JsonWebTokenError') {
      return errorResponseHandler(res, 401, 'fail', 'Invalid token');
    }
    next(error);
  }
};

export default officeMiddleware;