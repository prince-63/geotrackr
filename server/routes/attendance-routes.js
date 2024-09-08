import express from 'express';
import { checkIn, checkOut } from '../services/attendance-service.js';
import employeeMiddleware from '../middleware/employee-middleware.js';

const router = express.Router();

router.post('/check-in', employeeMiddleware, checkIn);
router.post('/check-out', employeeMiddleware, checkOut);

export default router;