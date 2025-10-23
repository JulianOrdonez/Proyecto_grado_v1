import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Login from './pages/Login';
import Register from './pages/Register';
import DashboardDocente from './pages/DashboardDocente';
import DashboardTecnico from './pages/DashboardTecnico';
import DashboardAdmin from './pages/DashboardAdmin';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/docente" element={<DashboardDocente />} />
        <Route path="/tecnico" element={<DashboardTecnico />} />
        <Route path="/admin" element={<DashboardAdmin />} />
      </Routes>
    </Router>
  );
}

export default App;
