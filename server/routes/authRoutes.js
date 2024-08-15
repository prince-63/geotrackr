import express from 'express';
import { login, signup, logout } from '../services/authService.js';
import { protect } from '../middleware/authMiddleware.js';
import { verifyEmail } from '../services/userVerificationService.js';
import {
  forgotPassword,
  resetPasswordVerification,
  setNewPassword,
} from '../services/forgotPasswordService.js';

const router = express.Router();

router.post('/signup', signup);
router.post('/login', login);
router.post('/logout', logout);
router.post('/verify-email', protect, verifyEmail);
router.post('/forgot-password', forgotPassword);
router.post('/forgot-password/verification', resetPasswordVerification);
router.post('/forgot-password/set-new-password', setNewPassword);

export default router;
