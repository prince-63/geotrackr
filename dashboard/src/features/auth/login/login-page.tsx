import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import TextInput from '../../../components/general/text-input';
import Button from '../../../components/general/button';
import FormContainer from '../../../components/general/form-container';
import { User, Lock } from 'lucide-react';
import Typography from '../../../components/general/typography';
import { Link } from 'react-router-dom';
import LogoForPages from '../../../components/general/logo-pages';
import { useUserContext } from '../../../hooks/use-user-context';
import { toast, ToastContainer } from 'react-toastify';

const Login: React.FC = () => {
  const [officeEmail, setOfficeEmail] = useState('');
  const [officePassword, setOfficePassword] = useState('');
  const { login } = useUserContext();
  const navigate = useNavigate();

  const handleUsernameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficeEmail(e.target.value);
  };

  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setOfficePassword(e.target.value);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    const response = await login(officeEmail, officePassword);

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
          <LogoForPages message="Login to your office account." />
        </div>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <TextInput
              type="text"
              placeholder="Email"
              value={officeEmail}
              onChange={handleUsernameChange}
              icon={User}
              className="w-full text-lg text-grey-800 dark:text-white"
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
          <div className="flex justify-end my-2">
            <Typography
              variant="body3"
              className="text-gray-700 dark:text-gray-300 hover:text-blue-400 dark:hover:text-blue-500 transition duration-200 ease-in-out"
            >
              <Link
                to="/forgot-password"
                className="text-grey-800 dark:text-white"
              >
                Forgot password?
              </Link>
            </Typography>
          </div>
          <Button
            type="submit"
            className="w-full py-2 bg-blue-600 hover:bg-blue-500 text-white font-medium rounded-lg shadow-md transition duration-300"
          >
            Login
          </Button>
        </form>
        <div className="flex justify-center items-center mt-4 space-x-2">
          <Typography variant="body3" className="text-gray-800 dark:text-white">
            Don't have an account?
          </Typography>
          <Typography
            variant="body3"
            className="text-blue-600 dark:text-blue-400 hover:text-blue-400 dark:hover:text-blue-500 transition duration-200 ease-in-out"
          >
            <Link to="/signup">Sign up</Link>
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

export default Login;
