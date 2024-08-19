import userEncryptedId from '../helper/userEncryptedId.js';
import userDecryptedId from '../helper/userDecryptedId.js';
import { createCanvas, Image, loadImage } from 'canvas';
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
    const width = 255;
    const height = 403;
    const scaleFactor = 4;
    const canvas = createCanvas(width * scaleFactor, height * scaleFactor);
    const context = canvas.getContext('2d');

    // Scale the canvas
    context.scale(scaleFactor, scaleFactor);

    // Draw background
    context.fillStyle = '#ffffff';
    context.fillRect(0, 0, width, height);

    // Fetch and draw profile image
    const image = user.profilePictureUrl;
    if (image) {
      try {
        const profileImage = await loadImage(image);
        const x = 128;
        const y = 70;
        const radius = 50;
        const width = 100;
        const height = 100;

        context.save();
        context.beginPath();
        context.arc(70, y, radius, 0, Math.PI * 2, true);
        context.closePath();
        context.clip();

        context.drawImage(profileImage, 70 - radius, y - radius, width, height);
        context.restore();

        // Draw border
        context.beginPath();
        context.arc(70, y, radius, 0, Math.PI * 2, true);
        context.closePath();
        context.lineWidth = 1; // Border width
        context.strokeStyle = '#333232'; // Border color
        context.stroke();
      } catch (error) {
        console.error('Failed to load profile image:', error);
      }
    }

    // Draw text
    context.fillStyle = 'rgba(0, 0, 0, 0.80)';
    context.font = 'bold 16px Arial';
    const textPosition = (width - context.measureText(user.name).width) / 2;
    context.fillText(user.name, textPosition, 150);

    // drow horizontal line
    context.beginPath();
    context.moveTo(0, 160);
    context.lineTo(255, 160);
    context.lineWidth = 1;
    context.strokeStyle = 'rgba(0, 0, 0, 0.40)';
    context.stroke();

    // Draw ID
    context.font = '13px Arial';
    context.fillText("Id: " + user.id, 15, 180);

    // Draw date of birth
    context.fillText("Date of Birth: " + user.dateOfBirth, 15, 200);

    // Draw blood group
    context.fillText("Blood Group: " + user.bloodGroup, 15, 220);

    // Drow email
    context.fillText("Email: " + user.email, 15, 240);

    // Drow phone number
    context.fillText("Phone: " + user.contactNumber, 15, 260);

    // Drow address
    context.fillText("Address: " + user.address, 15, 280);

    // organization name
    context.fillText("Organization: " + user.organizationName, 15, 300);

    // organization email
    context.fillText("Organization Email: " + user.organizationContactEmail, 15, 320);

    // organization phone number
    context.fillText("Organization Phone: " + user.organizationContactNumber, 15, 340);

    // organization address
    context.fillText("Organization Address: " + user.organizationAddress, 15, 360);

    // drow horizontal line
    context.beginPath();
    context.moveTo(0, 370);
    context.lineTo(255, 370);
    context.lineWidth = 1;
    // stroke opacity .75
    context.strokeStyle = 'rgba(0, 0, 0, 0.40)';
    context.stroke();

    // website url link
    context.font = 'bold 12px Arial';
    context.fillStyle = 'rgba(0, 0, 0, 0.80)';
    const url = "https://www.example.com";
    const urlPosition = (width - context.measureText(url).width) / 2;
    context.fillText(url, urlPosition, 390);

    // Generate QR code
    const qrCodeData = await QRCode.toDataURL(encryptedId, {
      scale: scaleFactor,
    });

    // Draw QR code on the canvas
    const qrImage = new Image();
    qrImage.onload = () => {
      context.drawImage(qrImage, 130, 10, 120, 120); // x, y, width, height

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
      res.status(500).json({ status: 'fail', message: error.message });
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
