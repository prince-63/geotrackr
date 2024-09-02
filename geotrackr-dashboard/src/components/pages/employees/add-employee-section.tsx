import React, { useState } from "react";
import Modal from "../../general/modal";
import LabeledInput from "../../general/labeled-input";
import Button from "../../general/button";
import { Plus } from "lucide-react";

interface AddEmployeeSectionProps {
  onAdd: (employee: { name: string; email: string; phone: string }) => void;
  label: string;
}

const AddEmployeeSection: React.FC<AddEmployeeSectionProps> = ({
  onAdd,
  label,
}) => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [employee, setEmployee] = useState({ name: "", email: "", phone: "" });

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setEmployee({ ...employee, [name]: value });
  };

  const handleAddClick = () => {
    onAdd(employee);
    setIsModalOpen(false);
    setEmployee({ name: "", email: "", phone: "" });
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
              value={employee.name}
              onChange={handleInputChange}
            />
            <LabeledInput
              label="Email"
              placeholder="Enter employee email"
              type="email"
              name="email"
              value={employee.email}
              onChange={handleInputChange}
            />
            <LabeledInput
              label="Phone"
              placeholder="Enter employee phone"
              type="text"
              name="phone"
              value={employee.phone}
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
