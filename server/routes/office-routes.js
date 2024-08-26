import { createOffice } from '../services/office-service/office-service.js';
import { masterAdminLogin } from '../services/master-admin-service/master-admin-service.js';
import {
  createNewInOfficeEmployee,
  inOfficeEmployeeJoin,
} from '../services/in-office-employee-service/in-office-employee-service.js';
import masterAdminMiddleware from '../middleware/master-admin-middleware.js';
import {
  createNewOutOfficeEmployee,
  outOfficeEmployeeJoin,
  addSingleWorkFromOutOfficeEmployee,
  addListOfWorkFromOutOfficeEmployee,
} from '../services/out-office-employee-service/out-office-employee-service.js';
import express from 'express';

const router = express.Router();

router.post('/create-office', createOffice);
router.post('/master-admin-login', masterAdminLogin);
router.post(
  '/add-in-office-employee',
  masterAdminMiddleware,
  createNewInOfficeEmployee
);
router.post(
  '/add-out-office-employee',
  masterAdminMiddleware,
  createNewOutOfficeEmployee
);
router.post('/in-office-employee-join', inOfficeEmployeeJoin);
router.post('/out-office-employee-join', outOfficeEmployeeJoin);
router.post(
  '/add-single-work-for-in-office-employee',
  masterAdminMiddleware,
  addSingleWorkFromOutOfficeEmployee
);
router.post(
  '/add-list-of-work-for-in-office-employee',
  masterAdminMiddleware,
  addListOfWorkFromOutOfficeEmployee
);

export default router;
