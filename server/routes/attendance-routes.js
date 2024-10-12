import express from 'express';
import {
  checkIn,
  checkOut,
  getEmployeeAttendance,
  getEmployeeTodayAttendance,
} from '../services/attendance-service.js';
import employeeMiddleware from '../middleware/employee-middleware.js';

const router = express.Router();

router.post('/check-in', employeeMiddleware, checkIn);
router.post('/check-out', employeeMiddleware, checkOut);
router.get('/attendances', employeeMiddleware, getEmployeeAttendance);
router.get(
  '/today-attendance',
  employeeMiddleware,
  getEmployeeTodayAttendance
);

export default router;
