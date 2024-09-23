import express from 'express';
import officeMiddleware from '../middleware/office-middleware.js';
import employeeMiddleware from '../middleware/employee-middleware.js';
import {
  addOfficeEmployee,
  addRemoteEmployee,
  deleteEmployee,
  getEmployees,
  getEmployeeDetails,
  uploadProfileImage,
  updateEmployeeDetails,
  getOfficeDetails,
} from '../services/employee-service.js';

import multerMiddleware from '../middleware/multer-middleware.js';
const router = express.Router();

router.post('/add-office-employee', officeMiddleware, addOfficeEmployee);
router.post('/add-remote-employee', officeMiddleware, addRemoteEmployee);
router.delete('/delete-employee/:employeeId', officeMiddleware, deleteEmployee);
router.get('/get-employees', officeMiddleware, getEmployees);
router.get('/get-employee-details', employeeMiddleware, getEmployeeDetails);
router.get('/get-office-details', employeeMiddleware, getOfficeDetails);
router.post(
  '/update-profile-image',
  employeeMiddleware,
  multerMiddleware,
  uploadProfileImage
);
router.put(
  '/update-employee-details',
  employeeMiddleware,
  updateEmployeeDetails
);

export default router;
