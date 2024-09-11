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

    return responseHandler(res, 200, 'success', 'Employee details updated successfully', {
        employee: updatedEmployee,
    });
};

export default updateEmployeeDetails;
