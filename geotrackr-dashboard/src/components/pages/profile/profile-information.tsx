import React, { useState } from "react";
import Typography from "../../general/typography";
import DetailItem from "./profile-details-item-props";
import Modal from "../../general/modal"; // Adjust the import path as necessary
import { Edit } from "lucide-react";
import ProfileService from "../../../api-services/profile/profile-service";
import LabeledInput from "../../general/labeled-input"; // Adjust the import path as necessary
import Button from "../../general/button";

interface ProfileInformationProps {
  officeName: string;
  officeSubTitle: string;
  officeEmail: string;
  officeContactNumber: string;
  officeCity: string;
  officeState: string;
  officeCountry: string;
  officePincodes: string;
  officeLongitude: string;
  officeLatitude: string;
}

const ProfileInformation: React.FC<ProfileInformationProps> = ({
  officeName: initialName,
  officeSubTitle: initialSubTitle,
  officeEmail: initialEmail,
  officeContactNumber: initialPhone,
  officeCity: initialCity,
  officeState: initialState,
  officeCountry: initialCountry,
  officePincodes: initialPincodes,
  officeLongitude: initialLongitude,
  officeLatitude: initialLatitude,
}) => {
  const [officeName, setOfficeName] = useState(initialName);
  const [officeSubTitle, setOfficeSubTitle] = useState(initialSubTitle);
  const [officeEmail, setOfficeEmail] = useState(initialEmail);
  const [officeContactNumber, setOfficeContactNumber] = useState(initialPhone);
  const [officeCity, setOfficeCity] = useState(initialCity);
  const [officeState, setOfficeState] = useState(initialState);
  const [officeCountry, setOfficeCountry] = useState(initialCountry);
  const [officePincodes, setOfficePincodes] = useState(initialPincodes);
  const [officeLongitude, setOfficeLongitude] = useState(initialLongitude);
  const [officeLatitude, setOfficeLatitude] = useState(initialLatitude);
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleEditClick = () => {
    setIsModalOpen(true);
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
  };

  const handleSaveDetails = async () => {
    await ProfileService.updateProfile({
      officeName,
      officeSubTitle,
      officeEmail,
      officeContactNumber,
      officeCity,
      officeState,
      officeCountry,
      officePincodes,
      officeLongitude,
      officeLatitude,
    });
    setIsModalOpen(false);
  };

  return (
    <div className="m-3">
      <div className="flex justify-between items-center mb-1">
        <Typography variant="h6" className="text-gray-700 font-sans">
          Office Information
        </Typography>
        <button
          onClick={handleEditClick}
          className="text-gray-600 hover:text-gray-800 focus:outline-none"
          aria-label="edit details"
        >
          <Edit className="w-5 h-5" />
        </button>
      </div>
      <div className="">
        <DetailItem label="Office name" value={officeName} />
        <DetailItem label="Office email" value={officeEmail} />
        <DetailItem label="Contact number" value={officeContactNumber} />
        <DetailItem label="City" value={officeCity} />
        <DetailItem label="State" value={officeState} />
        <DetailItem label="Country" value={officeCountry} />
        <DetailItem label="Pincodes" value={officePincodes} />
        <DetailItem label="Longitude" value={officeLongitude} />
        <DetailItem label="Latitude" value={officeLatitude} />
      </div>
      <Modal
        title="Edit Office Details"
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        width="800px"
        height="max-content"
      >
        <div className="grid grid-cols-2 gap-2">
          <LabeledInput
            label="Office Name"
            type="text"
            placeholder="Enter office name"
            value={officeName}
            onChange={(e) => setOfficeName(e.target.value)}
          />
          <LabeledInput
            label="Office Subtitle"
            type="text"
            placeholder="Enter office subtitle"
            value={officeSubTitle}
            onChange={(e) => setOfficeSubTitle(e.target.value)}
          />
          <LabeledInput
            label="Office Email"
            type="email"
            placeholder="Enter office email"
            value={officeEmail}
            onChange={(e) => setOfficeEmail(e.target.value)}
          />
          <LabeledInput
            label="Office Contact Number"
            type="text"
            placeholder="Enter office contact number"
            value={officeContactNumber}
            onChange={(e) => setOfficeContactNumber(e.target.value)}
          />
          <LabeledInput
            label="Office City"
            type="text"
            placeholder="Enter office city"
            value={officeCity}
            onChange={(e) => setOfficeCity(e.target.value)}
          />
          <LabeledInput
            label="Office State"
            type="text"
            placeholder="Enter office state"
            value={officeState}
            onChange={(e) => setOfficeState(e.target.value)}
          />
          <LabeledInput
            label="Office Country"
            type="text"
            placeholder="Enter office country"
            value={officeCountry}
            onChange={(e) => setOfficeCountry(e.target.value)}
          />
          <LabeledInput
            label="Office Pincodes"
            type="text"
            placeholder="Enter office pincodes"
            value={officePincodes}
            onChange={(e) => setOfficePincodes(e.target.value)}
          />
          <LabeledInput
            label="Office Longitude"
            type="text"
            placeholder="Enter office longitude"
            value={officeLongitude}
            onChange={(e) => setOfficeLongitude(e.target.value)}
          />
          <LabeledInput
            label="Office Latitude"
            type="text"
            placeholder="Enter office latitude"
            value={officeLatitude}
            onChange={(e) => setOfficeLatitude(e.target.value)}
          />
        </div>
        <div>
          <Button
            className="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-700 mt-2"
            type="button"
            onClick={handleSaveDetails}
          >
            Save Details
          </Button>
        </div>
      </Modal>
    </div>
  );
};

export default ProfileInformation;
