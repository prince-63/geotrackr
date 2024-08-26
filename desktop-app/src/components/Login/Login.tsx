import { Link } from 'react-router-dom';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import axios from 'axios';
const Login = () => {
    const handleLogin = async (e: React.FormEvent<HTMLButtonElement>) => {
        e.preventDefault();
        const masterOfficeAdminEmail = document.getElementById('master-office-admin-email') as HTMLInputElement;
        const masterOfficeAdminPassword = document.getElementById('master-office-admin-password') as HTMLInputElement;

        if (!masterOfficeAdminEmail || !masterOfficeAdminPassword) {
            toast.error('Please enter all fields');
            return;
        }
        try {
            const res = await axios.post(process.env.SERVER_API_URL + '/master-admin-login', {
                masterOfficeAdminEmail,
                masterOfficeAdminPassword
            });
            if (res.status == 400) {
                toast.error('Invalid credentials');
            }
            if (res.status == 200) {
                toast.success('Login successful');
                localStorage.setItem('token', res.data.token);
                localStorage.setItem('user', JSON.stringify(res.data.user));
                window.location.href = '/dashboard';
            }
        } catch (error: any) {
            toast.error(error.response.data.msg);
            console.log('ERROR:', error);         
        }
    };
    return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
        <div className="w-full max-w-md p-8 space-y-8 bg-white rounded-lg shadow-md">
            <h2 className="text-2xl font-bold text-center text-gray-800">Login to Your Account</h2>
            <form className="space-y-6">
                <div>
                    <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                        MAster Office Admin Email
                    </label>
                    <input
                        id="master-office-admin-email"
                        name="master-office-admin-email"
                        type="email"
                        autoComplete="email"
                        required
                        className="w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                    />
                </div>
                <div>
                    <label htmlFor="password" className="block text-sm font-medium text-gray-700">
                        Master Office Admin Password
                    </label>
                    <input
                        id="master-office-admin-password"
                        name="master-office-admin-password"
                        type="password"
                        autoComplete="current-password"
                        required
                        className="w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                    />
                </div>
                <div className="flex items-center justify-between">
                    <div className="flex items-center">
                        <input
                            id="remember_me"
                            name="remember_me"
                            type="checkbox"
                            className="w-4 h-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500"
                        />
                        <label htmlFor="remember_me" className="block ml-2 text-sm text-gray-900">
                            Remember me
                        </label>
                    </div>
                    <div className="text-sm">
                        <Link to="/forgot-password" className="font-medium text-indigo-600 hover:text-indigo-500">
                            Forgot your password?
                        </Link>
                    </div>
                </div>
                <div>
                    <button
                        type="submit"
                        className="w-full px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                        onClick={handleLogin}
                    >
                        Login
                    </button>
                </div>
            </form>
            <div className="text-sm text-center">
                <p>
                    Don’t have an account?{' '}
                    <Link to="/signup" className="font-medium text-indigo-600 hover:text-indigo-500">
                        Sign up
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

export default Login;
