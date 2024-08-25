import { PrismaClient } from '@prisma/client';
import defaultPasswordGenerator from '../../helper/default-password-generator.js';
import { hashPassword, comparePassword } from '../../helper/password.js';
import signToken from '../../helper/jwt-sign-token.js';
import { sendEmail } from '../../utils/email.js';
import { parseDuration } from '../../utils/parse-duration.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handlers.js';

const prisma = new PrismaClient();

export const createNewInOfficeEmployee = async (req, res) => {
  const { employeeName, employeeEmail, employeeContactNumber } = req.body;

  const officeId = req.user.officeId;

  if (!employeeName || !employeeEmail || !employeeContactNumber || !officeId) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const existingEmployee = await prisma.inOfficeEmployee.findFirst({
    where: { employeeEmail },
  });

  if (existingEmployee) {
    return errorResponseHandler(res, 400, 'fail', 'Employee already exists');
  }

  const defaultPassword = defaultPasswordGenerator();
  const hashedPassword = await hashPassword(defaultPassword);

  let newEmployee;
  try {
    newEmployee = await prisma.inOfficeEmployee.create({
      data: {
        employeeName,
        employeeEmail,
        employeeContactNumber,
        employeePassword: hashedPassword,
        officeId,
      },
    });

    const message = `Hello ${employeeName},\n\nYour account has been created successfully.\n\nEmail: ${employeeEmail}\nPassword: ${defaultPassword}\n\nPlease login to your account and update your password.\n\nThank you.`;
    const subject = 'Account Created Successfully';
    await sendEmail({ email: employeeEmail, message, subject });
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', 'Something went wrong');
  }

  return responseHandler(res, 201, 'success', 'Employee created successfully', {
    employeeId: newEmployee.employeeId,
    employeeName: newEmployee.employeeName,
    employeeEmail: newEmployee.employeeEmail,
    employeeContactNumber: newEmployee.employeeContactNumber,
  });
};

export const inOfficeEmployeeJoin = async (req, res) => {
  const { employeeEmail, employeePassword } = req.body;

  if (!employeeEmail || !employeePassword) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const inOfficeEmployee = await prisma.inOfficeEmployee.findFirst({
    where: { employeeEmail },
  });

  if (!inOfficeEmployee) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid email or password');
  }

  const isPasswordCorrect = await comparePassword(
    employeePassword,
    inOfficeEmployee.employeePassword
  );

  if (!isPasswordCorrect) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid email or password');
  }

  const token = signToken({ id: inOfficeEmployee.employeeId });
  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
  // Set the token in a cookie
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 200, 'success', 'Join successful', {
    token,
    data: {
      employeeId: inOfficeEmployee.employeeId,
      employeeName: inOfficeEmployee.employeeName,
      employeeEmail: inOfficeEmployee.employeeEmail,
      employeeContactNumber: inOfficeEmployee.employeeContactNumber,
    },
  });
};
