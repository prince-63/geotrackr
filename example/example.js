function generateQRCode() {
  const data = document.getElementById("data").value;
  const canvas = document.getElementById("qrcode");
  const ctx = canvas.getContext("2d");
  const size = 200; // Size of the QR code
  const qrData = encodeData(data);
  const qrMatrix = generateMatrix(qrData);

  // Clear the canvas
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  // Draw the QR code
  const cellSize = size / qrMatrix.length;
  for (let row = 0; row < qrMatrix.length; row++) {
    for (let col = 0; col < qrMatrix[row].length; col++) {
      ctx.fillStyle = qrMatrix[row][col] ? "black" : "white";
      ctx.fillRect(col * cellSize, row * cellSize, cellSize, cellSize);
    }
  }
}

function encodeData(data) {
  const alphanumeric = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:";
  let binary = "";

  for (let i = 0; i < data.length; i += 2) {
    if (i + 1 < data.length) {
      // Encode pairs of characters
      const index1 = alphanumeric.indexOf(data[i]);
      const index2 = alphanumeric.indexOf(data[i + 1]);
      if (index1 === -1 || index2 === -1) {
        throw new Error("Unsupported character: " + data[i] + data[i + 1]);
      }
      const pairValue = index1 * 45 + index2;
      binary += pairValue.toString(2).padStart(11, "0");
    } else {
      // Encode the last single character
      const index = alphanumeric.indexOf(data[i]);
      if (index === -1) {
        throw new Error("Unsupported character: " + data[i]);
      }
      binary += index.toString(2).padStart(6, "0");
    }
  }

  return binary;
}

function generateMatrix(data) {
  // Simplified fixed-size matrix (21x21 for version 1 QR code)
  const size = 21;
  const matrix = Array.from({ length: size }, () => Array(size).fill(0));

  // Add finder patterns
  addFinderPattern(matrix, 0, 0);
  addFinderPattern(matrix, size - 7, 0);
  addFinderPattern(matrix, 0, size - 7);

  // Add timing patterns
  addTimingPatterns(matrix);

  // Add data with error correction
  const dataWithEC = addErrorCorrection(data);
  let dataIndex = 0;
  let upward = true;

  for (let col = size - 1; col > 0; col -= 2) {
    if (col === 6) col--; // Skip vertical timing pattern
    for (
      let row = upward ? size - 1 : 0;
      upward ? row >= 0 : row < size;
      row += upward ? -1 : 1
    ) {
      for (let c = col; c > col - 2; c--) {
        if (matrix[row][c] === 0 && dataIndex < dataWithEC.length) {
          matrix[row][c] = dataWithEC[dataIndex] === "1" ? 1 : 0;
          dataIndex++;
        }
      }
    }
    upward = !upward; // Change direction
  }

  return matrix;
}

function addFinderPattern(matrix, row, col) {
  const pattern = [
    [1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 1, 1, 0, 1],
    [1, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 1],
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
}

function addErrorCorrection(data) {
  // Simplified Reed-Solomon error correction (not a full implementation)
  const errorCorrectionLevel = 7; // Number of error correction codewords
  const dataCodewords = data.match(/.{1,8}/g).map((byte) => parseInt(byte, 2));
  const generatorPolynomial = [87, 229, 146, 149, 238, 102, 21]; // Example generator polynomial for level 7

  let errorCorrectionCodewords = new Array(errorCorrectionLevel).fill(0);
  for (let i = 0; i < dataCodewords.length; i++) {
    const coefficient = dataCodewords[i] ^ errorCorrectionCodewords[0];
    errorCorrectionCodewords = errorCorrectionCodewords.slice(1).concat(0);
    for (let j = 0; j < generatorPolynomial.length; j++) {
      errorCorrectionCodewords[j] ^= multiplyGF256(
        coefficient,
        generatorPolynomial[j]
      );
    }
  }

  const errorCorrectionBits = errorCorrectionCodewords
    .map((codeword) => codeword.toString(2).padStart(8, "0"))
    .join("");

  return data + errorCorrectionBits;
}

function multiplyGF256(a, b) {
  let result = 0;
  for (let i = 0; i < 8; i++) {
    if (b & 1) {
      result ^= a;
    }
    const carry = a & 0x80;
    a = (a << 1) & 0xff;
    if (carry) {
      a ^= 0x1d;
    }
    b >>= 1;
  }
  return result;
}
