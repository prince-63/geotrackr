// Import VersionCheck from the external file
const VersionCheck = require("./version.js");

// Regular expressions for various QR encoding modes
const Regex = {
    KANJI: null,
    BYTE_KANJI: null,
    BYTE: null,
    NUMERIC: null,
    ALPHANUMERIC: null,
    TEST_KANJI: null,
    TEST_NUMERIC: null,
    TEST_ALPHANUMERIC: null,

    initialize: function () {
        const numeric = "[0-9]+";
        const alphanumeric = "[A-Z $%*+\\-./:]+";
        let kanji =
            "(?:[u3000-u303F]|[u3040-u309F]|[u30A0-u30FF]|" +
            "[uFF00-uFFEF]|[u4E00-u9FAF]|[u2605-u2606]|[u2190-u2195]|u203B|" +
            "[u2010u2015u2018u2019u2025u2026u201Cu201Du2225u2260]|" +
            "[u0391-u0451]|[u00A7u00A8u00B1u00B4u00D7u00F7])+";

        kanji = kanji.replace(/u/g, "\\u");

        const byte = "(?:(?![A-Z0-9 $%*+\\-./:]|" + kanji + ")(?:.|[\r\n]))+";

        this.KANJI = new RegExp(kanji, "g");
        this.BYTE_KANJI = new RegExp("[^A-Z0-9 $%*+\\-./:]+", "g");
        this.BYTE = new RegExp(byte, "g");
        this.NUMERIC = new RegExp(numeric, "g");
        this.ALPHANUMERIC = new RegExp(alphanumeric, "g");

        this.TEST_KANJI = new RegExp("^" + kanji + "$");
        this.TEST_NUMERIC = new RegExp("^" + numeric + "$");
        this.TEST_ALPHANUMERIC = new RegExp("^[A-Z0-9 $%*+\\-./:]+$");
    },

    testKanji: function (str) {
        return this.TEST_KANJI.test(str);
    },

    testNumeric: function (str) {
        return this.TEST_NUMERIC.test(str);
    },

    testAlphanumeric: function (str) {
        return this.TEST_ALPHANUMERIC.test(str);
    }
};

// Initialize the regular expressions
Regex.initialize();

// QR encoding modes
const Mode = {
    NUMERIC: {
        id: "Numeric",
        bit: 1 << 0,
        ccBits: [10, 12, 14]
    },
    ALPHANUMERIC: {
        id: "Alphanumeric",
        bit: 1 << 1,
        ccBits: [9, 11, 13]
    },
    BYTE: {
        id: "Byte",
        bit: 1 << 2,
        ccBits: [8, 16, 16]
    },
    KANJI: {
        id: "Kanji",
        bit: 1 << 3,
        ccBits: [8, 10, 12]
    },
    MIXED: {
        bit: -1
    },

    getCharCountIndicator: function (mode, version) {
        if (!mode.ccBits) throw new Error("Invalid mode: " + mode);

        if (!VersionCheck.isValid(version)) {
            throw new Error("Invalid version: " + version);
        }

        if (version >= 1 && version < 10) return mode.ccBits[0];
        else if (version < 27) return mode.ccBits[1];
        return mode.ccBits[2];
    },

    getBestModeForData: function (dataStr) {
        if (Regex.testNumeric(dataStr)) return this.NUMERIC;
        else if (Regex.testAlphanumeric(dataStr)) return this.ALPHANUMERIC;
        else if (Regex.testKanji(dataStr)) return this.KANJI;
        else return this.BYTE;
    },

    toString: function (mode) {
        if (mode && mode.id) return mode.id;
        throw new Error("Invalid mode");
    },

    isValid: function (mode) {
        return mode && mode.bit && mode.ccBits;
    },

    fromString: function (string) {
        if (typeof string !== "string") {
            throw new Error("Param is not a string");
        }

        const lcStr = string.toLowerCase();

        switch (lcStr) {
            case "numeric":
                return this.NUMERIC;
            case "alphanumeric":
                return this.ALPHANUMERIC;
            case "kanji":
                return this.KANJI;
            case "byte":
                return this.BYTE;
            default:
                throw new Error("Unknown mode: " + string);
        }
    },

    from: function (value, defaultValue) {
        if (this.isValid(value)) {
            return value;
        }

        try {
            return this.fromString(value);
        } catch (e) {
            return defaultValue;
        }
    }
};

