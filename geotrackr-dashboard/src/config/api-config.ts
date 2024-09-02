class ApiConfig {
  public static BASE_URL = "http://localhost:8000/api/v1";
  public static officeSignup = ApiConfig.BASE_URL + "/office/sign-up";
  public static officeLogin = ApiConfig.BASE_URL + "/office/login";
  public static profile = ApiConfig.BASE_URL + "/office/get-details";
  public static updateProfile = ApiConfig.BASE_URL + "/office/update-details";
  public static uploadProfile = ApiConfig.BASE_URL + "/office/upload-details";
  public static addInOfficeEmployee =
    ApiConfig.BASE_URL + "/office/add-in-office-employee";
  public static getInOfficeEmployees =
    ApiConfig.BASE_URL + "/office/get-all-in-office-employees";
  public static updateInOfficeEmployee =
    ApiConfig.BASE_URL + "/office/update-in-office-employee";
  public static deleteInOfficeEmployee =
    ApiConfig.BASE_URL + "/office/delete-in-office-employee";
}

export default ApiConfig;
