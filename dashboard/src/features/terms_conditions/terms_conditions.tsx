import React from 'react';
import Layout from '../../components/layout/layout';

const TermsAndConditions: React.FC = () => {
    return (
        <Layout>
            <section className="bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100 py-16 px-6 sm:px-12 lg:px-24 transition-colors duration-300">
                <div className="max-w-5xl mx-auto">
                    <h1 className="text-3xl sm:text-5xl font-bold mb-8 text-center text-gray-800 dark:text-gray-100">
                        Terms and Conditions
                    </h1>
                    <p className="text-lg sm:text-xl leading-relaxed text-center mb-12 text-gray-700 dark:text-gray-300">
                        Welcome to <span className="font-semibold text-indigo-600 dark:text-indigo-400">Geotrackr</span>. Please read these Terms and Conditions carefully before using our services.
                    </p>

                    <div className="space-y-8">
                        {[
                            {
                                title: '1. Acceptance of Terms',
                                content: 'By accessing or using Geotrackr, you agree to be bound by these Terms. If you do not agree with any part of the terms, you may not use our services.',
                            },
                            {
                                title: '2. Service Overview',
                                content: 'Geotrackr provides automated attendance tracking through geolocation technology. The service is intended to help businesses accurately manage employee attendance records.',
                            },
                            {
                                title: '3. User Responsibilities',
                                content: 'As a user, you are responsible for the security of your account and the accuracy of the information you provide. Misuse of our services or false data reporting may result in termination of access.',
                            },
                            {
                                title: '4. Data Privacy',
                                content: 'We value your privacy and ensure that your data is handled securely and in accordance with our Privacy Policy.',
                                link: true,
                            },
                            {
                                title: '5. Changes to Terms',
                                content: 'Geotrackr reserves the right to modify these terms at any time. You will be notified of any changes through our website or via email. Continued use of our services after changes indicates acceptance of the new terms.',
                            },
                            {
                                title: '6. Limitation of Liability',
                                content: 'Geotrackr is not liable for any indirect, incidental, or consequential damages arising from the use of our services. We strive to provide accurate and reliable information, but cannot guarantee uninterrupted service.',
                            },
                            {
                                title: '7. Governing Law',
                                content: 'These terms shall be governed and construed in accordance with the laws of your jurisdiction. Any disputes related to the service will be resolved in courts of the applicable jurisdiction.',
                            },
                        ].map(({ title, content, link }, index) => (
                            <div
                                key={index}
                                className="group bg-white dark:bg-gray-800 p-8 rounded-lg shadow-md transition-all transform hover:shadow-2xl hover:-translate-y-2 duration-300 ease-in-out border-l-4 border-indigo-600 dark:border-indigo-400"
                            >
                                <h2 className="text-xl font-semibold mb-4 group-hover:text-indigo-600 dark:text-indigo-400">
                                    {title}
                                </h2>
                                <p className="text-base text-gray-600 dark:text-gray-300 leading-relaxed">
                                    {link ? (
                                        <>
                                            {content}{' '}
                                            <a href="/privacy-policy" className="text-indigo-600 dark:text-indigo-400 underline hover:text-indigo-800 dark:hover:text-indigo-300">
                                                Privacy Policy
                                            </a>.
                                        </>
                                    ) : (
                                        content
                                    )}
                                </p>
                            </div>
                        ))}
                    </div>
                </div>
            </section>
        </Layout>
    );
};

export default TermsAndConditions;
