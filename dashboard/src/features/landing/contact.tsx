import React, { useRef } from 'react';
import { IoMdCall } from 'react-icons/io';
import { IoLocation } from 'react-icons/io5';
import { MdEmail } from 'react-icons/md';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import SectionHeader from '../../components/data-display/section-header';
import Typography from '../../components/general/typography';
import Button from '../../components/general/button';
import { sendMessage } from '../../api-services/contact-service';

const Contact: React.FC = () => {
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
    <div id="contact">
      <section className="bg-gray-100 py-12 md:py-20">
        <div className="container mx-auto px-4 sm:px-6 lg:px-8">
          <SectionHeader
            title="Contact Us"
            description="Have questions or need support regarding our innovative attendance system? Reach out to us through the following methods."
          />
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mt-20">
            <div className="bg-white dark:bg-gray-100 shadow-lg p-6 md:p-8 rounded-lg border border-gray-200 ">
              <Typography
                variant="h4"
                className="text-2xl sm:text-3xl font-bold mb-4 text-gray-800 dark:text-white"
              >
                Get in Touch
              </Typography>
              <Typography
                variant="body1"
                className="text-gray-800 dark:text-white mb-6"
              >
                We are available 24/7 to answer your questions and provide
                support. Feel free to contact us through the following methods.
              </Typography>
              <ul className="text-gray-800 dark:text-gray-200 text-base sm:text-lg">
                <li className="mb-3 flex items-center">
                  <IoMdCall className="text-blue-500 dark:text-blue-300 text-2xl sm:text-3xl mr-3" />
                  <Typography
                    variant="body1"
                    className="text-gray-800 dark:text-white
                    px-2"
                  >
                    Phone:
                  </Typography>{' '}
                  <Typography
                    variant="body1"
                    className="text-gray-800 dark:text-white"
                  >
                    +91 6289296197
                  </Typography>
                </li>
                <li className="mb-3 flex items-center">
                  <MdEmail className="text-blue-500 dark:text-blue-300 text-2xl sm:text-3xl mr-3" />
                  <Typography
                    variant="body1"
                    className="text-gray-800 dark:text-white
                    px-2"
                  >
                    Email:
                  </Typography>{' '}
                  <Typography
                    variant="body1"
                    className="text-gray-800 dark:text-white"
                  >
                    prince08833@gmail.com
                  </Typography>
                </li>
                <li className="flex items-center">
                  <IoLocation className="text-blue-500 dark:text-blue-300 text-2xl sm:text-3xl mr-3" />
                  <Typography
                    variant="body1"
                    className="text-gray-800 dark:text-white
                    px-2"
                  >
                    Address:
                  </Typography>{' '}
                  <Typography
                    variant="body1"
                    className="text-gray-800 dark:text-white"
                  >
                    Bara kanthalia, Barrackpore, Kolkata, West Bengal 700121
                  </Typography>
                </li>
              </ul>
            </div>
            <div className="bg-white dark:bg-gray-100 shadow-lg p-6 md:p-8 rounded-lg border border-gray-200 ">
              <h3 className="text-2xl sm:text-3xl font-bold mb-4 text-gray-800 dark:text-white">
                Contact Us
              </h3>
              <form className="space-y-4 sm:space-y-6" onSubmit={handleSubmit}>
                <div>
                  <label className="block text-sm font-medium text-gray-800 dark:text-white mb-1 sm:mb-2">
                    Name
                  </label>
                  <input
                    type="text"
                    name="name"
                    ref={nameRef}
                    className="w-full px-3 py-2 sm:px-4 sm:py-3 border border-gray-300 dark:border-gray-700 rounded-lg bg-gray-50 dark:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-900 dark:text-gray-200 placeholder-gray-500 dark:placeholder-gray-400 transition duration-300"
                    placeholder="Your Name"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-800 dark:text-white mb-1 sm:mb-2">
                    Email
                  </label>
                  <input
                    type="email"
                    name="email"
                    ref={emailRef}
                    className="w-full px-3 py-2 sm:px-4 sm:py-3 border border-gray-300 dark:border-gray-700 rounded-lg bg-gray-50 dark:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-900 dark:text-gray-200 placeholder-gray-500 dark:placeholder-gray-400 transition duration-300"
                    placeholder="Your Email"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-800 dark:text-white mb-1 sm:mb-2">
                    Message
                  </label>
                  <textarea
                    name="message"
                    ref={messageRef}
                    className="w-full px-3 py-2 sm:px-4 sm:py-3 border border-gray-300 dark:border-gray-700 rounded-lg bg-gray-50 dark:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-900 dark:text-gray-200 placeholder-gray-500 dark:placeholder-gray-400 transition duration-300"
                    rows={4}
                    placeholder="Your Message"
                  ></textarea>
                </div>
                <Button
                  className="w-full px-4 py-2 sm:px-6 sm:py-3 text-gray-100 bg-black font-semibold mt-4 rounded-lg shadow-lg transition-colors duration-300 dark:bg-white dark:text-black"
                  type={'submit'}
                >
                  Send Message
                </Button>
              </form>
            </div>
          </div>
        </div>
      </section>
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
  );
};

export default Contact;
