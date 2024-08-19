import express from 'express';
import { login, signup, logout, closeAccount } from '../services/authService.js';
import { protect } from '../middleware/authMiddleware.js';
import { verifyEmail, resendVerificationEmail } from '../services/userVerificationService.js';
import {
  forgotPassword,
  resetPasswordVerification,
  setNewPassword,
} from '../services/forgotPasswordService.js';

const router = express.Router();

router.post('/signup', signup);
router.post('/login', login);
router.post('/logout', logout);
router.post('/close-account', protect, closeAccount);
router.post('/verify-email', protect, verifyEmail);
router.post('/resend-verification-email', protect, resendVerificationEmail);
router.post('/forgot-password', forgotPassword);
router.post('/forgot-password/verification', resetPasswordVerification);
router.post('/forgot-password/set-new-password', setNewPassword);

export default router;
