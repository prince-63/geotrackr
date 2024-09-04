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

  const token = signToken({ id: office.officeId });

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

  const token = signToken({ id: office.officeId });

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

export const uploadOfficeDetails = async (req, res) => {
  const officeId = req.office.officeId;
  const {
    officeName,
    officeSubTitle,
    officeEmail,
    officeContactNumber,
    officeCity,
    officeCountry,
    officePincodes,
    officeLongitude,
    officeLatitude
  } = req.body;

  const officeDetails = await prisma.officeDetails.findFirst({
    where: { officeId },
  });

  if (officeDetails) {
    return errorResponseHandler(res, 400, 'fail', 'Office details already uploaded');
  }

  let officeDetailsData;
  try {
    officeDetailsData = await prisma.officeDetails.create({
      data: {
        officeId,
        officeName,
        officeSubTitle,
        officeEmail,
        officeContactNumber,
        officeCity,
        officeCountry,
        officePincodes,
        officeLongitude,
        officeLatitude
      },
    });
  }
  catch (error) {
    console.log(error);
    return errorResponseHandler(res, 500, 'fail', 'Internal Server Error');
  }

  return responseHandler(res, 201, 'success', "Office Details Upload Successful.", {
    officeDetailsData,
  });
}

export const getOfficeDetails = async (req, res) => {
  const officeId = req.office.officeId;

  const officeDetails = await prisma.office.findUnique({
    where: { officeId },
    select: {
      officeId: true,
      officeName: true,
      officeEmail: true,
      officeSubTitle: true,
      officeContactNumber: true,
      officeCity: true,
      officeState: true,
      officeCountry: true,
      officePincodes: true,
      officeLongitude: true,
      officeLatitude: true,
      createdAt: true,
      updatedAt: true,
    },
  });

  if (!officeDetails) {
    return errorResponseHandler(res, 404, 'fail', 'Office details not found');
  }

  return responseHandler(res, 200, 'success', "Office Details Fetch Successful.", {
    officeDetails,
  });
}

export const updateOfficeDetails = async (req, res) => {
  const officeId = req.office.officeId;
  const {
    officeName,
    officeSubTitle,
    officeEmail,
    officeContactNumber,
    officeCity,
    officeState,
    officeCountry,
    officePincodes,
    officeLongitude,
    officeLatitude
  } = req.body;

  let updatedOfficeDetails;
  try {
    updatedOfficeDetails = await prisma.office.update({
      where: { officeId },
      data: {
        officeName,
        officeSubTitle,
        officeEmail,
        officeContactNumber,
        officeCity,
        officeState,
        officeCountry,
        officePincodes,
        officeLongitude,
        officeLatitude
      },
    });
  }
  catch (error) {
    console.log(error);
    return errorResponseHandler(res, 500, 'fail', 'Internal Server Error');
  }

  return responseHandler(res, 200, 'success', "Office Details Update Successful.", {
    updatedOfficeDetails,
  });
}

export const getAllInOfficeEmployees = async (req, res) => {
  const officeId = req.office.officeId;

  const inOfficeEmployees = await prisma.inOfficeEmployee.findMany({
    where: { officeId },
    select: {
      employeeId: true,
      employeeName: true,
      employeeEmail: true,
      employeeContactNumber: true,
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
  const officeId = req.office.officeId;

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