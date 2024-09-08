import bcrypt from 'bcrypt';

export const comparePassword = async (candidatePassword, userPassword) => {
    return await bcrypt.compare(candidatePassword, userPassword);
};

export const hashPassword = async (password) => {
    return await bcrypt.hash(password, 12);
};
