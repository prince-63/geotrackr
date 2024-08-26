import { PrismaClient } from '@prisma/client';
import defaultPasswordGenerator from '../../helper/default-password-generator.js';
import { hashPassword, comparePassword } from '../../helper/password.js';
import signToken from '../../helper/jwt-sign-token.js';
import { sendEmail } from '../../utils/email.js';
import { parseDuration } from '../../utils/parse-duration.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handlers.js';

const prisma = new PrismaClient();

export const createNewOutOfficeEmployee = async (req, res) => {
  const { employeeName, employeeEmail, employeeContactNumber } = req.body;

  const officeId = req.masterOfficeAdmin.officeId;

  if (!employeeName || !employeeEmail || !employeeContactNumber || !officeId) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const existingEmployee = await prisma.outOfficeEmployee.findFirst({
    where: { employeeEmail },
  });

  if (existingEmployee) {
    return errorResponseHandler(res, 400, 'fail', 'Employee already exists');
  }

  const defaultPassword = defaultPasswordGenerator();
  const hashedPassword = await hashPassword(defaultPassword);

  let newEmployee;
  try {
    newEmployee = await prisma.outOfficeEmployee.create({
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
    next(error);
  }

  return responseHandler(res, 201, 'success', 'Employee created successfully', {
    employeeId: newEmployee.employeeId,
    employeeName: newEmployee.employeeName,
    employeeEmail: newEmployee.employeeEmail,
    employeeContactNumber: newEmployee.employeeContactNumber,
  });
};

export const outOfficeEmployeeJoin = async (req, res) => {
  const { employeeEmail, employeePassword } = req.body;

  if (!employeeEmail || !employeePassword) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const outOfficeEmployee = await prisma.outOfficeEmployee.findFirst({
    where: { employeeEmail },
  });

  if (!outOfficeEmployee) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid email or password');
  }

  const isPasswordCorrect = await comparePassword(
    employeePassword,
    outOfficeEmployee.employeePassword
  );

  if (!isPasswordCorrect) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid email or password');
  }

  const token = signToken({ id: outOfficeEmployee.employeeId });

  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
  // Set the token in a cookie
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 200, 'success', 'Join in successfully', {
    token,
    data: {
      employeeId: outOfficeEmployee.employeeId,
      employeeName: outOfficeEmployee.employeeName,
      employeeEmail: outOfficeEmployee.employeeEmail,
      employeeContactNumber: outOfficeEmployee.employeeContactNumber,
    },
  });
};

export const addSingleWorkFromOutOfficeEmployee = async (req, res) => {
  const {
    employeeId,
    workDate,
    workAddressName,
    workCity,
    workCountry,
    workState,
    workPincode,
    workLongitude,
    workLatitude,
  } = req.body;

  if (
    !employeeId ||
    !workDate ||
    !workAddressName ||
    !workCity ||
    !workCountry ||
    !workState ||
    !workPincode ||
    !workLongitude ||
    !workLatitude
  ) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const employee = await prisma.outOfficeEmployee.findUnique({
    where: { employeeId },
  });

  if (!employee) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid employee');
  }

  let workAddress;
  try {
    workAddress = await prisma.workAddress.create({
      data: {
        workAddressName,
        workCity,
        workCountry,
        workState,
        workPincode,
        workLongitude,
        workLatitude,
      },
    });
  } catch (error) {
    return errorResponseHandler(
      res,
      500,
      'fail',
      `Something went wrong: ${error.message}`
    );
  }

  let outOfficeEmployeeDayWork;
  try {
    outOfficeEmployeeDayWork = await prisma.outOfficeEmployeeDayWork.create({
      data: {
        outOfficeEmployeeEmployeeId: employeeId,
        workAddressId: workAddress.id,
        workDate,
        workStatus: 'IN_PROGRESS',
      },
    });
  } catch (error) {
    return errorResponseHandler(
      res,
      500,
      'fail',
      `Something went wrong: ${error.message}`
    );
  }

  try {
    await prisma.outOfficeEmployee.update({
      where: { employeeId },
      data: {
        outOfficeDayWork: {
          connect: { id: outOfficeEmployeeDayWork.id },
        },
      },
    });
  } catch (error) {
    return errorResponseHandler(
      res,
      500,
      'fail',
      `Something went wrong: ${error.message}`
    );
  }

  return responseHandler(res, 200, 'success', 'Work added successfully', null);
};

export const addListOfWorkFromOutOfficeEmployee = async (req, res) => {
  const {
    employeeId,
    works, // Array of work objects
  } = req.body;

  if (!employeeId || !Array.isArray(works) || works.length === 0) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const employee = await prisma.outOfficeEmployee.findUnique({
    where: { employeeId },
  });

  if (!employee) {
    return errorResponseHandler(res, 400, 'fail', 'Invalid employee');
  }

  const workPromises = works.map(async (work) => {
    const {
      workDate,
      workAddressName,
      workCity,
      workCountry,
      workState,
      workPincode,
      workLongitude,
      workLatitude,
    } = work;

    if (
      !workDate ||
      !workAddressName ||
      !workCity ||
      !workCountry ||
      !workState ||
      !workPincode ||
      !workLongitude ||
      !workLatitude
    ) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Please provide all required fields'
      );
    }

    let workAddress;
    try {
      workAddress = await prisma.workAddress.create({
        data: {
          workAddressName,
          workCity,
          workCountry,
          workState,
          workPincode,
          workLongitude,
          workLatitude,
        },
      });
    } catch (error) {
      return errorResponseHandler(
        res,
        500,
        'fail',
        `Something went wrong: ${error.message}`
      );
    }

    let outOfficeEmployeeDayWork;
    try {
      outOfficeEmployeeDayWork = await prisma.outOfficeEmployeeDayWork.create({
        data: {
          outOfficeEmployeeEmployeeId: employeeId,
          workAddressId: workAddress.id,
          workDate,
          workStatus: 'IN_PROGRESS',
        },
      });
    } catch (error) {
      return errorResponseHandler(
        res,
        500,
        'fail',
        `Something went wrong: ${error.message}`
      );
    }

    return outOfficeEmployeeDayWork;
  });

  try {
    const outOfficeEmployeeDayWorks = await Promise.all(workPromises);

    await prisma.outOfficeEmployee.update({
      where: { employeeId },
      data: {
        outOfficeDayWork: {
          connect: outOfficeEmployeeDayWorks.map((work) => ({ id: work.id })),
        },
      },
    });
  } catch (error) {
    return errorResponseHandler(
      res,
      500,
      'fail',
      `Something went wrong: ${error.message}`
    );
  }

  return responseHandler(res, 200, 'success', 'Works added successfully', null);
};
