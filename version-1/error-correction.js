/**
 * Error Correction Levels for QR codes.
 * Each level corresponds to a different bit value.
 */
const ECLevel = {
  L: { bit: 1 }, // Low
  M: { bit: 0 }, // Medium
  Q: { bit: 3 }, // Quartile
  H: { bit: 2 }, // High
};

/**
 * Converts a string representation of an error correction level to its corresponding object.
 *
 * @param  {String} string String representation of the error correction level
 * @return {Object}        Corresponding error correction level object
 * @throws {Error}         If the input string does not match any known error correction level
 */
function fromString(string) {
  if (typeof string !== "string") {
    throw new Error("Parameter is not a string");
  }

  const lcStr = string.toLowerCase();

  switch (lcStr) {
    case "l":
    case "low":
      return ECLevel.L;
    case "m":
    case "medium":
      return ECLevel.M;
    case "q":
    case "quartile":
      return ECLevel.Q;
    case "h":
    case "high":
      return ECLevel.H;
    default:
      throw new Error("Unknown EC Level: " + string);
  }
}

/**
 * Checks if the provided level object is a valid error correction level.
 *
 * @param  {Object} level Error correction level object
 * @return {Boolean}      True if the level is valid, false otherwise
 */
function isValid(level) {
  return (
    level && typeof level.bit !== "undefined" && level.bit >= 0 && level.bit < 4
  );
}

/**
 * Converts a value to a valid error correction level.
 * If the value is invalid, the defaultValue is returned.
 *
 * @param  {any} value            The value to convert
 * @param  {Object} defaultValue  Default value if the conversion fails
 * @return {Object}               Valid error correction level
 */
function from(value, defaultValue) {
  if (isValid(value)) {
    return value;
  }

  try {
    return fromString(value);
  } catch (e) {
    return defaultValue;
  }
}

/**
 * Precomputed tables for error correction block and codeword counts.
 * These are based on QR code version and error correction level.
 */
const EC_BLOCKS_TABLE = [
  // L  M  Q  H
  1, 1, 1, 1,
  1, 1, 1, 1,
  1, 1, 2, 2,
  1, 2, 2, 4,
  1, 2, 4, 4,
  2, 4, 4, 4,
  2, 4, 6, 5,
  2, 4, 6, 6,
  2, 5, 8, 8,
  4, 5, 8, 8,
  4, 5, 8, 11,
  4, 8, 10, 11,
  4, 9, 12, 16,
  4, 9, 16, 16,
  6, 10, 12, 18,
  6, 10, 17, 16,
  6, 11, 16, 19,
  6, 13, 18, 21,
  7, 14, 21, 25,
  8, 16, 20, 25,
  8, 17, 23, 25,
  9, 17, 23, 34,
  9, 18, 25, 30,
  10, 20, 27, 32,
  12, 21, 29, 35,
  12, 23, 34, 37,
  12, 25, 34, 40,
  13, 26, 35, 42,
  14, 28, 38, 45,
  15, 29, 40, 48,
  16, 31, 43, 51,
  17, 33, 45, 54,
  18, 35, 48, 57,
  19, 37, 51, 60,
  19, 38, 53, 63,
  20, 40, 56, 66,
  21, 43, 59, 70,
  22, 45, 62, 74,
  24, 47, 65, 77,
  25, 49, 68, 81
];

const EC_CODEWORDS_TABLE = [
  // L  M  Q  H
  7, 10, 13, 17,
  10, 16, 22, 28,
  15, 26, 36, 44,
  20, 36, 52, 64,
  26, 48, 72, 88,
  36, 64, 96, 112,
  40, 72, 108, 130,
  48, 88, 132, 156,
  60, 110, 160, 192,
  72, 130, 192, 224,
  80, 150, 224, 264,
  96, 176, 260, 308,
  104, 198, 288, 352,
  120, 216, 320, 384,
  132, 240, 360, 432,
  144, 280, 408, 480,
  168, 308, 448, 532,
  180, 338, 504, 588,
  196, 364, 546, 650,
  224, 416, 600, 700,
  224, 442, 644, 750,
  252, 476, 690, 816,
  270, 504, 750, 900,
  300, 560, 810, 960,
  312, 588, 870, 1050,
  336, 644, 952, 1110,
  360, 700, 1020, 1200,
  390, 728, 1050, 1260,
  420, 784, 1140, 1350,
  450, 812, 1200, 1440,
  480, 868, 1290, 1530,
  510, 924, 1350, 1620,
  540, 980, 1440, 1710,
  570, 1036, 1530, 1800,
  570, 1064, 1590, 1890,
  600, 1120, 1680, 1980,
  630, 1204, 1770, 2100,
  660, 1260, 1860, 2220,
  720, 1316, 1950, 2310,
  750, 1372, 2040, 2430
];

/**
 * Returns the number of error correction blocks for a given QR code version and error correction level.
 *
 * @param  {Number} version              QR Code version
 * @param  {Number} errorCorrectionLevel Error correction level
 * @return {Number}                      Number of error correction blocks
 */
function getBlocksCount(version, errorCorrectionLevel) {
  const index = (version - 1) * 4 + errorCorrectionLevel.bit;
  return EC_BLOCKS_TABLE[index];
}

/**
 * Returns the number of error correction codewords for a given QR code version and error correction level.
 *
 * @param  {Number} version              QR Code version
 * @param  {Number} errorCorrectionLevel Error correction level
 * @return {Number}                      Number of error correction codewords
 */
function getTotalCodewordsCount(version, errorCorrectionLevel) {
  const index = (version - 1) * 4 + errorCorrectionLevel.bit;
  return EC_CODEWORDS_TABLE[index];
}

