import {
  FaGooglePlay,
  FaAppStoreIos,
  FaFacebook,
  FaDiscord,
  FaTwitter,
} from 'react-icons/fa';
import Logo from '../../assets/fab-icons/mstile-70x70.png';

const Footer = () => {
  return (
    <footer className="bg-white dark:bg-black">
      <div className="container mx-auto p-4 py-6 lg:py-8">
        <div className="md:flex md:justify-between">
          <div className="mb-6 md:mb-0">
            <a href="/" className="flex gap-4 items-center">
              <img
                src={Logo}
                alt="GeoTrackr"
                className="w-10 h-10"
              />
              <span className="self-center text-2xl font-semibold whitespace-nowrap text-white">
                GeoTrackr
              </span>
            </a>

            <div className="mt-4">
              <div className="flex gap-4">
                <a
                  href="#"
                  className="flex items-center justify-center px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-md hover:bg-green-700"
                >
                  <FaGooglePlay className="mr-2 text-2xl" />
                  Download for Android
                </a>
                <a
                  href="#"
                  className="flex items-center justify-center px-4 py-2 text-sm font-medium text-green-600 bg-green-100 rounded-md hover:bg-green-200"
                >
                  <FaAppStoreIos className="mr-2 text-2xl" />
                  Download for iOS
                </a>
              </div>
            </div>
          </div>
          <div className="grid grid-cols-2 gap-8 sm:gap-6 sm:grid-cols-3">
            <div>
              <h2 className="mb-6 text-sm font-semibold text-black dark:text-white">
                Resources
              </h2>
              <ul className="text-green-600 dark:text-green-400 font-medium">
                <li className="mb-4">
                  <a href="/docs" className="hover:underline">
                    Docs
                  </a>
                </li>
              </ul>
            </div>
            <div>
              <h2 className="mb-6 text-sm font-semibold text-black dark:text-white">
                Follow us
              </h2>
              <ul className="text-green-600 dark:text-green-400 font-medium">
                <li className="mb-4">
                  <a
                    href="https://github.com/prince-63/id-card"
                    className="hover:underline"
                  >
                    Github
                  </a>
                </li>
                <li>
                  <a
                    href="https://twitter.com/prince_63"
                    className="hover:underline"
                  >
                    Twitter
                  </a>
                </li>
              </ul>
            </div>
            <div>
              <h2 className="mb-6 text-sm font-semibold text-black dark:text-white">
                Legal
              </h2>
              <ul className="text-green-600 dark:text-green-400 font-medium">
                <li className="mb-4">
                  <a href="#" className="hover:underline">
                    Privacy Policy
                  </a>
                </li>
                <li>
                  <a href="#" className="hover:underline">
                    Terms & Conditions
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <hr className="my-6 border-black sm:mx-auto dark:border-white lg:my-8" />
        <div className="sm:flex sm:items-center sm:justify-between">
          <span className="text-sm text-black dark:text-white sm:text-center">
            © 2024{' '}
            <a
              href="https://quantum-qr-website.vercel.app/"
              className="hover:underline"
            >
              GeoTrackr
            </a>
            . All Rights Reserved.
          </span>
          <div className="flex mt-4 sm:justify-center sm:mt-0">
            <a
              href="#"
              className="text-green-600 hover:text-green-400 dark:text-green-400 dark:hover:text-green-600"
            >
              <FaFacebook className="w-4 h-4" />
              <span className="sr-only">Facebook page</span>
            </a>
            <a
              href="#"
              className="text-green-600 hover:text-green-400 dark:text-green-400 dark:hover:text-green-600 ms-5"
            >
              <FaDiscord className="w-4 h-4" />
              <span className="sr-only">Discord community</span>
            </a>
            <a
              href="#"
              className="text-green-600 hover:text-green-400 dark:text-green-400 dark:hover:text-green-600 ms-5"
            >
              <FaTwitter className="w-4 h-4" />
              <span className="sr-only">Twitter page</span>
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
