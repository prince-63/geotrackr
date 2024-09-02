import React, { useState, useEffect } from 'react';

const Hero = () => {
    const content = [
        {
            heading: "Revolutionize Attendance Tracking",
            subheading: "With Cutting-Edge Technology",
            description: "Learn how our system combines biometric verification, GPS tracking, and blockchain for secure and accurate attendance management.",
            img: '/Illustration.png'
        },
        {
            heading: "Seamless Online & Offline",
            subheading: "Attendance Solutions",
            description: "Discover how our technology ensures reliable attendance recording even in low connectivity environments.",
            img: '/Illustration2.png'
        },
        {
            heading: "Start Using Our System",
            subheading: "Today and Transform Operations",
            description: "Get started with our solution to enhance security, accuracy, and efficiency in attendance management.",
            img: '/Illustration3.png'
        },
    ];    

    const [currentSlide, setCurrentSlide] = useState(0);
    const [animating, setAnimating] = useState(false);

    useEffect(() => {
        const interval = setInterval(() => {
            setAnimating(true);
            setTimeout(() => {
                setCurrentSlide((prevSlide) => (prevSlide + 1) % content.length);
                setAnimating(false);
            }, 300);
        }, 3500);

        return () => clearInterval(interval);
    }, [content.length]);

    const handleDotClick = (index) => {
        setAnimating(true);
        setTimeout(() => {
            setCurrentSlide(index);
            setAnimating(false);
        }, 300);
    };

    return (
        <div className="relative flex flex-col md:flex-row items-center justify-between p-6 md:p-12 max-w-7xl mx-auto">
            {/* Text Section */}
            <div
                className={`flex-1 text-center md:text-left mb-8 md:mb-0 transition-all duration-700 ease-in-out transform ${
                    animating ? 'opacity-0 translate-x-4' : 'opacity-100 translate-x-0'
                }`}
            >
                <h1 className="text-5xl md:text-7xl font-medium text-gray-700 mb-4">
                    {content[currentSlide].heading}
                </h1>
                <p className="text-4xl md:text-6xl font-medium text-green-500 mb-4">
                    {content[currentSlide].subheading}
                </p>
                <p className="text-base text-gray-500 mb-6">
                    {content[currentSlide].description}
                </p>
                <button className="px-8 py-3 bg-green-600 text-white rounded-lg shadow hover:bg-green-500 transition-colors transform hover:scale-105">
                    Get Started
                </button>
            </div>

            {/* Image Section */}
            <div
                className={`flex-1 flex justify-center transition-all duration-700 ease-in-out w-fit transform ${
                    animating ? 'opacity-0 translate-x-4' : 'opacity-100 translate-x-0'
                }`}
            >
                <img 
                    src={content[currentSlide].img} 
                    alt="hero" 
                    className="w-full max-w-md h-auto object-contain"
                    style={{ minHeight: '500px'}}
                />
            </div>

            {/* Dots Section */}
            <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-2">
                {content.map((_, index) => (
                    <button
                        key={index}
                        onClick={() => handleDotClick(index)}
                        className={`w-3 h-3 rounded-full ${currentSlide === index ? 'bg-green-600' : 'bg-gray-300'} transition-colors duration-300`}
                        aria-label={`Slide ${index + 1}`}
                    ></button>
                ))}
            </div>
        </div>
    );
};

export default Hero;
