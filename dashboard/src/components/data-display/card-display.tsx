import React from 'react';

interface CardDisplayProps {
  icon: React.ReactNode;
  title: string;
  description: string;
  iconColor: string;
}

const CardDisplay: React.FC<CardDisplayProps> = ({
  icon,
  title,
  description,
  iconColor,
}) => {
  return (
    <div className="w-[400px] bg-white text-gray-800 p-8 rounded-lg shadow-lg transform hover:scale-105 transition-transform duration-300 dark:bg-gray-800 dark:text-gray-200 h-[300px] flex flex-col justify-between">
      <div className={`text-4xl mb-4 ${iconColor}`}>{icon}</div>
      <h3 className="text-2xl font-semibold mb-4">{title}</h3>
      <p className="flex-grow">{description}</p>
    </div>
  );
};

export default CardDisplay;
