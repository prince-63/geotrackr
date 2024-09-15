import React from 'react';
import Typography from './typography';
import { Upload } from 'lucide-react';

interface ImageUploadModalProps {
  isOpen: boolean;
  onClose: () => void;
  onImageUpload: (event: React.ChangeEvent<HTMLInputElement>) => void;
  text: string;
  placeholder: string;
}

const ImageUploadModal: React.FC<ImageUploadModalProps> = ({
  isOpen,
  onClose,
  onImageUpload,
  text,
  placeholder,
}) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
      <div className="bg-white rounded-sm shadow-2xl max-w-md w-full">
        <div className="bg-slate-100 p-2">
          <Typography variant="h6" className="text-black font-semibold">
            {text}
          </Typography>
          <Typography variant="body3" className="text-black opacity-75">
            {placeholder}
          </Typography>
        </div>
        <div className="p-2 m-4">
          <div className="flex justify-center items-center rounded-sm bg-slate-200 h-48">
            <label
              htmlFor="file-upload"
              className="cursor-pointer flex flex-col items-center"
            >
              <Upload className="w-12 h-12 text-gray-500 transition duration-200 ease-in-out hover:text-gray-700" />
              <span className="text-sm text-gray-500 mt-2">
                Click to upload
              </span>
            </label>
            <input
              id="file-upload"
              type="file"
              accept="image/*"
              onChange={onImageUpload}
              className="hidden"
            />
          </div>
          <div className="mt-6 flex justify-end">
            <button
              className="px-4 py-2 bg-gray-800 text-white rounded-md hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-500"
              onClick={onClose}
            >
              Close
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ImageUploadModal;
