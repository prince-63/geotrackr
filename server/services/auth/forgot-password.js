import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';
import { sendEmail } from '../../utils/email.js';

const forgotPassword = async (req, res) => {
  const { employeeEmail } = req.body;

  if (!employeeEmail) {
    return errorResponseHandler(res, 400, 'fail', 'Please provide your email');
  }

  const employee = await prisma.employee.findUnique({
    where: { employeeEmail },
  });

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  // generate 6 digit random number
  const resetCode = Math.floor(100000 + Math.random() * 900000);

  // update employee reset code
  await prisma.employee.update({
    where: { employeeEmail },
    data: {
      verificationCode: resetCode.toString(),
    },
  });

  // send email
  const subject = 'Reset Password';
  const message = `Your reset code is ${resetCode}`;

  try {
    await sendEmail({ email: employeeEmail, subject, message });
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', 'Error sending email');
  }

  return responseHandler(
    res,
    200,
    'success',
    'Reset code sent to your email',
    null
  );
};

export default forgotPassword;
