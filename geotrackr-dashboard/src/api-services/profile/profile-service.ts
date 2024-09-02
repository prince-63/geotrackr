import ApiConfig from "../../config/api-config";

class ProfileService {
  ProfileService() {}

  public static async getProfile() {
    const url = ApiConfig.profile;
    const token = await window.electron.getToken();

    if (!token) {
      throw new Error("Token not found");
    }

    try {
      const response = await fetch(url, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      console.log("Profile fetch successful");

      return response.json();
    } catch (error) {
      console.error("Profile fetch failed", error);
      throw error;
    }
  }

  public static async updateProfile(data: {
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
  }) {
    const url = ApiConfig.updateProfile;
    const token = await window.electron.getToken();

    if (!token) {
      throw new Error("Token not found");
    }

    try {
      const response = await fetch(url, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(data),
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      console.log("Profile update successful");

      return response.json();
    } catch (error) {
      console.error("Profile update failed", error);
      throw error;
    }
  }
}

export default ProfileService;
