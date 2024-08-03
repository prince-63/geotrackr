/* ============================= data encoding ============================ */

/**
 * Array of characters available in alphanumeric mode
 */
const ALPHA_NUM_CHARS = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    ' ', '$', '%', '*', '+', '-', '.', '/', ':'
];

/*
 * data = "HELLO123"
 * length = 8
 * 11 * (8 / 2) + 6 * (8 % 2) = 44 bits need in qr to store this data
 */
function getBitsLength(length /* length of alphanumeric data */) {
    return 11 * Math.floor(length / 2) + 6 * (length % 2);
}

function getDataLength(data) {
    return data.length;
}

function writeDataIntoBitBuffer(bitBuffer, data) {
    let i;

    for (i = 0; i + 2 <= data.length; i += 2) {
        let value = ALPHA_NUM_CHARS.indexOf(data[i]) * 45;
        value += ALPHA_NUM_CHARS.indexOf(data[i + 1]);
        bitBuffer.put(value, 11); // value store in 11 bit binary
    }

    // remaning data
    if (data.length % 2) {
        bitBuffer.put(ALPHA_NUM_CHARS.indexOf(data[i]), 6);
    }
}

