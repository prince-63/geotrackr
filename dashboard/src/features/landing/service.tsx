import { service_data as services } from '../../lib/data';

const Service = () => {
  return (
    <div className="bg-gray-100 py-20" id="services">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl sm:text-4xl font-bold text-center mb-8 sm:mb-10 text-gray-900">
          Our Services
        </h2>
        <p className="text-center text-gray-600 max-w-3xl text-lg mx-auto">
          Our innovative attendance system offers a range of features to help
          businesses manage their workforce more efficiently. Here are some of
          the key services we offer
        </p>
      </div>
      <div className="flex flex-wrap justify-center gap-8 mt-12">
        {services.map((service, index) => (
          <div
            key={index}
            className="flex flex-col items-center w-full sm:w-1/2 lg:w-1/4 px-4"
          >
            <div className="w-36 h-36 rounded-full bg-gray-200 flex justify-center items-center transition-transform transform hover:scale-105">
              <img
                src={service.image}
                alt={service.title}
                className="w-36 h-36 rounded-full object-cover"
              />
            </div>
            <div className="text-center mt-4">
              <h3 className="text-xl font-bold text-gray-800">
                {service.title}
              </h3>
              <p className="text-gray-600 mt-2">{service.description}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Service;
