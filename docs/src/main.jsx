import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css'; 
import Docs from './components/Docs/Docs';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <>
    <Router>
      <Routes>
        <Route path="/docs" element={<Docs />} />
        <Route path="/" element={<App />} />
      </Routes>
    </Router>
  </>
);
