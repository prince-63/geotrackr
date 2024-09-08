import { PrismaClient } from '@prisma/client';
import errorResponseHandler from '../handlers/error-response-handlers.js';
import responseHandler from '../handlers/response-handler.js';

const prisma = new PrismaClient();

export const checkIn = async (req, res) => {
    const checkInLocation = req.body.checkInLocation;
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
                checkInLocation: checkInLocation || null,
                status: 'CHECKED_IN',
            },
        });
    } catch (error) {
        return errorResponseHandler(res, 500, 'fail', `Something wrong with the check in process: ${error.message}`);
    }

    return responseHandler(res, 200, 'success', 'Checked in successfully');
};

export const checkOut = async (req, res) => {
    const checkOutLocation = req.body.checkOutLocation;
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
            status: 'CHECKED_IN',
        },
    });

    if (!attendance) {
        return errorResponseHandler(res, 400, 'fail', 'No check-in record found for today or already checked out.');
    }

    const totalTimeWorked = calculateTotalHours(attendance.checkInTime, new Date());

    try {
        await prisma.attendances.update({
            where: {
                attendanceId: attendance.attendanceId,
            },
            data: {
                checkOutTime: new Date(),
                status: 'CHECKED_OUT',
                totalHours: totalTimeWorked,
                checkOutLocation: checkOutLocation || null,
            },
        });
    } catch (error) {
        return errorResponseHandler(res, 500, 'fail', `Something wrong with the check out process: ${error.message}`);
    }

    return responseHandler(res, 200, 'success', 'Checked out successfully');
};

function calculateTotalHours(checkInTime, checkOutTime) {
    const diff = checkOutTime.getTime() - checkInTime.getTime();
    const hours = Math.floor(diff / 1000 / 60 / 60);
    const minutes = Math.floor((diff / 1000 / 60) % 60);
    const seconds = Math.floor((diff / 1000) % 60);

    return `${hours}H:${minutes}M:${seconds}S`;
}