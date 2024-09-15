import React from 'react';

interface FormContainerProps {
  children: React.ReactNode;
  className?: string;
}

const FormContainer: React.FC<FormContainerProps> = ({
  children,
  className,
}) => {
  return (
    <div
      className={`bg-white p-8 rounded-sm shadow-sm w-full max-w-md ${className}`}
    >
      {children}
    </div>
  );
};

export default FormContainer;
