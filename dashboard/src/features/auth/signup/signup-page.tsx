import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import TextInput from '../../../components/general/text-input';
import Button from '../../../components/general/button';
import FormContainer from '../../../components/general/form-container';
import { User, Lock, Mail } from 'lucide-react';
import Typography from '../../../components/general/typography';
import { Link } from 'react-router-dom';
import LogoForPages from '../../../components/general/logo-pages';
import { useUserContext } from '../../../hooks/use-user-context';
import { toast, ToastContainer } from 'react-toastify';

const Signup: React.FC = () => {
  const [officeName, setOfficeName] = useState('');
  const [officeEmail, setOfficeEmail] = useState('');
  const [officePassword, setOfficePassword] = useState('');
  const { signup } = useUserContext();
  const navigate = useNavigate();

  const handleNameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficeName(e.target.value);
  };

  const handleEmailChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficeEmail(e.target.value);
  };

  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficePassword(e.target.value);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    const response = await signup(officeName, officeEmail, officePassword);

    if (response.error) {
      toast.error(response.error);
      return;
    }

    toast.success(response.message);
    navigate('/dashboard');
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-white dark:bg-gray-100">
      <FormContainer className="max-w-sm w-full bg-white dark:bg-gray-100 p-8 rounded-lg shadow-lg border border-gray-300">
        <div className="text-center mb-6">
          <LogoForPages message="Create a new office account to get started." />
        </div>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <TextInput
              type="text"
              placeholder="Name"
              value={officeName}
              onChange={handleNameChange}
              icon={User}
              className="w-full text-lg text-gray-700 dark:text-gray-200"
            />
          </div>
          <div className="mb-4">
            <TextInput
              type="email"
              placeholder="Email"
              value={officeEmail}
              onChange={handleEmailChange}
              icon={Mail}
              className="w-full text-lg text-gray-700 dark:text-gray-200"
            />
          </div>
          <div className="mb-4">
            <TextInput
              type="password"
              placeholder="Password"
              value={officePassword}
              onChange={handlePasswordChange}
              icon={Lock}
              className="w-full text-lg text-gray-700 dark:text-gray-200"
            />
          </div>
          <Button
            type="submit"
            className="w-full py-2 bg-blue-600 hover:bg-blue-500 text-white font-medium rounded-lg shadow-md transition duration-300"
          >
            Sign Up
          </Button>
        </form>
        <div className="flex justify-center items-center mt-4 space-x-2">
          <Typography variant="body3" className="text-gray-800 dark:text-white">
            Already have an account?
          </Typography>
          <Typography
            variant="body3"
            className="text-blue-600 dark:text-blue-400 hover:text-blue-400 dark:hover:text-blue-500 transition duration-200 ease-in-out"
          >
            <Link to="/login">Login</Link>
          </Typography>
        </div>
      </FormContainer>
      <ToastContainer
        position="top-right"
        autoClose={2000}
        hideProgressBar={false}
        newestOnTop={false}
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
