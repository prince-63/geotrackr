import React, { useState } from "react";
import AutoResizableImage from "../../general/auto-resizable-image";
import Typography from "../../general/typography";
import { Edit } from "lucide-react";
import ImageUploadModal from "../../general/image-upload-model";

interface ProfileHeaderProps {
  officeName: string;
  officeSubTitle: string;
  officeLogo: string;
  officeBanner: string;
}

const ProfileHeader: React.FC<ProfileHeaderProps> = ({
  officeName,
  officeSubTitle,
  officeLogo,
  officeBanner,
}) => {
  const [isBannerModalOpen, setIsBannerModalOpen] = useState(false);
  const [isLogoModalOpen, setIsLogoModalOpen] = useState(false);

  const handleBannerEditClick = () => {
    setIsBannerModalOpen(true);
  };

  const handleLogoEditClick = () => {
    setIsLogoModalOpen(true);
  };

  const handleCloseBannerModal = () => {
    setIsBannerModalOpen(false);
  };

  const handleCloseLogoModal = () => {
    setIsLogoModalOpen(false);
  };

  const handleBannerImageUpload = (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    const file = event.target.files?.[0];
    if (file) {
      // Handle the banner image upload logic here
      console.log("Uploaded banner file:", file);
      handleCloseBannerModal();
    }
  };

  const handleLogoImageUpload = (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    const file = event.target.files?.[0];
    if (file) {
      // Handle the logo image upload logic here
      console.log("Uploaded logo file:", file);
      handleCloseLogoModal();
    }
  };

  return (
    <div className="relative w-full">
      <div className="relative w-full h-[200px]">
        <AutoResizableImage
          src={officeBanner}
          alt="Office Banner"
          className="w-full h-full object-cover"
        />
        <div className="absolute inset-0"></div>
        <button
          className="absolute top-2 right-3 text-white bg-gray-800 p-2 rounded-full hover:bg-gray-700 focus:outline-none"
          aria-label="edit banner"
          onClick={handleBannerEditClick}
        >
          <Edit className="w-5 h-5" />
        </button>
      </div>
      <div className="relative flex flex-col items-center -mt-12">
        <div className="relative">
          <button onClick={handleLogoEditClick}>
            <img
              src={officeLogo}
              alt="Office Logo"
              className="h-24 w-24 rounded-full border-2"
            />
          </button>
        </div>
        <Typography variant="h6" className="text-black opacity-85">
          {officeName}
        </Typography>
        <Typography variant="body3" className="text-gray-500">
          {officeSubTitle}
        </Typography>
      </div>

      <ImageUploadModal
        text={"Upload New Banner Image"}
        placeholder={"Select a banner image 2000x400"}
        isOpen={isBannerModalOpen}
        onClose={handleCloseBannerModal}
        onImageUpload={handleBannerImageUpload}
      />

      <ImageUploadModal
        text={"Upload New Logo Image"}
        placeholder={"Select a logo image 70x70"}
        isOpen={isLogoModalOpen}
        onClose={handleCloseLogoModal}
        onImageUpload={handleLogoImageUpload}
      />
    </div>
  );
};

export default ProfileHeader;
