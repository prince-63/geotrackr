import React from 'react';
import { Outlet } from 'react-router-dom';
import MasterAdminSideBar from '../../components/master-admin-sidebar/master_admin_sidebar';

const MasterAdminSideBarLayout: React.FC = () => {
    return (
        <div className="md:flex md:h-screen">
            <MasterAdminSideBar />
            <div className="mt-12 md:mt-0 flex-1 overflow-y-auto">
                <Outlet />
            </div>
        </div>
    );
};

export default MasterAdminSideBarLayout;
