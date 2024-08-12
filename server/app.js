import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import morgan from 'morgan';
import session from 'express-session';
import authRoutes from './routes/authRoutes.js';
import idCardRoutes from './routes/idCardRoutes.js';
import attendanceRoutes from './routes/attendanceRoutes.js';
import { EventEmitter } from 'events';

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

// Routes
app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/id-card', idCardRoutes);
app.use('/api/v1/attendance', attendanceRoutes);

// testing
app.get("/", (req, res) => {
    res.send("Hello World")
});

// Error handling
app.all('*', (req, res, next) => {
  res.status(404).json({
    status: 'fail',
    message: `Can't find ${req.originalUrl} on this server!`,
  });
});

export { app as default };
