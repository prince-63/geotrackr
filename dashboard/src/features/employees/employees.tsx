import { useEffect, useState } from 'react';
import AddEmployeeSection from './add-employee-section';
import EmployeeTable from './employee-table';
import {
  addOfficeEmployee,
  deleteEmployee,
  loadEmployees,
} from '../../api-services/employee-service';
import { EmployeeType } from '../../lib/types';
import { useUserContext } from '../../hooks/use-user-context';

const Employees = () => {
  const [employees, setEmployees] = useState<EmployeeType[]>([]);
  const [searchTerm, setSearchTerm] = useState('');
  const { token } = useUserContext();

  const handleAddEmployee = async (employee: {
    employeeName: string;
    employeeEmail: string;
    employeeContactNumber: string;
    employeeRole: string;
  }) => {
    try {
      const response = await addOfficeEmployee(employee, { token });
      console.log('Employee added successfully:', response);
      const employeeId = response.employeeId;
      const employeeName = response.employeeName;
      const employeeEmail = response.employeeEmail;
      const employeeContactNumber = response.employeeContactNumber;
      const employeeRole = response.roles[0];

      console.log(response);

      setEmployees((prevEmployees) => [
        ...prevEmployees,
        {
          employeeId,
          employeeName,
          employeeEmail,
          employeeContactNumber,
          employeeRole,
        },
      ]);
    } catch (error) {
      console.error('Failed to add employee:', error);
    }
  };

  const handleEditEmployee = (id: string) => {
    // Logic to edit an employee
    console.log(`Edit employee with id: ${id}`);
  };

  const handleDeleteEmployee = async (employeeId: string) => {
    const response = await deleteEmployee({ employeeId }, { token });

    if (response === 'success') {
      console.log('Employee deleted successfully');
      setEmployees((prevEmployees) =>
        prevEmployees.filter((employee) => employee.employeeId !== employeeId)
      );
    }
  };

  useEffect(() => {
    const fetchEmployees = async () => {
      try {
        const response = await loadEmployees({ token });
        console.log('Fetched employees:', response);
        const employees = response;
        if (Array.isArray(employees)) {
          setEmployees(
            employees.map((employee) => ({
              employeeId: employee.employeeId,
              employeeName: employee.employeeName,
              employeeEmail: employee.employeeEmail,
              employeeContactNumber: employee.employeeContactNumber,
              employeeRole: employee.roles[0]
                ? employee.roles[0].Role.roleName
                : '',
            }))
          );
        } else {
          console.error('Failed to fetch employees:', employees);
        }
      } catch (error) {
        console.error('Failed to fetch employees:', error);
      }
    };

    fetchEmployees();
  }, [token]);

  const handleSearch = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
  };

  const filteredEmployees = employees.filter(
    (employee) =>
      employee.employeeName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      employee.employeeEmail.toLowerCase().includes(searchTerm.toLowerCase()) ||
      employee.employeeContactNumber.includes(searchTerm) ||
      employee.employeeRole.includes(searchTerm)
  );

  return (
    <div className="p-4">
      <div className="mb-4">
        <input
          type="text"
          placeholder="Search employees..."
          value={searchTerm}
          onChange={handleSearch}
          className="p-2 border border-gray-300 rounded-md w-full"
        />
      </div>
      <AddEmployeeSection onAdd={handleAddEmployee} label={'Employees'} />
      <EmployeeTable
        employees={filteredEmployees}
        onEdit={handleEditEmployee}
        onDelete={handleDeleteEmployee}
      />
    </div>
  );
};

export default Employees;
