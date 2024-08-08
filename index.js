const dotenv = require('dotenv');
const app = require('./app');
const connectWithRetry = require('./config/db');

dotenv.config({ path: './.env' });

// Database connection initiated
connectWithRetry();

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`App running on port ${port}...`);
});