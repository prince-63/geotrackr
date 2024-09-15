import Layout from '../../components/layout/layout';
import About from './about';
import Contact from './contact';
import Hero from './hero';
import Service from './service';
import Testimonials from './testmonials';

const LandingPage = () => {
  return (
    <Layout>
      <Hero />
      <About />
      <Service />
      <Testimonials />
      <Contact />
    </Layout>
  );
};

export default LandingPage;
