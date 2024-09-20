import React from 'react';
import { Outlet } from 'react-router-dom';
import SideBar from '../sidebar/side-bar';

const SideBarLayout: React.FC = () => {
  return (
    <div className="md:flex md:h-screen">
      <SideBar />
      <div className="mt-12 md:mt-0 flex-1 overflow-y-auto">
        <Outlet />
      </div>
    </div>
  );
};

export default SideBarLayout;
