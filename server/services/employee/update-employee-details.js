import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const updateEmployeeDetails = async (req, res) => {
  const employeeId = req.employee.employeeId;

  const { employeeName, employeeEmail, employeeContactNumber } = req.body;

  const updatedEmployee = await prisma.employee.update({
    where: {
      employeeId: employeeId,
    },
    data: {
      employeeName: employeeName,
      employeeEmail: employeeEmail,
      employeeContactNumber: employeeContactNumber,
    },
  });

  if (!updatedEmployee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  // Retrieve the updated employee details
  const employee = await prisma.employee.findUnique({
    where: {
      employeeId,
    },
    include: {
      Attendances: true,
    },
  });

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  const roles = await prisma.employeeRole.findMany({
    where: {
      employeeId: employee.employeeId,
    },
  });

  const roleNames = await Promise.all(
    roles.map(async (role) => {
      const employeeRole = await prisma.role.findUnique({
        where: {
          roleId: role.roleId,
        },
      });
      return employeeRole.roleName;
    })
  );

  return responseHandler(
    res,
    200,
    'success',
    'Employee details updated successfully',
    {
      employee: {
        employeeId: employee.employeeId,
        employeeName: employee.employeeName,
        employeeEmail: employee.employeeEmail,
        employeeContactNumber: employee.employeeContactNumber,
        roles: roleNames,
        employeeProfileImageUrl: employee.employeeProfileImageUrl,
        isVerified: employee.isVerified,
        biometricEnabled: employee.biometricEnabled,
        attendances: employee.Attendances,
        officeId: employee.officeId,
      },
    }
  );
};

export default updateEmployeeDetails;
