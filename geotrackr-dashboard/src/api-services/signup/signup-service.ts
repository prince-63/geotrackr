import ApiConfig from "../../config/api-config";

class SignupService {
  SingupService() {}

  public static async signup({
    officeName,
    officeEmail,
    officePassword,
  }: {
    officeName: string;
    officeEmail: string;
    officePassword: string;
  }) {
    try {
      const response = await this.post(ApiConfig.officeSignup, {
        officeName,
        officeEmail,
        officePassword,
      });
      return response;
    } catch (error) {
      console.error("Signup failed", error);
      throw error;
    }
  }

  private static async post(endpoint: string, data: object) {
    const response = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });

    console.log(response);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return response.json();
  }
}

export default SignupService;
