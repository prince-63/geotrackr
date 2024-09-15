import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const checkOut = async (req, res) => {
  const checkOutLocationLatitude = req.body.checkOutLocationLatitude;
  const checkOutLocationLongitude = req.body.checkOutLocationLongitude;
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
    return errorResponseHandler(
      res,
      400,
      'fail',
      'No check-in record found for today or already checked out.'
    );
  }

  const totalTimeWorked = calculateTotalHours(
    attendance.checkInTime,
    new Date()
  );

  try {
    await prisma.attendances.update({
      where: {
        attendanceId: attendance.attendanceId,
      },
      data: {
        checkOutTime: new Date(),
        status: 'CHECKED_OUT',
        totalHours: totalTimeWorked,
        checkOutLocationLatitude: checkOutLocationLatitude || null,
        checkOutLocationLongitude: checkOutLocationLongitude || null,
      },
    });
  } catch (error) {
    return errorResponseHandler(
      res,
      500,
      'fail',
      `Something wrong with the check out process: ${error.message}`
    );
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

export default checkOut;
