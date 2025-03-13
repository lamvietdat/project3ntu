package lvd.dao;

import lvd.database.DatabaseConnection;
import lvd.model.Student;
import lvd.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private UserDAO userDAO = new UserDAO();
    
    // Phương thức lấy học viên theo ID
    public Student getStudentById(int studentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Student student = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM students WHERE student_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                student = mapStudentFromResultSet(rs);
                // Lấy thông tin user của học viên
                User user = userDAO.getUserById(student.getUserId());
                student.setUser(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return student;
    }
    
    // Phương thức lấy học viên theo user_id
    public Student getStudentByUserId(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Student student = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM students WHERE user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                student = mapStudentFromResultSet(rs);
                // Lấy thông tin user của học viên
                User user = userDAO.getUserById(student.getUserId());
                student.setUser(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return student;
    }
    
    // Phương thức lấy tất cả học viên
    public List<Student> getAllStudents() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Student> students = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM students";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Student student = mapStudentFromResultSet(rs);
                // Lấy thông tin user của học viên
                User user = userDAO.getUserById(student.getUserId());
                student.setUser(user);
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return students;
    }
    
    // Phương thức thêm học viên mới
    public boolean addStudent(Student student) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO students (user_id, education_level, study_goals, parent_contact) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, student.getUserId());
            stmt.setString(2, student.getEducationLevel());
            stmt.setString(3, student.getStudyGoals());
            stmt.setString(4, student.getParentContact());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức cập nhật thông tin học viên
    public boolean updateStudent(Student student) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE students SET education_level = ?, study_goals = ?, parent_contact = ? WHERE student_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, student.getEducationLevel());
            stmt.setString(2, student.getStudyGoals());
            stmt.setString(3, student.getParentContact());
            stmt.setInt(4, student.getStudentId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức map từ ResultSet sang Student
    private Student mapStudentFromResultSet(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentId(rs.getInt("student_id"));
        student.setUserId(rs.getInt("user_id"));
        student.setEducationLevel(rs.getString("education_level"));
        student.setStudyGoals(rs.getString("study_goals"));
        student.setParentContact(rs.getString("parent_contact"));
        return student;
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