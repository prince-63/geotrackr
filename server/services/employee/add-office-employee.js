import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';
import { sendEmail } from '../../utils/email.js';
import { hashPassword } from '../../helper/password.js';
import defaultPasswordGenerator from '../../helper/default-password-generator.js';

const addOfficeEmployee = async (req, res) => {
    const employeeName = req.body.name;
    const employeeEmail = req.body.email;
    const employeeContactNumber = req.body.phone;
    const officeId = req.office.officeId;

    if (!employeeName || !employeeEmail || !employeeContactNumber || !officeId) {
        return errorResponseHandler(res, 400, 'fail', 'Please provide all required fields');
    }

    const existingEmployee = await prisma.employee.findUnique({
        where: { employeeEmail },
    });

    if (existingEmployee) {
        return errorResponseHandler(res, 400, 'fail', 'Employee already exists');
    }

    const defaultPassword = defaultPasswordGenerator();
    const hashedPassword = await hashPassword(defaultPassword);

    let newEmployee;
    try {
        newEmployee = await prisma.employee.create({
            data: {
                employeeName,
                employeeEmail,
                employeeContactNumber,
                employeePassword: hashedPassword,
                officeId,
            },
        });

        const role = await prisma.role.findUnique({
            where: { roleName: 'OFFICE' },
        });

        if (!role) {
            return errorResponseHandler(res, 400, 'fail', 'Role not found');
        }

        await prisma.employeeRole.create({
            data: {
                employeeId: newEmployee.employeeId,
                roleId: role.roleId,
            },
        });

        const message = `Hello ${employeeName},\n\nYour account has been created successfully.\n\nEmail: ${employeeEmail}\nPassword: ${defaultPassword}\n\nPlease login to your account and update your password.\n\nThank you.`;
        const subject = 'Account Created Successfully';
        await sendEmail({ email: employeeEmail, message, subject });
    } catch (error) {
        return errorResponseHandler(res, 500, 'fail', 'Something went wrong');
    }

    return responseHandler(res, 201, 'success', 'in office employee created successfully', {
        employee: {
            employeeId: newEmployee.employeeId,
            employeeName: newEmployee.employeeName,
            employeeEmail: newEmployee.employeeEmail,
            employeeContactNumber: newEmployee.employeeContactNumber,
            roles: ['OFFICE'],
        },
    });
};

export default addOfficeEmployee;
