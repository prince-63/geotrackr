const QRCode = require("qrcode");
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
 