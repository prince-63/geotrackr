import * as React from 'react';

interface BreakLineProps {
  className?: string;
}

const BreakLine: React.FC<BreakLineProps> = ({ className = '' }) => {
  return <hr className={`border-t border-gray-300 my-4 ${className}`} />;
};

export default BreakLine;
