import Login from './components/Login/Login'
import Signup from './components/Signup/Signup'
import ForgotPassword from './components/ForgotPassword/ForgotPassword'
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom'
import AdminPanel from './components/AdminPanel/AdminPanel'
import Settings from './components/AdminPanel/Settings'

function App() {

  return (
    <Router>
      <li>
        <Link to="/login">Login</Link>
        <Link to='/admin-panel'>Admin Panel</Link>
      </li>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/forgot-password" element={<ForgotPassword />} />
        <Route path="/admin-panel" element={<AdminPanel />} />
      </Routes>
    </Router>
  )
}

export default App