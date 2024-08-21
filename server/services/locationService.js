import { PrismaClient } from '@prisma/client';
import { errorResponseHandler, responseHandler } from '../helper/error.js';

const prisma = new PrismaClient();

export const getLocation = async (req, res) => {
  const user = req.user;

  if (!user) {
    return errorResponseHandler(res, 401, 'fail', 'User not authenticated');
  }
  try {
    const response = await prisma.user.findUnique({
      where: {
        id: user.id,
        email: user.email,
      },
    });

    if (!response) {
      return errorResponseHandler(res, 404, 'fail', 'User not found');
    }

    const data = {
      latitude: response.organizationLocationLatitude,
      longitude: response.organizationLocationLongitude,
    };
    return responseHandler(res, 200, 'success', 'User location', data);
  } catch (e) {
    console.log(e);
    return errorResponseHandler(res, 500, 'fail', 'Internal server error');
  }
};
