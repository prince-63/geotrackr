import express from 'express';
import { inOfficeEmployeeJoin, getInOfficeEmployeeDetail, getOfficeLocationCordinates } from '../services/in-office-employee-service/in-office-employee-service.js';
import inOfficeEmployeeMiddleware from '../middleware/in-office-employee-middleware.js';
import { checkInAttendanceForInOfficeEmployee, checkOutAttendanceForInOfficeEmployee } from '../services/in-office-employee-service/in-office-employee-attendance.js';

const router = express.Router();

router.post('/employee-join', inOfficeEmployeeJoin);
router.get('/get-employee-detail', inOfficeEmployeeMiddleware, getInOfficeEmployeeDetail);
router.get('/get-office-location', inOfficeEmployeeMiddleware, getOfficeLocationCordinates);
router.post('/attendance/check-in', inOfficeEmployeeMiddleware, checkInAttendanceForInOfficeEmployee);
router.post('/attendance/check-out', inOfficeEmployeeMiddleware, checkOutAttendanceForInOfficeEmployee);

export default router;