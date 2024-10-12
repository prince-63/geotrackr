import React, { useState, useEffect } from 'react';
import { hero_content as content } from '../../lib/data';
import Button from '../../components/general/button';
import Typography from '../../components/general/typography';
import { useNavigate } from 'react-router-dom';

const Hero = () => {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [animating, setAnimating] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    const interval = setInterval(() => {
      setAnimating(true);
      setTimeout(() => {
        setCurrentSlide((prevSlide) => (prevSlide + 1) % content.length);
        setAnimating(false);
      }, 300);
    }, 3500);

    return () => clearInterval(interval);
  }, []);

  const handleDotClick = (index: React.SetStateAction<number>) => {
    setAnimating(true);
    setTimeout(() => {
      setCurrentSlide(index);
      setAnimating(false);
    }, 300);
  };

  return (
    <div className="relative grid grid-cols-1 md:grid-cols-2 items-center justify-between p-6 md:p-12 md:flex md:justify-around min-h-screen bg-gray-100 dark:from-gray-800 dark:to-gray-900">
      {/* Text Section */}
      <div
        className={`flex-1 text-center md:text-left mb-8 md:mb-0 transition-all duration-700 ease-in-out transform md:max-w-xl ${
          animating ? 'opacity-0 translate-x-4' : 'opacity-100 translate-x-0'
        } min-h-[300px] flex flex-col justify-center order-2 md:order-1`}
      >
        <Typography
          variant="h1"
          className="text-4xl md:text-6xl font-bold text-black dark:text-white mb-4"
        >
          {content[currentSlide].heading}
        </Typography>
        <Typography
          variant="h2"
          className="text-2xl md:text-4xl font-semibold text-black dark:text-white mb-4"
        >
          {content[currentSlide].subheading}
        </Typography>
        <Typography
          variant="body1"
          className="text-lg md:text-xl text-gray-600 dark:text-gray-400 mb-4"
        >
          {content[currentSlide].description}
        </Typography>
        <div>
          <Button
            onClick={() => navigate('/login')}
            className="bg-black text-gray-100 font-semibold py-3 px-4 mt-4 rounded-lg shadow-lg hover:bg-gray-900 transition-colors duration-300 dark:bg-gray-700 dark:text-gray-200 dark:hover:bg-gray-600"
          >
            Get Started
          </Button>
        </div>
      </div>

      {/* Image Section */}
      <div
        className={`flex justify-center items-center transition-all duration-700 ease-in-out w-full md:w-fit transform md:justify-normal lg:items-end ${
          animating ? 'opacity-0 translate-x-4' : 'opacity-100 translate-x-0'
        } min-h-[300px] order-1 md:order-2`}
      >
        <img
          src={content[currentSlide].img}
          alt="hero"
          className="w-full max-w-xs sm:max-w-sm md:max-w-md lg:max-w-lg h-auto object-contain"
          style={{ minHeight: '400px', maxHeight: '500px' }}
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
