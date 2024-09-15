import { prisma } from '../../database/prisma-config.js';
import signToken from '../../helper/jwt-sign-token.js';
import { comparePassword } from '../../helper/password.js';
import { parseDuration } from '../../utils/parse-duration.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const officeLogin = async (req, res) => {
  const { officeEmail, officePassword } = req.body;

  if (!officeEmail || !officePassword) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const office = await prisma.office.findUnique({
    where: { officeEmail },
  });

  if (!office) {
    return errorResponseHandler(res, 401, 'fail', 'Invalid email or password');
  }

  const isPasswordCorrect = await comparePassword(
    officePassword,
    office.officePassword
  );

  if (!isPasswordCorrect) {
    return errorResponseHandler(res, 401, 'fail', 'Invalid email or password');
  }

  const token = signToken({ id: office.officeId });

  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 200, 'success', 'Login Successful.', {
    token,
  });
};

export default officeLogin;
