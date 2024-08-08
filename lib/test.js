const QRCode = require(".");

QRCode.toFile("test.png", "To convert the given code into an array", {
       // Transparent background
    color: {
        dark: "#000000", // QR code modules color (black)
        light: "#fff" // Background color (transparent)
    },
    errorCorrectionLevel: "M",
    version: 7,
    width: 200,
    margin: 2,
    scale: 1,
    mask: 0,
    transparent: true,
    type: "image/png",
    rendererOpts: {
        quality: 0.3
    }
}, function (err) {
    if (err) throw err;
    console.log("done");
});

/* "To convert the given code into an array, you can use a loop to dynamically generate the substrings and store them in an array. Here's how you can do it:" */