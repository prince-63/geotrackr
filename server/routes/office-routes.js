import { uploadOfficeDetails, updateOfficeDetails, getOfficeDetails, getAllInOfficeEmployees, getAllOutOfficeEmployees, getOfficeAddress, officeSingup, officeLogin } from '../services/office-service/office-service.js';
import { createNewInOfficeEmployee, updateInOfficeEmployee, deleteInOfficeEmployee } from '../services/in-office-employee-service/in-office-employee-service.js';
import officeMiddleware from '../middleware/office-middleware.js';
import { createNewOutOfficeEmployee, addSingleWorkFromOutOfficeEmployee, addListOfWorkFromOutOfficeEmployee } from '../services/out-office-employee-service/out-office-employee-service.js';
import express from 'express';

const router = express.Router();

router.post('/sign-up', officeSingup);
router.post('/login', officeLogin);
router.post('/upload-details', officeMiddleware, uploadOfficeDetails);
router.put('/update-details', officeMiddleware, updateOfficeDetails);
router.get('/get-details', officeMiddleware, getOfficeDetails);
router.get('/get-office-address', getOfficeAddress);
router.get('/get-all-in-office-employees', officeMiddleware, getAllInOfficeEmployees);
router.put('/update-in-office-employee/:employeeId', officeMiddleware, updateInOfficeEmployee);
router.delete(`/delete-in-office-employee/:employeeId`, officeMiddleware, deleteInOfficeEmployee);
router.get('/get-all-out-office-employees', officeMiddleware, getAllOutOfficeEmployees);
router.post('/add-in-office-employee', officeMiddleware, createNewInOfficeEmployee);
router.post('/add-out-office-employee', officeMiddleware, createNewOutOfficeEmployee);
router.post('/add-single-work-for-in-office-employee', officeMiddleware, addSingleWorkFromOutOfficeEmployee);
router.post('/add-list-of-work-for-in-office-employee', officeMiddleware, addListOfWorkFromOutOfficeEmployee);

export default router;
