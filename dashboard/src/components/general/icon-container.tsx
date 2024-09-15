import * as React from 'react';

interface IconContainerProps {
  children: React.ReactNode;
  className?: string;
}

const IconContainer: React.FC<IconContainerProps> = ({
  children,
  className = '',
}) => {
  return (
    <div
      className={`flex items-center justify-center p-2 rounded ${className}`}
    >
      {children}
    </div>
  );
};

export default IconContainer;
