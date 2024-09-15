import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const getEmployees = async (req, res) => {
  const officeId = req.office.officeId;

  const employees = await prisma.employee.findMany({
    where: {
      officeId: officeId,
    },
    select: {
      employeeId: true,
      employeeName: true,
      employeeEmail: true,
      employeeContactNumber: true,
      employeeProfileImageUrl: true,
      isVerified: true,
      biometricEnabled: true,
      Attendances: {
        // Corrected field name
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
      },
      officeId: true,
      roles: {
        select: {
          roleId: true,
          Role: {
            select: {
              roleName: true,
            },
          },
        },
      },
    },
  });

  if (!employees) {
    return errorResponseHandler(res, 404, 'fail', 'Employees not found');
  }

  return responseHandler(
    res,
    200,
    'success',
    'employees retrieved successfully',
    {
      employees: employees,
    }
  );
};

export default getEmployees;
