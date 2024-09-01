import ReactDOM from "react-dom/client";
import App from "./App.tsx";
import "./index.css";
import { UserProvider } from "./hooks/user-context";
import { IpcMessageEvent } from "electron";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <UserProvider>
    <App />
  </UserProvider>
);

// Use contextBridge
window.ipcRenderer.on(
  "main-process-message",
  (_event: IpcMessageEvent, message: string) => {
    console.log(message);
  }
);
