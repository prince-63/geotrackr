const express = require('express');
const helmet = require('helmet');
const cors = require('cors');
const morgan = require('morgan');
const authRoutes = require('./routes/authRoutes');

const app = express();

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

// Routes
app.use('/api/v1/auth', authRoutes);

// Error handling
app.all('*', (req, res, next) => {
  res.status(404).json({ status: 'fail', message: `Can't find ${req.originalUrl} on this server!` });
});

module.exports = app;