// Utility functions for QR Code generation
const Utils = {
    CODEWORDS_COUNT: [
        0, // Not used
        26, 44, 70, 100, 134, 172, 196, 242, 292, 346,
        404, 466, 532, 581, 655, 733, 815, 901, 991, 1085,
        1156, 1258, 1364, 1474, 1588, 1706, 1828, 1921, 2051, 2185,
        2323, 2465, 2611, 2761, 2876, 3034, 3196, 3362, 3532, 3706
    ],

    getSymbolSize: function (version) {
        if (!version) throw new Error('"version" cannot be null or undefined');
        if (version < 1 || version > 40)
            throw new Error('"version" should be in range from 1 to 40');
        return version * 4 + 17;
    },

    getSymbolTotalCodewords: function (version) {
        return this.CODEWORDS_COUNT[version];
    },

    getBCHDigit: function (data) {
        let digit = 0;

        while (data !== 0) {
            digit++;
            data >>>= 1;
        }

        return digit;
    },

    setToSJISFunction: function (f) {
        if (typeof f !== "function") {
            throw new Error('"toSJISFunc" is not a valid function.');
        }

        toSJISFunction = f;
    },

    isKanjiModeEnabled: function () {
        return typeof toSJISFunction !== "undefined";
    },

    toSJIS: function (kanji) {
        return toSJISFunction(kanji);
    }
};

// Implementing data handlers for various QR Code modes
function ByteData(data) {
    this.mode = Mode.BYTE;

    if (typeof data === "string") {
        this.data = new TextEncoder().encode(data);
    } else {
        this.data = new Uint8Array(data);
    }
}

ByteData.getBitsLength = function (length) {
    return length * 8;
};

ByteData.prototype.getLength = function () {
    return this.data.length;
};

ByteData.prototype.getBitsLength = function () {
    return ByteData.getBitsLength(this.data.length);
};

ByteData.prototype.write = function (bitBuffer) {
    for (let i = 0; i < this.data.length; i += 1) {
        bitBuffer.put(this.data[i], 8);
    }
};

function AlphanumericData(data) {
    this.mode = Mode.ALPHANUMERIC;
    this.data = data;
}

AlphanumericData.getBitsLength = function (length) {
    return 11 * Math.floor(length / 2) + 6 * (length % 2);
};

AlphanumericData.prototype.getLength = function () {
    return this.data.length;
};

AlphanumericData.prototype.getBitsLength = function () {
    return AlphanumericData.getBitsLength(this.data.length);
};

AlphanumericData.prototype.write = function (bitBuffer) {
    let i;

    for (i = 0; i + 2 <= this.data.length; i += 2) {
        let value = ALPHA_NUM_CHARS.indexOf(this.data[i]) * 45;
        value += ALPHA_NUM_CHARS.indexOf(this.data[i + 1]);
        bitBuffer.put(value, 11);
    }

    if (this.data.length % 2) {
        bitBuffer.put(ALPHA_NUM_CHARS.indexOf(this.data[i]), 6);
    }
};

function KanjiData(data) {
    this.mode = Mode.KANJI;
    this.data = data;
}

KanjiData.getBitsLength = function (length) {
    return 13 * Math.floor(length / 2) + 9 * (length % 2);
};

KanjiData.prototype.getLength = function () {
    return this.data.length;
};

KanjiData.prototype.getBitsLength = function () {
    return KanjiData.getBitsLength(this.data.length);
};

KanjiData.prototype.write = function (bitBuffer) {
    for (let i = 0; i < this.data.length; i++) {
        let value = this.data.charCodeAt(i);

        if (value >= 0x8140 && value <= 0x9ffc) {
            value -= 0x8140;
        } else if (value >= 0xe040 && value <= 0xebbf) {
            value -= 0xc140;
        } else {
            throw new Error("Invalid SJIS character: " + this.data[i]);
        }

        value = ((value >>> 8) & 0xff) * 0xc0 + (value & 0xff);

        bitBuffer.put(value, 13);
    }
};

function NumericData(data) {
    this.mode = Mode.NUMERIC;
    this.data = data.toString();
}

NumericData.getBitsLength = function (length) {
    return 10 * Math.floor(length / 3) + (length % 3 ? (length % 3) * 3 + 1 : 0);
};

NumericData.prototype.getLength = function () {
    return this.data.length;
};

NumericData.prototype.getBitsLength = function () {
    return NumericData.getBitsLength(this.data.length);
};

NumericData.prototype.write = function (bitBuffer) {
    let i, value, group;

    for (i = 0; i + 3 <= this.data.length; i += 3) {
        group = this.data.substr(i, 3);
        value = parseInt(group, 10);

        bitBuffer.put(value, 10);
    }

    const remainingNum = this.data.length - i;

    if (remainingNum > 0) {
        group = this.data.substr(i);
        value = parseInt(group, 10);
        bitBuffer.put(value, remainingNum * 3 + 1);
    }
};

// Export modules
module.exports = {
    Regex,
    Mode,
    ByteData,
    AlphanumericData,
    KanjiData,
    NumericData,
    Utils
};
