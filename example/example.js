/* function generateQRCode() {
    const data = document.getElementById('data').value;
    const canvas = document.getElementById('qrcode');

    QRCode.toCanvas(canvas, data, function (error) {
        if (error) console.error(error);
        console.log('QR code generated!');
    });
}

function encodeData(data) {
    // Simplified alphanumeric encoding
    const alphanumeric = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz $%*+-./:';
    let binary = '';
    for (let i = 0; i < data.length; i++) {
        const index = alphanumeric.indexOf(data[i]);
        if (index === -1) {
            throw new Error('Unsupported character: ' + data[i]);
        }
        binary += index.toString(2).padStart(6, '0');
    }
    return binary;
}

function generateMatrix(data) {
    // Simplified fixed-size matrix (21x21 for version 1 QR code)
    const size = 21;
    const matrix = Array.from({ length: size }, () => Array(size).fill(0));

    // Add finder patterns
    addPositionDetectionPattern(matrix, 0, 0);
    addPositionDetectionPattern(matrix, size - 7, 0);
    addPositionDetectionPattern(matrix, 0, size - 7);

    // Add timing patterns
    addTimingPatterns(matrix);

    // Add data (simplified, no error correction)
    addData(matrix, data);
    return matrix;
}

function addData(matrix, data) {
    let dataIndex = 0;
    for (let row = matrix.length - 1; row >= 0; row--) {
        for (let col = matrix.length - 1; col >= 0; col--) {
            if ((row < 9 && col < 9) || (row < 9 && col >= matrix.length - 8) || (row >= matrix.length - 8 && col < 9)) {
                // Skip finder patterns
                continue;
            }
            if (dataIndex < data.length) {
                matrix[row][col] = data[dataIndex] === '1' ? 1 : 0;
                dataIndex++;
            }
        }
    }
}

function addPositionDetectionPattern(matrix, row, col) {
    const pattern = [
        [1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 0, 1],
        [1, 0, 1, 1, 1, 0, 1],
        [1, 0, 1, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1]
    ];
    for (let r = 0; r < pattern.length; r++) {
        for (let c = 0; c < pattern[r].length; c++) {
            matrix[row + r][col + c] = pattern[r][c];
        }
    }
}

function addTimingPatterns(matrix) {
    const size = matrix.length;
    for (let i = 8; i < size - 8; i++) {
        matrix[6][i] = i % 2 === 0 ? 1 : 0;
        matrix[i][6] = i % 2 === 0 ? 1 : 0;
    }
} */

const QRCode = require("../lib");

QRCode.toFile(
  "example.png",
  "https://github.com",
  {
    color: {
      dark: "#ffffff", // Blue dots
      light: "#0000", // Transparent background
    },
  },
  function (err) {
    if (err) throw err;
    console.log("done");
  }
);
