package lvd.dao;

import lvd.database.DatabaseConnection;
import lvd.model.ClassInfo;
import lvd.model.Subject;
import lvd.model.Tutor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassDAO {
    private TutorDAO tutorDAO = new TutorDAO();
    private SubjectDAO subjectDAO = new SubjectDAO();
    
    // Phương thức lấy lớp học theo ID
    public ClassInfo getClassById(int classId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ClassInfo classInfo = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM classes WHERE class_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, classId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                classInfo = mapClassFromResultSet(rs);
                // Lấy thông tin gia sư và môn học
                Tutor tutor = tutorDAO.getTutorById(classInfo.getTutorId());
                Subject subject = subjectDAO.getSubjectById(classInfo.getSubjectId());
                classInfo.setTutor(tutor);
                classInfo.setSubject(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return classInfo;
    }
    
    // Phương thức lấy tất cả lớp học
    public List<ClassInfo> getAllClasses() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<ClassInfo> classes = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM classes";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                ClassInfo classInfo = mapClassFromResultSet(rs);
                // Lấy thông tin gia sư và môn học
                Tutor tutor = tutorDAO.getTutorById(classInfo.getTutorId());
                Subject subject = subjectDAO.getSubjectById(classInfo.getSubjectId());
                classInfo.setTutor(tutor);
                classInfo.setSubject(subject);
                classes.add(classInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return classes;
    }
    
    // Phương thức lấy các lớp học theo gia sư
    public List<ClassInfo> getClassesByTutor(int tutorId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<ClassInfo> classes = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM classes WHERE tutor_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, tutorId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                ClassInfo classInfo = mapClassFromResultSet(rs);
                // Lấy thông tin gia sư và môn học
                Tutor tutor = tutorDAO.getTutorById(classInfo.getTutorId());
                Subject subject = subjectDAO.getSubjectById(classInfo.getSubjectId());
                classInfo.setTutor(tutor);
                classInfo.setSubject(subject);
                classes.add(classInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return classes;
    }
    
    // Phương thức lấy các lớp học theo môn học
    public List<ClassInfo> getClassesBySubject(int subjectId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<ClassInfo> classes = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM classes WHERE subject_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, subjectId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                ClassInfo classInfo = mapClassFromResultSet(rs);
                // Lấy thông tin gia sư và môn học
                Tutor tutor = tutorDAO.getTutorById(classInfo.getTutorId());
                Subject subject = subjectDAO.getSubjectById(classInfo.getSubjectId());
                classInfo.setTutor(tutor);
                classInfo.setSubject(subject);
                classes.add(classInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return classes;
    }
    
    // Phương thức lấy các lớp học có thể đăng ký (status = 'open')
    public List<ClassInfo> getOpenClasses() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<ClassInfo> classes = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM classes WHERE status = 'open'";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                ClassInfo classInfo = mapClassFromResultSet(rs);
                // Lấy thông tin gia sư và môn học
                Tutor tutor = tutorDAO.getTutorById(classInfo.getTutorId());
                Subject subject = subjectDAO.getSubjectById(classInfo.getSubjectId());
                classInfo.setTutor(tutor);
                classInfo.setSubject(subject);
                classes.add(classInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return classes;
    }
    
    // Phương thức thêm lớp học mới
    public boolean addClass(ClassInfo classInfo) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO classes (tutor_id, subject_id, class_name, description, start_date, end_date, schedule, price, max_students, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, classInfo.getTutorId());
            stmt.setInt(2, classInfo.getSubjectId());
            stmt.setString(3, classInfo.getClassName());
            stmt.setString(4, classInfo.getDescription());
            stmt.setDate(5, classInfo.getStartDate());
            stmt.setDate(6, classInfo.getEndDate());
            stmt.setString(7, classInfo.getSchedule());
            stmt.setBigDecimal(8, classInfo.getPrice());
            stmt.setInt(9, classInfo.getMaxStudents());
            stmt.setString(10, classInfo.getStatus());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
 // Phương thức cập nhật thông tin lớp học
    public boolean updateClass(ClassInfo classInfo) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            // Kiểm tra lớp học có tồn tại không
            ClassInfo existingClass = getClassById(classInfo.getClassId());
            if (existingClass == null) {
                return false;
            }
            
            // Kiểm tra quyền cập nhật
            if (existingClass.getTutorId() != classInfo.getTutorId()) {
                return false; // Không cho phép thay đổi gia sư của lớp
            }
            
            String sql = "UPDATE classes SET class_name = ?, description = ?, start_date = ?, " +
                         "end_date = ?, schedule = ?, price = ?, max_students = ?, status = ? " +
                         "WHERE class_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, classInfo.getClassName());
            stmt.setString(2, classInfo.getDescription());
            stmt.setDate(3, classInfo.getStartDate());
            stmt.setDate(4, classInfo.getEndDate());
            stmt.setString(5, classInfo.getSchedule());
            stmt.setBigDecimal(6, classInfo.getPrice());
            stmt.setInt(7, classInfo.getMaxStudents());
            stmt.setString(8, classInfo.getStatus());
            stmt.setInt(9, classInfo.getClassId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
            
            // Kiểm tra nếu số lượng học viên tối đa giảm
            if (success && classInfo.getMaxStudents() < existingClass.getMaxStudents()) {
                int currentEnrollments = new EnrollmentDAO().getEnrollmentCountByClass(classInfo.getClassId());
                
                if (currentEnrollments > classInfo.getMaxStudents()) {
                    // Nếu số lượng học viên đã vượt quá số lượng mới, chuyển trạng thái lớp thành "đầy"
                    updateClassStatus(classInfo.getClassId(), "full");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }

    // Phương thức đóng các tài nguyên
    private void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                DatabaseConnection.closeConnection(conn);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đóng tài nguyên: " + e.getMessage());
            e.printStackTrace();
        }
    }
    // Phương thức cập nhật trạng thái lớp học
    public boolean updateClassStatus(int classId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE classes SET status = ? WHERE class_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, status);
            stmt.setInt(2, classId);
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức map từ ResultSet sang ClassInfo
    private ClassInfo mapClassFromResultSet(ResultSet rs) throws SQLException {
        ClassInfo classInfo = new ClassInfo();
        classInfo.setClassId(rs.getInt("class_id"));
        classInfo.setTutorId(rs.getInt("tutor_id"));
        classInfo.setSubjectId(rs.getInt("subject_id"));
        classInfo.setClassName(rs.getString("class_name"));
        classInfo.setDescription(rs.getString("description"));
        classInfo.setStartDate(rs.getDate("start_date"));
        classInfo.setEndDate(rs.getDate("end_date"));
        classInfo.setSchedule(rs.getString("schedule"));
        classInfo.setPrice(rs.getBigDecimal("price"));
        classInfo.setMaxStudents(rs.getInt("max_students"));
        classInfo.setStatus(rs.getString("status"));
        return classInfo;
    }
    
   
}
