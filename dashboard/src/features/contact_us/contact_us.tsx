import React, { useRef } from 'react';
import { FaPhoneAlt, FaEnvelope, FaMapMarkerAlt } from 'react-icons/fa';
import Layout from '../../components/layout/layout';
import { sendMessage } from '../../api-services/contact-service';
import { ToastContainer, toast } from 'react-toastify';

const ContactUs: React.FC = () => {
  const nameRef = useRef<HTMLInputElement>(null);
  const emailRef = useRef<HTMLInputElement>(null);
  const messageRef = useRef<HTMLTextAreaElement>(null);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const name = nameRef.current?.value;
    const email = emailRef.current?.value;
    const message = messageRef.current?.value;

    if (!name || !email || !message) {
      return toast.error('Please fill in all fields');
    }
    if (!email.includes('@') || !email.includes('.')) {
      return toast.error('Please enter a valid email address');
    }

    const response = await sendMessage({ name, email, message });

    if (response.error) {
      return toast.error(response.error);
    }
    return toast.success(response.success);
  };

  return (
    <Layout>
      <section className="bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100 py-16 px-6 sm:px-12 lg:px-24 transition-colors duration-300">
        <div className="max-w-6xl mx-auto text-center">
          <h1 className="text-3xl sm:text-5xl font-bold mb-8 text-gray-800 dark:text-gray-100">
            Contact Us
          </h1>
          <p className="text-lg sm:text-xl leading-relaxed mb-12 text-gray-700 dark:text-gray-300">
            Got questions? We'd love to hear from you! Reach out to us through
            any of the channels below.
          </p>

          {/* Contact Information */}
          <div className="grid gap-8 sm:grid-cols-2 lg:grid-cols-3">
            <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out">
              <FaPhoneAlt className="text-3xl text-blue-600 dark:text-blue-400 mb-4 mx-auto" />
              <h2 className="text-xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                Phone
              </h2>
              <p className="text-base leading-relaxed text-gray-600 dark:text-gray-300">
                Call us at: <br /> +91 6289296197
              </p>
            </div>
            <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out">
              <FaEnvelope className="text-3xl text-green-600 dark:text-green-400 mb-4 mx-auto" />
              <h2 className="text-xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                Email
              </h2>
              <p className="text-base leading-relaxed text-gray-600 dark:text-gray-300">
                Email us at: <br /> prince08833@gmail.com
              </p>
            </div>
            <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out">
              <FaMapMarkerAlt className="text-3xl text-red-600 dark:text-red-400 mb-4 mx-auto" />
              <h2 className="text-xl font-semibold mb-4 text-gray-800 dark:text-gray-200">
                Address
              </h2>
              <p className="text-base leading-relaxed text-gray-600 dark:text-gray-300">
                Bara kanthalia, Barrackpore,
                <br />
                Kolkata, West Bengal 700121
              </p>
            </div>
          </div>

          {/* Contact Form */}
          <div className="mt-12">
            <h2 className="text-2xl font-semibold mb-6 text-gray-800 dark:text-gray-100">
              Send Us a Message
            </h2>
            <form
              className="max-w-3xl mx-auto space-y-6"
              onSubmit={handleSubmit}
            >
              <div className="grid gap-6 sm:grid-cols-2">
                <div>
                  <label className="block text-left text-gray-700 dark:text-gray-300 mb-2">
                    Name
                  </label>
                  <input
                    type="text"
                    placeholder="Your Name"
                    ref={nameRef}
                    className="w-full px-4 py-3 bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-lg border border-gray-300 dark:border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors duration-300"
                  />
                </div>
                <div>
                  <label className="block text-left text-gray-700 dark:text-gray-300 mb-2">
                    Email
                  </label>
                  <input
                    type="email"
                    placeholder="Your Email"
                    ref={emailRef}
                    className="w-full px-4 py-3 bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-lg border border-gray-300 dark:border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors duration-300"
                  />
                </div>
              </div>
              <div>
                <label className="block text-left text-gray-700 dark:text-gray-300 mb-2">
                  Message
                </label>
                <textarea
                  rows={4}
                  placeholder="Your Message"
                  ref={messageRef}
                  className="w-full px-4 py-3 bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-lg border border-gray-300 dark:border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 transition-colors duration-300"
                ></textarea>
              </div>
              <div>
                <button
                  type="submit"
                  className="w-full sm:w-auto px-6 py-3 bg-blue-600 dark:bg-blue-500 text-white rounded-lg hover:bg-blue-700 dark:hover:bg-blue-600 transition-colors duration-300"
                >
                  Send Message
                </button>
              </div>
            </form>
          </div>
          <ToastContainer
            position="top-right"
            autoClose={2000}
            hideProgressBar={false}
            newestOnTop={false}
            closeOnClick
            rtl={false}
            pauseOnFocusLoss
            draggable
            pauseOnHover
            theme="light"
          />
        </div>
      </section>
    </Layout>
  );
};

export default ContactUs;
