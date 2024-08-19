import cloudinaryConfig from '../cloudinary/cloudinaryCofig.js';

cloudinaryConfig();

export const deleteImageFromCloudinary = async (imageId) => {
    try {
        await cloudinary.v2.uploader.destroy(imageId);
    } catch (error) {
        throw new Error('Failed to delete image from Cloudinary');
    }
};