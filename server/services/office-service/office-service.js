import { PrismaClient } from '@prisma/client';
import { hashPassword, comparePassword } from '../../helper/password.js';
import signToken from '../../helper/jwt-sign-token.js';
import { parseDuration } from '../../utils/parse-duration.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handlers.js';

const prisma = new PrismaClient();

export const officeSingup = async (req, res) => {
  const {
    officeName,
    officeEmail,
    officePassword
  } = req.body;

  if (!officeName || !officeEmail || !officePassword) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const existingOffice = await prisma.office.findFirst({
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
  }
  catch (error) {
    console.log(error);
    return errorResponseHandler(res, 500, 'fail', 'Internal Server Error');
  }

  const token = signToken({ id: office.id });

  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);

  // Set the token in a cookie
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 201, 'success', "Signup Successful.", {
    token,
  });
}

export const officeLogin = async (req, res) => {
  const { officeEmail, officePassword } = req.body;

  if (!officeEmail || !officePassword) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const office = await prisma.office.findFirst({
    where: { officeEmail },
  });

  if (!office) {
    return errorResponseHandler(
      res,
      401,
      'fail',
      'Invalid email or password'
    );
  }

  const isPasswordCorrect = await comparePassword(
    officePassword,
    office.officePassword
  );

  if (!isPasswordCorrect) {
    return errorResponseHandler(
      res,
      401,
      'fail',
      'Invalid email or password'
    );
  }

  const token = signToken({ id: office.id });

  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);

  // Set the token in a cookie
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 200, 'success', "Login Successful.", {
    token,
  });
}

export const createOffice = async (req, res) => {
  const {
    officeEmail,
    officeName,
    officeCity,
    officeState,
    officeCountry,
    officePincode,
    officeLongitude,
    officeLatitude,
    officeContactNumber,
    masterOfficeAdminName,
    masterOfficeAdminEmail,
    masterOfficeAdminContactNumber,
    masterOfficeAdminPassword,
  } = req.body;

  if (
    !officeEmail ||
    !officeName ||
    !officeCity ||
    !officeState ||
    !officeCountry ||
    !officePincode ||
    !officeLongitude ||
    !officeLatitude ||
    !officeContactNumber ||
    !masterOfficeAdminName ||
    !masterOfficeAdminEmail ||
    !masterOfficeAdminContactNumber ||
    !masterOfficeAdminPassword
  ) {
    return errorResponseHandler(
      res,
      400,
      'fail',
      'Please provide all required fields'
    );
  }

  const existingOffice = await prisma.office.findFirst({
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

  const hashedPassword = await hashPassword(masterOfficeAdminPassword);

  let office;
  let officeAddress;
  let masterOfficeAdmin;
  try {
    officeAddress = await prisma.officeAddress.create({
      data: {
        officeName,
        officeCity,
        officeState,
        officeCountry,
        officePincode,
        officeLongitude,
        officeLatitude,
      },
    });

    office = await prisma.office.create({
      data: {
        officeEmail,
        officeContactNumber,
        addressId: officeAddress.id,
      },
    });

    masterOfficeAdmin = await prisma.masterOfficeAdmin.create({
      data: {
        officeId: office.id,
        masterOfficeAdminName,
        masterOfficeAdminEmail,
        masterOfficeAdminContactNumber,
        masterOfficeAdminPassword: hashedPassword,
        role: 'MASTER_ADMIN',
      },
    });
  } catch (error) {
    next(error);
  }

  const token = signToken({ id: masterOfficeAdmin.id });

  const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
  // Set the token in a cookie
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 201, 'success', {
    token,
  });
};

export const getOfficeDetails = async (req, res) => {
  const officeId = req.masterOfficeAdmin.officeId;

  const office = await prisma.office.findFirst({
    where: { id: officeId },
  });

  if (!office) {
    return errorResponseHandler(res, 404, 'fail', 'Office not found');
  }

  console.log(office);

  const officeAddress = await prisma.officeAddress.findFirst({
    where: { id: office.addressId },
  });

  if (!office) {
    return errorResponseHandler(res, 404, 'fail', 'Office not found');
  }

  return responseHandler(res, 200, 'success', "Office Details Fetch Successful.", {
    office,
    officeAddress,
  });
}

export const getAllInOfficeEmployees = async (req, res) => {
  const officeId = req.masterOfficeAdmin.officeId;

  const inOfficeEmployees = await prisma.inOfficeEmployee.findMany({
    where: { officeId },
    select: {
      employeeId: true,
      employeeName: true,
      employeeEmail: true,
      employeeContactNumber: true,
      role: true,
    }
  });

  if (!inOfficeEmployees) {
    return errorResponseHandler(res, 404, 'fail', 'No in-office employees found');
  }

  return responseHandler(res, 200, 'success', "In Office Employee Details Fetch Successful.", {
    inOfficeEmployees,
  });
}

export const getAllOutOfficeEmployees = async (req, res) => {
  const officeId = req.masterOfficeAdmin.officeId;

  const outOfficeEmployees = await prisma.outOfficeEmployee.findMany({
    where: { officeId },
    select: {
      employeeId: true,
      employeeName: true,
      employeeEmail: true,
      employeeContactNumber: true,
      role: true,
    }
  });

  if (!outOfficeEmployees) {
    return errorResponseHandler(res, 404, 'fail', 'No out-office employees found');
  }

  return responseHandler(res, 200, 'success', "Out Office Employee Details Fetch Successful.", {
    outOfficeEmployees,
  });
}

export const getOfficeAddress = async (req, res) => {
  const officeId = req.body.officeId;

  const office = await prisma.office.findFirst({
    where: { id: officeId },
  });

  if (!office) {
    return errorResponseHandler(res, 404, 'fail', 'Office not found');
  }

  const officeAddress = await prisma.officeAddress.findFirst({
    where: { id: office.addressId },
  });

  if (!office) {
    return errorResponseHandler(res, 404, 'fail', 'Office not found');
  }

  return responseHandler(res, 200, 'success', "Office Address Fetch Successful.", {
    officeAddress,
  });
}