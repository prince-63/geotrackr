/* const QRCode = require("qrcode");
const { createCanvas } = require("canvas");
const fs = require("fs");

class LayeredQRCode {
  constructor(version, errorCorrectionLevel) {
    this.version = version;
    this.errorCorrectionLevel = errorCorrectionLevel;
    this.size = this.getQRCodeSize(version);
    this.usedPositions = Array(this.size)
      .fill()
      .map(() => Array(this.size).fill(false));
    this.layers = [];
  }

  getQRCodeSize(version) {
    return 21 + (version - 1) * 4;
  }

  generateLayer(data) {
    const qr = QRCode.create(data, {
      version: this.version,
      errorCorrectionLevel: this.errorCorrectionLevel,
    });
    const matrix = qr.modules.data;
    const layer = Array(this.size)
      .fill()
      .map(() => Array(this.size).fill(null));

    for (let row = 0; row < this.size; row++) {
      for (let col = 0; col < this.size; col++) {
        if (!this.usedPositions[row][col] && matrix[row * this.size + col]) {
          layer[row][col] = matrix[row * this.size + col];
          this.usedPositions[row][col] = true;
        }
      }
    }

    this.layers.push(layer);
  }

  saveLayersAsPNG() {
    for (let i = 0; i < this.layers.length; i++) {
      const canvas = createCanvas(this.size, this.size);
      const ctx = canvas.getContext("2d");

      // Set the canvas background to transparent
      ctx.clearRect(0, 0, this.size, this.size);

      for (let row = 0; row < this.size; row++) {
        for (let col = 0; col < this.size; col++) {
          if (this.layers[i][row][col]) {
            ctx.fillStyle = "black";
            ctx.fillRect(col, row, 1, 1);
          }
        }
      }

      const buffer = canvas.toBuffer("image/png");
      fs.writeFileSync(`layer${i + 1}.png`, buffer);
    }
  }
}

// Usage
const layeredQRCode = new LayeredQRCode(2, "M");
const dataParts = ["Part1", "Part2", "Part3", "Part4", "Part5", "Part6"];

dataParts.forEach((data) => layeredQRCode.generateLayer(data));
layeredQRCode.saveLayersAsPNG();
 */
const QRCode = require('qrcode');
const { createCanvas } = require('canvas');
const fs = require('fs');

class LayeredQRCode {
  constructor(version, errorCorrectionLevel) {
    this.version = version;
    this.errorCorrectionLevel = errorCorrectionLevel;
    this.size = this.getQRCodeSize(version);
    this.usedPositions = Array(this.size).fill().map(() => Array(this.size).fill(false));
    this.layers = [];
    this.baseMatrix = this.createBaseMatrix();
  }

  getQRCodeSize(version) {
    return 21 + (version - 1) * 4;
  }

  createBaseMatrix() {
    // Use a placeholder text to create the base matrix
    const placeholderText = 'BASE';
    const qr = QRCode.create(placeholderText, { version: this.version, errorCorrectionLevel: this.errorCorrectionLevel });
    const matrix = qr.modules.data;
    const baseMatrix = Array(this.size).fill().map(() => Array(this.size).fill(null));

    for (let row = 0; row < this.size; row++) {
      for (let col = 0; col < this.size; col++) {
        if (matrix[row * this.size + col]) {
          baseMatrix[row][col] = matrix[row * this.size + col];
          this.usedPositions[row][col] = true;
        }
      }
    }

    return baseMatrix;
  }

  generateLayer(data) {
    const qr = QRCode.create(data, { version: this.version, errorCorrectionLevel: this.errorCorrectionLevel });
    const matrix = qr.modules.data;
    const layer = Array(this.size).fill().map(() => Array(this.size).fill(null));

    for (let row = 0; row < this.size; row++) {
      for (let col = 0; col < this.size; col++) {
        if (!this.usedPositions[row][col] && matrix[row * this.size + col]) {
          layer[row][col] = matrix[row * this.size + col];
          this.usedPositions[row][col] = true;
        }
      }
    }

    this.layers.push(layer);
  }

  combineLayers() {
    const combinedMatrix = Array(this.size).fill().map(() => Array(this.size).fill(null));

    // Add base matrix patterns
    for (let row = 0; row < this.size; row++) {
      for (let col = 0; col < this.size; col++) {
        if (this.baseMatrix[row][col]) {
          combinedMatrix[row][col] = this.baseMatrix[row][col];
        }
      }
    }

    // Add layers
    this.layers.forEach(layer => {
      for (let row = 0; row < this.size; row++) {
        for (let col = 0; col < this.size; col++) {
          if (layer[row][col]) {
            combinedMatrix[row][col] = layer[row][col];
          }
        }
      }
    });

    return combinedMatrix;
  }

  saveMatrixAsPNG(matrix, filename) {
    const canvas = createCanvas(this.size * 10, this.size * 10); // Scale up for better visibility
    const ctx = canvas.getContext('2d');

    // Set the canvas background to white
    ctx.fillStyle = 'white';
    ctx.fillRect(0, 0, this.size * 10, this.size * 10);

    for (let row = 0; row < this.size; row++) {
      for (let col = 0; col < this.size; col++) {
        if (matrix[row][col]) {
          ctx.fillStyle = 'black';
          ctx.fillRect(col * 10, row * 10, 10, 10); // Scale up for better visibility
        }
      }
    }

    const buffer = canvas.toBuffer('image/png');
    fs.writeFileSync(filename, buffer);
  }

  saveLayersAsPNG() {
    for (let i = 0; i < this.layers.length; i++) {
      this.saveMatrixAsPNG(this.layers[i], `layer${i + 1}.png`);
    }
  }

  saveCombinedAsPNG() {
    const combinedMatrix = this.combineLayers();
    this.saveMatrixAsPNG(combinedMatrix, 'combined.png');
  }
}

// Usage
const layeredQRCode = new LayeredQRCode(2, 'M');
const dataParts = ['Part1', 'Part2', 'Part3', 'Part4', 'Part5', 'Part6'];

dataParts.forEach(data => layeredQRCode.generateLayer(data));
layeredQRCode.saveLayersAsPNG();
layeredQRCode.saveCombinedAsPNG();