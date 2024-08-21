import { PrismaClient } from '@prisma/client';
import { errorResponseHandler, responseHandler } from '../helper/error.js';
import cloudinaryConfig from '../cloudinary/cloudinaryCofig.js';
import { v2 as cloudinary } from 'cloudinary';
import fs from 'fs';

const prisma = new PrismaClient();

cloudinaryConfig();

export const profilePictureUpload = async (req, res) => {
  try {
    const { file } = req;
    const user = req.user;

    if (!file) {
      console.error('No file provided');
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Profile picture is required'
      );
    }

    if (!user) {
      console.error('User not authenticated');
      return errorResponseHandler(res, 401, 'fail', 'User not authenticated');
    }

    console.log('Uploading file to Cloudinary:', file.path);
    const response = await cloudinary.uploader.upload(file.path, {
      folder: 'profile_pictures',
      public_id: `${user.id}_profile_picture`,
      overwrite: true,
    });

    console.log('File uploaded to Cloudinary:', response.secure_url);

    // Save the URL to the user's profile in the database
    await prisma.user.update({
      where: { id: user.id },
      data: { profilePictureUrl: response.secure_url },
    });

    console.log('Profile picture URL saved to database');

    return responseHandler(
      res,
      200,
      'success',
      'Profile picture uploaded successfully',
      {
        profilePictureUrl: response.secure_url,
      }
    );
  } catch (error) {
    console.error('Error occurred:', error);
    return errorResponseHandler(
      res,
      500,
      'fail',
      'An error occurred while uploading the profile picture',
      error
    );
  } finally {
    console.log('Deleting file from server:', req.file.path);
    fs.unlinkSync(req.file.path);
    await prisma.$disconnect();
  }
};

export const profileDetailsUpload = async (req, res) => {
  const user = req.user;

  const {
    name,
    contactNumber,
    dateOfBirth,
    bloodGroup,
    address,
    organizationName,
    organizationAddress,
    organizationContactEmail,
    organizationContactNumber,
    workingScheduleStart,
    workingScheduleEnd,
    organizationLocationLatitude,
    organizationLocationLongitude,
  } = req.body;

  try {
    if (!user) {
      return errorResponseHandler(res, 404, 'fail', 'User not found');
    }

    if (!name) {
      return errorResponseHandler(res, 400, 'fail', 'Name is required');
    }
    if (!contactNumber) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Contact number is required'
      );
    }
    if (!dateOfBirth) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Date of birth is required'
      );
    }
    if (!bloodGroup) {
      return errorResponseHandler(res, 400, 'fail', 'Blood group is required');
    }
    if (!address) {
      return errorResponseHandler(res, 400, 'fail', 'Address is required');
    }
    if (!organizationName) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Organization name is required'
      );
    }
    if (!organizationAddress) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Organization address is required'
      );
    }
    if (!organizationContactNumber) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Organization contact number is required'
      );
    }

    if (!organizationContactEmail) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Organization contact email is required'
      );
    }

    if (!workingScheduleStart) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Working schedule start is required'
      );
    }

    if (!workingScheduleEnd) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Working schedule end is required'
      );
    }

    if (!organizationLocationLatitude) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Organization location latitude is required'
      );
    }

    if (!organizationLocationLongitude) {
      return errorResponseHandler(
        res,
        400,
        'fail',
        'Organization location longitude is required'
      );
    }

    const updateUser = await prisma.user.update({
      where: {
        id: user.id,
      },
      data: {
        name: name,
        contactNumber: contactNumber,
        dateOfBirth: dateOfBirth,
        bloodGroup: bloodGroup,
        address: address,
        organizationName: organizationName,
        organizationAddress: organizationAddress,
        organizationContactEmail: organizationContactEmail,
        organizationContactNumber: organizationContactNumber,
        workingScheduleStart: workingScheduleStart,
        workingScheduleEnd: workingScheduleEnd,
        organizationLocationLatitude: organizationLocationLatitude,
        organizationLocationLongitude: organizationLocationLongitude,
      },
    });

    return responseHandler(
      res,
      200,
      'success',
      'Profile updated successfully',
      updateUser
    );
  } catch (error) {
    console.log(error);
    return errorResponseHandler(res, 500, 'fail', 'Internal server error');
  } finally {
    await prisma.$disconnect();
  }
};

export const getProfileDetails = async (req, res) => {
  const user = req.user;

  try {
    if (!user) {
      return errorResponseHandler(res, 404, 'fail', 'User not found');
    }

    const userDetails = await prisma.user.findUnique({
      where: {
        id: user.id,
      },
    });

    return responseHandler(
      res,
      200,
      'success',
      'User details fetched successfully',
      userDetails
    );
  } catch (error) {
    console.log(error);
    return errorResponseHandler(res, 500, 'fail', 'Internal server error');
  } finally {
    await prisma.$disconnect();
  }
};
