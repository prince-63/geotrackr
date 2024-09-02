import React from "react";
import { Link } from "react-router-dom";
import { dashboard_sidebar_link } from "../../lib/data";
import Typography from "../general/typography";
import SideBarHeader from "./side-bar-header";
import BreakLine from "../general/break-line";
import IconContainer from "../general/icon-container";
import SideBarFooter from "./side-bar-footer"; // Import the footer component

const SideBar: React.FC = () => {
  return (
    <aside className="w-52 bg-white border-r-[1px] text-black p-4 fixed h-full flex flex-col">
      <SideBarHeader />
      <BreakLine />
      <nav className="flex-1 overflow-y-auto">
        <ul className="space-y-1">
          {dashboard_sidebar_link.map((link, index) => (
            <li key={index}>
              <Link
                to={link.link}
                className="flex items-center rounded-md hover:bg-gray-200 transition duration-200 ease-in-out"
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
      <BreakLine />
      <SideBarFooter />
    </aside>
  );
};

export default SideBar;
