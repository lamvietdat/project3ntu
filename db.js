const sql = require('mssql');

    const config = {
      server: 'LOQ', // Thay đổi server name
      database: 'TutorManagement', // Thay đổi tên database
      authentication: { // Sử dụng Windows Authentication
        type: 'default'
      },
      options: {
        encrypt: true, // Bật mã hóa
        trustServerCertificate: true // Tin tưởng chứng chỉ máy chủ
      }
    };

    async function connectToSQLServer() {
      try {
        await sql.connect(config);
        console.log('Kết nối thành công đến SQL Server!');

        // Thực hiện truy vấn
        const result = await sql.query('SELECT * FROM your_table_name'); // Thay đổi tên bảng
        console.log(result.recordset);

        // Đóng kết nối
        sql.close();
      } catch (err) {
        console.error('Lỗi kết nối hoặc truy vấn:', err);
      }
    }

    connectToSQLServer();