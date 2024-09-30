import { prisma } from '../../database/prisma-config.js';
import { comparePassword } from '../../helper/password.js';
import signToken from '../../helper/jwt-sign-token.js';
import { parseDuration } from '../../utils/parse-duration.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const loginEmployee = async (req, res) => {
  const employeeEmail = req.body.email;
  const employeePassword = req.body.password;

  if (!employeeEmail || !employeePassword) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const employee = await prisma.employee.findUnique({
    where: { employeeEmail },
    include: {
      Attendances: true, // Include attendances
    },
  });

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  const roles = await prisma.employeeRole.findMany({
    where: {
      employeeId: employee.employeeId,
    },
  });

  const roleNames = await Promise.all(
    roles.map(async (role) => {
      const employeeRole = await prisma.role.findUnique({
        where: {
          roleId: role.roleId,
        },
      });
      return employeeRole.roleName;
    })
  );

  const isPasswordMatch = await comparePassword(
    employeePassword,
    employee.employeePassword
  );

  if (!isPasswordMatch) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid credentials');
  }

  const token = signToken(employee.employeeId);

  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 200, 'success', 'login successful', {
    token: token,
    employee: {
      employeeId: employee.employeeId,
      employeeName: employee.employeeName,
      employeeEmail: employee.employeeEmail,
      employeeContactNumber: employee.employeeContactNumber,
      roles: roleNames,
      employeeProfileImageUrl: employee.employeeProfileImageUrl,
      isVerified: employee.isVerified,
      biometricEnabled: employee.biometricEnabled,
      attendances: employee.Attendances,
      officeId: employee.officeId,
    },
  });
};

export default loginEmployee;
