import express from 'express';
import uploadProfilePictureService from '../services/uploadProfilePictureService.js';

const router = express.Router();

router.post('/upload-profile-picture', uploadProfilePictureService);

export default router;