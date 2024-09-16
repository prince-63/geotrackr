import React from 'react';

interface SectionHeaderProps {
  title: string;
  description: string;
}

const SectionHeader: React.FC<SectionHeaderProps> = ({
  title,
  description,
}) => {
  return (
    <div className="text-center mb-12">
      <h2 className="text-3xl sm:text-4xl font-bold text-center mb-5 sm:mb-5 dark:text-white">
        {title}
      </h2>
      <p className="text-lg max-w-3xl mx-auto dark:text-white">{description}</p>
    </div>
  );
};

export default SectionHeader;
