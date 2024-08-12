import express from 'express';
import { SetAttendance } from '../services/attendanceService.js';
import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/set-attendance', protect, SetAttendance);

export default router;
