import React, { useEffect, useState } from 'react';
import { loadOffice } from '../../api-services/profile-service';
import ProfileInformation from './profile-information';
import { useUserContext } from '../../hooks/use-user-context';

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
    officeName: '',
    officeSubTitle: '',
    officeEmail: '',
    officeContactNumber: '',
    officeCity: '',
    officeState: '',
    officeCountry: '',
    officePincodes: '',
    officeLongitude: '',
    officeLatitude: '',
  });
  const { token } = useUserContext();

  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await loadOffice({ token });
        setProfileData(response);
        setLoading(false);
      } catch (error) {
        console.error(error);
        setLoading(false);
      }
    }
    fetchData();
  }, [token]);

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
