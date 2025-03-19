package lvd.controller.tutor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.ClassDAO;
import lvd.dao.EnrollmentDAO;
import lvd.dao.TutorDAO;
import lvd.model.ClassInfo;
import lvd.model.Enrollment;
import lvd.model.Tutor;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class TutorClassDashboardServlet
 */
@WebServlet("/tutor/class-dashboard")
public class TutorClassDashboardServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	    private TutorDAO tutorDAO = new TutorDAO();
	    private ClassDAO classDAO = new ClassDAO();
	    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
	    
	    public TutorClassDashboardServlet() {
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
	            try {
	                // Lấy danh sách lớp học của gia sư
	                List<ClassInfo> classes = classDAO.getClassesByTutor(tutor.getTutorId());
	                request.setAttribute("classes", classes);
	                
	                // Tính toán các thông tin thống kê
	                int totalClasses = classes.size();
	                int openClasses = 0;
	                int inProgressClasses = 0;
	                int completedClasses = 0;
	                int cancelledClasses = 0;
	                int totalStudents = 0;
	                
	                // Tạo map để lưu số lượng học viên cho mỗi lớp
	                Map<Integer, Integer> enrollmentCounts = new HashMap<>();
	                
	                for (ClassInfo classInfo : classes) {
	                    // Đếm theo trạng thái lớp học
	                    switch (classInfo.getStatus()) {
	                        case "open":
	                            openClasses++;
	                            break;
	                        case "in_progress":
	                            inProgressClasses++;
	                            break;
	                        case "completed":
	                            completedClasses++;
	                            break;
	                        case "cancelled":
	                            cancelledClasses++;
	                            break;
	                    }
	                    
	                    // Đếm số lượng học viên trong lớp
	                    int studentCount = enrollmentDAO.getEnrollmentCountByClass(classInfo.getClassId());
	                    enrollmentCounts.put(classInfo.getClassId(), studentCount);
	                    totalStudents += studentCount;
	                }
	                
	                // Lưu vào request attribute
	                request.setAttribute("totalClasses", totalClasses);
	                request.setAttribute("openClasses", openClasses);
	                request.setAttribute("inProgressClasses", inProgressClasses);
	                request.setAttribute("completedClasses", completedClasses);
	                request.setAttribute("cancelledClasses", cancelledClasses);
	                request.setAttribute("totalStudents", totalStudents);
	                request.setAttribute("enrollmentCounts", enrollmentCounts);
	                
	                // Lấy số lượng yêu cầu đăng ký đang chờ duyệt
	                int pendingEnrollments = getPendingEnrollmentsCount(tutor.getTutorId());
	                request.setAttribute("pendingEnrollments", pendingEnrollments);
	                
	                // Chuyển đến trang dashboard
	                request.getRequestDispatcher("/WEB-INF/views/tutor/class-dashboard.jsp").forward(request, response);
	            } catch (Exception e) {
	                e.printStackTrace();
	                AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi tải dữ liệu: " + e.getMessage());
	                response.sendRedirect(request.getContextPath() + "/tutor/dashboard");
	            }
	        } else {
	            // Nếu không tìm thấy thông tin gia sư
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin gia sư!");
	            response.sendRedirect(request.getContextPath() + "/home");
	        }
	    }
	    
	    // Đếm số lượng yêu cầu đăng ký đang chờ duyệt
	    private int getPendingEnrollmentsCount(int tutorId) {
	        int count = 0;
	        List<ClassInfo> classes = classDAO.getClassesByTutor(tutorId);
	        
	        for (ClassInfo classInfo : classes) {
	            List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsByClass(classInfo.getClassId());
	            for (Enrollment enrollment : enrollments) {
	                if ("pending".equals(enrollment.getStatus())) {
	                    count++;
	                }
	            }
	        }
	        
	        return count;
	    }
	    
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        doGet(request, response);
	    }
}
