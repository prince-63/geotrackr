import dataEncryption from './dataEncryption.js';
import generateRandomString from './generateRandomString.js';

const userEncryptedId = (userEmail) => {
    const encryptedData = dataEncryption(userEmail);

    // splitting encrypted data into 10 parts
    const dataLength = encryptedData.length;
    const partLength = Math.ceil(dataLength / 10);
    const parts = [];
    let start = 0;
    let end = partLength;
    for (let i = 0; i < 10; i++) {
        parts.push(encryptedData.slice(start, end));
        start = end;
        end += partLength;
    }

    // generated random string add to each part of encrypted data
    const randomString = generateRandomString(10);
    for (let i = 0; i < 10; i++) {
        parts[i] = parts[i] + randomString;
    }

    // join all parts
    let encryptedId = '';
    for (let i = 0; i < 10; i++) {
        encryptedId = encryptedId + parts[i];
    }

    // again encrypt the ecryptedId
    const finalEncryptedId = dataEncryption(encryptedId);
    return finalEncryptedId;
};

export default userEncryptedId;
