import crypto from 'crypto';

const defaulPasswordGenerator = () => {
  // Generate a random string
  const randomString = crypto.randomBytes(8).toString('hex'); // 16 characters (8 bytes * 2 hex characters per byte)

  // Hash the random string using SHA-256 and take the first 16 characters
  const hash = crypto
    .createHash('sha256')
    .update(randomString)
    .digest('hex')
    .substring(0, 8);

  return hash;
};

export default defaulPasswordGenerator;
