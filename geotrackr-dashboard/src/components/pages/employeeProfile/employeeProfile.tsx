import React, { useEffect, useState } from 'react';

interface EmployeeProfileProps {
    employeeId: string; // Employee ID passed as a prop
}

interface Employee {
    name: string;
    address: string;
    image: string;
    email: string;
    phone: string;
    department: string;
    role: string;
    skills: string[]; // New property for skills
    hireDate: string; // Date the employee was hired
}

interface Performance {
    rating: number; // Scale of 1 to 5
    completedProjects: number;
    ongoingProjects: number;
    attendance: string; // e.g., "95%"
    feedback: string; // Manager feedback
}

const EmployeeProfile: React.FC<EmployeeProfileProps> = ({ employeeId }) => {
    const [employee, setEmployee] = useState<Employee | null>({
        image: '',
        name: 'Rupankar Das',
        role: 'In-office',
        address: 'vyufekuwglf lelufgl ugfwugf',
        email: 'rupankarads54@gmail.com',
        phone: '7429528452',
        department: '',
        skills: ['JavaScript', 'React', 'TypeScript'],
        hireDate: 'January 15, 2021',
    });
    const [performance, setPerformance] = useState<Performance | null>({
        rating: 4.5,
        completedProjects: 12,
        ongoingProjects: 2,
        attendance: '95%',
        feedback: 'Great team player with consistent performance.',
    });
    const [loading, setLoading] = useState<boolean>(false);
    const [error, setError] = useState<string | null>(null);

    if (loading) return <div>Loading...</div>;
    if (error) return <div>{error}</div>;

    return employee && performance ? (
        <div className="w-full mx-auto p-6 bg-white rounded-lg shadow-md">
            {/* Employee Details Section */}
            <div className="flex items-center space-x-6">
                <img
                    src={employee.image}
                    alt={employee.name}
                    className="w-24 h-24 rounded-full object-cover"
                />
                <div>
                    <h2 className="text-3xl font-bold text-gray-900">
                        {employee.name}
                    </h2>
                    <p className="text-sm text-gray-500">
                        {employee.role} - {employee.department}
                    </p>
                    <p className="text-sm text-gray-500">{employee.address}</p>
                    <p className="text-sm text-gray-500">
                        Email: {employee.email}
                    </p>
                    <p className="text-sm text-gray-500">
                        Phone: {employee.phone}
                    </p>
                    <p className="text-sm text-gray-500">
                        Hire Date: {employee.hireDate}
                    </p>
                    <p className="text-sm text-gray-500">
                        Skills: {employee.skills.join(', ')}
                    </p>
                </div>
            </div>

            {/* Performance Section */}
            <div className="mt-8">
                <h3 className="text-2xl font-semibold text-gray-900 mb-4">
                    Performance
                </h3>
                <div className="grid grid-cols-2 gap-6">
                    <div className="bg-gray-100 p-4 rounded-lg text-center">
                        <h4 className="text-lg font-semibold text-gray-700">
                            Performance Rating
                        </h4>
                        <p className="text-2xl font-bold text-green-600">
                            {performance.rating}/5
                        </p>
                    </div>
                    <div className="bg-gray-100 p-4 rounded-lg text-center">
                        <h4 className="text-lg font-semibold text-gray-700">
                            Completed Projects
                        </h4>
                        <p className="text-2xl font-bold text-blue-600">
                            {performance.completedProjects}
                        </p>
                    </div>
                    <div className="bg-gray-100 p-4 rounded-lg text-center">
                        <h4 className="text-lg font-semibold text-gray-700">
                            Ongoing Projects
                        </h4>
                        <p className="text-2xl font-bold text-yellow-600">
                            {performance.ongoingProjects}
                        </p>
                    </div>
                    <div className="bg-gray-100 p-4 rounded-lg text-center">
                        <h4 className="text-lg font-semibold text-gray-700">
                            Attendance
                        </h4>
                        <p className="text-2xl font-bold text-purple-600">
                            {performance.attendance}
                        </p>
                    </div>
                </div>
            </div>

            {/* Feedback Section */}
            <div className="mt-8">
                <h3 className="text-2xl font-semibold text-gray-900 mb-4">
                    Manager Feedback
                </h3>
                <p className="bg-gray-100 p-4 rounded-lg text-gray-700">
                    {performance.feedback}
                </p>
            </div>

            {/* Milestones Section */}
            <div className="mt-8">
                <h3 className="text-2xl font-semibold text-gray-900 mb-4">
                    Milestones
                </h3>
                <ul className="list-disc list-inside space-y-2">
                    <li>Joined the team on {employee.hireDate}</li>
                    <li>
                        Successfully completed {performance.completedProjects}{' '}
                        projects.
                    </li>
                    <li>
                        Currently managing {performance.ongoingProjects} ongoing
                        projects.
                    </li>
                </ul>
            </div>
        </div>
    ) : (
        <div>No employee data found</div>
    );
};

export default EmployeeProfile;
