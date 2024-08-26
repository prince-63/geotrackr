import React from 'react';
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
    DialogTrigger,
} from './Popup';

import { toast, ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import axios from 'axios';
import AddEmployee from './AddEmployee';

const AssignWork = () => {
    const employees = [
        {
            employeeId: 1,
            employeeName: 'John Doe',
            employeeEmail: 'abc@email.com',
            employeeContactNumber: '1234567890',
        },
        {
            employeeId: 2,
            employeeName: 'Jane Doe',
            employeeEmail: 'abc@email.com',
            employeeContactNumber: '1234567890',
        },
        {
            employeeId: 3,
            employeeName: 'John Doe',
            employeeEmail: 'abc@email.com',
            employeeContactNumber: '1234567890',
        },
    ];

    const handleAssignWork = async () => {
        const employeeId = (document.getElementById('employeeId') as HTMLInputElement).value;
        const workDate = (document.getElementById('workDate') as HTMLInputElement).value;
        const workAddressName = (document.getElementById('workAddressName') as HTMLInputElement).value;
        const workCity = (document.getElementById('workCity') as HTMLInputElement).value;
        const workState = (document.getElementById('workState') as HTMLInputElement).value;
        const workCountry = (document.getElementById('workCountry') as HTMLInputElement).value;
        const workPincode = (document.getElementById('workPincode') as HTMLInputElement).value;
        const workLongitude = (document.getElementById('workLongitude') as HTMLInputElement).value;
        const workLatitude = (document.getElementById('workLatitude') as HTMLInputElement).value;

        if (workDate === '' || workAddressName === '' || workCity === '' || workState === '' || workCountry === '' || workPincode === '' || workLongitude === '' || workLatitude === '') {
            toast.error('Please fill in all the details.');
            return;
        }

        try {            
            const res = await axios.post(process.env.SERVER_API_URL + '/assignWork', {
                employeeId,
                workDate,
                workAddressName,
                workCity,
                workState,
                workCountry,
                workPincode,
                workLongitude,
                workLatitude,
            });

            if (res.status === 200) {
                toast.success('Work assigned successfully.');
            } else {
                toast.error('Failed to assign work.');
            }
        } catch (error: any) {
            toast.error(error.message);
            console.log(error);
        }
    }

    return (
        <div className="flex justify-center items-center min-h-screen bg-gray-100 p-4">
            <div className="w-full max-w-7xl h-full bg-white p-8 rounded-lg shadow-lg">
                <h1 className="text-3xl font-semibold text-gray-800 mb-8 text-center">Assign Tasks</h1>
                
                <section className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4 mb-8">
                    {/* Card 1 */}
                    <div className="bg-blue-50 shadow-md rounded-lg p-6">
                        <h2 className="text-xl font-semibold text-gray-700 mb-2">Total Tasks</h2>
                        <p className="text-3xl font-bold text-blue-600">4,500</p>
                    </div>

                    {/* Card 2 */}
                    <div className="bg-green-50 shadow-md rounded-lg p-6">
                        <h2 className="text-xl font-semibold text-gray-700 mb-2">Completed Tasks</h2>
                        <p className="text-3xl font-bold text-green-600">320</p>
                    </div>

                    {/* Card 3 */}
                    <div className="bg-yellow-50 shadow-md rounded-lg p-6">
                        <h2 className="text-xl font-semibold text-gray-700 mb-2">Pending Tasks</h2>
                        <p className="text-3xl font-bold text-yellow-600">25</p>
                    </div>

                    {/* Card 4 */}
                    <div className="bg-red-50 shadow-md rounded-lg p-6">
                        <h2 className="text-xl font-semibold text-gray-700 mb-2">Ongoing Tasks</h2>
                        <p className="text-3xl font-bold text-red-600">5</p>
                    </div>
                </section>

                {/* Employee List */}
                <div>
                    <h2 className="text-2xl font-medium text-gray-700 mb-6">Employee List</h2>
                    <div className="h-72 overflow-y-auto space-y-4">
                        {employees.map((employee, idx) => (
                            <div key={idx} className="flex gap-6 justify-between items-center p-4 bg-gray-50 rounded-lg shadow-sm hover:shadow-md transition-shadow">
                                <div className="flex flex-col">
                                    <h3 className="text-lg flex gap-6 font-semibold text-gray-800">{employee.employeeId}. {employee.employeeName}</h3>
                                    <p className="text-sm text-gray-600">{employee.employeeEmail}, {employee.employeeContactNumber}</p>
                                </div>
                                <Dialog>
                                    <DialogTrigger className="bg-blue-500 text-white px-4 py-2 rounded-md">
                                        Assign
                                    </DialogTrigger>
                                    <DialogContent className="bg-white text-black p-6 rounded-lg shadow-lg max-w-md">
                                        <DialogHeader>
                                            <DialogTitle className="text-xl font-semibold">Assign Task</DialogTitle>
                                            <DialogDescription className="text-sm text-gray-600">
                                                Fill in the details to assign a task.
                                            </DialogDescription>
                                        </DialogHeader>
                                        <div className="space-y-4">
                                            <div>
                                                <label htmlFor="workDate" className="block text-sm font-medium text-gray-700">Date</label>
                                                <input type="date" id="workDate" className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                                            </div>
                                            <div>
                                                <label htmlFor="workAddressName" className="block text-sm font-medium text-gray-700">Address</label>
                                                <input type="text" id="workAddressName" className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                                            </div>
                                            <div className="grid grid-cols-2 gap-4">
                                                <div>
                                                    <label htmlFor="workCity" className="block text-sm font-medium text-gray-700">City</label>
                                                    <input type="text" id="workCity" className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                                                </div>
                                                <div>
                                                    <label htmlFor="workState" className="block text-sm font-medium text-gray-700">State</label>
                                                    <input type="text" id="workState" className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                                                </div>
                                            </div>
                                            <div className="grid grid-cols-2 gap-4">
                                                <div>
                                                    <label htmlFor="workCountry" className="block text-sm font-medium text-gray-700">Country</label>
                                                    <input type="text" id="workCountry" className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                                                </div>
                                                <div>
                                                    <label htmlFor="workPincode" className="block text-sm font-medium text-gray-700">Pincode</label>
                                                    <input type="text" id="workPincode" className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                                                </div>
                                            </div>
                                            <div className="grid grid-cols-2 gap-4">
                                                <div>
                                                    <label htmlFor="workLongitude" className="block text-sm font-medium text-gray-700">Longitude</label>
                                                    <input type="text" id="workLongitude" className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                                                </div>
                                                <div>
                                                    <label htmlFor="workLatitude" className="block text-sm font-medium text-gray-700">Latitude</label>
                                                    <input type="text" id="workLatitude" className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                                                </div>
                                            </div>
                                        </div>
                                        <DialogFooter className="mt-6">
                                            <button className="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600" onClick={handleAssignWork}>
                                                Assign
                                            </button>
                                        </DialogFooter>
                                    </DialogContent>
                                </Dialog>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
            <ToastContainer
                position="top-right"
                autoClose={1000}
                hideProgressBar={false}
                newestOnTop
                closeOnClick
                rtl={false}
                pauseOnFocusLoss
                draggable
                pauseOnHover
                theme="light"
            />
        </div>
    );
}

export default AssignWork;
