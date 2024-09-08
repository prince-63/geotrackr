import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css'; 
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HowToUse from './components/HowToUse/HowToUse';

const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
  <>
    <Router>
      <Routes>
        <Route path="/docs" element={<HowToUse/>} />
        <Route path="/" element={<App />} />
      </Routes>
    </Router>
  </>
);
