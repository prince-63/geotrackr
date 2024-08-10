import crypto from 'crypto';

const text = process.env.DATA_ENCRYPTION_KEY;
const key = crypto
  .createHash('sha256')
  .update(String(text))
  .digest('base64')
  .substr(0, 32);
const iv = crypto.randomBytes(16);

const aesEncrypt = (data) => {
  const cipher = crypto.createCipheriv('aes-256-cbc', key, iv);
  let encrypted = cipher.update(data, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  return `${iv.toString('hex')}:${encrypted}`;
};

export default aesEncrypt;
