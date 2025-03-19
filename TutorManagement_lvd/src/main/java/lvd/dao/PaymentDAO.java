package lvd.dao;

import lvd.database.DatabaseConnection;
import lvd.model.Enrollment;
import lvd.model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    
    // Phương thức lấy thanh toán theo ID
    public Payment getPaymentById(int paymentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Payment payment = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM payments WHERE payment_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, paymentId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                payment = mapPaymentFromResultSet(rs);
                // Lấy thông tin đăng ký
                Enrollment enrollment = enrollmentDAO.getEnrollmentById(payment.getEnrollmentId());
                payment.setEnrollment(enrollment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return payment;
    }
    
    // Phương thức lấy các thanh toán theo đăng ký
    public List<Payment> getPaymentsByEnrollment(int enrollmentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Payment> payments = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM payments WHERE enrollment_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, enrollmentId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Payment payment = mapPaymentFromResultSet(rs);
                // Lấy thông tin đăng ký
                Enrollment enrollment = enrollmentDAO.getEnrollmentById(payment.getEnrollmentId());
                payment.setEnrollment(enrollment);
                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return payments;
    }
    
    // Phương thức thêm thanh toán mới
    public boolean addPayment(Payment payment) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO payments (enrollment_id, amount, payment_method, status, transaction_id) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, payment.getEnrollmentId());
            stmt.setBigDecimal(2, payment.getAmount());
            stmt.setString(3, payment.getPaymentMethod());
            stmt.setString(4, payment.getStatus());
            stmt.setString(5, payment.getTransactionId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức cập nhật trạng thái thanh toán
    public boolean updatePaymentStatus(int paymentId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE payments SET status = ? WHERE payment_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, status);
            stmt.setInt(2, paymentId);
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức map từ ResultSet sang Payment
    private Payment mapPaymentFromResultSet(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentId(rs.getInt("payment_id"));
        payment.setEnrollmentId(rs.getInt("enrollment_id"));
        payment.setAmount(rs.getBigDecimal("amount"));
        payment.setPaymentDate(rs.getTimestamp("payment_date"));
        payment.setPaymentMethod(rs.getString("payment_method"));
        payment.setStatus(rs.getString("status"));
        payment.setTransactionId(rs.getString("transaction_id"));
        return payment;
    }
    
    // Phương thức đóng các tài nguyên
    private void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) DatabaseConnection.closeConnection(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}