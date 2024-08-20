import express from 'express';
import {
  profilePictureUpload,
  profileDetailsUpload,
  getProfileDetails,
} from '../services/profileService.js';
import { protect } from '../middleware/authMiddleware.js';
import upload from '../multer/multerConfig.js';

const router = express.Router();

router.post('/upload/profile-picture', protect, upload, profilePictureUpload);
router.post('/upload/profile-details', protect, profileDetailsUpload);
router.get('/get-profile-details', protect, getProfileDetails);

export default router;
