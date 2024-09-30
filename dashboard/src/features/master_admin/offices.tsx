import { SetStateAction, useEffect, useState } from 'react';
import AddOfficeSection from './add-office-section'; // Updated component
import OfficeTable from './office-table'; // Updated component
import {
    addOffice,
    deleteOffice,
    loadOffices,
} from '../../api-services/office-service'; // Adjusted API service
import { useUserContext } from '../../hooks/use-user-context';

const Offices = () => {
    interface Office {
        officeId: string;
        officeName: string;
        officeLocation: string;
        officeContactNumber: string;
        officeManager: string;
    }
    
    const [offices, setOffices] = useState<Office[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const { token } = useUserContext();

    const handleAddOffice = async (office: any) => {
        try {
            const response = await addOffice(office, { token });
            console.log('Office added successfully:', response);
            const { officeId, officeName, officeLocation, officeContactNumber, officeManager } = response;

            setOffices((prevOffices) => [
                ...prevOffices,
                {
                    officeId,
                    officeName,
                    officeLocation,
                    officeContactNumber,
                    officeManager,
                },
            ]);
        } catch (error) {
            console.error('Failed to add office:', error);
        }
    };

    const handleEditOffice = (id: any) => {
        // Logic to edit an office
        console.log(`Edit office with id: ${id}`);
    };

    const handleDeleteOffice = async (officeId: string) => {
        const response = await deleteOffice({ officeId }, { token });

        if (response === 'success') {
            console.log('Office deleted successfully');
            setOffices((prevOffices) =>
                prevOffices.filter((office) => office.officeId !== officeId)
            );
        }
    };

    useEffect(() => {
        const fetchOffices = async () => {
            try {
                const response = await loadOffices({ token });
                console.log('Fetched offices:', response);
                if (Array.isArray(response)) {
                    setOffices(
                        response.map((office) => ({
                            officeId: office.officeId,
                            officeName: office.officeName,
                            officeLocation: office.officeLocation,
                            officeContactNumber: office.officeContactNumber,
                            officeManager: office.officeManager,
                        }))
                    );
                } else {
                    console.error('Failed to fetch offices:', response);
                }
            } catch (error) {
                console.error('Failed to fetch offices:', error);
            }
        };

        fetchOffices();
    }, [token]);

    const handleSearch = (e: { target: { value: SetStateAction<string>; }; }) => {
        setSearchTerm(e.target.value);
    };

    const filteredOffices = offices.filter(
        (office) =>
            office.officeName.toLowerCase().includes(searchTerm.toLowerCase()) ||
            office.officeLocation.toLowerCase().includes(searchTerm.toLowerCase()) ||
            office.officeContactNumber.includes(searchTerm) ||
            office.officeManager.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="p-4">
            <div className="mb-4">
                <input
                    type="text"
                    placeholder="Search offices..."
                    value={searchTerm}
                    onChange={handleSearch}
                    className="p-2 border border-gray-300 rounded-md w-full"
                />
            </div>
            <AddOfficeSection onAdd={handleAddOffice} label={'Offices'} />
            <OfficeTable
                offices={filteredOffices}
                onEdit={handleEditOffice}
                onDelete={handleDeleteOffice}
            />
        </div>
    );
};

export default Offices;
