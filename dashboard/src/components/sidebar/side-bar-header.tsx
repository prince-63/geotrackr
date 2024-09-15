import { Link } from 'react-router-dom';
import logo from '../../assets/mstile-70x70.png';
// import Typography from "../general/typography";

const SideBarHeader = () => {
  return (
    <div>
      <Link
        to={'/dashboard'}
        className="side-bar-header flex flex-row justify-center items-center"
      >
        {/* <div className="side-bar-header__logo">
          <img src={logo} alt="logo" width={40} height={40} />
        </div> */}
        <div className="flex items-center justify-center">
          <img
            src={logo}
            alt="Office Logo"
            className="w-[80px] h-[80px] rounded-full shadow-md p-1 bg-white"
          />
        </div>

        {/* <Typography
          variant="h6"
          className="text-center ml-2 text-blue-600 font-bold tracking-wide"
        >
          GeoTrackr
        </Typography> */}
      </Link>
    </div>
  );
};

export default SideBarHeader;
