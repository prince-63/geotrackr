function generateQRCode() {
    const data = document.getElementById('data').value;
    const canvas = document.getElementById('qrcode');
    const ctx = canvas.getContext('2d');
    const size = 200; // Size of the QR code
    const qrData = encodeData(data);
    const qrMatrix = generateMatrix(qrData);

    // Clear the canvas
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Draw the QR code
    const cellSize = size / qrMatrix.length;
    for (let row = 0; row < qrMatrix.length; row++) {
        for (let col = 0; col < qrMatrix[row].length; col++) {
            ctx.fillStyle = qrMatrix[row][col] ? 'black' : 'white';
            ctx.fillRect(col * cellSize, row * cellSize, cellSize, cellSize);
        }
    }
}

function encodeData(data) {
    // Simplified alphanumeric encoding
    const alphanumeric = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:';
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
    addFinderPattern(matrix, 0, 0);
    addFinderPattern(matrix, size - 7, 0);
    addFinderPattern(matrix, 0, size - 7);

    // Add timing patterns
    addTimingPatterns(matrix);

    // Add data (simplified, no error correction)
    let dataIndex = 0;
    for (let row = size - 1; row >= 0; row--) {
        for (let col = size - 1; col >= 0; col--) {
            if ((row < 9 && col < 9) || (row < 9 && col >= size - 8) || (row >= size - 8 && col < 9)) {
                // Skip finder patterns
                continue;
            }
            if (dataIndex < data.length) {
                matrix[row][col] = data[dataIndex] === '1' ? 1 : 0;
                dataIndex++;
            }
        }
    }

    return matrix;
}

function addFinderPattern(matrix, row, col) {
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
}