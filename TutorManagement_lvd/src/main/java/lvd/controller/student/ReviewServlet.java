package lvd.controller.student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.EnrollmentDAO;
import lvd.dao.ReviewDAO;
import lvd.dao.StudentDAO;
import lvd.model.Enrollment;
import lvd.model.Review;
import lvd.model.Student;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;

/**
 * Servlet implementation class ReviewServlet
 */
@WebServlet("/student/review")
public class ReviewServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	    private StudentDAO studentDAO = new StudentDAO();
	    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
	    private ReviewDAO reviewDAO = new ReviewDAO();
	    
	    public ReviewServlet() {
	        super();
	    }
	    
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        request.setCharacterEncoding("UTF-8");
	        
	        // Kiểm tra quyền truy cập
	        if (!AuthUtil.hasPermission(request, "student")) {
	            response.sendRedirect(request.getContextPath() + "/login");
	            return;
	        }
	        
	        // Lấy thông tin học viên hiện tại
	        User currentUser = AuthUtil.getLoginedUser(request);
	        Student student = studentDAO.getStudentByUserId(currentUser.getUserId());
	        
	        if (student != null) {
	            int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
	            int rating = Integer.parseInt(request.getParameter("rating"));
	            String comment = request.getParameter("comment");
	            
	            // Lấy thông tin đăng ký
	            Enrollment enrollment = enrollmentDAO.getEnrollmentById(enrollmentId);
	            
	            // Kiểm tra đăng ký có thuộc về học viên này không và đã hoàn thành chưa
	            if (enrollment != null && enrollment.getStudentId() == student.getStudentId() && "completed".equals(enrollment.getStatus())) {
	                // Tạo đối tượng Review
	                Review review = new Review();
	                review.setStudentId(student.getStudentId());
	                review.setTutorId(enrollment.getClassInfo().getTutorId());
	                review.setClassId(enrollment.getClassId());
	                review.setRating(rating);
	                review.setComment(comment);
	                
	                // Thêm đánh giá vào cơ sở dữ liệu
	                boolean success = reviewDAO.addReview(review);
	                
	                if (success) {
	                    AuthUtil.storeSuccessMessage(request, "Đánh giá đã được gửi thành công!");
	                } else {
	                    AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi gửi đánh giá!");
	                }
	                
	                response.sendRedirect(request.getContextPath() + "/student/enrollments?action=view&enrollmentId=" + enrollmentId);
	            } else {
	                // Nếu không thỏa điều kiện
	                AuthUtil.storeErrorMessage(request, "Không thể đánh giá cho đăng ký này!");
	                response.sendRedirect(request.getContextPath() + "/student/enrollments");
	            }
	        } else {
	            // Nếu không tìm thấy thông tin học viên
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin học viên!");
	            response.sendRedirect(request.getContextPath() + "/home");
	        }
	    }
}
