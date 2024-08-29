import { PrismaClient } from "@prisma/client";
import errorResponseHandler from "../../handlers/error-response-handlers.js";
import responseHandler from "../../handlers/response-handlers.js";

const prisma = new PrismaClient();

export const checkInAttendanceForOutOfficeEmployee = async (req, res) => {
    const { longitude, latitude } = req.body;
    const employeeId = req.outOfficeEmployee.employeeId;
    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);

    const endOfDay = new Date();
    endOfDay.setHours(23, 59, 59, 999);

    const outOfficeAttendance = await prisma.outOfficeAttendance.findFirst({
        where: {
            employeeId,
            date: {
                gte: startOfDay,
                lte: endOfDay,
            },
        },
    });

    if (outOfficeAttendance) {
        const checkInAttendance = await prisma.outOfficeAttendanceCheckIn.findFirst({
            where: {
                outOfficeAttendanceId: outOfficeAttendance.id,
                checkInTime: {
                    gte: startOfDay,
                    lte: endOfDay,
                },
            },
        });

        if (checkInAttendance) {
            return errorResponseHandler(
                res,
                400,
                "fail",
                "You have already checked in today"
            );
        }

        try {
            await prisma.outOfficeAttendanceCheckIn.create({
                data: {
                    outOfficeAttendanceId: outOfficeAttendance.id,
                    checkInTime: new Date(),
                    longitude: longitude,
                    latitude: latitude,
                    status: "CHECKED_IN",
                },
            });
        } catch (error) {
            return errorResponseHandler(
                res,
                500,
                "fail",
                `Something wrong with the out office employee check in process: ${error.message}`
            );
        }
    }
    else {
        const outOfficeAttendance = await prisma.outOfficeAttendance.create({
            data: {
                employeeId,
                date: new Date(),
            },
        });

        try {
            await prisma.outOfficeAttendanceCheckIn.create({
                data: {
                    outOfficeAttendanceId: outOfficeAttendance.id,
                    checkInTime: new Date(),
                    longitude: longitude,
                    latitude: latitude,
                    status: "CHECKED_IN",
                },
            });
        } catch (error) {
            return errorResponseHandler(
                res,
                500,
                "fail",
                `Something wrong with the out office employee check in process: ${error.message}`
            );
        }
    }

    responseHandler(res, 200, "success", "You have successfully checked in");
}

export const checkOutAttendanceForOutOfficeEmployee = async (req, res) => {
    const { longitude, latitude } = req.body;
    const employeeId = req.outOfficeEmployee.employeeId;
    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);

    const endOfDay = new Date();
    endOfDay.setHours(23, 59, 59, 999);

    const outOfficeAttendance = await prisma.outOfficeAttendance.findFirst({
        where: {
            employeeId,
            date: {
                gte: startOfDay,
                lte: endOfDay,
            },
        },
    });

    if (!outOfficeAttendance) {
        return errorResponseHandler(
            res,
            400,
            "fail",
            "You have not checked in yet"
        );
    }

    const checkOutAttendance = await prisma.outOfficeAttendanceCheckOut.findFirst({
        where: {
            outOfficeAttendanceId: outOfficeAttendance.id,
            checkOutTime: {
                gte: startOfDay,
                lte: endOfDay,
            },
        },
    });

    if (checkOutAttendance) {
        return errorResponseHandler(
            res,
            400,
            "fail",
            "You have already checked out today"
        );
    }

    try {
        await prisma.outOfficeAttendanceCheckOut.create({
            data: {
                outOfficeAttendanceId: outOfficeAttendance.id,
                checkOutTime: new Date(),
                longitude: longitude,
                latitude: latitude,
                status: "CHECKED_OUT",
            },
        });
    } catch (error) {
        return errorResponseHandler(
            res,
            500,
            "fail",
            `Something wrong with the out office employee check out process: ${error.message}`
        );
    }

    const checkInTime = await prisma.outOfficeAttendanceCheckIn.findFirst({
        where: {
            outOfficeAttendanceId: outOfficeAttendance.id,
        },
        select: {
            checkInTime: true,
        },
    });

    const checkOutTime = new Date();

    const workingTime = calculateWorkingTime(checkInTime.checkInTime, checkOutTime);

    await prisma.outOfficeAttendance.update({
        where: { id: outOfficeAttendance.id },
        data: {
            totalHours: workingTime,
        },
    });

    responseHandler(res, 200, "success", "You have successfully checked out");
}

function calculateWorkingTime(checkInTime, checkOutTime) {
    const diff = checkOutTime - checkInTime;
    const hours = Math.floor(diff / 3600000);
    const minutes = Math.floor((diff % 3600000) / 60000);
    const seconds = Math.floor((diff % 60000) / 1000);
    return `${hours}H:${minutes}M:${seconds}S`;
}