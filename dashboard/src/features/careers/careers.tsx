import React from 'react';
import Layout from '../../components/layout/layout';

const Careers: React.FC = () => {
  return (
    <Layout>
      <section className="bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100 py-16 px-6 sm:px-12 lg:px-24 transition-colors duration-300">
        <div className="max-w-5xl mx-auto text-center">
          <h1 className="text-3xl sm:text-5xl font-bold mb-8 text-gray-800 dark:text-gray-100">
            Join Our Team
          </h1>
          <p className="text-lg sm:text-xl leading-relaxed text-gray-700 dark:text-gray-300 mb-12">
            At{' '}
            <span className="font-semibold text-indigo-600 dark:text-indigo-400">
              Geotrackr
            </span>
            , we're always looking for passionate individuals to help us
            innovate and create cutting-edge solutions. Check out our current
            job openings and become part of a dynamic, forward-thinking team.
          </p>

          <div className="space-y-8">
            {jobOpenings.map((job, index) => (
              <JobOpening
                key={index}
                title={job.title}
                description={job.description}
              />
            ))}
          </div>
        </div>
      </section>
    </Layout>
  );
};

const JobOpening: React.FC<{ title: string; description: string }> = ({
  title,
  description,
}) => (
  <div className="p-8 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-transform transform hover:-translate-y-2 hover:shadow-2xl duration-300 ease-in-out border-l-4 border-indigo-600 dark:border-indigo-400">
    <h2 className="text-2xl font-semibold mb-4 text-indigo-600 dark:text-indigo-400">
      {title}
    </h2>
    <p className="text-base text-gray-600 dark:text-gray-300 leading-relaxed mb-4">
      {description}
    </p>
    <a
      href="#"
      className="text-indigo-600 dark:text-indigo-400 font-semibold underline hover:text-indigo-800 dark:hover:text-indigo-300"
    >
      Apply Now
    </a>
  </div>
);

const jobOpenings = [
  {
    title: 'Frontend Developer',
    description:
      'We are looking for a talented Frontend Developer with experience in React and Tailwind CSS. Join our team to help create smooth and responsive user interfaces.',
  },
  {
    title: 'Backend Developer',
    description:
      'We need a skilled Backend Developer with experience in Node.js and Express to build and maintain APIs that power our geolocation-based solutions.',
  },
  {
    title: 'Product Manager',
    description:
      "We're seeking an experienced Product Manager to lead our development projects, manage timelines, and collaborate across departments to bring our ideas to life.",
  },
  {
    title: 'UI/UX Designer',
    description:
      'If you have a keen eye for design and a passion for creating intuitive user experiences, we want you on our team. Experience with Figma and Adobe XD is a plus!',
  },
];

export default Careers;
