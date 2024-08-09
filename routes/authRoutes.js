import express from 'express';
import {
  login,
  signup,
  verifyEmail,
  forgotPassword,
  resetPassword,
} from '../services/authService.js';
import { protect } from '../middleware/authMiddleware.js';
const router = express.Router();

router.post('/signup', signup);
router.post('/login', login);
router.post('/verify-email', protect, verifyEmail);
router.post('/forgotPassword', forgotPassword);
router.patch('/resetPassword/:token', resetPassword);

export default router;
