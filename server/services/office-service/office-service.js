import { PrismaClient } from '@prisma/client';
import { hashPassword } from '../../helper/password.js';
import signToken from '../../helper/jwt-sign-token.js';
import { parseDuration } from '../../utils/parse-duration.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handlers.js';

const prisma = new PrismaClient();

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
