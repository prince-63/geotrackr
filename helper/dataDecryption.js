import crypto from 'crypto';

const text = process.env.DATA_ENCRYPTION_KEY;
const key = crypto
  .createHash('sha256')
  .update(String(text))
  .digest('base64')
  .substr(0, 32);

const aesDecrypt = (encrypted) => {
  const [ivHex, encryptedData] = encrypted.split(':');
  const iv = Buffer.from(ivHex, 'hex');
  const decipher = crypto.createDecipheriv('aes-256-cbc', key, iv);
  let decrypted = decipher.update(encryptedData, 'hex', 'utf8');
  decrypted += decipher.final('utf8');
  return decrypted;
};

export default aesDecrypt;
