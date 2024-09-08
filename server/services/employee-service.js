import { PrismaClient } from '@prisma/client';
import defaultPasswordGenerator from '../helper/default-password-generator.js';
import { hashPassword, comparePassword } from '../helper/password.js';
import signToken from '../helper/jwt-sign-token.js';
import { sendEmail } from '../utils/email.js';
import { parseDuration } from '../utils/parse-duration.js';
import errorResponseHandler from '../handlers/error-response-handlers.js';
import responseHandler from '../handlers/response-handler.js';
import cloudinaryConfig from '../config/cloudinary/cloudinary-config.js';
import { v2 as cloudinary } from 'cloudinary';
import fs from 'fs';

cloudinaryConfig();

const prisma = new PrismaClient();

export const addOfficeEmployee = async (req, res) => {
    const employeeName = req.body.name;
    const employeeEmail = req.body.email;
    const employeeContactNumber = req.body.phone;
    const officeId = req.office.officeId;

    if (!employeeName || !employeeEmail || !employeeContactNumber || !officeId) {
        return errorResponseHandler(
            res,
            400,
            'fail',
            'Please provide all required fields'
        );
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
            where: { roleName: "OFFICE" },
        });

        if (!role) {
            return errorResponseHandler(res, 400, 'fail', "Role not found");
        }

        await prisma.employeeRole.create({
            data: {
                employeeId: newEmployee.employeeId,
                roleId: role.roleId,
            }
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
        }
    });
};

export const addRemoteEmployee = async (req, res) => {
    const employeeName = req.body.name;
    const employeeEmail = req.body.email;
    const employeeContactNumber = req.body.phone;
    const officeId = req.office.officeId;

    if (!employeeName || !employeeEmail || !employeeContactNumber || !officeId) {
        return errorResponseHandler(
            res,
            400,
            'fail',
            'Please provide all required fields'
        );
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
            where: { roleName: "REMOTE" },
        });

        if (!role) {
            return errorResponseHandler(res, 400, 'fail', "Role not found");
        }

        await prisma.employeeRole.create({
            data: {
                employeeId: newEmployee.employeeId,
                roleId: role.roleId,
            }
        });

        const message = `Hello ${employeeName},\n\nYour account has been created successfully.\n\nEmail: ${employeeEmail}\nPassword: ${defaultPassword}\n\nPlease login to your account and update your password.\n\nThank you.`;
        const subject = 'Account Created Successfully';
        await sendEmail({ email: employeeEmail, message, subject });
    } catch (error) {
        return errorResponseHandler(res, 500, 'fail', 'Something went wrong');
    }

    return responseHandler(res, 201, 'success', 'remote employee created successfully', {
        employee: {
            employeeId: newEmployee.employeeId,
            employeeName: newEmployee.employeeName,
            employeeEmail: newEmployee.employeeEmail,
            employeeContactNumber: newEmployee.employeeContactNumber,
            roles: ['REMOTE'],
        }
    });
}

export const deleteEmployee = async (req, res) => {
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

        return responseHandler(res, 200, 'success', 'Employee deleted successfully');
    } catch (error) {
        return errorResponseHandler(res, 500, 'fail', 'Something went wrong');
    }
};

export const getEmployees = async (req, res) => {
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
            Attendances: { // Corrected field name
                select: {
                    attendanceId: true,
                    date: true,
                    checkInTime: true,
                    checkInLocation: true,
                    checkOutTime: true,
                    checkOutLocation: true,
                    status: true,
                    totalHours: true,
                    createdAt: true,
                    updatedAt: true
                }
            },
            officeId: true,
            roles: {
                select: {
                    roleId: true,
                    Role: {
                        select: {
                            roleName: true
                        }
                    }
                }
            }
        }
    });

    if (!employees) {
        return errorResponseHandler(res, 404, 'fail', 'Employees not found');
    }

    return responseHandler(res, 200, 'success', 'employees retrieved successfully', {
        employees: employees
    });
};

