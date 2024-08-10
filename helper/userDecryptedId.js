import dataDecryption from "./dataDecryption.js";

const userDecryptedId = (userEncryptedId) => {
    const decryptedData = dataDecryption(userEncryptedId);

    // spliting the decrypted data into 10 parts
    const dataLength = decryptedData.length;
    const partLength = Math.ceil(dataLength / 10);
    const parts = [];
    let start = 0;
    let end = partLength;
    for (let i = 0; i < 10; i++) {
        parts.push(decryptedData.slice(start, end));
        start = end;
        end += partLength;
    }

    // remove the garbage data from each part
    for (let i = 0; i < 10; i++) {
        parts[i] = parts[i].slice(0, -10);
    }

    // join all parts
    let decryptedId = "";
    for (let i = 0; i < 10; i++) {
        decryptedId = decryptedId + parts[i];
    }

    // final decryption
    decryptedId = dataDecryption(decryptedId);

    return decryptedId;
}

export default userDecryptedId;