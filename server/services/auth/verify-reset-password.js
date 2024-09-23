import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const verifyResetPassword = async (req, res) => {
  const { verificationCode, employeeEmail } = req.body;

  if (!verificationCode || !employeeEmail) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const employee = await prisma.employee.findUnique({
    where: { employeeEmail },
  });

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  if (employee.verificationCode !== verificationCode) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid verification code');
  }

  // update employee reset code
  await prisma.employee.update({
    where: { employeeEmail },
    data: {
      verificationCode: null,
    },
  });

  return responseHandler(res, 200, 'success', 'Verification Successful', null);
};

export default verifyResetPassword;
