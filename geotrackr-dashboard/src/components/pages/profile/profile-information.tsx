import React, { useState } from "react";
import Typography from "../../general/typography";
import DetailItem from "./profile-details-item-props";
import Modal from "../../general/modal";
import { Edit } from "lucide-react";
import ProfileService from "../../../api-services/profile/profile-service";
import LabeledInput from "../../general/labeled-input";
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
    <div className="min-h-screen bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto bg-white shadow-lg rounded-lg p-6 sm:p-8">
        {/* Profile Information Card */}
        <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-6">
          <Typography variant="h2" className="text-2xl md:text-3xl font-semibold text-gray-800 border-b-2 border-gray-300 pb-2">
            {officeName || "Office Name"}
          </Typography>
          <button
            onClick={handleEditClick}
            className="text-green-600 hover:text-green-800 transition-colors duration-200 mt-4 md:mt-0"
            aria-label="Edit details"
          >
            <Edit size={24} />
          </button>
        </div>

        <p className="text-gray-600 mb-6 text-lg font-semibold italic">{officeSubTitle || "Office Subtitle"}</p>

        <div className="space-y-6">
          <div className="bg-gray-100 p-4 rounded-lg shadow-inner">
            <h2 className="text-lg font-medium text-gray-700 border-b-2 border-gray-300 pb-2">Contact Information</h2>
            <p className="text-gray-600 mt-2 text-base">
              <span className="font-semibold">Email: </span>{officeEmail || "office@example.com"}
            </p>
            <p className="text-gray-600 mt-2 text-base">
              <span className="font-semibold">Phone: </span>{officeContactNumber || "+123 456 7890"}
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="bg-gray-100 p-4 rounded-lg shadow-inner">
              <h2 className="text-lg font-medium text-gray-700 border-b-2 border-gray-300 pb-2">Location</h2>
              <p className="text-gray-600 mt-2 text-base">
                {officeCity || "City"}, {officeState || "State"}, {officeCountry || "Country"}
              </p>
            </div>
            <div className="bg-gray-100 p-4 rounded-lg shadow-inner">
              <h2 className="text-lg font-medium text-gray-700 border-b-2 border-gray-300 pb-2">Pincodes & Coordinates</h2>
              <p className="text-gray-600 mt-2 text-base">Pincode: {officePincodes || "000000"}</p>
              <p className="text-gray-600 text-base">
                Coordinates: {officeLongitude || "Longitude"}, {officeLatitude || "Latitude"}
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Modal for editing profile information */}
      <Modal
        title="Edit Office Details"
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        width="2xl"
        className="p-6"
      >
        <div className="grid w-full grid-cols-1 md:grid-cols-2 gap-4 mb-4">
          {[
            { label: "Office Name", value: officeName, setter: setOfficeName, type: "text" },
            { label: "Office Subtitle", value: officeSubTitle, setter: setOfficeSubTitle, type: "text" },
            { label: "Office Email", value: officeEmail, setter: setOfficeEmail, type: "email" },
            { label: "Contact Number", value: officeContactNumber, setter: setOfficeContactNumber, type: "text" },
            { label: "City", value: officeCity, setter: setOfficeCity, type: "text" },
            { label: "State", value: officeState, setter: setOfficeState, type: "text" },
            { label: "Country", value: officeCountry, setter: setOfficeCountry, type: "text" },
            { label: "Pincodes", value: officePincodes, setter: setOfficePincodes, type: "text" },
            { label: "Longitude", value: officeLongitude, setter: setOfficeLongitude, type: "text" },
            { label: "Latitude", value: officeLatitude, setter: setOfficeLatitude, type: "text" },
          ].map(({ label, value, setter, type }) => (
            <div key={label} className="mb-4">
              <label className="block text-gray-700 text-sm font-medium mb-2">{label}</label>
              <input
                type={type}
                value={value}
                onChange={(e) => setter(e.target.value)}
                className="w-full p-3 border border-gray-300 rounded-lg focus:border-green-500 focus:ring-green-500 transition-colors duration-200"
                placeholder={`Enter ${label.toLowerCase()}`}
              />
            </div>
          ))}
        </div>
        <div className="flex flex-col sm:flex-row justify-end space-y-4 sm:space-y-0 sm:space-x-4 mt-6">
          <Button
            className="bg-gray-300 text-gray-700 hover:bg-gray-400 transition-colors duration-200"
            onClick={handleCloseModal}
          >
            Cancel
          </Button>
          <Button
            className="bg-green-600 text-white hover:bg-green-700 transition-colors duration-200"
            onClick={handleSaveDetails}
          >
            Save Changes
          </Button>
        </div>
      </Modal>
    </div>
  );
};

export default ProfileInformation;
