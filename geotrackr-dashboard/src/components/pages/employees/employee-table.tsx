import React, { useState } from "react";
import { Edit, Trash } from "lucide-react";
import { InOfficeEmployeeType } from "../../../lib/types";

interface EmployeeTableProps {
  employees: InOfficeEmployeeType;
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
      <table className="min-w-full bg-white border border-gray-200">
        <thead>
          <tr className="bg-gray-100 border-b">
            <th className="px-4 py-2 text-left text-gray-600">SL No.</th>
            <th className="px-4 py-2 text-left text-gray-600">Name</th>
            <th className="px-4 py-2 text-left text-gray-600">Email Id</th>
            <th className="px-4 py-2 text-left text-gray-600">Phone No.</th>
            <th className="px-4 py-2 text-left text-gray-600">Actions</th>
          </tr>
        </thead>
        <tbody>
          {currentEmployees.map((employee, index) => (
            <tr key={index} className="border-b hover:bg-gray-50">
              <td className="px-4 py-2">{indexOfFirstItem + index + 1}</td>
              <td className="px-4 py-2">{employee.name}</td>
              <td className="px-4 py-2">{employee.email}</td>
              <td className="px-4 py-2">{employee.phone}</td>
              <td className="px-4 py-2 flex space-x-2">
                <button
                  className="text-blue-500 hover:text-blue-700"
                  onClick={() => onEdit(employee.id)}
                >
                  <Edit className="w-5 h-5" />
                </button>
                <button
                  className="text-red-500 hover:text-red-700"
                  onClick={() => onDelete(employee.id)}
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
          className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
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
