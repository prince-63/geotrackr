import React from "react";
import { X } from "lucide-react";

interface ModalProps {
  title: string;
  width?: string;
  height?: string;
  isOpen: boolean;
  onClose: () => void;
  children: React.ReactNode;
  className?: string;
}

const Modal: React.FC<ModalProps> = ({
  title,
  width = "auto",
  height = "auto",
  isOpen,
  onClose,
  children,
  className,
}) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
      <div
        className="bg-white rounded-sm shadow-2xl max-h-full overflow-y-auto"
        style={{ width, height }}
      >
        <div className="bg-slate-100 p-2 flex justify-between items-center">
          <span className="text-black font-semibold opacity-80">{title}</span>
          <button className="text-gray-600" onClick={onClose}>
            <X className="w-6 h-6" />
          </button>
        </div>
        <div className={`p-4 ${className}`}>{children}</div>
      </div>
    </div>
  );
};

export default Modal;
