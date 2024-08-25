import { PrismaClient } from '@prisma/client';
import signToken from '../../helper/jwt-sign-token.js';
import { comparePassword } from '../../helper/password.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handlers.js';
import { parseDuration } from '../../utils/parse-duration.js';

const prisma = new PrismaClient();

export const masterAdminLogin = async (req, res) => {
  const { masterOfficeAdminEmail, masterOfficeAdminPassword } = req.body;

  if (!masterOfficeAdminEmail || !masterOfficeAdminPassword) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const masterOfficeAdmin = await prisma.masterOfficeAdmin.findFirst({
    where: { masterOfficeAdminEmail },
  });

  if (!masterOfficeAdmin) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid email or password');
  }

  const isPasswordCorrect = await comparePassword(
    masterOfficeAdminPassword,
    masterOfficeAdmin.masterOfficeAdminPassword
  );

  if (!isPasswordCorrect) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid email or password');
  }

  const token = signToken({ id: masterOfficeAdmin.id });

  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
  // Set the token in a cookie
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  responseHandler(res, 200, 'success', {
    token,
    id: masterOfficeAdmin.id,
    masterOfficeAdminName: masterOfficeAdmin.masterOfficeAdminName,
    masterOfficeAdminEmail: masterOfficeAdmin.masterOfficeAdminEmail,
  });
};
