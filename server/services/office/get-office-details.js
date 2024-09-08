import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';
import { prisma } from '../../database/prisma-config.js';

const getOfficeDetails = async (req, res) => {
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

    return responseHandler(res, 200, 'success', 'Office Details Fetch Successful.', {
        officeDetails,
    });
};

export default getOfficeDetails;
