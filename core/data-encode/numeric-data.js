const Mode = require("../helper/mode");

function NumericData(data) {
  this.mode = Mode.NUMERIC;
  this.data = data.toString();
}

/*
 * 10 * Math.floor(length / 3) -> This part calculates the number of bits needed to encode complete groups of three digits. 
 * Each group of three digits requires 10 bits for encoding.
 * 
 * ((length % 3) ? ((length % 3) * 3 + 1) : 0) -> This part deals with the remaining digits that don't fit into groups of three.
 * If there are 1 or 2 digits left after dividing into groups of three, they require 4 or 7 bits, respectively. 
 * This is calculated using the formula ((length % 3) * 3 + 1).
 * 
 * Example:
 * 
 * data = '0123456789'
 * length = 10 (length of the data)
 * 
 * 10 * Math.floor(10 / 3) = 30  -> calculates the bits needed for full groups of three digits
 * 
 * 10 % 3 = 1 -> (10 % 3) * 3 + 1 = 4 -> calculates the bits needed for the remaining digits
 * 
 * final_ans = 30 + 4 = 34 bits are required to store this data in a QR code
 */
NumericData.getBitsLength = function getBitsLength(length) {
  return 10 * Math.floor(length / 3) + (length % 3 ? (length % 3) * 3 + 1 : 0);
};

NumericData.prototype.getLength = function getLength() {
  return this.data.length;
};

/**
 * Return the total bits size need to store the provide data into a QR
 * */
NumericData.prototype.getBitsLength = function getBitsLength() {
  return NumericData.getBitsLength(this.data.length);
};

NumericData.prototype.write = function write(bitBuffer) {
  let i, value, group;

  // The input data string is divided into groups of three digits,
  // and each group is converted to its 10-bit binary equivalent.
  for (i = 0; i + 3 <= this.data.length; i += 3) {
    group = this.data.substr(i, 3);
    value = parseInt(group, 10);

    bitBuffer.put(value, 10);
  }

  // If the number of input digits is not an exact multiple of three,
  // the final one or two digits are converted to 4 or 7 bits respectively.
  const remainingNum = this.data.length - i;
  if (remainingNum > 0) {
    group = this.data.substr(i);
    value = parseInt(group, 10);

    bitBuffer.put(value, remainingNum * 3 + 1);
  }
};

module.exports = NumericData;
