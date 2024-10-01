import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import LoginPage from './features/auth/login/login-page';
import SignupPage from './features/auth/signup/signup-page';
import ProfilePage from './features/profile/profile-page';
import HelpPage from './features/help/help-page';
import DashboardPage from './features/dashboard/dashboard-page';
import EmployeesPage from './features/employees/employees-page';
import SettingsPage from './features/settings/settings-page';
import ProtectedRoute from './protected-route';
// import EmployeeProfile from './features/employees/employee-profile';
import LandingPage from './features/landing/landing-page';
import SideBarLayout from './components/layout/sidebar-layout';
import AboutUs from './features/about/about_us';
import PrivacyPolicy from './features/privacy_policy/privacy_policy';
import TermsAndConditions from './features/terms_conditions/terms_conditions';
import Careers from './features/careers/careers';
import Notices from './features/notices/notices';
import Support from './features/support/support';
import ContactUs from './features/contact_us/contact_us';
import MasterAdminSideBarLayout from './features/master_admin/sidebar-layout';
import OfficesPage from './features/master_admin/offices';
import MasterAdminDashboardPage from './features/master_admin/dashboard-page';
import LogoutPage from './features/master_admin/logout-page';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="about" element={<AboutUs />} />
        <Route path="privacy" element={<PrivacyPolicy />} />
        <Route path="terms" element={<TermsAndConditions />} />
        <Route path="careers" element={<Careers />} />
        <Route path="notices" element={<Notices />} />
        <Route path="support" element={<Support />} />
        <Route path="contact" element={<ContactUs />} />
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
          <Route
            path="settings"
            element={<ProtectedRoute element={<SettingsPage />} />}
          />
        </Route>

        <Route path="master-admin" element={<MasterAdminSideBarLayout />}>
          <Route path="dashboard" element={<MasterAdminDashboardPage />} />

          <Route path="offices" element={<OfficesPage />} />
          <Route path="logout" element={<LogoutPage />} />
        </Route>
      </Routes>
    </Router>
  );
}

export default App;
