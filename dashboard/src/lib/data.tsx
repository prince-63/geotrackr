import { BarChart, User, HelpCircle, LogOut, UserRoundPen } from 'lucide-react';
import { DASHBOARD_SIDEBAR_LINKS_TYPE } from './types';
import appInstall from '../assets/images/app-install.png';
import security from '../assets/images/security.png';
import attendance from '../assets/images/attendance.png';
import identity from '../assets/images/identity.png';
import fingerprint from '../assets/images/fingerprint.png';
import mobile from '../assets/images/mobile.webp';

export const dashboard_sidebar_link: DASHBOARD_SIDEBAR_LINKS_TYPE = [
  {
    title: 'Dashboard',
    icon: BarChart,
    link: '/dashboard',
  },
  {
    title: 'Employees',
    icon: User,
    link: '/employees',
  },
  {
    title: 'Profile',
    icon: UserRoundPen,
    link: '/profile',
  },
  {
    title: 'Help',
    icon: HelpCircle,
    link: '/help',
  },
  {
    title: 'Logout',
    icon: LogOut,
    link: '/logout',
  },
];

export const NAV_LINKS = [
  {
    label: 'Home',
    href: '/',
  },
  {
    label: 'Login',
    href: '/login',
  },
  {
    label: 'Signup',
    href: '/signup',
  },
];

export const hero_content = [
  {
    heading: 'Revolutionize Attendance Tracking',
    subheading: 'With Cutting-Edge Technology',
    description:
      'Learn how our system combines biometric verification, GPS tracking, and blockchain for secure and accurate attendance management.',
    img: attendance,
  },
  {
    heading: 'Seamless Online & Offline',
    subheading: 'Attendance Solutions',
    description:
      'Discover how our technology ensures reliable attendance recording even in low connectivity environments.',
    img: security,
  },
  {
    heading: 'Start Using Our System',
    subheading: 'Today and Transform Operations',
    description:
      'Get started with our solution to enhance security, accuracy, and efficiency in attendance management.',
    img: appInstall,
  },
];

export const service_data = [
  {
    image: identity,
    title: 'Identity Verification',
    description:
      'Each user receives a unique QR codeed identity card storing encrypted data including user ID, fingerprint, and office location, offering a compact secure method to manage attendance.',
  },
  {
    image: mobile,
    title: 'Mobile Application',
    description:
      'Our mobile app offers a convenient way for employees to clock in and out, view their attendance history, and receive notifications about their attendance status.',
  },
  {
    image: fingerprint,
    title: 'Biometric Verification',
    description:
      'Our system uses biometric verification to ensure that the person clocking in is the same person assigned to the user ID, preventing buddy punching and other forms of attendance fraud.',
  },
];
