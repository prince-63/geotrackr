const Mode = require("../helper/mode");

function ByteData(data) {
  this.mode = Mode.BYTE;

  if (typeof data === "string") {
    this.data = new TextEncoder().encode(data);
  } else {
    this.data = new Uint8Array(data);
  }
}

/*
 * data = "ABC"
 * length = 3
 * 3 * 8 = 24 bits need in qr to store this data
 */
ByteData.getBitsLength = function getBitsLength(length) {
  return length * 8;
};

ByteData.prototype.getLength = function getLength() {
  return this.data.length;
};

ByteData.prototype.getBitsLength = function getBitsLength() {
  return ByteData.getBitsLength(this.data.length);
};

ByteData.prototype.write = function write(bitBuffer) {
  for (let i = 0; i < this.data.length; i += 1) {
    bitBuffer.put(this.data[i], 8);
  }
};

module.exports = ByteData;
