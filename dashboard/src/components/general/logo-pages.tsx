import React from 'react';
import Typography from '../../components/general/typography';
import Logo from './logo';

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
      <Logo />
      <Typography variant="body3" className="mt-2 text-grey-800 dark:text-white">
        {message}
      </Typography>
    </div>
  );
};

export default LogoForPages;
