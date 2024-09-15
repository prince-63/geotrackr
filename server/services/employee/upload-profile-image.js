import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';
import cloudinaryConfig from '../../config/cloudinary/cloudinary-config.js';
import { v2 as cloudinary } from 'cloudinary';
import fs from 'fs';

cloudinaryConfig();

const uploadProfileImage = async (req, res) => {
  const { file } = req;
  const employee = req.employee;

  if (!file) {
    return errorResponseHandler(res, 400, 'fail', 'Please provide an image');
  }

  console.log('uploading file to cloudinary: ', file.path);
  const reponse = await cloudinary.uploader
    .upload(file.path, {
      folder: 'employee-profile-images',
      public_id: `${employee.employeeId}_profile_image`,
      use_filename: true,
    })
    .then((result) => result)
    .catch((error) => {
      console.log('error uploading image to cloudinary: ', error);
    })
    .finally(() => {
      // Delete the file from the server
      fs.unlinkSync(file.path);
    });

  console.log('cloudinary response: ', reponse.secure_url);

  const updatedEmployee = await prisma.employee.update({
    where: { employeeId: employee.employeeId },
    data: {
      employeeProfileImageUrl: reponse.secure_url,
    },
  });

  return responseHandler(
    res,
    200,
    'success',
    'profile image uploaded successfully',
    {
      employee: {
        employeeId: updatedEmployee.employeeId,
        employeeName: updatedEmployee.employeeName,
        employeeEmail: updatedEmployee.employeeEmail,
        employeeContactNumber: updatedEmployee.employeeContactNumber,
        employeeProfileImageUrl: updatedEmployee.employeeProfileImageUrl,
        isVerified: updatedEmployee.isVerified,
        biometricEnabled: updatedEmployee.biometricEnabled,
        officeId: updatedEmployee.officeId,
        attendances: updatedEmployee.Attendances,
      },
    }
  );
};

export default uploadProfileImage;
