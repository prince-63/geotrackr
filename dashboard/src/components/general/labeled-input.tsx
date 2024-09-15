import React from 'react';
import Typography from './typography';

interface LabeledInputProps {
  label: string;
  type: string;
  placeholder: string;
  value: string;
  name?: string;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  className?: string;
}

const LabeledInput: React.FC<LabeledInputProps> = ({
  label,
  type,
  placeholder,
  value,
  name,
  onChange,
  className,
}) => {
  return (
    <div className={`mb-4 w-full ${className}`}>
      <label className="block text-gray-800 ml-1 mb-1">
        <Typography variant="body3">{label}</Typography>
      </label>
      <input
        type={type}
        placeholder={placeholder}
        value={value}
        onChange={onChange}
        name={name}
        className="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-1 focus:ring-blue-500"
      />
    </div>
  );
};

export default LabeledInput;
