import React, { useState } from 'react';
import Modal from '../../components/general/modal';
import LabeledInput from '../../components/general/labeled-input';
import Button from '../../components/general/button';
import { Plus } from 'lucide-react';

interface AddOfficeSectionProps {
    onAdd: (office: {
        officeName: string;
        officeLocation: string;
        officeContactNumber: string;
        officeManager: string;
    }) => void;
    label: string;
}

const AddOfficeSection: React.FC<AddOfficeSectionProps> = ({
    onAdd,
    label,
}) => {
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [office, setOffice] = useState({
        officeName: '',
        officeLocation: '',
        officeContactNumber: '',
        officeManager: '',
    });

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const { name, value } = e.target;
        console.log(`Input Change - Name: ${name}, Value: ${value}`);
        setOffice({ ...office, [name]: value });
    };

    const handleAddClick = () => {
        console.log('Add Clicked', office);
        onAdd(office);
        setIsModalOpen(false);
        setOffice({
            officeName: '',
            officeLocation: '',
            officeContactNumber: '',
            officeManager: '',
        });
    };

    return (
        <div>
            <div className="flex justify-between items-center p-4 bg-gray-100 border border-gray-200 rounded-md mb-4">
                <span className="text-gray-700">{label}</span>
                <button
                    className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-700 flex items-center space-x-2"
                    onClick={() => {
                        console.log('Open Modal');
                        setIsModalOpen(true);
                    }}
                >
                    <Plus className="w-5 h-5" />
                    <span>Add</span>
                </button>
            </div>

            <div>
                <Modal
                    isOpen={isModalOpen}
                    onClose={() => {
                        console.log('Close Modal');
                        setIsModalOpen(false);
                    }}
                    title={label}
                    width="400px"
                    height="max-content"
                >
                    <div>
                        <LabeledInput
                            label="Office Name"
                            placeholder="Enter office name"
                            type="text"
                            name="officeName"
                            value={office.officeName}
                            onChange={handleInputChange}
                        />
                        <LabeledInput
                            label="Location"
                            placeholder="Enter office location"
                            type="text"
                            name="officeLocation"
                            value={office.officeLocation}
                            onChange={handleInputChange}
                        />
                        <LabeledInput
                            label="Phone"
                            placeholder="Enter office phone"
                            type="text"
                            name="officeContactNumber"
                            value={office.officeContactNumber}
                            onChange={handleInputChange}
                        />
                        <LabeledInput
                            label="Manager"
                            placeholder="Enter office manager name"
                            type="text"
                            name="officeManager"
                            value={office.officeManager}
                            onChange={handleInputChange}
                        />
                    </div>
                    <div>
                        <Button
                            className="bg-blue-600 text-white px-3 py-2 rounded-md hover:bg-blue-700 mt-2"
                            type="button"
                            onClick={handleAddClick}
                        >
                            <span className="font-light">Add Office</span>
                        </Button>
                    </div>
                </Modal>
            </div>
        </div>
    );
};

export default AddOfficeSection;
