import React from 'react';
import { FaCogs, FaUserShield, FaMobileAlt } from 'react-icons/fa';
import SectionHeader from '../../components/data-display/section-header';
import CardDisplay from '../../components/data-display/card-display';
import Button from '../../components/general/button';

const About: React.FC = () => {
  return (
    <section
      className="bg-gray-100 text-black py-20 dark:from-gray-800 dark:to-gray-900"
      id="about"
    >
      <div className="container mx-auto px-6">
        <SectionHeader
          title={'About Our System'}
          description={
            'We are excited to present our innovative attendance tracking system & a designed to meet the needs of modern work environments. Our solution integrates cutting-edge technologies to offer a secure and efficient way of managing attendance across diverse settings.'
          }
        />
        <div className="flex flex-row flex-wrap gap-8 justify-center items-center">
          <CardDisplay
            icon={<FaCogs />}
            title="Innovative Technology"
            description="Our project leverages state-of-the-art technology to deliver a seamless and reliable attendance tracking experience. From biometric verification to blockchain security, ensuring modern needs of businesses are met."
            iconColor="text-blue-500 dark:text-blue-300"
          />
          <CardDisplay
            icon={<FaUserShield />}
            title="User-Centric Design"
            description="Designed with users in mind, our system offers an intuitive interface and flexible features to accommodate various work environments. Whether online or offline, our solution provides a smooth and user-friendly experience."
            iconColor="text-purple-500 dark:text-purple-300"
          />
          <CardDisplay
            icon={<FaMobileAlt />}
            title="Mobile Accessibility"
            description="Our system is designed to be fully accessible on mobile devices, ensuring that users can manage attendance and related tasks on the go. With a responsive design, our solution fits seamlessly into any screen size."
            iconColor="text-green-500 dark:text-green-300"
          />
        </div>
        <div className="text-center mt-12">
          <Button className="bg-black text-gray-100 font-semibold py-3 px-4 mt-4 rounded-lg shadow-lg hover:bg-gray-800 transition-colors duration-300 dark:bg-gray-700 dark:text-gray-200 dark:hover:bg-gray-600">
            Learn More
          </Button>
        </div>
      </div>
    </section>
  );
};

export default About;
