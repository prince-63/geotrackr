import express from 'express';
import { checkIn, checkOut, getUserAttendance } from '../services/attendanceService.js';
import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/check-in', protect, checkIn);
router.post('/check-out', protect, checkOut);
router.get('/get-user-attendance', protect, getUserAttendance);

export default router;
