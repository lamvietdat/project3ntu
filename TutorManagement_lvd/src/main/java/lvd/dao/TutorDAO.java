package lvd.dao;

import lvd.database.DatabaseConnection;
import lvd.model.Tutor;
import lvd.model.User;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TutorDAO {
    private UserDAO userDAO = new UserDAO();
    
    // Phương thức lấy gia sư theo ID
    public Tutor getTutorById(int tutorId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Tutor tutor = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM tutors WHERE tutor_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, tutorId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                tutor = mapTutorFromResultSet(rs);
                // Lấy thông tin user của gia sư
                User user = userDAO.getUserById(tutor.getUserId());
                tutor.setUser(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return tutor;
    }
    
    // Phương thức lấy gia sư theo user_id
    public Tutor getTutorByUserId(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Tutor tutor = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM tutors WHERE user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                tutor = mapTutorFromResultSet(rs);
                // Lấy thông tin user của gia sư
                User user = userDAO.getUserById(tutor.getUserId());
                tutor.setUser(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return tutor;
    }
    
    // Phương thức lấy tất cả gia sư
    public List<Tutor> getAllTutors() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Tutor> tutors = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM tutors WHERE status = 'active'";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Tutor tutor = mapTutorFromResultSet(rs);
                // Lấy thông tin user của gia sư
                User user = userDAO.getUserById(tutor.getUserId());
                tutor.setUser(user);
                tutors.add(tutor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return tutors;
    }
    
    // Phương thức thêm gia sư mới
    public boolean addTutor(Tutor tutor) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO tutors (user_id, qualification, experience, hourly_rate, bio, status) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, tutor.getUserId());
            stmt.setString(2, tutor.getQualification());
            stmt.setString(3, tutor.getExperience());
            stmt.setBigDecimal(4, tutor.getHourlyRate());
            stmt.setString(5, tutor.getBio());
            stmt.setString(6, tutor.getStatus());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức cập nhật thông tin gia sư
    public boolean updateTutor(Tutor tutor) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE tutors SET qualification = ?, experience = ?, hourly_rate = ?, bio = ?, status = ? WHERE tutor_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, tutor.getQualification());
            stmt.setString(2, tutor.getExperience());
            stmt.setBigDecimal(3, tutor.getHourlyRate());
            stmt.setString(4, tutor.getBio());
            stmt.setString(5, tutor.getStatus());
            stmt.setInt(6, tutor.getTutorId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức map từ ResultSet sang Tutor
    private Tutor mapTutorFromResultSet(ResultSet rs) throws SQLException {
        Tutor tutor = new Tutor();
        tutor.setTutorId(rs.getInt("tutor_id"));
        tutor.setUserId(rs.getInt("user_id"));
        tutor.setQualification(rs.getString("qualification"));
        tutor.setExperience(rs.getString("experience"));
        tutor.setHourlyRate(rs.getBigDecimal("hourly_rate"));
        tutor.setBio(rs.getString("bio"));
        tutor.setStatus(rs.getString("status"));
        return tutor;
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