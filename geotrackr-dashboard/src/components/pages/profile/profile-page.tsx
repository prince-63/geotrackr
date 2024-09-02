import React, { useEffect, useState } from "react";
// import ProfileHeader from "./profile-header";
// import officeLogo from "../../../../assets/fab-icons/mstile-70x70.png";
// import officeBanner from "../../../../assets/images/banner.jpg";
// import BreakLine from "../../general/break-line";
import ProfileInformation from "./profile-information";
import ProfileService from "../../../api-services/profile/profile-service";

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

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await ProfileService.getProfile();
        setProfileData(response.data.officeDetails);
        setLoading(false);
        console.log("Profile data fetched", response.data.officeDetails);
      } catch (error) {
        console.error(error);
        setLoading(false);
      }
    }
    fetchData();
  }, []);

  if (loading) {
    return (
      <div className="min-h-screen flex-col items-center justify-center m-3">
        Loading...
      </div>
    );
  }

  return (
    <div className="min-h-screen flex-col items-center justify-center">
      {/* <ProfileHeader
        officeName={profileData.officeName || "Office Name"}
        officeLogo={officeLogo}
        officeBanner={officeBanner}
        officeSubTitle={profileData.officeSubTitle || "Office Subtitle"}
      />
      <BreakLine /> */}
      <ProfileInformation
        officeName={profileData.officeName || "Office Name"}
        officeSubTitle={profileData.officeSubTitle || "Office Subtitle"}
        officeEmail={profileData.officeEmail || "Office Email"}
        officeContactNumber={
          profileData.officeContactNumber || "Office Contact Number"
        }
        officeCity={profileData.officeCity || "Office City"}
        officeState={profileData.officeState || "Office State"}
        officeCountry={profileData.officeCountry || "Office Country"}
        officePincodes={profileData.officePincodes || "Office Pincodes"}
        officeLongitude={profileData.officeLongitude || "Longitude"}
        officeLatitude={profileData.officeLatitude || "Latitude"}
      />
    </div>
  );
};

export default ProfilePage;
