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
  const employeeName = req.body.name;
  const employeeEmail = req.body.email;
  const employeeContactNumber = req.body.phone;

  const officeId = req.office.officeId;

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

  return responseHandler(res, 201, 'success', 'in office employee created successfully', {
    employeeId: newEmployee.employeeId,
    employeeName: newEmployee.employeeName,
    employeeEmail: newEmployee.employeeEmail,
    employeeContactNumber: newEmployee.employeeContactNumber,
  });
};

export const deleteInOfficeEmployee = async (req, res) => {
  const employeeId = req.params.employeeId;
  console.log(employeeId);

  const employee = await prisma.inOfficeEmployee.findFirst({
    where: { employeeId },
  });

  console.log(employee);

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  await prisma.inOfficeEmployee.delete({
    where: { employeeId },
  });

  return responseHandler(res, 200, 'success', 'Employee deleted successfully');
};

export const updateInOfficeEmployee = async (req, res) => {
  const employeeId = req.params.employeeId;

  const employeeName = req.body.name;
  const employeeEmail = req.body.email;
  const employeeContactNumber = req.body.phone;

  if (!employeeName || !employeeEmail || !employeeContactNumber) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const employee = await prisma.inOfficeEmployee.findFirst({
    where: { employeeId },
  });

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  const updatedEmployee = await prisma.inOfficeEmployee.update({
    where: { employeeId },
    data: {
      employeeName,
      employeeEmail,
      employeeContactNumber,
    },
  });

  return responseHandler(res, 200, 'success', 'Employee updated successfully', {
    employeeId: updatedEmployee.employeeId,
    employeeName: updatedEmployee.employeeName,
    employeeEmail: updatedEmployee.employeeEmail,
    employeeContactNumber: updatedEmployee.employeeContactNumber,
  });
};

export const inOfficeEmployeeJoin = async (req, res) => {
  const { employeeEmail, employeePassword } = req.body;

  console.log(employeeEmail, employeePassword);

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

  return responseHandler(res, 200, 'success', 'in office employee join successful.', {
    token,
    employee: {
      employeeId: inOfficeEmployee.employeeId,
      employeeName: inOfficeEmployee.employeeName,
      employeeEmail: inOfficeEmployee.employeeEmail,
      employeeContactNumber: inOfficeEmployee.employeeContactNumber,
      employeeRole: inOfficeEmployee.role,
    },
  });
};

export const getInOfficeEmployeeDetail = async (req, res) => {
  const employeeId = req.inOfficeEmployee.employeeId;

  const employee = await prisma.inOfficeEmployee.findFirst({
    where: { employeeId },
    select: {
      employeeId: true,
      employeeName: true,
      employeeEmail: true,
      employeeContactNumber: true,
    },
  });

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  return responseHandler(res, 200, 'success', "fetch in office employee details successful.", {
    employee,
  });
}

export const getOfficeLocationCordinates = async (req, res) => {
  const employeeId = req.inOfficeEmployee.employeeId;

  const employee = await prisma.inOfficeEmployee.findFirst({
    where: { employeeId },
    select: {
      officeId: true,
    },
  });

  //console.log(employee);

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  const office = await prisma.office.findFirst({
    where: { id: employee.officeId },
    select: {
      addressId: true,
    }
  });

  //console.log(office);

  if (!office) {
    return errorResponseHandler(res, 404, 'fail', 'Office not found');
  }

  const address = await prisma.officeAddress.findFirst({
    where: { id: office.addressId },
    select: {
      officeName: true,
      officePincode: true,
      officeCity: true,
      officeState: true,
      officeCountry: true,
      officeLongitude: true,
      officeLatitude: true,
    }
  });

  //console.log(address);

  if (!address) {
    return errorResponseHandler(res, 404, 'fail', 'Address not found');
  }

  return responseHandler(res, 200, 'success', {
    address,
  });
}