import React, { useState } from 'react';
import { Edit, Trash } from 'lucide-react';

interface EmployeeType {
  employeeId: string;
  employeeName: string;
  employeeEmail: string;
  employeeContactNumber: string;
  employeeRole: Array<string>;
}

interface EmployeeTableProps {
  employees: EmployeeType[];
  onEdit: (id: string) => void;
  onDelete: (id: string) => void;
}

const EmployeeTable: React.FC<EmployeeTableProps> = ({
  employees,
  onEdit,
  onDelete,
}) => {
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;

  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentEmployees = employees.slice(indexOfFirstItem, indexOfLastItem);

  const totalPages = Math.ceil(employees.length / itemsPerPage);

  const handleNextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  };

  const handlePreviousPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  };

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full bg-white dark:bg-gray-100 border border-gray-200">
        <thead>
          <tr className="bg-gray-100 border-b">
            <th className="px-4 py-2 text-left text-gray-600">SL No.</th>
            <th className="px-4 py-2 text-left text-gray-600">Name</th>
            <th className="px-4 py-2 text-left text-gray-600">Email Id</th>
            <th className="px-4 py-2 text-left text-gray-600">Phone No.</th>
            <th className="px-4 py-2 text-left text-gray-600">Role</th>
            <th className="px-4 py-2 text-left text-gray-600">Actions</th>
          </tr>
        </thead>
        <tbody>
          {currentEmployees.map((employee, index) => (
            <tr key={index} className="border-b bg-white dark:bg-gray-100">
              <td className="px-4 py-2">{indexOfFirstItem + index + 1}</td>
              <td className="px-4 py-2">{employee.employeeName}</td>
              <td className="px-4 py-2">{employee.employeeEmail}</td>
              <td className="px-4 py-2">{employee.employeeContactNumber}</td>
              <td className="px-4 py-2">{employee.employeeRole}</td>
              <td className="px-4 py-2 flex space-x-2">
                <button
                  className="text-blue-500 hover:text-blue-700"
                  onClick={() => onEdit(employee.employeeId)}
                >
                  <Edit className="w-5 h-5" />
                </button>
                <button
                  className="text-red-500 hover:text-red-700"
                  onClick={() => onDelete(employee.employeeId)}
                >
                  <Trash className="w-5 h-5" />
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <div className="flex justify-around mt-4 items-center">
        <button
          className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
          onClick={handlePreviousPage}
          disabled={currentPage === 1}
        >
          Previous
        </button>
        <span>
          Page {currentPage} of {totalPages}
        </span>
        <button
          className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded mb-10"
          onClick={handleNextPage}
          disabled={currentPage === totalPages}
        >
          Next
        </button>
      </div>
    </div>
  );
};

export default EmployeeTable;