export const getEmployeeDetails = async (req, res) => {
    const employeeId = req.employee.employeeId;

    const employee = await prisma.employee.findUnique({
        where: {
            employeeId,
        },
        include: {
            Attendances: true, // Include attendances
        },
    });

    if (!employee) {
        return errorResponseHandler(res, 404, 'fail', 'Employee not found');
    }

    const roles = await prisma.employeeRole.findMany({
        where: {
            employeeId: employee.employeeId,
        }
    });

    const roleNames = await Promise.all(
        roles.map(async (role) => {
            const employeeRole = await prisma.role.findUnique({
                where: {
                    roleId: role.roleId,
                }
            });
            return employeeRole.roleName;
        })
    );

    return responseHandler(res, 200, 'success', 'employee details retrieved successfully', {
        employee: {
            employeeId: employee.employeeId,
            employeeName: employee.employeeName,
            employeeEmail: employee.employeeEmail,
            employeeContactNumber: employee.employeeContactNumber,
            roles: roleNames,
            employeeProfileImageUrl: employee.employeeProfileImageUrl,
            isVerified: employee.isVerified,
            biometricEnabled: employee.biometricEnabled,
            attendances: employee.Attendances, // Include attendances in the response
            officeId: employee.officeId,
        },
    });
}

export const loginEmployee = async (req, res) => {
    const employeeEmail = req.body.email;
    const employeePassword = req.body.password;

    if (!employeeEmail || !employeePassword) {
        return errorResponseHandler(
            res,
            400,
            'fail',
            'Please provide all required fields'
        );
    }

    const employee = await prisma.employee.findUnique({
        where: { employeeEmail },
        include: {
            Attendances: true, // Include attendances
        },
    });

    if (!employee) {
        return errorResponseHandler(res, 404, 'fail', 'Employee not found');
    }

    const roles = await prisma.employeeRole.findMany({
        where: {
            employeeId: employee.employeeId,
        }
    });

    const roleNames = await Promise.all(
        roles.map(async (role) => {
            const employeeRole = await prisma.role.findUnique({
                where: {
                    roleId: role.roleId,
                }
            });
            return employeeRole.roleName;
        })
    );

    const isPasswordMatch = await comparePassword(employeePassword, employee.employeePassword);

    if (!isPasswordMatch) {
        return errorResponseHandler(res, 400, 'fail', 'Invalid credentials');
    }

    const token = signToken(employee.employeeId);

    const cookieExpiresInMs = parseDuration(process.env.JWT_EXPIRES_IN);
    res.cookie('token', token, {
        expires: new Date(Date.now() + cookieExpiresInMs),
        httpOnly: true,
    });

    return responseHandler(res, 200, 'success', 'login successful', {
        token: token,
        employee: {
            employeeId: employee.employeeId,
            employeeName: employee.employeeName,
            employeeEmail: employee.employeeEmail,
            employeeContactNumber: employee.employeeContactNumber,
            roles: roleNames,
            employeeProfileImageUrl: employee.employeeProfileImageUrl,
            isVerified: employee.isVerified,
            biometricEnabled: employee.biometricEnabled,
            attendances: employee.Attendances, // Include attendances in the response
            officeId: employee.officeId,
        },
    });
};

export const uploadProfileImage = async (req, res) => {
    const { file } = req;
    const employee = req.employee;

    if (!file) {
        return errorResponseHandler(res, 400, 'fail', 'Please provide an image');
    }

    console.log('uploading file to cloudinary: ', file.path);
    const reponse = await cloudinary.uploader.upload(file.path, {
        folder: 'employee-profile-images',
        public_id: `${employee.employeeId}_profile_image`,
        use_filename: true,
    });

    console.log('cloudinary response: ', reponse.secure_url);

    const updatedEmployee = await prisma.employee.update({
        where: { employeeId: employee.employeeId },
        data: {
            employeeProfileImageUrl: reponse.secure_url,
        },
    });

    // Delete the file from the server
    fs.unlinkSync(req.file.path);

    return responseHandler(res, 200, 'success', 'profile image uploaded successfully', {
        employee: {
            employeeId: updatedEmployee.employeeId,
            employeeName: updatedEmployee.employeeName,
            employeeEmail: updatedEmployee.employeeEmail,
            employeeContactNumber: updatedEmployee.employeeContactNumber,
            employeeProfileImageUrl: updatedEmployee.employeeProfileImageUrl,
            isVerified: updatedEmployee.isVerified,
            biometricEnabled: updatedEmployee.biometricEnabled,
            officeId: updatedEmployee.officeId,
            attendances: updatedEmployee.Attendances,
        },
    });
};