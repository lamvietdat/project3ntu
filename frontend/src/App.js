import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import AdminDashboard from './components/AdminDashboard';
import UserList from './components/User/UserList';
import GiaSuList from './components/GiaSu/GiaSuList';
import LopHocList from './components/LopHoc/LopHocList';
import DangKyLopList from './components/DangKyLop/DangKyLopList';
import ThanhToanList from './components/ThanhToan/ThanhToanList';
import Dangky from './components/Dangky/Dangky';
import Dangnhap from './components/Dangnhap/Dangnhap';
import Home from './components/Home/Home';
import Header from './components/Header/Header';

function App() {
  return (
    <Router>
      <div>
        {/* The header should be inside the Router */}
        <Header />

        <Routes>
          <Route path="/admin" element={<AdminDashboard />} />
          <Route path="/users" element={<UserList />} />
          <Route path="/gia-su" element={<GiaSuList />} />
          <Route path="/lop-hoc" element={<LopHocList />} />
          <Route path="/dang-ky-lop" element={<DangKyLopList />} />
          <Route path="/thanh-toan" element={<ThanhToanList />} />
          <Route path="/dangky" element={<Dangky />} />
          <Route path="/dangnhap" element={<Dangnhap />} />
          <Route path="/" element={<Home />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
