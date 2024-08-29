import jwt from 'jsonwebtoken';
import { PrismaClient } from '@prisma/client';
import errorResponseHandler from '../handlers/error-response-handlers.js';

const prisma = new PrismaClient();

const inOfficeEmployeeMiddleware = async (req, res, next) => {
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    token = req.headers.authorization.split(' ')[1];
  }

  if (!token) {
    return errorResponseHandler(res, 401, 'Not authorized to access this route');
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    //console.log(decoded);

    const inOfficeEmployee = await prisma.inOfficeEmployee.findUnique({
      where: {
        employeeId: decoded.id.id,
      },
    });

    //console.log(inOfficeEmployee);

    if (!inOfficeEmployee) {
      return errorResponseHandler(res, 401, 'No user found with this id');
    }

    req.inOfficeEmployee = inOfficeEmployee;
    next();
  } catch (error) {
    return errorResponseHandler(res, 401, 'Not authorized to access this route');
  }
};

export default inOfficeEmployeeMiddleware;