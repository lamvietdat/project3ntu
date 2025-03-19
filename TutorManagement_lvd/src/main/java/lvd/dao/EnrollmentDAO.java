package lvd.dao;

import lvd.database.DatabaseConnection;
import lvd.model.ClassInfo;
import lvd.model.Enrollment;
import lvd.model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO {
    private StudentDAO studentDAO = new StudentDAO();
    private ClassDAO classDAO = new ClassDAO();
    
    // Phương thức lấy đăng ký theo ID
    public Enrollment getEnrollmentById(int enrollmentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Enrollment enrollment = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM enrollments WHERE enrollment_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, enrollmentId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                enrollment = mapEnrollmentFromResultSet(rs);
                // Lấy thông tin học viên và lớp học
                Student student = studentDAO.getStudentById(enrollment.getStudentId());
                ClassInfo classInfo = classDAO.getClassById(enrollment.getClassId());
                enrollment.setStudent(student);
                enrollment.setClassInfo(classInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return enrollment;
    }
    
    // Phương thức lấy tất cả đăng ký
    public List<Enrollment> getAllEnrollments() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Enrollment> enrollments = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM enrollments ORDER BY enrollment_date DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Enrollment enrollment = mapEnrollmentFromResultSet(rs);
                // Lấy thông tin học viên và lớp học
                Student student = studentDAO.getStudentById(enrollment.getStudentId());
                ClassInfo classInfo = classDAO.getClassById(enrollment.getClassId());
                enrollment.setStudent(student);
                enrollment.setClassInfo(classInfo);
                enrollments.add(enrollment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return enrollments;
    }
    
    // Phương thức lấy các đăng ký theo học viên
    public List<Enrollment> getEnrollmentsByStudent(int studentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Enrollment> enrollments = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM enrollments WHERE student_id = ? ORDER BY enrollment_date DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Enrollment enrollment = mapEnrollmentFromResultSet(rs);
                // Lấy thông tin học viên và lớp học
                Student student = studentDAO.getStudentById(enrollment.getStudentId());
                ClassInfo classInfo = classDAO.getClassById(enrollment.getClassId());
                enrollment.setStudent(student);
                enrollment.setClassInfo(classInfo);
                enrollments.add(enrollment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return enrollments;
    }
    
    // Phương thức lấy các đăng ký theo lớp học
    public List<Enrollment> getEnrollmentsByClass(int classId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Enrollment> enrollments = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM enrollments WHERE class_id = ? ORDER BY enrollment_date DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, classId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Enrollment enrollment = mapEnrollmentFromResultSet(rs);
                // Lấy thông tin học viên và lớp học
                Student student = studentDAO.getStudentById(enrollment.getStudentId());
                ClassInfo classInfo = classDAO.getClassById(enrollment.getClassId());
                enrollment.setStudent(student);
                enrollment.setClassInfo(classInfo);
                enrollments.add(enrollment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return enrollments;
    }
    
    // Phương thức lấy các đăng ký theo trạng thái
    public List<Enrollment> getEnrollmentsByStatus(String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Enrollment> enrollments = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM enrollments WHERE status = ? ORDER BY enrollment_date DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Enrollment enrollment = mapEnrollmentFromResultSet(rs);
                // Lấy thông tin học viên và lớp học
                Student student = studentDAO.getStudentById(enrollment.getStudentId());
                ClassInfo classInfo = classDAO.getClassById(enrollment.getClassId());
                enrollment.setStudent(student);
                enrollment.setClassInfo(classInfo);
                enrollments.add(enrollment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return enrollments;
    }
    
    // Phương thức lấy số lượng học viên đã đăng ký vào một lớp
    public int getEnrollmentCountByClass(int classId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM enrollments WHERE class_id = ? AND status IN ('approved', 'completed')";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, classId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return count;
    }
    
    // Phương thức thêm đăng ký mới
    public boolean addEnrollment(Enrollment enrollment) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO enrollments (student_id, class_id, status) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, enrollment.getStudentId());
            stmt.setInt(2, enrollment.getClassId());
            stmt.setString(3, enrollment.getStatus());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức cập nhật trạng thái đăng ký
    public boolean updateEnrollmentStatus(int enrollmentId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            // Kiểm tra tính hợp lệ của trạng thái
            if (!"pending".equals(status) && !"approved".equals(status) && 
                !"rejected".equals(status) && !"completed".equals(status)) {
                return false;
            }
            
            // Kiểm tra đăng ký có tồn tại không
            Enrollment enrollment = getEnrollmentById(enrollmentId);
            if (enrollment == null) {
                return false;
            }
            
            String sql = "UPDATE enrollments SET status = ? WHERE enrollment_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, status);
            stmt.setInt(2, enrollmentId);
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
            
            // Nếu cập nhật thành công và trạng thái là "approved"
            if (success && "approved".equals(status)) {
                // Kiểm tra số lượng học viên trong lớp
                ClassInfo classInfo = enrollment.getClassInfo();
                int enrolledCount = getEnrollmentCountByClass(classInfo.getClassId());
                
                // Nếu lớp đã đủ học viên, cập nhật trạng thái lớp thành "full"
                if (enrolledCount >= classInfo.getMaxStudents()) {
                    new ClassDAO().updateClassStatus(classInfo.getClassId(), "full");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức kiểm tra học viên đã đăng ký lớp học chưa
    public boolean isStudentEnrolledInClass(int studentId, int classId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean enrolled = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND class_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            stmt.setInt(2, classId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                enrolled = (rs.getInt(1) > 0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return enrolled;
    }
    
    // Phương thức map từ ResultSet sang Enrollment
    private Enrollment mapEnrollmentFromResultSet(ResultSet rs) throws SQLException {
        Enrollment enrollment = new Enrollment();
        enrollment.setEnrollmentId(rs.getInt("enrollment_id"));
        enrollment.setStudentId(rs.getInt("student_id"));
        enrollment.setClassId(rs.getInt("class_id"));
        enrollment.setEnrollmentDate(rs.getTimestamp("enrollment_date"));
        enrollment.setStatus(rs.getString("status"));
        return enrollment;
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