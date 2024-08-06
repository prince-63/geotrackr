const EXP_TABLE = new Uint8Array(512);
const LOG_TABLE = new Uint8Array(256);

/**
 * Precompute the log and anti-log tables for faster computation later
 *
 * For each possible value in the galois field 2^8, we will pre-compute
 * the logarithm and anti-logarithm (exponential) of this value
 *
 * ref {@link https://en.wikiversity.org/wiki/Reed%E2%80%93Solomon_codes_for_coders#Introduction_to_mathematical_fields}
 */
(function initTables() {
  let x = 1;
  for (let i = 0; i < 255; i++) {
    EXP_TABLE[i] = x;
    LOG_TABLE[x] = i;

    x <<= 1; // multiply by 2

    // The QR code specification says to use byte-wise modulo 100011101 arithmetic.
    // This means that when a number is 256 or larger, it should be XORed with 0x11D.
    if (x & 0x100) {
      // similar to x >= 256, but a lot faster (because 0x100 == 256)
      x ^= 0x11d;
    }
  }

  // Optimization: double the size of the anti-log table so that we don't need to mod 255 to
  // stay inside the bounds (because we will mainly use this table for the multiplication of
  // two GF numbers, no more).
  // @see {@link mul}
  for (let i = 255; i < 512; i++) {
    EXP_TABLE[i] = EXP_TABLE[i - 255];
  }

  /*
   * Exponential Table (EXP_TABLE):
   *
   * [
   *   1, 2, 4, 8, 16, 32, 64, 128, 29, 58, 116, 232, 205, 135, 19, 38,
   *   76, 152, 45, 90, 180, 117, 234, 201, 143, 3, 6, 12, 24, 48, 96,
   *   192, 157, 39, 78, 156, 37, 74, 148, 53, 106, 212, 181, 119, 238,
   *   193, 159, 35, 70, 140, 5, 10, 20, 40, 80, 160, 93, 186, 105, 210,
   *   185, 111, 222, 161, 95, 190, 97, 194, 153, 47, 94, 188, 101, 202,
   *   137, 15, 30, 60, 120, 240, 253, 231, 211, 187, 107, 214, 177, 127,
   *   254, 225, 223, 163, 91, 182, 113, 226, 217, 175, 67, 134, 17, 34,
   *   68, 136, 13, 26, 52, 104, 208, 189, 103, 206, 129, 31, 62, 124,
   *   248, 237, 199, 147, 59, 118, 236, 197, 151, 51, 102, 204, 133, 23,
   *   46, 92, 184, 109, 218, 169, 79, 158, 33, 66, 132, 21, 42, 84, 168,
   *   77, 154, 41, 82, 164, 85, 170, 73, 146, 57, 114, 228, 213, 183,
   *   115, 230, 209, 191, 99, 198, 145, 63, 126, 252, 229, 215, 179,
   *   123, 246, 241, 255, 227, 219, 171, 75, 150, 49, 98, 196, 149, 55,
   *   110, 220, 165, 87, 174, 65, 130, 25, 50, 100, 200, 141, 7, 14, 28,
   *   56, 112, 224, 221, 167, 83, 166, 81, 162, 89, 178, 121, 242, 249,
   *   239, 195, 155, 43, 86, 172, 69, 138, 9, 18, 36, 72, 144, 61, 122,
   *   244, 245, 247, 243, 251, 235, 203, 139, 11, 22, 44, 88, 176, 125,
   *   250, 233, 207, 131, 27, 54, 108, 216, 173, 71, 142, 1, 2, 4, 8,
   *   16, 32, 64, 128, 29, 58, 116, 232, 205, 135, 19, 38, 76, 152, 45,
   *   90, 180, 117, 234, 201, 143, 3, 6, 12, 24, 48, 96, 192, 157, 39,
   *   78, 156, 37, 74, 148, 53, 106, 212, 181, 119, 238, 193, 159, 35,
   *   70, 140, 5, 10, 20, 40, 80, 160, 93, 186, 105, 210, 185, 111, 222,
   *   161, 95, 190, 97, 194, 153, 47, 94, 188, 101, 202, 137, 15, 30, 60,
   *   120, 240, 253, 231, 211, 187, 107, 214, 177, 127, 254
   * ]
   *
   * Logarithm Table (LOG_TABLE):
   *
   * [
   *   undefined, 0, 1, 25, 2, 50, 26, 198, 3, 223, 51, 238, 27, 104, 199,
   *   75, 4, 100, 224, 14, 52, 141, 239, 129, 28, 193, 105, 248, 200, 8,
   *   76, 113, 5, 138, 101, 47, 225, 36, 15, 33, 53, 147, 142, 218, 240,
   *   18, 130, 69, 29, 181, 194, 125, 106, 39, 249, 185, 201, 154, 9, 120,
   *   77, 228, 114, 166, 6, 191, 139, 98, 102, 221, 48, 253, 226, 152, 37,
   *   179, 16, 145, 34, 136, 54, 208, 148, 206, 143, 150, 219, 189, 241, 210,
   *   19, 92, 131, 56, 70, 64, 30, 66, 182, 163, 195, 72, 126, 110, 107,
   *   58, 40, 84, 250, 133, 186, 61, 202, 94, 155, 159, 10, 21, 121, 43,
   *   78, 212, 229, 172, 115, 243, 167, 87, 7, 112, 192, 247, 140, 128, 99,
   *   13, 103, 74, 222, 237, 49, 197, 254, 24, 227, 165, 153, 119, 38, 184,
   *   180, 17, 146, 47, 186, 189, 17, 174, 155, 229, 57, 157, 169, 79, 22,
   *   201, 68, 71, 149, 231, 231, 37, 132, 119, 148, 73, 98, 240, 85, 48,
   *   247, 64, 73, 104, 42, 217, 195, 56, 246, 103, 120, 74, 187, 248, 79,
   *   132, 224, 101, 231, 75, 121, 195, 72, 148, 126, 141, 10, 85, 139, 23,
   *   203, 172, 135, 90, 32, 45, 157, 111, 150, 30, 251, 202, 217, 163, 194,
   *   98, 123, 84, 35, 100, 223, 62, 57, 253, 37, 203, 146, 71, 157, 99,
   *   159, 10, 125, 143, 48, 65, 50, 106, 82, 192, 74, 31, 163, 192, 75
   * ]
   */
})();

/**
 * Returns log value of n inside Galois Field
 *
 * @param  {Number} n
 * @return {Number}
 */
exports.log = function log(n) {
  if (n < 1) throw new Error("log(" + n + ")");
  return LOG_TABLE[n];
};

/**
 * Returns anti-log value of n inside Galois Field
 *
 * @param  {Number} n
 * @return {Number}
 */
exports.exp = function exp(n) {
  return EXP_TABLE[n];
};

/**
 * Multiplies two number inside Galois Field
 *
 * @param  {Number} x
 * @param  {Number} y
 * @return {Number}
 */
exports.mul = function mul(x, y) {
  if (x === 0 || y === 0) return 0;

  // should be EXP_TABLE[(LOG_TABLE[x] + LOG_TABLE[y]) % 255] if EXP_TABLE wasn't oversized
  // @see {@link initTables}
  return EXP_TABLE[LOG_TABLE[x] + LOG_TABLE[y]];
};
