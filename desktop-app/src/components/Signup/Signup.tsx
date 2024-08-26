import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { ToastContainer, toast } from 'react-toastify';
import axios from 'axios';
import 'react-toastify/dist/ReactToastify.css';

const InputField = ({
  id,
  label,
  type = 'text',
  value,
  onChange,
  autoComplete,
}: {
  id: string;
  label: string;
  type?: string;
  value: string;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  autoComplete: string;
}) => (
  <div>
    <label htmlFor={id} className="block text-sm font-medium text-gray-700">
      {label}
    </label>
    <input
      id={id}
      name={id}
      type={type}
      value={value}
      onChange={onChange}
      autoComplete={autoComplete}
      required
      className="w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
    />
  </div>
);

const Signup = () => {
  const [formData, setFormData] = useState({
    officeEmail: '',
    officeName: '',
    officeCity: '',
    officeState: '',
    officeCountry: '',
    officePincode: '',
    officeLongitude: '',
    officeLatitude: '',
    officeContactNumber: '',
    masterOfficeAdminName: '',
    masterOfficeAdminEmail: '',
    masterOfficeAdminContactNumber: '',
    masterOfficeAdminPassword: '',
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const validateForm = () => {
    return Object.values(formData).every((field) => field.trim() !== '');
  };

  const handleSignup = async (e: React.FormEvent<HTMLButtonElement>) => {
    e.preventDefault();

    if (!validateForm()) {
      toast.error('All fields are required');
      return;
    }

    try {
      const res = await axios.post(process.env.SERVER_API_URL + '/create-office', formData);

      if (res.status === 400) {
        toast.error(res.data.error);
      } else if (res.status === 200) {
        toast.success(res.data.message);
      }
    } catch (error) {
      toast.error((error as any).response?.data?.error || 'An error occurred');
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="w-full max-w-md p-8 space-y-8 bg-white rounded-lg shadow-md">
        <h2 className="text-2xl font-bold text-center text-gray-800">Create Your Office Account</h2>
        <form className="space-y-6">
          <InputField
            id="office-email"
            label="Office Email"
            type="email"
            value={formData.officeEmail}
            onChange={handleChange}
            autoComplete="email"
          />
          <InputField
            id="office-name"
            label="Office Name"
            value={formData.officeName}
            onChange={handleChange}
            autoComplete="office-name"
          />
          <InputField
            id="office-city"
            label="Office City"
            value={formData.officeCity}
            onChange={handleChange}
            autoComplete="office-city"
          />
          <InputField
            id="office-state"
            label="Office State"
            value={formData.officeState}
            onChange={handleChange}
            autoComplete="office-state"
          />
          <InputField
            id="office-country"
            label="Office Country"
            value={formData.officeCountry}
            onChange={handleChange}
            autoComplete="office-country"
          />
          <InputField
            id="office-pincode"
            label="Office Pincode"
            value={formData.officePincode}
            onChange={handleChange}
            autoComplete="office-pincode"
          />
          <InputField
            id="office-longitude"
            label="Office Longitude"
            value={formData.officeLongitude}
            onChange={handleChange}
            autoComplete="office-longitude"
          />
          <InputField
            id="office-latitude"
            label="Office Latitude"
            value={formData.officeLatitude}
            onChange={handleChange}
            autoComplete="office-latitude"
          />
          <InputField
            id="office-contact-number"
            label="Office Contact Number"
            value={formData.officeContactNumber}
            onChange={handleChange}
            autoComplete="office-contact-number"
          />
          <InputField
            id="master-office-admin-name"
            label="Master Office Admin Name"
            value={formData.masterOfficeAdminName}
            onChange={handleChange}
            autoComplete="master-office-admin-name"
          />
          <InputField
            id="master-office-admin-email"
            label="Master Office Admin Email"
            type="email"
            value={formData.masterOfficeAdminEmail}
            onChange={handleChange}
            autoComplete="master-office-admin-email"
          />
          <InputField
            id="master-office-admin-contact-number"
            label="Master Office Admin Contact Number"
            value={formData.masterOfficeAdminContactNumber}
            onChange={handleChange}
            autoComplete="master-office-admin-contact-number"
          />
          <InputField
            id="master-office-admin-password"
            label="Master Office Admin Password"
            type="password"
            value={formData.masterOfficeAdminPassword}
            onChange={handleChange}
            autoComplete="current-password"
          />
          <div>
            <button
              type="submit"
              className="w-full px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              onClick={handleSignup}
            >
              Sign up
            </button>
          </div>
        </form>
        <div className="text-sm text-center">
          <p>
            Already have an account?{' '}
            <Link to="/login" className="font-medium text-indigo-600 hover:text-indigo-500">
              Login
            </Link>
          </p>
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

export default Signup;
