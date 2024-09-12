import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const getEmployeeAttendance = async (req, res) => {
    const employeeId = req.employee.employeeId;

    const attendances = await prisma.attendances.findMany({
        where: {
            employeeId,
        },
        select: {
            attendanceId: true,
            date: true,
            checkInTime: true,
            checkInLocationLongitude: true,
            checkInLocationLatitude: true,
            checkOutTime: true,
            checkOutLocationLongitude: true,
            checkOutLocationLatitude: true,
            status: true,
            totalHours: true,
        },
    });

    if (!attendances) {
        return errorResponseHandler(res, 404, 'fail', 'Employee not found');
    }

    return responseHandler(res, 200, 'success', 'Employee attendance retrieved successfully', {
        attendances: attendances,
    });
}

export default getEmployeeAttendance;