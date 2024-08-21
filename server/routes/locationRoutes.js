import express from 'express';
import { getLocation } from '../services/locationService.js';
import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

router.get('/get-organization-location', protect, getLocation);

export default router;
