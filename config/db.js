const mongoose = require('mongoose');
require('dotenv').config();

const connectWithRetry = () => {
  console.log('MongoDB connection with retry');
  mongoose
    .connect(process.env.MONGO_URI)
    .then(() => {
      console.log('MongoDB is connected');
    })
    .catch((err) => {
      console.error(
        'MongoDB connection unsuccessful, retry after 5 seconds. ',
        err
      );
      setTimeout(connectWithRetry, 5000);
    });
};

module.exports = connectWithRetry;
