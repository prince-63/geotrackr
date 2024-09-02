import React from 'react';
import { FaGooglePlay, FaAppStoreIos } from 'react-icons/fa';

const DownloadLink = () => {
    return (
        <div className="flex flex-col items-center justify-center py-16 bg-gradient-to-r from-green-400 via-teal-500 to-blue-600 text-white relative overflow-hidden">
            {/* Background patterns */}
            <div className="absolute inset-0 bg-pattern opacity-20"></div>
            
            <h2 className="text-3xl sm:text-4xl font-bold text-center mb-8 sm:mb-10">Get Started with Our App</h2>
            
            <p className="mb-8 text-base sm:text-lg text-center max-w-lg animate-slideInUp px-4 sm:px-0 text-shadow-lg">
                Elevate your productivity with our app, designed to streamline your tasks and help you achieve more every day. Available across platforms, it's never been easier to get started. Download now and take control!
            </p>
            
            <div className="flex flex-col sm:flex-row gap-4 mt-4 animate-bounceIn">
                <a 
                    href="#" 
                    className="flex items-center justify-center px-6 py-4 font-bold text-white bg-gradient-to-r from-green-600 to-green-500 rounded-full shadow-lg transform transition hover:scale-105 hover:shadow-md"
                >
                    <FaGooglePlay className="text-xl sm:text-2xl mr-2 sm:mr-3" />
                    Download for Android
                </a>
                <a 
                    href="#" 
                    className="flex items-center justify-center px-6 py-4 font-bold text-green-600 bg-white rounded-full shadow-lg transform transition hover:scale-105 hover:bg-gray-100 hover:shadow-md"
                >
                    <FaAppStoreIos className="text-xl sm:text-2xl mr-2 sm:mr-3" />
                    Download for iOS
                </a>
            </div>
            
            <p className="mt-8 text-xs sm:text-sm animate-fadeIn text-gray-200">
                Need help? <a href="/support" className="underline hover:text-green-300">Visit our support page</a>
            </p>
        </div>
    );
};

export default DownloadLink;
