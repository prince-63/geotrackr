class ApiConfig {
  public static BASE_URL = 'http://localhost:8000/api/v1';

  public static officeSignup = ApiConfig.BASE_URL + '/office/sign-up';

  public static officeLogin = ApiConfig.BASE_URL + '/office/login';

  public static addOfficeEmployee =
    ApiConfig.BASE_URL + '/office/add-office-employee';

  public static addRemoteEmployee =
    ApiConfig.BASE_URL + '/office/add-remote-employee';

  public static getEmployees = ApiConfig.BASE_URL + '/office/get-employees';

  public static deleteEmployee = ApiConfig.BASE_URL + '/office/delete-employee';
  
  public static loadOffice = ApiConfig.BASE_URL + '/office/get-details';

  public static updateOffice = ApiConfig.BASE_URL + '/office/update-details';

  public static updateOfficeEmployee =
    ApiConfig.BASE_URL + '/office/update-employee';

}

export default ApiConfig;