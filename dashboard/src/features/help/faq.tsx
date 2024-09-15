import React, { useState } from 'react';
import Typography from '../../components/general/typography';
import { FaAngleDown, FaAngleUp } from 'react-icons/fa';

interface FAQItem {
  question: string;
  answer: string;
}

const faqData: FAQItem[] = [
  {
    question: 'How do I reset my password?',
    answer:
      "You can reset your password by going to the account settings and selecting 'Reset Password.'",
  },
  {
    question: 'How can I contact support?',
    answer:
      'You can contact support via email at support@yourdomain.com or through our contact form below.',
  },
  {
    question: 'Where can I find more resources?',
    answer:
      'Visit our resources page for tutorials, articles, and other helpful content.',
  },
];

const FAQ: React.FC = () => {
  const [activeIndex, setActiveIndex] = useState<number | null>(null);

  const toggleFAQ = (index: number) => {
    setActiveIndex(activeIndex === index ? null : index);
  };

  return (
    <section className="mb-12">
      <Typography variant="h5" className="font-semibold text-gray-700 mb-6">
        Frequently Asked Questions
      </Typography>
      <div className="space-y-4">
        {faqData.map((item, index) => (
          <div key={index} className="border-b border-gray-200 pb-4">
            <div
              className="flex justify-between items-center cursor-pointer"
              onClick={() => toggleFAQ(index)}
            >
              <Typography variant="h6" className="text-gray-800">
                {item.question}
              </Typography>
              <Typography className="text-gray-600" variant="body1">
                {activeIndex === index ? <FaAngleUp /> : <FaAngleDown />}
              </Typography>
            </div>
            <div
              className={`mt-2 overflow-hidden transition-all duration-300 ease-in-out ${activeIndex === index ? 'max-h-screen' : 'max-h-0'}`}
            >
              <Typography variant="body2" className="text-gray-600">
                {item.answer}
              </Typography>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
};

export default FAQ;
