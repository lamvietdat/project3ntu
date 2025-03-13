// src/main/java/lvd/database/DatabaseConnection.java
package lvd.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Thông tin kết nối MySQL
    private static final String URL = "jdbc:mysql://localhost:3306/lvd_tutor_management";
    private static final String USER = "root";
    private static final String PASSWORD = "1234"; // Điền mật khẩu MySQL của bạn
    
    // Phương thức lấy kết nối đến cơ sở dữ liệu
    public static Connection getConnection() throws SQLException {
        try {
            // Đăng ký MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Tạo và trả về kết nối
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            // Xử lý nếu không tìm thấy driver
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }
    
    // Phương thức đóng kết nối
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}