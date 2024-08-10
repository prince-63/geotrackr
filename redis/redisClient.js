import { promisify } from 'util';

import { createClient } from 'redis';

const client = createClient({
  password: 'dvAZ1h1Etoq5FFaIRdKrvshcwy1IoT7R',
  socket: {
    host: 'redis-11122.c301.ap-south-1-1.ec2.redns.redis-cloud.com',
    port: 11122,
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
