import express from "express";
import { protect } from "../middleware/authMiddleware.js";
import { generateIdCard, encryptedIdCardKey, decryptedIdCardKey } from "../services/idCardService.js";

const router = express.Router();

router.get("/generate-id-card", protect, generateIdCard);
router.get("/user-encrypted-id-key", protect, encryptedIdCardKey);
router.get("/user-decrypted-id-key", protect, decryptedIdCardKey);

export default router;