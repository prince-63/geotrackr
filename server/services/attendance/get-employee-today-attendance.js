import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const getEmployeeTodayAttendance = async (req, res) => {
  const employeeId = req.employee.employeeId;
  const startOfDay = new Date();
  startOfDay.setHours(0, 0, 0, 0);

  const endOfDay = new Date();
  endOfDay.setHours(23, 59, 59, 999);

  const attendances = await prisma.attendances.findMany({
    where: {
      employeeId,
      date: {
        gte: startOfDay,
        lte: endOfDay,
      },
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

  console.log(attendances);

  return responseHandler(
    res,
    200,
    'success',
    'Employee attendance retrieved successfully',
    {
      attendances: attendances[0],
    }
  );
};

export default getEmployeeTodayAttendance;
