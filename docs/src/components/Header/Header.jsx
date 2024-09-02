import React from 'react';
import { IoMenu, IoClose, IoQrCodeOutline } from 'react-icons/io5';
const Header = () => {
    const navLinks = [
        {
            title: 'Home',
            slug: '/'
        },
        {
            title: 'About',
            slug: '#about'
        },
        {
            title: 'Pricing',
            slug: '#pricing'
        },
        {
            title: 'Contact',
            slug: '#contact'
        },
        {
            title: 'Docs',
            slug: '/docs'
        }
    ];
    
    const [isOpen, setIsOpen] = React.useState(false);

    const handleButton = () => {
        setIsOpen(!isOpen);
    }
    return (
        <header>
            <div className='container mx-auto flex justify-between items-center'>
                <div className='flex items-center p-2 m-2 rounded-lg'>
                    <a href="/" className="flex gap-4 items-center">
                        <img src="/mstile-144x144.png" alt="GeoTrackr" className="w-10 h-10" />
                        <span className="self-center text-2xl font-semibold whitespace-nowrap">GeoTrackr</span>
                    </a>
                </div>
                <nav className='hidden md:block'>
                    <ul className='flex gap-6'>
                        {navLinks.map((link, index) => (
                            <a href={link.slug} key={index} className='text-xl font-medium hover:text-green-500'>
                                <span>{link.title}</span>
                            </a>
                        ))}
                    </ul>
                </nav>

                <div className='md:hidden'>
                    <button onClick={handleButton} className='text-4xl p-4'>
                        {isOpen ? <IoClose /> : <IoMenu />}
                    </button>
                    {
                        isOpen && (
                            <div className='absolute top-16 left-0 w-full bg-white shadow-lg z-20 py-4'>
                                <ul className='flex flex-col items-center gap-4'>
                                    {navLinks.map((link, index) => (
                                        <a href={link.slug} key={index} className='text-xl font-medium hover:text-green-500' onClick={handleButton}>
                                            <span>{link.title}</span>
                                        </a>
                                    ))}
                                </ul>
                            </div>
                        )
                    }
                </div>
            </div>
        </header>
    )
}

export default Header;