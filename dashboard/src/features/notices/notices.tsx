import React from 'react';
import Layout from '../../components/layout/layout';

const Notices: React.FC = () => {
  return (
    <Layout>
      <section className="bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100 py-16 px-6 sm:px-12 lg:px-24 transition-colors duration-300">
        <div className="max-w-5xl mx-auto">
          <h1 className="text-3xl sm:text-5xl font-bold mb-8 text-center text-gray-800 dark:text-gray-100">
            Latest Notices
          </h1>
          <div className="space-y-8">
            {/* Notice 1 */}
            <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out border-l-4 border-blue-500 dark:border-blue-400">
              <h2 className="text-2xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                System Maintenance on September 30, 2024
              </h2>
              <p className="text-base text-gray-600 dark:text-gray-300 leading-relaxed">
                We will be performing scheduled system maintenance on September
                30, 2024, from 12:00 AM to 4:00 AM. During this time, the
                service may be unavailable. We apologize for any inconvenience.
              </p>
            </div>

            {/* Notice 2 */}
            <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out border-l-4 border-green-500 dark:border-green-400">
              <h2 className="text-2xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                New Feature: Geolocation-based Check-ins
              </h2>
              <p className="text-base text-gray-600 dark:text-gray-300 leading-relaxed">
                We’re excited to introduce our new geolocation-based check-in
                feature. Employees can now check in automatically when they
                enter the office premises within a 200-meter radius.
              </p>
            </div>

            {/* Notice 3 */}
            <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out border-l-4 border-red-500 dark:border-red-400">
              <h2 className="text-2xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                Urgent: Security Patch Released
              </h2>
              <p className="text-base text-gray-600 dark:text-gray-300 leading-relaxed">
                A critical security patch has been released. We recommend all
                users to update their systems immediately to ensure data
                security and prevent vulnerabilities.
              </p>
            </div>

            {/* Notice 4 */}
            <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out border-l-4 border-yellow-500 dark:border-yellow-400">
              <h2 className="text-2xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                Upcoming Webinar: Streamlining Attendance Management
              </h2>
              <p className="text-base text-gray-600 dark:text-gray-300 leading-relaxed">
                Join us for an exclusive webinar on how to use our geolocation
                technology to streamline attendance management. The webinar will
                be held on October 10, 2024, at 2:00 PM.
              </p>
            </div>
          </div>
        </div>
      </section>
    </Layout>
  );
};

export default Notices;
