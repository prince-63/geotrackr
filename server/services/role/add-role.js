import { prisma } from '../../database/prisma-config.js';
import errorResponseHandler from '../../handlers/error-response-handlers.js';
import responseHandler from '../../handlers/response-handler.js';

const addRole = async (req, res) => {
  const { roleName } = req.body;

  if (!roleName) {
    return errorResponseHandler(res, 400, 'fail', 'Please provide a role name');
  }

  const role = await prisma.role.create({
    data: {
      roleName,
    },
  });

  return responseHandler(res, 201, 'success', 'Role added successfully', role);
};

export default addRole;
