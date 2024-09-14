import React, { useEffect, useState } from "react";
import ProfileService from "../../../api-services/profile/profile-service";
import { FaEdit } from "react-icons/fa";
import ProfileInformation from "./profile-information";

interface ProfileData {
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

const ProfilePage: React.FC = () => {
  const [profileData, setProfileData] = useState<ProfileData>({
    officeName: "",
    officeSubTitle: "",
    officeEmail: "",
    officeContactNumber: "",
    officeCity: "",
    officeState: "",
    officeCountry: "",
    officePincodes: "",
    officeLongitude: "",
    officeLatitude: "",
  });

  const [loading, setLoading] = useState(true);
  const [isEditing, setIsEditing] = useState(false);
  const [editedData, setEditedData] = useState<ProfileData>(profileData);

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await ProfileService.getProfile();
        setProfileData(response.data.officeDetails);
        setEditedData(response.data.officeDetails); // Pre-fill the edit form with fetched data
        setLoading(false);
      } catch (error) {
        console.error(error);
        setLoading(false);
      }
    }
    fetchData();
  }, []);

  const handleEditClick = () => {
    setIsEditing(true);
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setEditedData({
      ...editedData,
      [name]: value,
    });
  };

  const handleSaveChanges = async () => {
    try {
      await ProfileService.updateProfile(editedData);
      setProfileData(editedData); // Update the main profile data after saving
      setIsEditing(false); // Close the edit modal
    } catch (error) {
      console.error("Failed to update profile:", error);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-100">
        <div className="text-gray-500 text-lg">Loading...</div>
      </div>
    );
  }

  return (
    <ProfileInformation 
      officeName={profileData.officeName}
      officeSubTitle={profileData.officeSubTitle}
      officeEmail={profileData.officeEmail}
      officeContactNumber={profileData.officeContactNumber}
      officeCity={profileData.officeCity}
      officeState={profileData.officeState}
      officeCountry={profileData.officeCountry}
      officePincodes={profileData.officePincodes}
      officeLongitude={profileData.officeLongitude}
      officeLatitude={profileData.officeLatitude}
    />
  );
};

export default ProfilePage;
