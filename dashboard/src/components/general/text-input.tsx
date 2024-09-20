import React from 'react';
import { LucideIcon } from 'lucide-react';
import IconContainer from '../general/icon-container';

interface TextInputProps {
  type?: string;
  placeholder?: string;
  value: string;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  className?: string;
  icon?: LucideIcon;
}

const TextInput: React.FC<TextInputProps> = ({
  type = 'text',
  placeholder,
  value,
  onChange,
  className,
  icon: Icon,
}) => {
  return (
    <div
      className={`relative flex items-center ${className} border rounded-md bg-white dark:bg-gray-800`}
    >
      {Icon && (
        <IconContainer>
          <Icon
            className="text-gray-500 dark:text-gray-400"
            width={20}
            height={20}
          />
        </IconContainer>
      )}
      <input
        type={type}
        placeholder={placeholder}
        value={value}
        onChange={onChange}
        required
        className={`p-2 focus:outline-none transition duration-200 ease-in-out w-full placeholder-gray-500 dark:placeholder-gray-400 text-gray-900 dark:text-gray-100 bg-white dark:bg-gray-800 border-none`}
      />
    </div>
  );
};

export default TextInput;
