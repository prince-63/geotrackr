import { useEffect, useState } from 'react';
import { Menu, X } from 'lucide-react';

import {
  Drawer,
  DrawerTrigger,
  DrawerClose,
  DrawerContent,
} from '../navigation/drawer';
import { dashboard_sidebar_link } from '../../lib/data';
import useWindowSize from '../../hooks/use-window-size';
import { Link } from 'react-router-dom';
import IconButton from '../general/icon-button';
import Typography from '../general/typography';
import ThemeSwitcher from '../general/theme-switcher';
import LogoImage from '../../assets/fab-icons/mstile-70x70.png';
import IconContainer from '../general/icon-container';

const Logo = () => (
  <Typography variant="h1" className="hidden md:flex font-semibold">
    <img src={LogoImage} alt="Office Logo" className="w-[80px] h-[80px]" />
  </Typography>
);

const SideBar = () => {
  const [isOpen, setIsOpen] = useState(false);
  const size = useWindowSize();

  // close sidebar if open in screen size < 768px
  useEffect(() => {
    if (size?.width && size?.width > 767 && isOpen) {
      setIsOpen(false);
    }
  }, [size, isOpen]);

  return (
    <div className="flex">
      <div className="hidden md:mx-auto md:flex md:flex-col md:w-[200px] md:items-start md:px-4 bg-white dark:bg-gray-100">
        <div className="w-full flex items-center justify-center pt-4">
          <Logo />
        </div>
        <div className="w-full h-[1px] bg-gray-200 dark:bg-gray-700 my-2" />
        <div className="">
          <nav className="flex-1">
            <ul className="space-y-1">
              {dashboard_sidebar_link.map((link, index) => (
                <li key={index}>
                  <Link
                    to={link.link}
                    className="flex w-[160px] items-center rounded-md hover:bg-gray-200 duration-200 ease-in-out text-base font-medium text-gray-600 transition-all hover:text-gray-900 active:text-gray-600"
                  >
                    <IconContainer>
                      <link.icon className="w-5 h-5" />
                    </IconContainer>
                    <Typography variant="body3" className="ml-2">
                      {link.title}
                    </Typography>
                  </Link>
                </li>
              ))}
            </ul>
          </nav>
          <div className="fixed bottom-8 left-4">
            <ThemeSwitcher />
          </div>
        </div>
      </div>

      <Drawer open={isOpen} onOpenChange={setIsOpen}>
        <div className="md:hidden fixed top-0 z-30 border-b border-transparent p-2 w-full items-center flex justify-between bg-white dark:bg-gray-100 px-5">
          <Typography variant="h1" className="font-semibold">
            <img
              src={LogoImage}
              alt="Office Logo"
              className="w-[45px] h-[45px]"
            />
          </Typography>
          <div className="flex gap-2 items-center justify-center">
            <div className="md:hidden">
              <ThemeSwitcher />
            </div>
            <DrawerTrigger asChild className="flex md:hidden">
              <IconButton>
                <Menu />
              </IconButton>
            </DrawerTrigger>
          </div>
        </div>

        <DrawerContent className="fixed top-0 right-0 h-full w-52 bg-white dark:bg-gray-100 shadow-lg z-50 transition-transform duration-300">
          <div className="flex items-center justify-between border-b border-gray-100 dark:border-gray-700 p-2">
            <Typography variant="h1" className="font-semibold">
              <img
                src={LogoImage}
                alt="Office Logo"
                className="w-[45px] h-[45px]"
              />
            </Typography>
            <DrawerClose asChild>
              <IconButton>
                <X />
              </IconButton>
            </DrawerClose>
          </div>
          <div className="p-4">
            <ul className="space-y-1">
              {dashboard_sidebar_link.map((link, index) => (
                <li key={index}>
                  <Link
                    to={link.link}
                    onClick={() => {
                      const timeoutId = setTimeout(() => {
                        setIsOpen(false);
                        clearTimeout(timeoutId);
                      }, 100);
                    }}
                    className="flex items-center rounded-md hover:bg-gray-200 duration-200 ease-in-out text-base font-medium text-gray-600 transition-all hover:text-gray-900 active:text-gray-600"
                  >
                    <IconContainer>
                      <link.icon className="w-5 h-5" />
                    </IconContainer>
                    <Typography variant="body3" className="ml-2">
                      {link.title}
                    </Typography>
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </DrawerContent>
      </Drawer>
    </div>
  );
};

export default SideBar;
