import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const deleteEmployee = async (req, res) => {
  const employeeId = req.params.employeeId;
  console.log(employeeId);

  const employee = await prisma.employee.findUnique({
    where: { employeeId },
  });

  if (!employee) {
    return errorResponseHandler(res, 404, 'fail', 'Employee not found');
  }

  try {
    // Delete related EmployeeRole records
    await prisma.employeeRole.deleteMany({
      where: { employeeId },
    });

    // Delete related Attendances records
    await prisma.attendances.deleteMany({
      where: { employeeId },
    });

    // Delete the employee
    await prisma.employee.delete({
      where: { employeeId },
    });

    return responseHandler(
      res,
      200,
      'success',
      'Employee deleted successfully'
    );
  } catch (error) {
    return errorResponseHandler(res, 500, 'fail', 'Something went wrong');
  }
};

export default deleteEmployee;
