package lvd.dao;

import lvd.database.DatabaseConnection;
import lvd.model.Subject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {
    
    // Phương thức lấy môn học theo ID
    public Subject getSubjectById(int subjectId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Subject subject = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM subjects WHERE subject_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, subjectId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                subject = mapSubjectFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return subject;
    }
    
    // Phương thức lấy tất cả môn học
    public List<Subject> getAllSubjects() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Subject> subjects = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM subjects";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Subject subject = mapSubjectFromResultSet(rs);
                subjects.add(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return subjects;
    }
    
    // Phương thức thêm môn học mới
    public boolean addSubject(Subject subject) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO subjects (subject_name, description, category) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, subject.getSubjectName());
            stmt.setString(2, subject.getDescription());
            stmt.setString(3, subject.getCategory());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức cập nhật thông tin môn học
    public boolean updateSubject(Subject subject) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE subjects SET subject_name = ?, description = ?, category = ? WHERE subject_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, subject.getSubjectName());
            stmt.setString(2, subject.getDescription());
            stmt.setString(3, subject.getCategory());
            stmt.setInt(4, subject.getSubjectId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức xóa môn học
    public boolean deleteSubject(int subjectId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM subjects WHERE subject_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, subjectId);
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức map từ ResultSet sang Subject
    private Subject mapSubjectFromResultSet(ResultSet rs) throws SQLException {
        Subject subject = new Subject();
        subject.setSubjectId(rs.getInt("subject_id"));
        subject.setSubjectName(rs.getString("subject_name"));
        subject.setDescription(rs.getString("description"));
        subject.setCategory(rs.getString("category"));
        return subject;
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