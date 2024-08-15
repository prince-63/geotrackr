import { PrismaClient } from '@prisma/client';
import { errorResponseHandler, responseHandler } from '../helper/error.js';
import cloudinaryConfig from '../cloudinary/cloudinaryCofig.js';
const prisma = new PrismaClient();

cloudinaryConfig();

const uploadProfilePictureService = async (req, res) => {
    try {
        const { file } = req.files;
        const user = req.user;
        if(!file) {
            return errorResponseHandler(res, 400, 'fail', 'Profile picture is required');
        }

        if(!user) {
            return errorResponseHandler(res, 401, 'fail', 'User not authenticated');
        }

        const response = await cloudinary.uploader.upload(file.path, {
            public_id: `profile_pictures/${file.filename}`,
        });

        await prisma.user.update({
            where: { id: user.id },
            data: {
                profilePicture: response.secure_url, // or response.url if you don't want the secure url
            }
        });

        return responseHandler(res, 200, 'success', 'Profile picture uploaded', null);

    } catch (error) {
        console.log(error);
        return errorResponseHandler(res, 500, 'fail', 'Internal server error');
    } finally {
        await prisma.$disconnect();
    }
}

export default uploadProfilePictureService;