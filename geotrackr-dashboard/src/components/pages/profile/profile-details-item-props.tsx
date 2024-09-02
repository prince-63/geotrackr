import React from "react";
import Typography from "../../general/typography";

interface DetailItemProps {
  label: string;
  value: string;
}

const DetailItem: React.FC<DetailItemProps> = ({ label, value }) => {
  return (
    <div className="flex items-center">
      <Typography variant="body3" className="text-gray-800">
        {label}:
      </Typography>
      <Typography variant="body3" className="ml-1 text-gray-800">
        {value}
      </Typography>
    </div>
  );
};

export default DetailItem;
