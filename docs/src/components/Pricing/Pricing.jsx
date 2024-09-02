import React from 'react';
import { FaCheckCircle } from 'react-icons/fa';

const Pricing = () => {
    return (
        <section className="bg-gray-100 py-20" id="pricing">
            <div className="container mx-auto px-4">
                <h2 className="text-3xl sm:text-4xl font-bold text-center mb-8 sm:mb-10 text-gray-900">Our Pricing Plans</h2>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                    {/* Basic Plan */}
                    <div className="bg-white border border-gray-200 shadow-lg p-8 rounded-lg transition-transform transform hover:scale-105 hover:shadow-xl hover:border-green-300">
                        <h3 className="text-2xl font-bold mb-6 text-black">Basic</h3>
                        <p className="text-green-600 text-4xl font-semibold mb-6">$29<span className="text-base font-medium text-gray-500">/month</span></p>
                        <ul className="mb-8 text-gray-600 space-y-4">
                            <li className="flex items-center"><FaCheckCircle className="text-green-500 mr-2" /> Core Attendance Features</li>
                            <li className="flex items-center"><FaCheckCircle className="text-green-500 mr-2" /> GPS Tracking</li>
                            <li className="flex items-center"><FaCheckCircle className="text-green-500 mr-2" /> Basic Reporting</li>
                            <li className="flex items-center"><FaCheckCircle className="text-green-500 mr-2" /> Email Support</li>
                        </ul>
                        <button className="w-full px-6 py-3 bg-green-600 text-white rounded-lg shadow hover:bg-green-500 transition-colors transform hover:scale-105">Get Started</button>
                    </div>

                    {/* Standard Plan */}
                    <div className="bg-white border border-gray-200 shadow-lg p-8 rounded-lg transition-transform transform hover:scale-105 hover:shadow-xl hover:border-green-300">
                        <h3 className="text-2xl font-bold mb-6 text-black">Standard</h3>
                        <p className="text-green-600 text-4xl font-semibold mb-6">$59<span className="text-base font-medium text-gray-500">/month</span></p>
                        <ul className="mb-8 text-gray-600 space-y-4">
                            <li className="flex items-center"><FaCheckCircle className="text-green-500 mr-2" /> Includes Basic Features</li>
                            <li className="flex items-center"><FaCheckCircle className="text-green-500 mr-2" /> Biometric QR Codes</li>
                            <li className="flex items-center"><FaCheckCircle className="text-green-500 mr-2" /> Blockchain Security</li>
                            <li className="flex items-center"><FaCheckCircle className="text-green-500 mr-2" /> Priority Support</li>
                        </ul>
                        <button className="w-full px-6 py-3 bg-green-600 text-white rounded-lg shadow hover:bg-green-500 transition-colors transform hover:scale-105">Get Started</button>
                    </div>

                    {/* Premium Plan */}
                    <div className="bg-gradient-to-r from-green-300 to-green-500 border border-gray-200 shadow-lg p-8 rounded-lg transition-transform transform hover:scale-105 hover:shadow-xl hover:border-green-300">
                        <h3 className="text-2xl font-bold mb-6">Premium</h3>
                        <p className="text-4xl font-semibold mb-6">$99<span className="text-base font-medium">/month</span></p>
                        <ul className="mb-8 text-lg space-y-4">
                            <li className="flex items-center"><FaCheckCircle className="mr-2" /> All Standard Features</li>
                            <li className="flex items-center"><FaCheckCircle className="mr-2" /> Customizable Reports</li>
                            <li className="flex items-center"><FaCheckCircle className="mr-2" /> API Access</li>
                            <li className="flex items-center"><FaCheckCircle className="mr-2" /> Dedicated Account Manager</li>
                        </ul>
                        <button className="w-full px-6 py-3 text-green-600 bg-white rounded-lg shadow hover:bg-gray-100 transition-colors transform hover:scale-105">Get Started</button>
                    </div>
                </div>
            </div>
        </section>
    );
};

export default Pricing;
