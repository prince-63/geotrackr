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

import axios from 'axios';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
const AddEmployee = () => {
    const inOfficeEmployee = [
        {
            "No.": 1,
            "Employee Id": 1,
            "Employee Name": "Employee 1",
            "Employee Email": "abc@email.com",
            "Employee Phone": 1234567890,
        },
        {
            "No.": 2,
            "Employee Id": 2,
            "Employee Name": "Employee 2",
            "Employee Email": "bca@email.com",
            "Employee Phone": 1234567890,
        }
    ];

    const outOfficeEmployee = [
        {
            "No.": 1,
            "Employee Id": 1,
            "Employee Name": "Employee 1",
            "Employee Email": "abc@email.com",
            "Employee Phone": 1234567890,
        },
        {
            "No.": 2,
            "Employee Id": 2,
            "Employee Name": "Employee 2",
            "Employee Email": "bca@email.com",
            "Employee Phone": 1234567890,
        }
    ];

    const handleAddOutOfficeEmployee = async (e:React.MouseEvent<HTMLButtonElement>) => {
        e.preventDefault();
        const employeeName = (document.getElementById('employeeName') as HTMLInputElement).value;
        const employeeEmail = (document.getElementById('employeeEmail') as HTMLInputElement).value;
        const employeeContactNumber = (document.getElementById('employeeContactNumber') as HTMLInputElement).value;

        if(employeeName === '' || employeeEmail === '' || employeeContactNumber === '') {
            toast.error('Please fill all the details');
            return;
        }
        try {
            const res = await axios.post(process.env.SERVER_API_URL + '/add-out-office-employee', {
                employeeName,
                employeeEmail,
                employeeContactNumber
            });

            if(res.status === 400) {
                toast.error('Employee already exists');
                return;
            }
            if(res.status === 200) {
                toast.success('Employee add request sent successfully');
                return;
            }
        } catch (error: any) {
            toast.error(error.response.data.message);
            console.log(error);
            
        }
    }

    const handleAddInOfficeEmployee = async (e:React.MouseEvent<HTMLButtonElement>) => {
        e.preventDefault();
        const employeeName = (document.getElementById('employeeName') as HTMLInputElement).value;
        const employeeEmail = (document.getElementById('employeeEmail') as HTMLInputElement).value;
        const employeeContactNumber = (document.getElementById('employeeContactNumber') as HTMLInputElement).value;

        if(employeeName === '' || employeeEmail === '' || employeeContactNumber === '') {
            toast.error('Please fill all the details');
            return;
        }

        try {
            const res = await axios.post(process.env.SERVER_API_URL + '/add-in-office-employee', {
                employeeName,
                employeeEmail,
                employeeContactNumber
            });

            if(res.status === 400) {
                toast.error('Employee already exists');
                return;
            }
            if(res.status === 200) {
                toast.success('Employee add request sent successfully');
                return;
            }
        } catch (error: any) {
            toast.error(error.response.data.message);
            console.log(error);
        }
    }

    return (
        <div className="p-6">
            {/* In Office Employee */}
            <div className="mb-10">
                <div className="flex justify-between items-center mb-4">
                    <h2 className="text-2xl font-semibold text-gray-800">In Office Employee</h2>
                    <div className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                    <Dialog>
                        <DialogTrigger>Add New Employee</DialogTrigger>
                        <DialogContent className='bg-black text-white px-6 py-1 rounded'>
                            <div className="m-6 text-black">
                                <DialogHeader>
                                    <DialogTitle className='text-center text-white py-3'>Fillup all the details.</DialogTitle>
                                </DialogHeader>
                                <DialogDescription className='text-gray-500 pb-4'>
                                    <label className="text-sm text-gray-300">Employee Name</label>
                                    <input id="employeeName" type='text' placeholder='John Doe' className="rounded w-full p-2 mb-4" />

                                    <label className="text-sm text-gray-300">Employee Email</label>
                                    <input id="employeeEmail" type='email' placeholder='abc@email.com' className="rounded w-full p-2 mb-4" />

                                    <label className="text-sm text-gray-300">Employee Contact Number</label>
                                    <input id="employeeContactNumber" type='number' placeholder='+21 89692-77654' className="rounded w-full p-2 mb-4" />
                                    An email will be sent to employee attached with employee id and temporary password.
                                </DialogDescription>
                                <button className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600" onClick={handleAddInOfficeEmployee}>Add Employee</button>
                            </div>

                        </DialogContent>
                    </Dialog>
                    </div>
                </div>
                <div className="overflow-x-auto text-center">
                    <table className="min-w-full bg-white border border-gray-200 rounded-lg">
                        <thead className="bg-gray-100 text-gray-600">
                            <tr className="bg-gray-100 text-gray-600">
                                <th className="py-2 px-4">No.</th>
                                <th className="py-2 px-4">Employee Id</th>
                                <th className="py-2 px-4">Employee Name</th>
                                <th className="py-2 px-4">Employee Email</th>
                                <th className="py-2 px-4">Employee Phone</th>
                                <th className="py-2 px-4">Edit</th>
                            </tr>
                        </thead>
                        <tbody>
                            {inOfficeEmployee.map((employee) => (
                                <tr key={employee["Employee Id"]} className="border-t">
                                    <td className="py-2 px-4">{employee["No."]}</td>
                                    <td className="py-2 px-4">{employee["Employee Id"]}</td>
                                    <td className="py-2 px-4">{employee["Employee Name"]}</td>
                                    <td className="py-2 px-4">{employee["Employee Email"]}</td>
                                    <td className="py-2 px-4">{employee["Employee Phone"]}</td>
                                    <td className="">
                                        <button className="bg-black text-white px-6 py-1 rounded">Edit</button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>

            {/* Out Office Employee */}
            <div>
                <div className="flex justify-between items-center mb-4">
                    <h2 className="text-2xl font-semibold text-gray-800">Out Office Employee</h2>
                    <div className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                    <Dialog>
                        <DialogTrigger>Add New Employee</DialogTrigger>
                        <DialogContent className='bg-black text-white px-6 py-1 rounded'>
                            <div className="m-6 text-black">
                                <DialogHeader>
                                    <DialogTitle className='text-center text-white py-3'>Fillup all the details.</DialogTitle>
                                </DialogHeader>
                                <label className="text-sm text-gray-300">Employee Name</label>
                                <input id="employeeName" type='text' placeholder='John Doe' className="rounded w-full p-2 mb-4" />

                                <label className="text-sm text-gray-300">Employee Email</label>
                                <input id="employeeEmail" type='email' placeholder='abc@email.com' className="rounded w-full p-2 mb-4" />

                                <label className="text-sm text-gray-300">Employee Contact Number</label>
                                <input id="employeeContactNumber" type='number' placeholder='+21 89692-77654' className="rounded w-full p-2 mb-4" />

                                <DialogDescription className='text-gray-500 pb-4'>
                                    An email will be sent to employee attached with employee id and temporary password.
                                </DialogDescription>
                                <button className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600" onClick={handleAddOutOfficeEmployee}>Add Employee</button>
                            </div>

                        </DialogContent>
                    </Dialog>
                    </div>
                </div>
                <div className="overflow-x-auto text-center">
                    <table className="min-w-full bg-white border border-gray-200 rounded-lg">
                        <thead>
                            <tr className="bg-gray-100 text-gray-600">
                                <th className="py-2 px-4">No.</th>
                                <th className="py-2 px-4">Employee Id</th>
                                <th className="py-2 px-4">Employee Name</th>
                                <th className="py-2 px-4">Employee Email</th>
                                <th className="py-2 px-4">Employee Phone</th>
                                <th className="py-2 px-4">Edit</th>
                            </tr>
                        </thead>
                        <tbody>
                            {outOfficeEmployee.map((employee) => (
                                <tr key={employee["Employee Id"]} className="border-t">
                                    <td className="py-2 px-4">{employee["No."]}</td>
                                    <td className="py-2 px-4">{employee["Employee Id"]}</td>
                                    <td className="py-2 px-4">{employee["Employee Name"]}</td>
                                    <td className="py-2 px-4">{employee["Employee Email"]}</td>
                                    <td className="py-2 px-4">{employee["Employee Phone"]}</td>
                                    <td className="">
                                        <button className="bg-black text-white px-6 py-1 rounded">Edit</button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
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
};

export default AddEmployee;
