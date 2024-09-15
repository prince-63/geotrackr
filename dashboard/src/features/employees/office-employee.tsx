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

const OfficeEmployee = () => {
  const [employees, setEmployees] = useState<EmployeeType[]>([]);
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
      const employeeRole = response.employeeRole;

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
        const inOfficeEmployees = employees.filter(
          (employee: any) => employee.roles[0].Role.roleName === 'OFFICE'
        );
        if (Array.isArray(inOfficeEmployees)) {
          inOfficeEmployees.forEach((employee) => {
            const employeeId = employee.employeeId;
            const employeeName = employee.employeeName;
            const employeeEmail = employee.employeeEmail;
            const employeeContactNumber = employee.employeeContactNumber;
            const employeeRole = employee.roles[0].Role.roleName;

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
          });
        } else {
          console.error('Failed to fetch employees:', employees);
        }
      } catch (error) {
        console.error('Failed to fetch employees:', error);
      }
    };

    fetchEmployees();
  }, [token]);

  return (
    <div className="p-4">
      <AddEmployeeSection
        onAdd={handleAddEmployee}
        label={'In Office Employee'}
      />

      <EmployeeTable
        employees={employees}
        onEdit={handleEditEmployee}
        onDelete={handleDeleteEmployee}
      />
    </div>
  );
};

export default OfficeEmployee;
