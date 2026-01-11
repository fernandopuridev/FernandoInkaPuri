import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Calculator from './components/Calculator';
import Login from './components/Login';

const isAuthenticated = () => {
  return localStorage.getItem('token') !== null;
};

function App() {
  return (
    <BrowserRouter>
      <div>
        <Routes>
          <Route path="/" element={
            isAuthenticated() ? <Navigate to="/calculator" /> : <Navigate to="/login" />
          } />
          <Route path="/calculator" element={<Calculator />} />
          <Route path="/login" element={<Login />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;