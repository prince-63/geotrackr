import { useEffect, useState } from 'react';
import { Menu, X } from 'lucide-react';

import { Drawer, DrawerTrigger, DrawerClose } from '../navigation/drawer';
import { DrawerContent } from '../navigation/drawer';
import { NAV_LINKS } from '../../lib/data';
import { mergeClasses } from '../../lib/utils';
import useWindowSize from '../../hooks/use-window-size';
import useScroll from '../../hooks/use-scroll';
import Link from '../navigation/link';
import IconButton from '../general/icon-button';
import Typography from '../general/typography';
import ThemeSwitcher from '../general/theme-switcher';
import LogoImage from '../../assets/fab-icons/mstile-70x70.png';

const Logo = () => (
  <Typography variant="h1" className=" font-semibold">
    <img src={LogoImage} alt="Office Logo" className="w-[40px] h-[40px]" />
  </Typography>
);

const Header = () => {
  const scrolled = useScroll(40);
  const [isOpen, setIsOpen] = useState(false);
  const size = useWindowSize();

  // close sidebar if open in screen size < 768px
  useEffect(() => {
    if (size?.width && size?.width > 767 && isOpen) {
      setIsOpen(false);
    }
  }, [size, isOpen]);

  return (
    <header
      className={mergeClasses(
        'sticky top-0 z-30 w-full border-b border-transparent bg-gray-100  max-md:border-gray-100',
        scrolled ? 'bg-gray/20 backdrop-blur-xl md:border-gray-100' : ''
      )}
    >
      <div className="mx-auto flex w-full max-w-7xl items-center justify-between p-4 md:px-8">
        <Logo />
        <div className="hidden items-center gap-6 md:flex">
          <ul className="flex list-none items-center gap-6">
            {NAV_LINKS.map((link, index) => (
              <li key={index}>
                <Link href={link.href}>{link.label}</Link>
              </li>
            ))}
          </ul>
          <div className="h-6 w-0.5 bg-gray-100"></div>
          <div className="flex items-center gap-4">
            <ThemeSwitcher />
          </div>
        </div>

        <Drawer open={isOpen} onOpenChange={setIsOpen}>
          <div className="md:hidden flex items-center gap-4">
            <div className="md:hidden">
              <ThemeSwitcher />
            </div>
            <DrawerTrigger asChild className="flex md:hidden">
              <IconButton>
                <Menu />
              </IconButton>
            </DrawerTrigger>
          </div>

          <DrawerContent>
            <div className="flex items-center justify-between border-b border-gray-100 p-4">
              <Logo />
              <DrawerClose asChild>
                <IconButton>
                  <X />
                </IconButton>
              </DrawerClose>
            </div>
            <div className="border-b border-gray-100 p-4">
              <ul className="flex list-none flex-col gap-4">
                {NAV_LINKS.map((link, index) => (
                  <li key={index}>
                    <Link
                      href={link.href}
                      onClick={() => {
                        const timeoutId = setTimeout(() => {
                          setIsOpen(false);
                          clearTimeout(timeoutId);
                        }, 500);
                      }}
                    >
                      {link.label}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          </DrawerContent>
        </Drawer>
      </div>
    </header>
  );
};

export default Header;
