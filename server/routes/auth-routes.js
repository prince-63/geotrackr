import express from 'express';
import {
  loginEmployee,
  forgotPassword,
  verifyResetPassword,
  setNewPassword,
} from '../services/auth-service.js';

const router = express.Router();

router.post('/login-employee', loginEmployee);
router.post('/forgot-password', forgotPassword);
router.post('/verify-reset-password', verifyResetPassword);
router.post('/set-new-password', setNewPassword);

export default router;
