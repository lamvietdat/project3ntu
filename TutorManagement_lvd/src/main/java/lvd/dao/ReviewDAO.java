
package lvd.dao;

import lvd.database.DatabaseConnection;
import lvd.model.ClassInfo;
import lvd.model.Review;
import lvd.model.Student;
import lvd.model.Tutor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    private StudentDAO studentDAO = new StudentDAO();
    private TutorDAO tutorDAO = new TutorDAO();
    private ClassDAO classDAO = new ClassDAO();
    
    // Phương thức lấy đánh giá theo ID
    public Review getReviewById(int reviewId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Review review = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM reviews WHERE review_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, reviewId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                review = mapReviewFromResultSet(rs);
                // Lấy thông tin học viên, gia sư và lớp học
                Student student = studentDAO.getStudentById(review.getStudentId());
                Tutor tutor = tutorDAO.getTutorById(review.getTutorId());
                ClassInfo classInfo = classDAO.getClassById(review.getClassId());
                review.setStudent(student);
                review.setTutor(tutor);
                review.setClassInfo(classInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return review;
    }
    
    // Phương thức lấy các đánh giá theo gia sư
    public List<Review> getReviewsByTutor(int tutorId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Review> reviews = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM reviews WHERE tutor_id = ? ORDER BY created_at DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, tutorId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Review review = mapReviewFromResultSet(rs);
                // Lấy thông tin học viên, gia sư và lớp học
                Student student = studentDAO.getStudentById(review.getStudentId());
                Tutor tutor = tutorDAO.getTutorById(review.getTutorId());
                ClassInfo classInfo = classDAO.getClassById(review.getClassId());
                review.setStudent(student);
                review.setTutor(tutor);
                review.setClassInfo(classInfo);
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return reviews;
    }
    
    // Phương thức lấy các đánh giá theo lớp học
    public List<Review> getReviewsByClass(int classId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Review> reviews = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM reviews WHERE class_id = ? ORDER BY created_at DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, classId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Review review = mapReviewFromResultSet(rs);
                // Lấy thông tin học viên, gia sư và lớp học
                Student student = studentDAO.getStudentById(review.getStudentId());
                Tutor tutor = tutorDAO.getTutorById(review.getTutorId());
                ClassInfo classInfo = classDAO.getClassById(review.getClassId());
                review.setStudent(student);
                review.setTutor(tutor);
                review.setClassInfo(classInfo);
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return reviews;
    }
    
    // Phương thức lấy đánh giá trung bình của gia sư
    public double getAverageRatingByTutor(int tutorId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        double avgRating = 0.0;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT AVG(rating) FROM reviews WHERE tutor_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, tutorId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                avgRating = rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return avgRating;
    }
    
    // Phương thức thêm đánh giá mới
    public boolean addReview(Review review) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO reviews (student_id, tutor_id, class_id, rating, comment) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, review.getStudentId());
            stmt.setInt(2, review.getTutorId());
            stmt.setInt(3, review.getClassId());
            stmt.setInt(4, review.getRating());
            stmt.setString(5, review.getComment());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức cập nhật đánh giá
    public boolean updateReview(Review review) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE reviews SET rating = ?, comment = ? WHERE review_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getComment());
            stmt.setInt(3, review.getReviewId());
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức xóa đánh giá
    public boolean deleteReview(int reviewId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM reviews WHERE review_id = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, reviewId);
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Phương thức map từ ResultSet sang Review
    private Review mapReviewFromResultSet(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setReviewId(rs.getInt("review_id"));
        review.setStudentId(rs.getInt("student_id"));
        review.setTutorId(rs.getInt("tutor_id"));
        review.setClassId(rs.getInt("class_id"));
        review.setRating(rs.getInt("rating"));
        review.setComment(rs.getString("comment"));
        review.setCreatedAt(rs.getTimestamp("created_at"));
        return review;
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