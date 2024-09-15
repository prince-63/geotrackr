import React, { useState } from 'react';
import Modal from '../../components/general/modal';
import LabeledInput from '../../components/general/labeled-input';
import Button from '../../components/general/button';
import { Plus } from 'lucide-react';

interface AddEmployeeSectionProps {
  onAdd: (employee: {
    employeeName: string;
    employeeEmail: string;
    employeeContactNumber: string;
    employeeRole: string;
  }) => void;
  label: string;
}

const AddEmployeeSection: React.FC<AddEmployeeSectionProps> = ({
  onAdd,
  label,
}) => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [employee, setEmployee] = useState({
    employeeName: '',
    employeeEmail: '',
    employeeContactNumber: '',
    employeeRole: '',
  });

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setEmployee({ ...employee, [name]: value });
  };

  const handleAddClick = () => {
    onAdd(employee);
    setIsModalOpen(false);
    setEmployee({
      employeeName: '',
      employeeEmail: '',
      employeeContactNumber: '',
      employeeRole: '',
    });
  };

  return (
    <div>
      <div className="flex justify-between items-center p-4 bg-gray-100 border border-gray-200 rounded-md mb-4">
        <span className="text-gray-700">{label}</span>
        <button
          className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-700 flex items-center space-x-2"
          onClick={() => setIsModalOpen(true)}
        >
          <Plus className="w-5 h-5" />
          <span>Add</span>
        </button>
      </div>

      <div>
        <Modal
          isOpen={isModalOpen}
          onClose={() => setIsModalOpen(false)}
          title={label}
          width="400px"
          height="max-content"
        >
          <div>
            <LabeledInput
              label="Name"
              placeholder="Enter employee name"
              type="text"
              name="name"
              value={employee.employeeName}
              onChange={handleInputChange}
            />
            <LabeledInput
              label="Email"
              placeholder="Enter employee email"
              type="email"
              name="email"
              value={employee.employeeEmail}
              onChange={handleInputChange}
            />
            <LabeledInput
              label="Phone"
              placeholder="Enter employee phone"
              type="text"
              name="phone"
              value={employee.employeeContactNumber}
              onChange={handleInputChange}
            />
            <LabeledInput
              label="Role"
              placeholder="Enter employee role"
              type="text"
              name="role"
              value={employee.employeeRole}
              onChange={handleInputChange}
            />
          </div>
          <div>
            <Button
              className="bg-blue-600 text-white px-3 py-2 rounded-md hover:bg-blue-700 mt-2"
              type="button"
              onClick={handleAddClick}
            >
              <span className="font-light">Add Employee</span>
            </Button>
          </div>
        </Modal>
      </div>
    </div>
  );
};

export default AddEmployeeSection;
