import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const getOfficeDetails = async (req, res) => {
    const officeId = req.employee.officeId;

    const officeDetails = await prisma.office.findUnique({
        where: {
            officeId: officeId,
        },
        select: {
            officeName: true,
            officeEmail: true,
            officeContactNumber: true,
            officeSubTitle: true,
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

    return responseHandler(res, 200, 'success','Office details fetched successfully', {
        office: {
            officeId: officeId,
            officeName: officeDetails.officeName,
            officeEmail: officeDetails.officeEmail,
            officeContactNumber: officeDetails.officeContactNumber,
            officeSubTitle: officeDetails.officeSubTitle,
            officeCity: officeDetails.officeCity,
            officeState: officeDetails.officeState,
            officeCountry: officeDetails.officeCountry,
            officePincodes: officeDetails.officePincodes,
            officeLongitude: officeDetails.officeLongitude,
            officeLatitude: officeDetails.officeLatitude,
        }
    });
};

export default getOfficeDetails;
