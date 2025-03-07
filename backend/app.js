const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config();

const { connectToDatabase } = require('./config/database');  // Import hàm kết nối từ database.js

const userRoutes = require('./routes/UserRoutes');
const giaSuRoutes = require('./routes/giaSuRoutes.js');
const lopHocRoutes = require('./routes/lopHocRoutes.js');
const dangKyLopRoutes = require('./routes/dangKyLopRoutes.js');
const thanhToanRoutes = require('./routes/thanhToanRoutes.js');
const danhGiaRoutes = require('./routes/danhGiaRoutes.js');
const adminRoutes = require('./routes/adminRoutes.js');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api', userRoutes);
app.use('/api', giaSuRoutes);
app.use('/api', lopHocRoutes);
app.use('/api', dangKyLopRoutes);
app.use('/api', thanhToanRoutes);
app.use('/api', danhGiaRoutes);
app.use('/api', adminRoutes);

// Middleware để xử lý lỗi
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send({ message: 'Có lỗi xảy ra!' });
});

// Start server
const PORT = process.env.PORT || 5000;

async function startServer() {
  try {
    // Kiểm tra kết nối cơ sở dữ liệu
    await connectToDatabase();  // Chờ kết nối đến cơ sở dữ liệu
    console.log('Kết nối đến cơ sở dữ liệu SQL Server thành công!');

    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  } catch (err) {
    console.error('Lỗi khi kết nối đến cơ sở dữ liệu:', err);
    process.exit(1);  // Nếu kết nối không thành công, dừng ứng dụng
  }
}

startServer();
