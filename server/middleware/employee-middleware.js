import { PrismaClient } from "@prisma/client";
import jwt from "jsonwebtoken";
import errorResponseHandler from "../handlers/error-response-handlers.js";

const prisma = new PrismaClient();

const employeeMiddleware = async (req, res, next) => {
    let token;
    if (
        req.headers.authorization &&
        req.headers.authorization.startsWith("Bearer")
    ) {
        token = req.headers.authorization.split(" ")[1];
    }

    if (!token) {
        return errorResponseHandler(res, 401, "fail", "Not authorized to access this route");
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        //console.log(decoded);

        if (!decoded.id) {
            return errorResponseHandler(res, 401, "fail", "Invalid token payload");
        }

        const employee = await prisma.employee.findUnique({
            where: { employeeId: decoded.id },
        });

        if (!employee) {
            return errorResponseHandler(res, 401, "fail", "No employee found with this id");
        }

        req.employee = employee;
        next();
    } catch (error) {
        if (error.name === "JsonWebTokenError") {
            return errorResponseHandler(res, 401, "fail", "Invalid token");
        }
        next(error);
    }
}

export default employeeMiddleware;