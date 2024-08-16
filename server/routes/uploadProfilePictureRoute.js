import express from 'express';
import uploadProfilePictureService from '../services/uploadProfilePictureService.js';
import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/profile-picture', protect, uploadProfilePictureService);

export default router;