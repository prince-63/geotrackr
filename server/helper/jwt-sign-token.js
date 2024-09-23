import jwt from 'jsonwebtoken';
import { parseDuration } from '../utils/parse-duration.js';

const JWT_EXPIRES_IN = parseDuration(process.env.JWT_EXPIRES_IN);

const signToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: JWT_EXPIRES_IN,
  });
};

export default signToken;
