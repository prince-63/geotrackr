import { sendMessage } from '../services/contact-service.js';
import express from 'express';

const router = express.Router();

router.post('/send-message', sendMessage);

export default router;
