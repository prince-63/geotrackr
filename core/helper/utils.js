let toSJISFunction;

// Basically it determine the how much data qr code store in specific version
const CODEWORDS_COUNT = [
    0, // Not Used
    26, 44, 70, 100, 134, 172, 196, 242, 292, 346,
    404, 466, 532, 581, 655, 733, 815, 901, 991, 1085,
    1156, 1258, 1364, 1474, 1588, 1706, 1828, 1921, 2051, 2185,
    2323, 2465, 2611, 2761, 2876, 3034, 3196, 3362, 3532, 3706
];

/**
 * Returns the QR Code size for the specified version
 *
 * @param  {Number} version QR Code version
 * @return {Number}         size of QR code
 */
exports.getSymbolSize = function getSymbolSize(version) {
  if (!version) throw new Error('"version" cannot be null or undefined');
  if (version < 1 || version > 40)
    throw new Error('"version" should be in range from 1 to 40');

  /*
   *   version * 4 + 17
   *   1 * 4 + 17 = 21 ( size of the qr code in version 1)
   *   2 * 4 + 17 = 25 ( size of the qr code in version 2)
   */
  return version * 4 + 17;
};

/**
 * Returns the total number of codewords used to store data and EC information.
 *
 * @param  {Number} version QR Code version
 * @return {Number}         Data length in bits
 */
exports.getSymbolTotalCodewords = function getSymbolTotalCodewords(version) {
  /*
   *   version = 1 -> CODEWORDS_COUNT[1] = 26
   *   version = 2 -> CODEWORDS_COUNT[2] = 44
   */
  return CODEWORDS_COUNT[version];
};

/*
Here’s how the function processes this value step by step:

Initial Setup:
data = 13 (in binary: 1101)
digit = 0

First Iteration:
Before shift: data = 1101 (binary), digit = 0
Increment digit: digit = 1
Right shift data by 1: data = 1101 >>> 1 = 110 (binary) or 6 (decimal)

Second Iteration:
Before shift: data = 110 (binary), digit = 1
Increment digit: digit = 2
Right shift data by 1: data = 110 >>> 1 = 11 (binary) or 3 (decimal)

Third Iteration:
Before shift: data = 11 (binary), digit = 2
Increment digit: digit = 3
Right shift data by 1: data = 11 >>> 1 = 1 (binary) or 1 (decimal)

Fourth Iteration:
Before shift: data = 1 (binary), digit = 3
Increment digit: digit = 4
Right shift data by 1: data = 1 >>> 1 = 0 (binary)

Loop Ends:
The loop ends as data is now 0.
The function returns digit = 4.

Result:
The function returns 4, meaning the binary representation of 13 (which is 1101) consists of 4 bits.
*/
/**
 * Encode data with Bose-Chaudhuri-Hocquenghem
 * @param  {Number} data Value to encode
 * @return {Number}      Encoded value
 */
exports.getBCHDigit = function (data) {
  let digit = 0;

  while (data !== 0) {
    digit++;
    data >>>= 1;
  }

  return digit;
};

/*
The setToSJISFunction function in your QR code implementation is responsible 
for setting a custom conversion function that converts characters into their 
Shift JIS (SJIS) encoded form. Shift JIS is a character encoding used 
for Japanese text, and QR codes can support it to encode Japanese characters efficiently.
*/
exports.setToSJISFunction = function setToSJISFunction(f) {
  if (typeof f !== "function") {
    throw new Error('"toSJISFunc" is not a valid function.');
  }

  toSJISFunction = f;
};

exports.isKanjiModeEnabled = function () {
  return typeof toSJISFunction !== "undefined";
};

exports.toSJIS = function toSJIS(kanji) {
  return toSJISFunction(kanji);
};
