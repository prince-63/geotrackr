import { useState, useEffect } from 'react';
import { FaStar } from 'react-icons/fa';
import './testmonials.css';
import SectionHeader from '../../components/data-display/section-header';
import Typography from '../../components/general/typography';

const testimonials = [
  {
    name: 'John Doe',
    position: 'CEO, ExampleCorp',
    feedback:
      'This service has transformed our business operations. Highly recommended!',
    rating: 5,
  },
  {
    name: 'Jane Smith',
    position: 'CTO, TechSolutions',
    feedback:
      'Exceptional quality and support. The team really goes above and beyond.',
    rating: 4,
  },
  {
    name: 'Alex Johnson',
    position: 'Product Manager, InnovateX',
    feedback:
      'A game-changer for our team. The features are robust and user-friendly.',
    rating: 5,
  },
  {
    name: 'Sarah Wilson',
    position: 'HR Manager, Workforce Inc.',
    feedback:
      'We have seen a significant improvement in our attendance tracking process.',
    rating: 4,
  },
  {
    name: 'David Brown',
    position: 'COO, GlobalTech',
    feedback:
      'Our team is more productive and efficient thanks to this service.',
    rating: 5,
  },
  {
    name: 'Emily Davis',
    position: 'Lead Developer, SoftWorks',
    feedback: 'The best attendance system I have used. Great value for money.',
    rating: 4,
  },
];

const Testimonials = () => {
  const [currentIndex, setCurrentIndex] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentIndex((prevIndex) => (prevIndex + 1) % testimonials.length);
    }, 3000); // Change slide every 3 seconds

    return () => clearInterval(interval);
  }, []);

  return (
    <section className="bg-gray-100 py-20">
      <div className="container mx-auto px-4">
        <SectionHeader
          title="Testimonials"
          description="Hear what our clients have to say about our service. We take pride in delivering the best experience for our customers."
        />
        <div className="relative overflow-hidden py-12">
          <div
            className="testimonials-container flex transition-transform duration-700 ease-in-out"
            style={{ transform: `translateX(-${currentIndex * 100}%)` }}
          >
            {[...testimonials, ...testimonials].map((testimonial, index) => (
              <div
                key={index}
                className="testimonial-item bg-white border border-gray-200 shadow-lg p-6 rounded-lg w-80 mx-4 flex-shrink-0 dark:bg-gray-100"
              >
                <div className="flex items-center mb-4">
                  <div className="flex-1">
                    <Typography
                      variant="h4"
                      className="text-gray-800"
                      component="h4"
                    >
                      {testimonial.name}
                    </Typography>
                    <Typography
                      variant="body3"
                      className="text-gray-600"
                      component="p"
                    >
                      {testimonial.position}
                    </Typography>
                  </div>
                  <div className="ml-4 flex items-center">
                    <div className="text-yellow-500 flex">
                      {Array.from({ length: testimonial.rating }).map(
                        (_, i) => (
                          <FaStar key={i} className="text-lg" />
                        )
                      )}
                    </div>
                  </div>
                </div>
                <Typography
                  variant="body2"
                  className="text-gray-600 text-wrap"
                  component="p"
                >
                  {testimonial.feedback}
                </Typography>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};

export default Testimonials;
