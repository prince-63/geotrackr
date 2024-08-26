import React from 'react';
import { Link } from 'react-router-dom';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import axios from 'axios';

const ForgotPassword = () => {
  const [otpSent, setOtpSent] = React.useState(false);
  const [otpVerified, setOtpVerified] = React.useState(false);

  const handleSendOtp = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const email = (document.getElementById('email') as HTMLInputElement).value;
      await axios.post(`${process.env.SERVER_API_URL}/sendOtp`, { email });
      setOtpSent(true);
      toast.success('OTP sent successfully');
    } catch (error) {
      toast.error('Could not send OTP');
    }
  };

  const handleCheckOtp = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const otp = (document.getElementById('otp') as HTMLInputElement).value;
      await axios.post(`${process.env.SERVER_API_URL}/checkOtp`, { otp });
      setOtpVerified(true);
      toast.success('OTP verified successfully');
    } catch (error) {
      toast.error('Invalid OTP');
    }
  };

  const handleResetPassword = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const password = (document.getElementById('password') as HTMLInputElement).value;
      const confirmPassword = (document.getElementById('confirm-password') as HTMLInputElement).value;

      if (password !== confirmPassword) {
        toast.error('Passwords do not match');
        return;
      }

      await axios.post(`${process.env.SERVER_API_URL}/resetPassword`, { password });
      toast.success('Password reset successfully');
    } catch (error) {
      toast.error('Could not reset password');
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="w-full max-w-md p-8 space-y-8 bg-white rounded-lg shadow-md">
        {!otpSent ? (
          <>
            <h2 className="text-2xl font-bold text-center text-gray-800">Forgot Your Password?</h2>
            <p className="text-sm text-center text-gray-600">
              Enter your email address below and we'll send you a link to reset your password.
            </p>
            <form className="space-y-6" onSubmit={handleSendOtp}>
              <div>
                <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                  Email address
                </label>
                <input
                  id="email"
                  name="email"
                  type="email"
                  autoComplete="email"
                  required
                  className="w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                />
              </div>
              <div>
                <button
                  type="submit"
                  className="w-full px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                  Next
                </button>
              </div>
            </form>
          </>
        ) : (
          <>
            {!otpVerified ? (
              <>
                <h2 className="text-2xl font-bold text-center text-gray-800">Verify OTP</h2>
                <p className="text-sm text-center text-gray-600">Enter the OTP sent to your email address</p>
                <form className="space-y-6" onSubmit={handleCheckOtp}>
                  <div>
                    <label htmlFor="otp" className="block text-sm font-medium text-gray-700">
                      OTP
                    </label>
                    <input
                      id="otp"
                      name="otp"
                      type="text"
                      autoComplete="otp"
                      required
                      className="w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                    />
                  </div>
                  <div>
                    <button
                      type="submit"
                      className="w-full px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                    >
                      Verify OTP
                    </button>
                  </div>
                </form>
              </>
            ) : (
              <>
                <h2 className="text-2xl font-bold text-center text-gray-800">Reset Password</h2>
                <p className="text-sm text-center text-gray-600">Enter your new password</p>
                <form className="space-y-6" onSubmit={handleResetPassword}>
                  <div>
                    <label htmlFor="password" className="block text-sm font-medium text-gray-700">
                      New Password
                    </label>
                    <input
                      id="password"
                      name="password"
                      type="password"
                      autoComplete="password"
                      required
                      className="w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                    />
                  </div>
                  <div>
                    <label htmlFor="confirm-password" className="block text-sm font-medium text-gray-700">
                      Confirm Password
                    </label>
                    <input
                      id="confirm-password"
                      name="confirm-password"
                      type="password"
                      autoComplete="password"
                      required
                      className="w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                    />
                  </div>
                  <div>
                    <button
                      type="submit"
                      className="w-full px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                      onClick={handleResetPassword}
                    >
                      Reset Password
                    </button>
                  </div>
                </form>
              </>
            )}
          </>
        )}
        <div className="text-sm text-center">
          <p>
            Remembered your password?{' '}
            <Link to="/login" className="font-medium text-indigo-600 hover:text-indigo-500">
              Log in
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

export default ForgotPassword;