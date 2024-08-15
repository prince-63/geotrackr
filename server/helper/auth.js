import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

export const comparePassword = async (candidatePassword, userPassword) => {
  return await bcrypt.compare(candidatePassword, userPassword);
};

export const hashPassword = async (password) => {
  return await bcrypt.hash(password, 12);
};

export const signToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};
