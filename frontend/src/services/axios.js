import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:5000/api', // Đảm bảo backend đang chạy ở đây
});

export default api;
