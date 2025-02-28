import { useEffect, useState } from "react";
import axios from "axios";

function Dashboard() {
  const [userData, setUserData] = useState(null);

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const token = localStorage.getItem("token");
        const response = await axios.get("http://localhost:5000/api/user/profile", {
          headers: { Authorization: `Bearer ${token}` },
        });
        setUserData(response.data);
      } catch (error) {
        console.error("Lỗi tải dữ liệu người dùng");
      }
    };
    fetchUserData();
  }, []);

  return (
    <div>
      <h1>Trang Dashboard</h1>
      {userData ? <p>Chào mừng, {userData.email}</p> : <p>Đang tải dữ liệu...</p>}
    </div>
  );
}

export default Dashboard;
