import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const checkIn = async (req, res) => {
    const checkInLocationLatitude = req.body.checkInLocationLatitude;
    const checkInLocationLongitude = req.body.checkInLocationLongitude;
    const employeeId = req.employee.employeeId;
    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);

    const endOfDay = new Date();
    endOfDay.setHours(23, 59, 59, 999);

    const attendance = await prisma.attendances.findFirst({
        where: {
            employeeId,
            date: {
                gte: startOfDay,
                lte: endOfDay,
            },
        },
    });

    if (attendance) {
        return errorResponseHandler(res, 400, 'fail', 'Already checked in for today please check out.');
    }

    try {
        await prisma.attendances.create({
            data: {
                employeeId,
                checkInTime: new Date(),
                checkInLocationLatitude: checkInLocationLatitude || null,
                checkInLocationLongitude: checkInLocationLongitude || null,
                status: 'CHECKED_IN',
            },
        });
    } catch (error) {
        return errorResponseHandler(res, 500, 'fail', `Something wrong with the check in process: ${error.message}`);
    }

    return responseHandler(res, 200, 'success', 'Checked in successfully');
};

export default checkIn;
