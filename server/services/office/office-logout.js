import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';
import { prisma } from '../../database/prisma-config.js';

const officeLogout = async (req, res) => {
    res.clearCookie('token');

    return responseHandler(res, 200, 'success', 'Logout Successful.');
};

export default officeLogout;
