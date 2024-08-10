import dataEncryption from '../helper/dataEncryption.js';

export const generateIdCard = async (req, res) => {
  try {
    const data = req.body.data;
    const encryptedData = dataEncryption(data);
    res.status(200).json({ status: 'success', data: encryptedData });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};
