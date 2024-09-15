import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';
import { prisma } from '../../database/prisma-config.js';

const updateOfficeDetails = async (req, res) => {
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
    officeLatitude,
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
        officeLatitude,
      },
    });
  } catch (error) {
    console.log(error);
    return errorResponseHandler(res, 500, 'fail', 'Internal Server Error');
  }

  return responseHandler(
    res,
    200,
    'success',
    'Office Details Update Successful.',
    {
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
        officeLatitude: updatedOfficeDetails.officeLatitude,
      },
    }
  );
};

export default updateOfficeDetails;
