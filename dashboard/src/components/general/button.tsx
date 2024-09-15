import React from 'react';

interface ButtonProps {
  children: React.ReactNode;
  onClick?: (e: React.MouseEvent<HTMLButtonElement>) => void;
  type?: 'button' | 'submit' | 'reset';
  className?: string;
}

const Button: React.FC<ButtonProps> = ({
  children,
  onClick,
  type = 'button',
  className,
}) => {
  return (
    <button
      type={type}
      onClick={onClick}
      className={`p-2 rounded-sm transition duration-200 ease-in-out ${className}`}
    >
      {children}
    </button>
  );
};

export default Button;