/**
 * Logarithm and Exponent tables used for Galois Field (GF(2^8)) calculations.
 */
const EXP_TABLE = new Uint8Array(512);
const LOG_TABLE = new Uint8Array(256);

/**
 * Precompute the log and anti-log tables for faster Galois Field arithmetic.
 */
(function initTables() {
  let x = 1;
  for (let i = 0; i < 255; i++) {
    EXP_TABLE[i] = x;
    LOG_TABLE[x] = i;

    x <<= 1; // Multiply by 2

    // The QR code specification says to use byte-wise modulo 100011101 arithmetic.
    if (x & 0x100) {
      // Equivalent to x >= 256
      x ^= 0x11d; // Equivalent to modulo 0x11D
    }
  }

  for (let i = 255; i < 512; i++) {
    EXP_TABLE[i] = EXP_TABLE[i - 255];
  }
})();

/**
 * Returns log value of n inside Galois Field.
 *
 * @param  {Number} n
 * @return {Number}
 * @throws {Error}  If n < 1
 */
function log(n) {
  if (n < 1) throw new Error("log(" + n + ")");
  return LOG_TABLE[n];
}

/**
 * Returns anti-log value of n inside Galois Field.
 *
 * @param  {Number} n
 * @return {Number}
 */
function exp(n) {
  return EXP_TABLE[n];
}

/**
 * Multiplies two numbers inside Galois Field.
 *
 * @param  {Number} x
 * @param  {Number} y
 * @return {Number}
 */
function mul(x, y) {
  if (x === 0 || y === 0) return 0;

  // Should be EXP_TABLE[(LOG_TABLE[x] + LOG_TABLE[y]) % 255] if EXP_TABLE wasn't oversized
  return EXP_TABLE[LOG_TABLE[x] + LOG_TABLE[y]];
}

/**
 * Multiplies two polynomials inside Galois Field.
 *
 * @param  {Uint8Array} p1 Polynomial
 * @param  {Uint8Array} p2 Polynomial
 * @return {Uint8Array}    Product of p1 and p2
 */
function mulPolynomials(p1, p2) {
  const coeff = new Uint8Array(p1.length + p2.length - 1);

  for (let i = 0; i < p1.length; i++) {
    for (let j = 0; j < p2.length; j++) {
      coeff[i + j] ^= mul(p1[i], p2[j]);
    }
  }

  return coeff;
}

/**
 * Calculates the remainder of polynomial division.
 *
 * @param  {Uint8Array} divident Polynomial
 * @param  {Uint8Array} divisor  Polynomial
 * @return {Uint8Array}          Remainder
 */
function mod(divident, divisor) {
  let result = new Uint8Array(divident);

  while (result.length - divisor.length >= 0) {
    const coeff = result[0];

    for (let i = 0; i < divisor.length; i++) {
      result[i] ^= mul(divisor[i], coeff);
    }

    // Remove all zeros from buffer head
    let offset = 0;
    while (offset < result.length && result[offset] === 0) offset++;
    result = result.slice(offset);
  }

  return result;
}

/**
 * Generate an irreducible generator polynomial of specified degree.
 * Used by Reed-Solomon encoder.
 *
 * @param  {Number} degree Degree of the generator polynomial
 * @return {Uint8Array}    Buffer containing polynomial coefficients
 */
function generateECPolynomial(degree) {
  let poly = new Uint8Array([1]);
  for (let i = 0; i < degree; i++) {
    poly = mulPolynomials(poly, new Uint8Array([1, exp(i)]));
  }

  return poly;
}

/**
 * Reed-Solomon Encoder class.
 * Used for generating error correction codes for QR codes.
 */
class ReedSolomonEncoder {
  constructor(degree) {
    this.genPoly = undefined;
    this.degree = degree;

    if (this.degree) {
      this.initialize(degree);
    }
  }

  /**
   * Initializes the encoder with a generator polynomial of specified degree.
   *
   * @param  {Number} degree Degree of the generator polynomial
   */
  initialize(degree) {
    this.degree = degree;
    this.genPoly = generateECPolynomial(this.degree);
  }

  /**
   * Encodes a chunk of data using Reed-Solomon error correction.
   *
   * @param  {Uint8Array} data Buffer containing input data
   * @return {Uint8Array}      Buffer containing encoded data
   */
  encode(data) {
    if (!this.genPoly) {
      throw new Error("Encoder not initialized");
    }

    // Calculate EC for this data block
    const paddedData = new Uint8Array(data.length + this.degree);
    paddedData.set(data);

    // The error correction codewords are the remainder after dividing the data codewords
    // by a generator polynomial
    const remainder = mod(paddedData, this.genPoly);

    // Return EC data blocks (last n bytes, where n is the degree of genPoly)
    const start = this.degree - remainder.length;
    if (start > 0) {
      const buff = new Uint8Array(this.degree);
      buff.set(remainder, start);
      return buff;
    }
    return remainder;
  }
}

module.exports = {
  ECLevel,
  fromString,
  isValid,
  from,
  getBlocksCount,
  getTotalCodewordsCount,
  log,
  exp,
  mul,
  mulPolynomials,
  mod,
  generateECPolynomial,
  ReedSolomonEncoder,
};

/* Example usage:

// Instantiate the Reed-Solomon encoder with a specified degree
const encoder = new ReedSolomonEncoder(10);

// Encode some data
const data = new Uint8Array([32, 91, 11, 120]);
const encodedData = encoder.encode(data);

console.log(encodedData); // Outputs the error correction codewords

*/