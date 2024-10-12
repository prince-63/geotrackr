import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

const LogoutPage = () => {
    const navigate = useNavigate();

    useEffect(() => {
        // Function to handle logout
        const handleLogout = () => {
            // Clear any user authentication data (local storage, cookies, etc.)
            localStorage.removeItem('userToken'); // Adjust based on your auth mechanism
            // Redirect to login page
            navigate('/login'); // Adjust the path based on your routing setup
        };

        handleLogout();
    }, [navigate]);

    return (
        <div className="flex items-center justify-center min-h-screen bg-gray-50">
            <div className="bg-white p-6 rounded-lg shadow-md text-center">
                <h2 className="text-xl font-semibold mb-4">Logging out...</h2>
                <p>You will be redirected to the login page shortly.</p>
            </div>
        </div>
    );
};

export default LogoutPage;
