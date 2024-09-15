import React from 'react';
import { Link } from 'react-router-dom';
import { dashboard_sidebar_footer } from '../../lib/data';
import IconContainer from '../general/icon-container';
import Typography from '../general/typography';

const SideBarFooter: React.FC = () => {
  return (
    <div className="mt-auto flex-1">
      <nav>
        <ul className="space-y-1">
          {dashboard_sidebar_footer.map((link, index) => (
            <li key={index}>
              <Link
                to={link.link}
                className="flex items-center rounded-md hover:bg-gray-200 transition duration-200 ease-in-out"
              >
                <IconContainer>
                  <link.icon className="w-5 h-5" />
                </IconContainer>
                <Typography variant="body3">{link.title}</Typography>
              </Link>
            </li>
          ))}
        </ul>
      </nav>
    </div>
  );
};

export default SideBarFooter;
