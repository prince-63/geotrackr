import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import LoginPage from './features/auth/login/login-page';
import SignupPage from './features/auth/signup/signup-page';
import ProfilePage from './features/profile/profile-page';
import HelpPage from './features/help/help-page';
import DashboardPage from './features/dashboard/dashboard-page';
import WorkPage from './features/work/work-page';
import EmployeesPage from './features/employees/employees-page';
import SettingsPage from './features/settings/settings-page';
import ProtectedRoute from './protected-route';
// import EmployeeProfile from './features/employees/employee-profile';
import LandingPage from './features/landing/landing-page';
import SideBarLayout from './components/layout/sidebar-layout';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="/" element={<SideBarLayout />}>
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
          {/* <Route
            path="employee-profile"
            element={<EmployeeProfile employeeId={'t4785353'} />}
          /> */}
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
