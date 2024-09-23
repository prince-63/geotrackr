import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';
import { hashPassword } from '../../helper/password.js';

const setNewPassword = async (req, res) => {
  const { employeePassword, employeeEmail } = req.body;

  if (!employeePassword || !employeeEmail) {
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

  // hash password
  const hashedPassword = await hashPassword(employeePassword);

  // update employee password
  await prisma.employee.update({
    where: { employeeEmail },
    data: {
      employeePassword: hashedPassword,
    },
  });

  return responseHandler(
    res,
    200,
    'success',
    'Password updated successfully',
    null
  );
};

export default setNewPassword;
