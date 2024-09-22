import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import morgan from 'morgan';
import session from 'express-session';
import globalErrorHandler from './handlers/global-error-handler.js';
import { EventEmitter } from 'events';
import roleRoutes from './routes/role-routes.js';
import officeRoutes from './routes/office-routes.js';
import authRoutes from './routes/auth-routes.js';
import employeeRoutes from './routes/employee-routes.js';
import attendanceRoutes from './routes/attendance-routes.js';

EventEmitter.defaultMaxListeners = 20;

const app = express();

// Middleware
app.use(helmet());
app.use(
  cors({
    // any origin can access this API
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'HEAD'],
    credentials: true,
  })
);
app.use(morgan('dev'));
app.use(express.json());
app.use(
  session({
    secret: process.env.JWT_SECRET,
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }, // Set to true if using HTTPS
  })
);

// version
const version = process.env.VERSION || 'v1';

// Routes
app.use(`/api/${version}/office`, roleRoutes);
app.use(`/api/${version}/office`, authRoutes);
app.use(`/api/${version}/office`, officeRoutes);
app.use(`/api/${version}/office`, employeeRoutes);
app.use(`/api/${version}/office/employee`, attendanceRoutes);
app.use(globalErrorHandler);

// testing
app.get('/', (req, res) => {
  res.send('Hello World');
});

// Error handling
app.all('*', (req, res, next) => {
  res.status(404).json({
    status: 'fail',
    message: `Can't find ${req.originalUrl} on this server!`,
  });
});

export { app as default };
