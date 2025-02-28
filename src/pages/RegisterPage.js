import { useState } from "react";
import axios from "axios";

function RegisterPage() {
  const [user, setUser] = useState({ email: "", password: "", role: "HocVien" });

  const handleRegister = async (e) => {
    e.preventDefault();
    try {
      await axios.post("http://localhost:5000/api/auth/register", user);
      alert("Đăng ký thành công!");
    } catch (error) {
      alert("Đăng ký thất bại!");
    }
  };

  return (
    <div>
      <h1>Đăng ký</h1>
      <form onSubmit={handleRegister}>
        <input type="email" placeholder="Email" onChange={(e) => setUser({ ...user, email: e.target.value })} required />
        <input type="password" placeholder="Mật khẩu" onChange={(e) => setUser({ ...user, password: e.target.value })} required />
        <select onChange={(e) => setUser({ ...user, role: e.target.value })}>
          <option value="HocVien">Học viên</option>
          <option value="GiaSu">Gia sư</option>
        </select>
        <button type="submit">Đăng ký</button>
      </form>
    </div>
  );
}

export default RegisterPage;
