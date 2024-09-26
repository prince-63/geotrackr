import React from 'react';
import { motion } from 'framer-motion';
import Layout from '../../components/layout/layout';
import aboutUsGif from '../../assets/images/aboutUs.gif';

const AboutUs: React.FC = () => {
  const sectionVariants = {
    hidden: { opacity: 0, y: 50 },
    visible: { opacity: 1, y: 0, transition: { duration: 0.5 } },
  };

  const cardVariants = {
    hover: { scale: 1.05, transition: { duration: 0.3 } },
  };

  return (
    <Layout>
      <motion.section
        className="bg-gray-100 text-gray-900 py-16 px-6 sm:px-12 lg:px-24"
        initial="hidden"
        animate="visible"
        variants={sectionVariants}
      >
        <div className="max-w-5xl mx-auto">
          <h1 className="text-3xl sm:text-5xl font-bold mb-8 text-center text-gray-800">
            About Us
          </h1>
          <p className="text-lg sm:text-xl leading-relaxed text-center mb-12 text-gray-700">
            At{' '}
            <span className="font-semibold group-hover:text-indigo-600">
              Geotrackr
            </span>
            , we are committed to transforming attendance tracking. Our mission
            is to provide a seamless experience for both employers and
            employees, ensuring accuracy, efficiency, and security in workforce
            management.
          </p>
          <img
            src={aboutUsGif}
            alt="Prince Kumar Prasad"
            className="w-96 h-96 mx-auto rounded-full object-cover mb-8"
          />
          <div className="grid gap-8 sm:grid-cols-2">
            {/* Mission, Offer, Choose Us, Vision sections */}
            <motion.div
              className="group p-8 bg-white rounded-lg shadow-md transition-all border-l-4 border-indigo-600"
              whileHover="hover"
              variants={cardVariants}
            >
              <h2 className="text-xl font-semibold mb-4 group-hover:text-indigo-600 dark:text-indigo-400">
                Our Mission
              </h2>
              <p className="text-base leading-relaxed text-gray-600 dark:text-gray-200">
                To simplify workforce management with automated
                geolocation-based attendance tracking, providing a hassle-free
                experience for employees and accurate, real-time records for
                employers.
              </p>
            </motion.div>

            <motion.div
              className="group p-8 bg-white rounded-lg shadow-md transition-all border-l-4 border-indigo-600"
              whileHover="hover"
              variants={cardVariants}
            >
              <h2 className="text-xl font-semibold mb-4 group-hover:text-indigo-600 dark:text-indigo-400">
                What We Offer
              </h2>
              <p className="text-base leading-relaxed text-gray-600 dark:text-gray-200">
                Using advanced geolocation technology, we automate employee
                check-ins and check-outs across multiple locations, ensuring
                secure and real-time data synchronization.
              </p>
            </motion.div>

            <motion.div
              className="group p-8 bg-white rounded-lg shadow-md transition-all border-l-4 border-indigo-600"
              whileHover="hover"
              variants={cardVariants}
            >
              <h2 className="text-xl font-semibold mb-4 group-hover:text-indigo-600 dark:text-indigo-400">
                Why Choose Us
              </h2>
              <p className="text-base leading-relaxed text-gray-600 dark:text-gray-200">
                Our focus on accuracy and security ensures tamper-proof records
                and reliable data for managing your workforce with confidence.
              </p>
            </motion.div>

            <motion.div
              className="group p-8 bg-white rounded-lg shadow-md transition-all border-l-4 border-indigo-600"
              whileHover="hover"
              variants={cardVariants}
            >
              <h2 className="text-xl font-semibold mb-4 hover:text-indigo-600 dark:text-indigo-400">
                Our Vision
              </h2>
              <p className="text-base leading-relaxed text-gray-600 dark:text-gray-200">
                We aim to become the leading solution for attendance tracking,
                helping businesses worldwide manage their teams effortlessly and
                effectively.
              </p>
            </motion.div>
          </div>
        </div>
      </motion.section>
    </Layout>
  );
};

export default AboutUs;
