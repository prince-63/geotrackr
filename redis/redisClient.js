import { promisify } from 'util';

import { createClient } from 'redis';

const client = createClient({
  password: process.env.REDIS_PASSWORD,
  socket: {
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT,
  },
});

client
  .connect()
  .then(() => {
    if (client.isOpen) {
      console.log('Connected to Redis');
    }
  })
  .catch((err) => {
    console.error('Redis connection error:', err);
  });

client.on('error', (err) => {
  console.error('Redis error:', err);
});

export default client;
