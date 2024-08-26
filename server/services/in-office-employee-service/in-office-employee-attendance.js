import { PrismaClient } from '@prisma/client';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handlers.js';

const prisma = new PrismaClient();

export const checkInAttendanceForInOfficeEmployee = async (req, res) => {
    const employeeId = req.inOfficeEmployee.employeeId;
    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);

    const endOfDay = new Date();
    endOfDay.setHours(23, 59, 59, 999);


    const inOfficeAttendance = await prisma.inOfficeAttendance.findFirst({
        where: {
            employeeId,
            checkInTime: {
                gte: startOfDay,
                lte: endOfDay,
            },
        },
    });

    if (inOfficeAttendance) {
        return errorResponseHandler(res, 400, 'fail', 'Already checked in for today please check out.');
    }

    try {
        await prisma.inOfficeAttendance.create({
            data: {
                employeeId,
                checkInTime: new Date(),
                status: 'CHECKED_IN',
            },
        });
    } catch (error) {
        return errorResponseHandler(res, 500, 'fail', `Something wrong with the check in process: ${error.message}`);
    }

    return responseHandler(res, 200, 'success', 'Checked in successfully');
};

export const checkOutAttendanceForInOfficeEmployee = async (req, res) => {
    const employeeId = req.inOfficeEmployee.employeeId;
    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);

    const endOfDay = new Date();
    endOfDay.setHours(23, 59, 59, 999);


    const inOfficeAttendance = await prisma.inOfficeAttendance.findFirst({
        where: {
            employeeId,
            date: {
                gte: startOfDay,
                lte: endOfDay,
            },
            status: 'CHECKED_IN',
        },
    });

    if (!inOfficeAttendance) {
        return errorResponseHandler(res, 400, 'fail', 'No check-in record found for today or already checked out.');
    }

    const totalTimeWorked = calculateTotalHours(inOfficeAttendance.checkInTime, new Date());

    try {
        await prisma.inOfficeAttendance.update({
            where: {
                id: inOfficeAttendance.id,
            },
            data: {
                checkOutTime: new Date(),
                status: 'CHECKED_OUT',
                totalHours: totalTimeWorked,
            },
        });
    } catch (error) {
        return errorResponseHandler(res, 500, 'fail', `Something wrong with the check out process: ${error.message}`);
    }

    return responseHandler(res, 200, 'success', 'Checked out successfully');
}

function calculateTotalHours(checkInTime, checkOutTime) {
    const diff = checkOutTime.getTime() - checkInTime.getTime();
    const hours = Math.floor(diff / 1000 / 60 / 60);
    const minutes = Math.floor((diff / 1000 / 60) % 60);
    const seconds = Math.floor((diff / 1000) % 60);

    return `${hours}H:${minutes}M:${seconds}S`;
}

/* export const checkInAttendanceForInOfficeEmployee = async (req, res) => {
    const employee = req.inOfficeEmployee;
    const qrText = req.body.qrText;

    if (!qrText) {
        return errorResponseHandler(res, 400, 'fail', 'Please provide QR code text');
    }

    const employeeId = employee.employeeId;
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const inOfficeAttendance = await prisma.inOfficeAttendance.findFirst({
        where: {
            employeeId,
        },
        checkInTime: {
            gte: today,
        },
    });

    if (inOfficeAttendance) {
        return errorResponseHandler(res, 400, 'fail', 'Already checked in for today please check out.');
    }

    try {
        await prisma.inOfficeAttendance.create({
            data: {
                employeeId,
                checkInTime: new Date(),
                status: 'CHECKED_IN',
            },
        });
    }
    catch (error) {
        return errorResponseHandler(res, 500, 'fail', `Something wrong with the check in process: ${error.message}`);
    }

    return responseHandler(res, 200, 'success', 'Checked in successfully');
}

export const checkOutAttendanceForInOfficeEmployee = async (req, res) => {
    const employee = req.inOfficeEmployee;
    const qrText = req.body.qrText;

    if (!qrText) {
        return errorResponseHandler(res, 400, 'fail', 'Please provide QR code text');
    }

    const employeeId = employee.employeeId;
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const inOfficeAttendance = await prisma.inOfficeAttendance.findFirst({
        where: {
            employeeId,
        },
        checkOutTime: {
            gte: today,
        },
    });

    if (inOfficeAttendance) {
        return errorResponseHandler(res, 400, 'fail', 'Already checked out for today.');
    }

    try {
        await prisma.inOfficeAttendance.update({
            where: {
                employeeId,
            },
            data: {
                checkOutTime: new Date(),
                status: 'CHECKED_OUT',
            },
        });
    }
    catch (error) {
        return errorResponseHandler(res, 500, 'fail', `Something wrong with the check out process: ${error.message}`);
    }

    return responseHandler(res, 200, 'success', 'Checked out successfully');
} */