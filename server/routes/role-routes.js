import express from 'express';
import { addRole } from '../services/role-service.js';

const router = express.Router();

router.post('/add-role', addRole);

export default router;
