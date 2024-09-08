import { storage } from '../config/multer/multer.js';
import multer from 'multer';
import path from 'path';

const upload = multer({
    storage: storage,
    limits: { fileSize: 10000000 }, // 10 MB
    fileFilter: (req, file, cb) => {
        checkFileType(file, cb);
    },
}).single('file');

function checkFileType(file, cb) {
    const filetypes = /jpeg|jpg|png|gif/;
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
    const mimetype = filetypes.test(file.mimetype);

    if (mimetype && extname) {
        return cb(null, true);
    } else {
        cb('Error: Images Only!');
    }
}

export default upload;
