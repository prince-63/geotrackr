import { prisma } from '../../database/prisma-config.js';
import { hashPassword } from '../../helper/password.js';
import signToken from '../../helper/jwt-sign-token.js';
import { parseDuration } from '../../utils/parse-duration.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const officeSignup = async (req, res) => {
  const { officeName, officeEmail, officePassword } = req.body;

  if (!officeName || !officeEmail || !officePassword) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const existingOffice = await prisma.office.findUnique({
    where: { officeEmail },
  });

  if (existingOffice) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Office with that email already exists'
    );
  }

  const hashedPassword = await hashPassword(officePassword);

  let office;
  try {
    office = await prisma.office.create({
      data: {
        officeName,
        officeEmail,
        officePassword: hashedPassword,
      },
    });
  } catch (error) {
    console.log(error);
    return errorResponseHandler(res, 500, 'fail', 'Internal Server Error');
  }

  const token = signToken({ id: office.officeId });

  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 201, 'success', 'Signup Successful.', {
    token,
  });
};

export default officeSignup;
