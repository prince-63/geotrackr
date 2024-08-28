import express from 'express';
import { outOfficeEmployeeJoin, getOutOfficeEmployeeDetail } from '../services/out-office-employee-service/out-office-employee-service.js';
import outOfficeEmployeeMiddleware from '../middleware/out-office-employee-middleware.js';
import { checkInAttendanceForOutOfficeEmployee, checkOutAttendanceForOutOfficeEmployee } from '../services/out-office-employee-service/out-office-employee-attendance.js';

const router = express.Router();

router.post('/employee-join', outOfficeEmployeeJoin);
router.get('/get-employee-detail', outOfficeEmployeeMiddleware, getOutOfficeEmployeeDetail);
router.post('/attendance/check-in', outOfficeEmployeeMiddleware, checkInAttendanceForOutOfficeEmployee);
router.post('/attendance/check-out', outOfficeEmployeeMiddleware, checkOutAttendanceForOutOfficeEmployee);

export default router;