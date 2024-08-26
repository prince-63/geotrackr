import React, { useState } from "react";
import { Sidebar, SidebarBody, SidebarLink } from "./Sidebar";
import {
  IconArrowLeft,
  IconBrandTabler,
  IconSettings,
  IconUserBolt,
} from "@tabler/icons-react";
import { Link } from 'react-router-dom';
import { motion } from "framer-motion";
import { cn } from "../../lib/utils";

import Dashboard from "./Dashboard";
import Settings from "./Settings"; // Import Settings component
import AddEmployee from "./AddEmployee";
import AssignWork from "./AssignWork";
import { Navigate } from "react-router-dom";

export default function AdminPanel() {
  const [open, setOpen] = useState(false);
  const [currentView, setCurrentView] = useState('Dashboard'); // Manage current view state

  const links = [
    {
      label: "Dashboard",
      icon: (
        <IconBrandTabler className="text-neutral-700 dark:text-neutral-200 h-5 w-5 flex-shrink-0" />
      ),
      view: 'Dashboard',
    },
    {
      label: "Add Employee",
      icon: (
        <IconUserBolt className="text-neutral-700 dark:text-neutral-200 h-5 w-5 flex-shrink-0" />
      ),
      view: 'AddEmployee',
    },
    {
      label: "Assign Work",
      icon: (
        <IconUserBolt className="text-neutral-700 dark:text-neutral-200 h-5 w-5 flex-shrink-0" />
      ),
      view: 'AssignWork',
    },
    {
      label: "Settings",
      icon: (
        <IconSettings className="text-neutral-700 dark:text-neutral-200 h-5 w-5 flex-shrink-0" />
      ),
      view: 'Settings',
    },
    {
      label: "Logout",
      icon: (
        <IconArrowLeft className="text-neutral-700 dark:text-neutral-200 h-5 w-5 flex-shrink-0" />
      ),
      view: 'Logout',
    },
  ];

  const handleLinkClick = (view: React.SetStateAction<string>) => {
    setCurrentView(view); // Update current view state
  };

  return (
    <div
      className={cn(
        "flex flex-col md:flex-row bg-white min-h-screen flex-1 mx-auto",
        "h-screen" // Full height
      )}
    >
      <Sidebar open={open} setOpen={setOpen}>
        <SidebarBody className="justify-between gap-10">
          <div className="flex flex-col flex-1 overflow-y-auto overflow-x-hidden">
            {open ? <Logo /> : <LogoIcon />}
            <div className="mt-8 flex flex-col gap-2">
              {links.map((link, idx) => (
                <p
                  key={idx}
                  className={`flex items-center space-x-2 text-neutral-700 dark:text-neutral-200 py-4 pl-1 rounded-xl hover:cursor-pointer ${currentView === link.view ? 'bg-gray-200 dark:bg-orange-800' : ''}`}
                  onClick={() => handleLinkClick(link.view)}
                >
                  {link.icon}
                  <span>{link.label}</span>
                </p>
              ))}
            </div>
          </div>
          <div>
            <SidebarLink
              link={{
                label: "Manu Arora",
                href: "#",
                icon: (
                  <img
                    src="https://avatars.githubusercontent.com/u/16586443?v=4"
                    alt="profile"
                    className="h-8 w-8 rounded-full"
                  />
                ),
              }}
            />
          </div>
        </SidebarBody>
      </Sidebar>
      <div className="flex-1">
        {/* Conditionally render the component based on currentView state */}
        {
          currentView === 'Dashboard' ? <Dashboard /> : null
        }
        {
          currentView === 'Settings' ? <Settings /> : null
        }
        {
          currentView === 'AddEmployee' ? <AddEmployee /> : null
        }
        {
          currentView === 'AssignWork' ? <AssignWork /> : null
        }
        {
          currentView === 'Logout' ?  <Navigate to="/login" /> : null
        }
      </div>
    </div>
  );
}

export const Logo = () => {
  return (
    <Link
      to="#"
      className="font-normal flex space-x-2 items-center text-sm text-black py-1 relative z-20"
    >
      <div className="h-5 w-6 bg-black dark:bg-white rounded-br-lg rounded-tr-sm rounded-tl-lg rounded-bl-sm flex-shrink-0" />
      <motion.span
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        className="font-medium text-black dark:text-white whitespace-pre"
      >
        QuantumQR
      </motion.span>
    </Link>
  );
};

export const LogoIcon = () => {
  return (
    <Link
      to="#"
      className="font-normal flex space-x-2 items-center text-sm text-black py-1 relative z-20"
    >
      <div className="h-5 w-6 bg-black dark:bg-white rounded-br-lg rounded-tr-sm rounded-tl-lg rounded-bl-sm flex-shrink-0" />
    </Link>
  );
};
