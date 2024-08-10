import express from 'express';
import {
  login,
  signup,
  logout,
  verifyEmail,
  forgotPassword,
  resetPassword,
} from '../services/authService.js';
import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/signup', signup);
router.post('/login', login);
router.post('/logout', logout);
router.post('/verify-email', protect, verifyEmail);
router.post('/forgot-password', forgotPassword);
router.patch('/reset-password/:token', resetPassword);

export default router;
