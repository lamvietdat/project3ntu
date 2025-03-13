package lvd.controller.tutor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.ClassDAO;
import lvd.dao.EnrollmentDAO;
import lvd.dao.ReviewDAO;
import lvd.dao.TutorDAO;
import lvd.model.ClassInfo;
import lvd.model.Review;
import lvd.model.Tutor;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class TutorDashboardServlet
 */
@WebServlet("/tutor/dashboard")
public class TutorDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TutorDAO tutorDAO = new TutorDAO();
    private ClassDAO classDAO = new ClassDAO();
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private ReviewDAO reviewDAO = new ReviewDAO();
    
    public TutorDashboardServlet() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra quyền truy cập
        if (!AuthUtil.hasPermission(request, "tutor")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy thông tin gia sư hiện tại
        User currentUser = AuthUtil.getLoginedUser(request);
        Tutor tutor = tutorDAO.getTutorByUserId(currentUser.getUserId());
        
        if (tutor != null) {
            // Lấy danh sách lớp học của gia sư
            List<ClassInfo> classes = classDAO.getClassesByTutor(tutor.getTutorId());
            request.setAttribute("classes", classes);
            
            // Tính số lượng học viên
            int totalStudents = 0;
            for (ClassInfo classInfo : classes) {
                totalStudents += enrollmentDAO.getEnrollmentCountByClass(classInfo.getClassId());
            }
            request.setAttribute("totalStudents", totalStudents);
            
            // Lấy đánh giá trung bình
            double avgRating = reviewDAO.getAverageRatingByTutor(tutor.getTutorId());
            request.setAttribute("avgRating", avgRating);
            
            // Lấy các đánh giá gần đây
            List<Review> reviews = reviewDAO.getReviewsByTutor(tutor.getTutorId());
            request.setAttribute("reviews", reviews);
            
            // Chuyển đến trang dashboard của gia sư
            request.getRequestDispatcher("/WEB-INF/views/tutor/dashboard.jsp").forward(request, response);
        } else {
            // Nếu không tìm thấy thông tin gia sư
            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin gia sư!");
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
