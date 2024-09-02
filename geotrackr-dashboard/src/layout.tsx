import React from 'react';
import { Outlet } from 'react-router-dom';
import SideBar from './components/sidebar/side-bar';

const Layout: React.FC = () => {
  return (
    <div className="flex h-screen">
      <SideBar />
      <div className="ml-52 flex-1 p-0 overflow-y-auto mb-20">
        <Outlet />
      </div>
    </div>
  );
};

export default Layout;
