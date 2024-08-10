import userEncryptedId from '../helper/userEncryptedId.js';
import userDecryptedId from '../helper/userDecryptedId.js';
import { createCanvas, Image } from 'canvas';
import PDFDocument from 'pdfkit';
import { PrismaClient } from '@prisma/client';
import QRCode from 'qrcode';

const prisma = new PrismaClient();

export const generateIdCard = async (req, res) => {
  try {
    const email = req.user.email;
    const user = await prisma.user.findUnique({
      where: { email: email },
    });

    if (!user) {
      return res
        .status(404)
        .json({ status: 'fail', message: 'User not found' });
    }

    // Encrypt user ID
    const encryptedId = userEncryptedId(user.email);

    // Create a canvas for the ID card
    const width = 475;
    const height = 275;
    const scaleFactor = 3;
    const canvas = createCanvas(width * scaleFactor, height * scaleFactor);
    const context = canvas.getContext('2d');

    // Scale the canvas
    context.scale(scaleFactor, scaleFactor);

    // Draw background
    context.fillStyle = '#ffffff';
    context.fillRect(0, 0, width, height);

    // Draw text
    context.fillStyle = '#000000';
    context.font = '15px Sans-serif';
    context.fillText(`Name: ${user.name}`, 15, 30);
    //context.fillText(`ID: ${user.id}`, 15, 50);

    // Generate QR code
    const qrCodeData = await QRCode.toDataURL(encryptedId, {
      scale: scaleFactor,
    });

    // Draw QR code on the canvas
    const qrImage = new Image();
    qrImage.onload = () => {
      context.drawImage(qrImage, 270, 50, 170, 170); // x, y, width, height

      // Convert canvas to buffer
      const buffer = canvas.toBuffer('image/png');

      // write buffer to a file
      const doc = new PDFDocument({ size: [width, height] });
      let pdfBuffer = [];
      doc.on('data', (chunk) => pdfBuffer.push(chunk));
      doc.on('end', () => {
        const pdfData = Buffer.concat(pdfBuffer);
        res.setHeader('Content-Type', 'application/pdf');
        res.send(pdfData);
      });

      doc.image(buffer, 0, 0, { width: width, height: height });
      doc.end();
    };
    qrImage.onerror = (error) => {
      res
        .status(500)
        .json({ status: 'fail', message: 'Failed to load QR code image' });
    };
    qrImage.src = qrCodeData;
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};

export const encryptedIdCardKey = async (req, res) => {
  try {
    const userEmail = req.user.email;
    const encryptedId = userEncryptedId(userEmail);
    res.status(200).json({ status: 'success', data: encryptedId });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};

export const decryptedIdCardKey = async (req, res) => {
  try {
    const encryptedId = req.body.data;
    const decryptedId = userDecryptedId(encryptedId);
    res.status(200).json({ status: 'success', data: decryptedId });
  } catch (error) {
    res.status(400).json({ status: 'fail', message: error.message });
  }
};
