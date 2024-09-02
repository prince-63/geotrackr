import ReactDOM from "react-dom/client";
import App from "./App.tsx";
import "./index.css";
import { UserProvider } from "./hooks/user-context";
import TitleBar from "./title-bar"; 

ReactDOM.createRoot(document.getElementById("root")!).render(
  <UserProvider>
    <div>
      <TitleBar />
      <App />
    </div>
  </UserProvider>
);