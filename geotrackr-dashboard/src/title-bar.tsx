import React from "react";
import { Minus, Square, X } from "lucide-react"; // Import Lucide icons
import logo from "../assets/fab-icons/mstile-70x70.png"; // Import the logo image

const TitleBar: React.FC = () => {
  const handleMinimize = () => {
    window.ipcRenderer.send("minimize-window");
  };

  const handleMaximize = () => {
    window.ipcRenderer.send("maximize-window");
  };

  const handleClose = () => {
    window.ipcRenderer.send("close-window");
  };

  return (
    <div className="title-bar flex justify-between items-center bg-gray-100 p-2 w-screen">
      <div className="title">
        <img src={logo} alt="Geotrackr Logo" className="h-8" />
      </div>
      <div className="window-controls flex space-x-1">
        <button
          id="minimize"
          className="hover:bg-gray-200 text-white font-bold py-2 px-3 rounded"
          onClick={handleMinimize}
        >
          <Minus className="w-3 h-3" color="#000000" /> {/* Use Lucide icon */}
        </button>
        <button
          id="maximize"
          className="hover:bg-gray-200 text-white font-bold py-2 px-3 rounded"
          onClick={handleMaximize}
        >
          <Square className="w-3 h-3" color="#000000" /> {/* Use Lucide icon */}
        </button>
        <button
          id="close"
          className="hover:bg-gray-200 text-white font-bold py-2 px-3 rounded"
          onClick={handleClose}
        >
          <X className="w-3 h-3" color="#000000" /> {/* Use Lucide icon */}
        </button>
      </div>
    </div>
  );
};

export default TitleBar;
