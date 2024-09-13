import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from "react-router-dom";
import LoginPage from "./components/pages/login/login-page";
import SignupPage from "./components/pages/signup/signup-page";
import ProfilePage from "./components/pages/profile/profile-page";
import HelpPage from "./components/pages/help/help-page";
import Layout from "./layout";
import DashboardPage from "./components/pages/dashboard/dashboard-page";
import WorkPage from "./components/pages/work/work-page";
import EmployeesPage from "./components/pages/employees/employees-page";
import SettingsPage from "./components/pages/settings/settings-page";
import ProtectedRoute from "./protected-route";
import EmployeeProfile from "./components/pages/employeeProfile/employeeProfile";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Navigate to="/login" />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="/" element={<Layout />}>
          <Route
            path="dashboard"
            element={<ProtectedRoute element={<DashboardPage />} />}
          />
          <Route
            path="profile"
            element={<ProtectedRoute element={<ProfilePage />} />}
          />
          <Route
            path="help"
            element={<ProtectedRoute element={<HelpPage />} />}
          />
          <Route
            path="employees"
            element={<ProtectedRoute element={<EmployeesPage />} />}
          />
          <Route
            path="employee-profile"
            element={<EmployeeProfile employeeId={"t4785353"}              
            />}
            />
          <Route
            path="work"
            element={<ProtectedRoute element={<WorkPage />} />}
          />
          <Route
            path="settings"
            element={<ProtectedRoute element={<SettingsPage />} />}
          />
        </Route>
      </Routes>
    </Router>
  );
}

export default App;