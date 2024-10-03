import { FaGooglePlay } from 'react-icons/fa';
import Logo from '../../assets/fab-icons/mstile-70x70.png';
import Typography from '../general/typography';
import Link from '../navigation/link';

const Footer = () => {
  return (
    <footer className="bg-white dark:bg-gray-100 text-gray-800 dark:text-gray-200 border-t-2 shadow-lg">
      <div className="container mx-auto p-4 py-6 lg:py-8">
        <div className="md:flex md:justify-between">
          <div className="mb-6 md:mb-0">
            <Link href="/" className="flex gap-1 items-center">
              <img src={Logo} alt="GeoTrackr" className="w-10 h-10" />
              <Typography
                variant="h4"
                className="text-grey-800 dark:text-white"
              >
                Geotrackr
              </Typography>
            </Link>
            <div className="mt-6">
              <div className="flex gap-4">
                <button className="flex items-center justify-center px-4 py-2 text-sm font-medium text-white bg-black rounded-md transition duration-300 dark:text-black dark:bg-white hover:text-white">
                  <FaGooglePlay className="mr-2 text-2xl" />
                  <a href="../../assets/app/app-release.apk" download={true}>
                    <Typography variant="body3">Download App</Typography>
                  </a>
                </button>
              </div>
            </div>
          </div>
          <div className="grid grid-cols-2 gap-8 sm:gap-6 sm:grid-cols-3">
            <div>
              <Typography
                variant="body2"
                className="text-grey-800 dark:text-white font-semibold mb-5"
              >
                Resources
              </Typography>
              <ul className="text-gray-600 dark:text-gray-400 font-medium">
                <li className="mb-4">
                  <Link href="/notices" className="hover:underline">
                    Notices
                  </Link>
                </li>
                <li className="mb-4">
                  <Link href="/support" className="hover:underline">
                    Support
                  </Link>
                </li>
              </ul>
            </div>
            <div>
              <Typography
                variant="body2"
                className="text-grey-800 dark:text-white font-semibold mb-5"
              >
                Company
              </Typography>
              <ul className="text-gray-600 dark:text-gray-400 font-medium">
                <li className="mb-4">
                  <Link href="/about" className="hover:underline">
                    About Us
                  </Link>
                </li>
                <li className="mb-4">
                  <Link href="/careers" className="hover:underline">
                    Careers
                  </Link>
                </li>
                <li className="mb-4">
                  <Link href="/contact" className="hover:underline">
                    Contact Us
                  </Link>
                </li>
              </ul>
            </div>
            <div>
              <Typography
                variant="body2"
                className="text-grey-800 dark:text-white font-semibold mb-5"
              >
                Legal
              </Typography>
              <ul className="text-gray-600 dark:text-gray-400 font-medium">
                <li className="mb-4">
                  <Link href="/privacy" className="hover:underline">
                    Privacy Policy
                  </Link>
                </li>
                <li>
                  <Link href="/terms" className="hover:underline">
                    Terms & Conditions
                  </Link>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <hr className="my-6 border-gray-300 dark:border-gray-700 sm:mx-auto lg:my-8" />
        <div className="flex items-center justify-center">
          <Typography className="text-sm sm:text-center text-grey-800 dark:text-white">
            © 2024{' '}
            <Link href="https://geotrackr.tech" className="hover:underline">
              GeoTrackr
            </Link>
            . All Rights Reserved.
          </Typography>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
