import { updateOfficeDetails, getOfficeDetails, officeSingup, officeLogin, officeLogout } from '../services/office-service.js';
import officeMiddleware from '../middleware/office-middleware.js';
import express from 'express';

const router = express.Router();

router.post('/sign-up', officeSingup);
router.post('/login', officeLogin);
router.post('/logout', officeMiddleware, officeLogout);
router.put('/update-details', officeMiddleware, updateOfficeDetails);
router.get('/get-details', officeMiddleware, getOfficeDetails);

export default router;
