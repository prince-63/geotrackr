import express from 'express';
import { profilePictureUpload, profileDetailsUpload } from '../services/profileService.js';
import { protect } from '../middleware/authMiddleware.js';
import upload from '../multer/multerConfig.js';

const router = express.Router();

router.post('/upload/profile-picture', protect, upload, profilePictureUpload);
router.post('/upload/profile-details', protect, profileDetailsUpload);

export default router;