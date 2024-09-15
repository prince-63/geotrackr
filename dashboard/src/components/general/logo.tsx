import React from 'react';
import logoImage from '../../../../../fab-icons/mstile-70x70.png';

const Logo: React.FC = () => {
  return (
    <div className="flex items-center justify-center">
      <img
        src={logoImage}
        alt="Application Logo"
        className="w-[80px] h-[80px] mr-2 rounded-full shadow-md p-1 bg-white"
      />
    </div>
  );
};

export default Logo;
