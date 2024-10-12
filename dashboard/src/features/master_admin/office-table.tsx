import React, { useState } from 'react';
import { Edit, Trash } from 'lucide-react';

interface OfficeType {
    officeId: string;
    officeName: string;
    officeLocation: string;
    officeContactNumber: string;
    officeManager: string;
}

interface OfficeTableProps {
    offices: OfficeType[];
    onEdit: (id: string) => void;
    onDelete: (id: string) => void;
}

const OfficeTable: React.FC<OfficeTableProps> = ({
    offices,
    onEdit,
    onDelete,
}) => {
    const [currentPage, setCurrentPage] = useState(1);
    const itemsPerPage = 10;

    const indexOfLastItem = currentPage * itemsPerPage;
    const indexOfFirstItem = indexOfLastItem - itemsPerPage;
    const currentOffices = offices.slice(indexOfFirstItem, indexOfLastItem);

    const totalPages = Math.ceil(offices.length / itemsPerPage);

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
                        <th className="px-4 py-2 text-left text-gray-600">Office Name</th>
                        <th className="px-4 py-2 text-left text-gray-600">Location</th>
                        <th className="px-4 py-2 text-left text-gray-600">Phone No.</th>
                        <th className="px-4 py-2 text-left text-gray-600">Manager</th>
                        <th className="px-4 py-2 text-left text-gray-600">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {currentOffices.map((office, index) => (
                        <tr key={index} className="border-b bg-white dark:bg-gray-100">
                            <td className="px-4 py-2">{indexOfFirstItem + index + 1}</td>
                            <td className="px-4 py-2">{office.officeName}</td>
                            <td className="px-4 py-2">{office.officeLocation}</td>
                            <td className="px-4 py-2">{office.officeContactNumber}</td>
                            <td className="px-4 py-2">{office.officeManager}</td>
                            <td className="px-4 py-2 flex space-x-2">
                                <button
                                    className="text-blue-500 hover:text-blue-700"
                                    onClick={() => onEdit(office.officeId)}
                                >
                                    <Edit className="w-5 h-5" />
                                </button>
                                <button
                                    className="text-red-500 hover:text-red-700"
                                    onClick={() => onDelete(office.officeId)}
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

export default OfficeTable;
