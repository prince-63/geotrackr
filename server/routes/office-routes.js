import { createOffice, getOfficeDetails, getAllInOfficeEmployees, getAllOutOfficeEmployees, getOfficeAddress, officeSingup, officeLogin } from '../services/office-service/office-service.js';
import { masterAdminLogin } from '../services/master-admin-service/master-admin-service.js';
import { createNewInOfficeEmployee } from '../services/in-office-employee-service/in-office-employee-service.js';
import masterAdminMiddleware from '../middleware/master-admin-middleware.js';
import { createNewOutOfficeEmployee, addSingleWorkFromOutOfficeEmployee, addListOfWorkFromOutOfficeEmployee } from '../services/out-office-employee-service/out-office-employee-service.js';
import express from 'express';

const router = express.Router();

router.post('/sign-up', officeSingup);
router.post('/login', officeLogin);
router.post('/create-office', createOffice);
router.get('/get-office-details', masterAdminMiddleware, getOfficeDetails);
router.get('/get-office-address', getOfficeAddress);
router.get('/get-all-in-office-employees', masterAdminMiddleware, getAllInOfficeEmployees);
router.get('/get-all-out-office-employees', masterAdminMiddleware, getAllOutOfficeEmployees);
router.post('/master-admin-login', masterAdminLogin);
router.post('/add-in-office-employee', masterAdminMiddleware, createNewInOfficeEmployee);
router.post('/add-out-office-employee', masterAdminMiddleware, createNewOutOfficeEmployee);
router.post('/add-single-work-for-in-office-employee', masterAdminMiddleware, addSingleWorkFromOutOfficeEmployee);
router.post('/add-list-of-work-for-in-office-employee', masterAdminMiddleware, addListOfWorkFromOutOfficeEmployee);

export default router;
