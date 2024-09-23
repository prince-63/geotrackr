import React, { useState } from 'react';
import { FaChevronDown, FaChevronUp } from 'react-icons/fa';
import faqs from '../../lib/faqs';
import Layout from '../../components/layout/layout';

const Support: React.FC = () => {
    const [activeFAQ, setActiveFAQ] = useState<number | null>(null);

    const toggleFAQ = (index: number) => {
        setActiveFAQ(activeFAQ === index ? null : index);
    };

    return (
        <Layout>
            <section className="bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100 py-16 px-6 sm:px-12 lg:px-24 transition-colors duration-300">
                <div className="max-w-5xl mx-auto">
                    <h1 className="text-3xl sm:text-5xl font-bold mb-8 text-center text-gray-800 dark:text-gray-100">
                        Support & Help Center
                    </h1>
                    <p className="text-lg sm:text-xl leading-relaxed text-center mb-12 text-gray-700 dark:text-gray-300">
                        We’re here to help! Find answers to frequently asked questions or contact our support team for further assistance.
                    </p>

                    {/* FAQ Section */}
                    <div className="space-y-8">
                        {faqs.map((faq, index) => (
                            <div
                                key={index}
                                className="p-6 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-1 hover:shadow-2xl duration-300 ease-in-out cursor-pointer"
                                onClick={() => toggleFAQ(index)}
                            >
                                <div className="flex justify-between items-center">
                                    <h2 className="text-xl font-semibold text-gray-800 dark:text-gray-200">
                                        {faq.question}
                                    </h2>
                                    {activeFAQ === index ? (
                                        <FaChevronUp className="text-gray-600 dark:text-gray-400" />
                                    ) : (
                                        <FaChevronDown className="text-gray-600 dark:text-gray-400" />
                                    )}
                                </div>
                                {activeFAQ === index && (
                                    <p className="mt-4 text-base text-gray-600 dark:text-gray-300 leading-relaxed">
                                        {faq.answer}
                                    </p>
                                )}
                            </div>
                        ))}
                    </div>

                    {/* Contact Section */}
                    <div className="mt-12 grid gap-8 sm:grid-cols-2">
                        <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out">
                            <h2 className="text-2xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                                Contact Support
                            </h2>
                            <p className="text-base text-gray-600 dark:text-gray-300 mb-4">
                                Need further assistance? Get in touch with our support team for any issues or questions.
                            </p>
                            <a
                                href="mailto:support@geotrackr.com"
                                className="inline-block bg-blue-600 dark:bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-700 dark:hover:bg-blue-600 transition-colors duration-300"
                            >
                                Email Support
                            </a>
                        </div>

                        <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out">
                            <h2 className="text-2xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                                Live Chat
                            </h2>
                            <p className="text-base text-gray-600 dark:text-gray-300 mb-4">
                                Our support team is available for live chat Monday through Friday from 9 AM to 6 PM.
                            </p>
                            <button
                                className="inline-block bg-green-600 dark:bg-green-500 text-white py-2 px-4 rounded-lg hover:bg-green-700 dark:hover:bg-green-600 transition-colors duration-300"
                            >
                                Start Live Chat
                            </button>
                        </div>
                    </div>
                </div>
            </section>
        </Layout>
    );
};

export default Support;
