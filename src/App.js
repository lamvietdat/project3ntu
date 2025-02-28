import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import HomePage from "./pages/HomePage";
import LoginPage from "./pages/LoginPage";
import RegisterPage from "./pages/RegisterPage";
import Dashboard from "./pages/Dashboard";
import thongtingiasu from"./pages/thongtingiasu";
import thongtinlophoc from"./pages/thongtinlophoc";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/thongtingiasu" element={<thongtingiasu />} />
        <Route path="/thongtinlophoc" element={<thongtinlophoc />} />
      </Routes>
    </Router>
  );
}

export default App;
