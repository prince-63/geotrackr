import ApiConfig from "../../config/api-config";

class InOfficeEmployeeService {
  InOfficeEmployeeService() {}

  public static async AddEmployee(employee: {
    name: string;
    email: string;
    phone: string;
  }) {
    const url = ApiConfig.addInOfficeEmployee;
    const token = await window.electron.getToken();
    try {
      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(employee),
      });

      if (!response.ok) {
        throw new Error("Network response was not ok");
      }

      const newEmployee = await response.json();
      return newEmployee;
    } catch (error) {
      console.error("Failed to add employee:", error);
      throw error;
    }
  }

  public static async fetchEmployees() {
    const url = ApiConfig.getInOfficeEmployees;
    const token = await window.electron.getToken();
    try {
      const response = await fetch(url, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error("Network response was not ok");
      }

      const employees = await response.json();
      return employees;
    } catch (error) {
      console.error("Failed to fetch employees:", error);
      throw error;
    }
  }

  public static async deleteEmployee(id: string) {
    const url = `${ApiConfig.deleteInOfficeEmployee}/${id}`;
    const token = await window.electron.getToken();
    try {
      const response = await fetch(url, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error("Network response was not ok");
      }

      const deletedEmployee = await response.json();
      return deletedEmployee.status;
    } catch (error) {
      console.error("Failed to delete employee:", error);
      throw error;
    }
  }
}

export default InOfficeEmployeeService;
