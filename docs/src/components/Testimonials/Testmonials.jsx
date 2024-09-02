import React from 'react';
import { FaStar } from 'react-icons/fa';
import './Testimonials.css';

const testimonials = [
    {
        name: 'John Doe',
        position: 'CEO, ExampleCorp',
        feedback: 'This service has transformed our business operations. Highly recommended!',
        rating: 5
    },
    {
        name: 'Jane Smith',
        position: 'CTO, TechSolutions',
        feedback: 'Exceptional quality and support. The team really goes above and beyond.',
        rating: 4
    },
    {
        name: 'Alex Johnson',
        position: 'Product Manager, InnovateX',
        feedback: 'A game-changer for our team. The features are robust and user-friendly.',
        rating: 5
    }
];

const Testimonials = () => {
    return (
        <section className="bg-gray-100 py-20">
            <div className="container mx-auto px-4">
                <h2 className="text-3xl sm:text-4xl font-bold text-center mb-8 sm:mb-10 text-gray-900">What Our Clients Say</h2>
                <div className="relative overflow-hidden">
                    <div className="testimonials-container flex space-x-6">
                        {[...testimonials, ...testimonials].map((testimonial, index) => (
                            <div 
                                key={index} 
                                className="testimonial-item bg-white border border-gray-200 shadow-lg p-6 rounded-lg w-80 md:w-96 transform transition-transform duration-300 hover:scale-105"
                            >
                                <div className="flex items-center mb-4">
                                    <div className="flex-1">
                                        <h3 className="text-xl font-semibold text-black">{testimonial.name}</h3>
                                        <p className="text-gray-500 text-sm">{testimonial.position}</p>
                                    </div>
                                    <div className="ml-4 flex items-center">
                                        <div className="text-yellow-500 flex">
                                            {Array.from({ length: testimonial.rating }).map((_, i) => (
                                                <FaStar key={i} className="text-lg" />
                                            ))}
                                        </div>
                                    </div>
                                </div>
                                <p className="text-gray-600 text-wrap">{testimonial.feedback}</p>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </section>
    );
};

export default Testimonials;
