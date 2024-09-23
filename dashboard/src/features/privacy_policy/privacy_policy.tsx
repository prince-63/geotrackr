import React from 'react';
import Layout from '../../components/layout/layout';

const PrivacyPolicy: React.FC = () => {
    return (
        <Layout>
            <section className="bg-white dark:bg-slate-900 text-gray-900 py-16 px-6 sm:px-12 lg:px-24">
                <div className="max-w-5xl mx-auto">
                    <h1 className="text-3xl sm:text-5xl font-bold mb-8 text-center text-gray-800">
                        Privacy Policy
                    </h1>
                    <p className="text-lg sm:text-xl leading-relaxed text-gray-700 mb-12 text-center">
                        At <span className="font-semibold text-indigo-600">Geotrackr</span>, your privacy is our priority.
                        This Privacy Policy explains how we collect, use, and protect your information when using our application.
                    </p>

                    {/* Section 1 */}
                    <div className="group mb-10 p-6 bg-gray-100 rounded-lg shadow-sm transition-transform transform hover:-translate-y-2 hover:shadow-lg duration-300 ease-in-out border-l-4 border-indigo-600">
                        <h2 className="text-2xl font-semibold text-gray-800 mb-4 group-hover:text-indigo-600 transition-colors duration-300">1. Information We Collect</h2>
                        <p className="text-base leading-relaxed text-gray-600">
                            We collect personal information such as your location data to track attendance,
                            along with your name, email address, and work details to facilitate the app’s functions.
                            Location data is only collected when you check in or check out of your workplace.
                        </p>
                    </div>

                    {/* Section 2 */}
                    <div className="group mb-10 p-6 bg-gray-100 rounded-lg shadow-sm transition-transform transform hover:-translate-y-2 hover:shadow-lg duration-300 ease-in-out border-l-4 border-indigo-600">
                        <h2 className="text-2xl font-semibold text-gray-800 mb-4 group-hover:text-indigo-600 transition-colors duration-300">2. How We Use Your Information</h2>
                        <p className="text-base leading-relaxed text-gray-600">
                            Your location data is used to track attendance accurately and securely. We may also
                            use your data for troubleshooting, analysis, and improving the app’s performance.
                        </p>
                    </div>

                    {/* Section 3 */}
                    <div className="group mb-10 p-6 bg-gray-100 rounded-lg shadow-sm transition-transform transform hover:-translate-y-2 hover:shadow-lg duration-300 ease-in-out border-l-4 border-indigo-600">
                        <h2 className="text-2xl font-semibold text-gray-800 mb-4 group-hover:text-indigo-600 transition-colors duration-300">3. Data Security</h2>
                        <p className="text-base leading-relaxed text-gray-600">
                            We use encryption and secure data storage to protect your information. Access to
                            your data is restricted to authorized personnel only. While we strive to ensure the security
                            of your personal information, no method of transmission over the internet or electronic storage
                            is 100% secure.
                        </p>
                    </div>

                    {/* Section 4 */}
                    <div className="group mb-10 p-6 bg-gray-100 rounded-lg shadow-sm transition-transform transform hover:-translate-y-2 hover:shadow-lg duration-300 ease-in-out border-l-4 border-indigo-600">
                        <h2 className="text-2xl font-semibold text-gray-800 mb-4 group-hover:text-indigo-600 transition-colors duration-300">4. Third-Party Sharing</h2>
                        <p className="text-base leading-relaxed text-gray-600">
                            We do not sell, trade, or otherwise transfer your personally identifiable information to
                            outside parties without your consent, except as required by law or in the event of a business transaction.
                        </p>
                    </div>

                    {/* Section 5 */}
                    <div className="group mb-10 p-6 bg-gray-100 rounded-lg shadow-sm transition-transform transform hover:-translate-y-2 hover:shadow-lg duration-300 ease-in-out border-l-4 border-indigo-600">
                        <h2 className="text-2xl font-semibold text-gray-800 mb-4 group-hover:text-indigo-600 transition-colors duration-300">5. Your Rights</h2>
                        <p className="text-base leading-relaxed text-gray-600">
                            You have the right to request access to the data we collect about you, as well as
                            request corrections or deletion of your information. You can contact us at any time to
                            exercise these rights.
                        </p>
                    </div>

                    {/* Section 6 */}
                    <div className="group p-6 bg-gray-100 rounded-lg shadow-sm transition-transform transform hover:-translate-y-2 hover:shadow-lg duration-300 ease-in-out border-l-4 border-indigo-600">
                        <h2 className="text-2xl font-semibold text-gray-800 mb-4 group-hover:text-indigo-600 transition-colors duration-300">6. Changes to This Policy</h2>
                        <p className="text-base leading-relaxed text-gray-600">
                            We may update this Privacy Policy from time to time. Any changes will be posted on this page, and we encourage
                            you to review it periodically to stay informed about how we are protecting your data.
                        </p>
                    </div>
                </div>
            </section>
        </Layout>
    );
};

export default PrivacyPolicy;
