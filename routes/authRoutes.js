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
import { generateIdCard } from '../services/idCardService.js';

const router = express.Router();

router.post('/signup', signup);
router.post('/login', login);
router.post('/logout', logout);
router.post('/verify-email', protect, verifyEmail);
router.post('/forgotPassword', forgotPassword);
router.patch('/resetPassword/:token', resetPassword);
router.post('/idCard', protect, generateIdCard);

export default router;
