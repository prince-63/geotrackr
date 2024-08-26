import express from 'express';
import { outOfficeEmployeeJoin } from '../services/out-office-employee-service/out-office-employee-service.js';
import outOfficeEmployeeMiddleware from '../middleware/out-office-employee-middleware.js';

const router = express.Router();

router.post('/employee-join', outOfficeEmployeeJoin);
router.post('/middleware-check', outOfficeEmployeeMiddleware);

export default router;