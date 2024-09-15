import React from 'react';
import Typography from '../../components/general/typography';

interface logoForPagesProps {
  message?: string;
  className?: string;
}

const LogoForPages: React.FC<logoForPagesProps> = ({
  message = 'Create a new account to get started.',
  className,
}) => {
  return (
    <div className={`text-center mb-6 ${className}`}>
      {/* <Logo /> */}
      <Typography variant="body3" className="mt-2">
        {message}
      </Typography>
    </div>
  );
};

export default LogoForPages;
