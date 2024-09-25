import React from 'react';
import Typography from '../../components/general/typography';
import Button from '../../components/general/button';
import Faq from './faq';
import { Link } from 'react-router-dom';

const HelpPage: React.FC = () => {
  const Resources = [
    {
      id: 1,
      title: 'Getting Started',
      description:
        'Learn the basics of our app and get started quickly with our beginner guide.',
      to: '/getting-started',
    },
    {
      id: 2,
      title: 'Advanced Tutorials',
      description:
        'Explore advanced techniques and unlock the full potential of our features.',
      to: '/advanced-tutorials',
    },
    {
      id: 3,
      title: 'Community Forums',
      description:
        'Join the conversation, ask questions, and help others in our community forums.',
      to: '/community-forums',
    },
  ];
  return (
    <div className="container mx-auto px-6 py-12">
      {/* Header Section */}
      <div className="text-center mb-16">
        <Typography variant="h5">Help & Support</Typography>
        <Typography variant="body1" className="mt-4 text-lg text-gray-500">
          Find answers to common questions or contact our support team.
        </Typography>
      </div>

      {/* FAQ Section */}
      <Faq />

      {/* Resources Section */}
      <section className="my-16">
        <Typography variant="h5" className="mb-8">
          Helpful Resources
        </Typography>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          {Resources.map((resource, index) => {
            return (
              <div key={index} className="p-6 border border-gray-200 rounded-lg hover:shadow-2xl transition-shadow duration-500 transform hover:scale-105">
                <Typography variant="h6" className="font-bold text-gray-900">
                  {resource.title}
                </Typography>
                <Typography variant="body2" className="mt-3 text-gray-600">
                  {resource.description}
                </Typography>
                <Link
                  to={resource.to}
                  className="mt-4 text-blue-600 hover:text-blue-700"
                >
                  Learn More
                </Link>
              </div>
            );
          })}
        </div>
      </section>

      {/* Contact Form Section */}
      <section className="bg-gray-100 rounded-xl p-8 shadow-lg">
        <Typography variant="h5">Contact Support</Typography>
        <form className="grid grid-cols-1 sm:grid-cols-2 gap-8">
          <FormInput label="Name" type="text" placeholder="Enter your name" />
          <FormInput
            label="Email"
            type="email"
            placeholder="Enter your email"
          />

          <div className="sm:col-span-2">
            <label className="block text-gray-600 font-medium mb-2">
              Message
            </label>
            <textarea
              placeholder="Write your message"
              rows={5}
              className="w-full p-4 border border-gray-300 rounded-lg focus:outline-none focus:ring focus:ring-blue-400 transition-shadow duration-300 shadow-sm"
            ></textarea>
          </div>

          <div className="sm:col-span-2 text-center">
            <Button className="bg-blue-600 text-white px-8 py-3 rounded-full shadow-md hover:bg-blue-700 transition-all duration-300">
              Send Message
            </Button>
          </div>
        </form>
      </section>
    </div>
  );
};

// FormInput Component
const FormInput: React.FC<{
  label: string;
  type: string;
  placeholder: string;
}> = ({ label, type, placeholder }) => {
  return (
    <div>
      <label className="block text-gray-600 font-medium mb-2">{label}</label>
      <input
        type={type}
        placeholder={placeholder}
        className="w-full p-4 border border-gray-300 rounded-lg focus:outline-none focus:ring focus:ring-blue-400 transition-shadow duration-300 shadow-sm"
      />
    </div>
  );
};

export default HelpPage;
