import { useEffect, useState } from "react";
import AddEmployeeSection from "./add-employee-section";
import EmployeeTable from "./employee-table";
import OutOfficeEmployeeService from '../../../api-services/employee/out-office-employee-service';
import { OutOfficeEmployeeType } from '../../../lib/types';

const OutOfficeEmployee = () => {
    const [employees, setEmployees] = useState<OutOfficeEmployeeType>([]);

    const handleAddEmployee = async (employee: {
        name: string;
        email: string;
        phone: string;
    }) => {
        try {
            const response = await OutOfficeEmployeeService.AddEmployee(employee);
            console.log("Employee added successfully:", response);
            const id = response.data.employeeId;
            const name = response.data.employeeName;
            const email = response.data.employeeEmail;
            const phone = response.data.employeeContactNumber;
            setEmployees((prevEmployees) => [
                ...prevEmployees,
                {
                    id: id,
                    name: name,
                    email: email,
                    phone: phone,
                },
            ]);
        } catch (error) {
            console.error("Failed to add employee:", error);
        }
    };

    const handleEditEmployee = (id: string) => {
        // Logic to edit an employee
        console.log(`Edit employee with id: ${id}`);
    };

    const handleDeleteEmployee = async (id: string) => {
        const response = await OutOfficeEmployeeService.deleteEmployee(id);

        if (response === "success") {
            console.log("Employee deleted successfully");
            // Update the state to remove the deleted employee
            setEmployees((prevEmployees) =>
                prevEmployees.filter((employee) => employee.id !== id)
            );
        }
    };

    useEffect(() => {
        const fetchEmployees = async () => {
            try {
                const response = await OutOfficeEmployeeService.fetchEmployees();
                console.log("Fetched employees:", response);
                const employees = response.data.outOfficeEmployees;
                if (Array.isArray(employees)) {
                    employees.forEach((employee) => {
                        const id = employee.employeeId;
                        const name = employee.employeeName;
                        const email = employee.employeeEmail;
                        const phone = employee.employeeContactNumber;
                        setEmployees((prevEmployees) => [
                            ...prevEmployees,
                            {
                                id: id,
                                name: name,
                                email: email,
                                phone: phone,
                            },
                        ]);
                    });
                } else {
                    console.error("Failed to fetch employees:", employees);
                }
            } catch (error) {
                console.error("Failed to fetch employees:", error);
            }
        };

        fetchEmployees();
    }, []);

    return (
        <div className="p-4">
            <AddEmployeeSection 
                onAdd={handleAddEmployee}
                label={"Out Office Employee"}
            />

            <EmployeeTable 
                employees={employees}
                onEdit={handleEditEmployee}
                onDelete={handleDeleteEmployee}
            />
        </div>
    )
};

export default OutOfficeEmployee;