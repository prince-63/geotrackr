import { PrismaClient } from '@prisma/client';
import { hashPassword, comparePassword } from '../helper/password.js';
import signToken from '../helper/jwt-sign-token.js';
import { parseDuration } from '../utils/parse-duration.js';
import errorResponseHandler from '../handlers/error-response-handlers.js';
import responseHandler from '../handlers/response-handler.js';

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

  const existingOffice = await prisma.office.findUnique({
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

  const office = await prisma.office.findUnique({
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
  res.cookie('token', token, {
    expires: new Date(Date.now() + cookieExpiresInMs),
    httpOnly: true,
  });

  return responseHandler(res, 200, 'success', "Login Successful.", {
    token,
  });
}

export const officeLogout = async (req, res) => {
  res.clearCookie('token');

  return responseHandler(res, 200, 'success', "Logout Successful.");
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
    officeDetails: {
      officeId: updatedOfficeDetails.officeId,
      officeName: updatedOfficeDetails.officeName,
      officeEmail: updatedOfficeDetails.officeEmail,
      officeSubTitle: updatedOfficeDetails.officeSubTitle,
      officeContactNumber: updatedOfficeDetails.officeContactNumber,
      officeCity: updatedOfficeDetails.officeCity,
      officeState: updatedOfficeDetails.officeState,
      officeCountry: updatedOfficeDetails.officeCountry,
      officePincodes: updatedOfficeDetails.officePincodes,
      officeLongitude: updatedOfficeDetails.officeLongitude,
      officeLatitude: updatedOfficeDetails.officeLatitude
    }
  });
}