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
import java.util.List;

/**
 * Servlet implementation class TutorEnrollmentsServlet
 */
@WebServlet("/tutor/enrollments")
public class TutorEnrollmentsServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	    private TutorDAO tutorDAO = new TutorDAO();
	    private ClassDAO classDAO = new ClassDAO();
	    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
	    
	    public TutorEnrollmentsServlet() {
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
	            
	            // Lấy danh sách đăng ký đang chờ duyệt
	            List<Enrollment> pendingEnrollments = getPendingEnrollmentsForTutor(tutor.getTutorId());
	            request.setAttribute("pendingEnrollments", pendingEnrollments);
	            
	            // Lấy tất cả đăng ký của học viên vào lớp của gia sư
	            List<Enrollment> allEnrollments = getAllEnrollmentsForTutor(tutor.getTutorId());
	            request.setAttribute("allEnrollments", allEnrollments);
	            
	            request.getRequestDispatcher("/WEB-INF/views/tutor/enrollments.jsp").forward(request, response);
	        } else {
	            // Nếu không tìm thấy thông tin gia sư
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin gia sư!");
	            response.sendRedirect(request.getContextPath() + "/home");
	        }
	    }
	    
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        request.setCharacterEncoding("UTF-8");
	        
	        // Kiểm tra quyền truy cập
	        if (!AuthUtil.hasPermission(request, "tutor")) {
	            response.sendRedirect(request.getContextPath() + "/login");
	            return;
	        }
	        
	        // Lấy thông tin gia sư hiện tại
	        User currentUser = AuthUtil.getLoginedUser(request);
	        Tutor tutor = tutorDAO.getTutorByUserId(currentUser.getUserId());
	        
	        if (tutor != null) {
	            String action = request.getParameter("action");
	            int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
	            int classId = Integer.parseInt(request.getParameter("classId"));
	            
	            // Kiểm tra lớp học có thuộc về gia sư này không
	            ClassInfo classInfo = classDAO.getClassById(classId);
	            if (classInfo == null || classInfo.getTutorId() != tutor.getTutorId()) {
	                AuthUtil.storeErrorMessage(request, "Bạn không có quyền quản lý lớp học này!");
	                response.sendRedirect(request.getContextPath() + "/tutor/classes");
	                return;
	            }
	            
	            if ("approve".equals(action)) {
	                // Duyệt đăng ký
	                approveEnrollment(request, response, enrollmentId, classId);
	            } else if ("reject".equals(action)) {
	                // Từ chối đăng ký
	                rejectEnrollment(request, response, enrollmentId, classId);
	            } else if ("complete".equals(action)) {
	                // Hoàn thành đăng ký
	                completeEnrollment(request, response, enrollmentId, classId);
	            } else {
	                // Chuyển hướng về trang lớp học
	                response.sendRedirect(request.getContextPath() + "/tutor/classes?action=view&classId=" + classId);
	            }
	        } else {
	            // Nếu không tìm thấy thông tin gia sư
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin gia sư!");
	            response.sendRedirect(request.getContextPath() + "/home");
	        }
	    }
	    
	    // Lấy danh sách đăng ký đang chờ duyệt của gia sư
	    private List<Enrollment> getPendingEnrollmentsForTutor(int tutorId) {
	        List<Enrollment> pendingEnrollments = enrollmentDAO.getEnrollmentsByStatus("pending");
	        pendingEnrollments.removeIf(enrollment -> 
	            enrollment.getClassInfo().getTutorId() != tutorId
	        );
	        return pendingEnrollments;
	    }
	    
	    // Lấy tất cả đăng ký của học viên vào lớp của gia sư
	    private List<Enrollment> getAllEnrollmentsForTutor(int tutorId) {
	        List<Enrollment> allEnrollments = enrollmentDAO.getAllEnrollments();
	        allEnrollments.removeIf(enrollment -> 
	            enrollment.getClassInfo().getTutorId() != tutorId
	        );
	        return allEnrollments;
	    }
	    
	    // Duyệt đăng ký
	    private void approveEnrollment(HttpServletRequest request, HttpServletResponse response, int enrollmentId, int classId) throws IOException {
	        // Kiểm tra số lượng học viên đã đăng ký
	        ClassInfo classInfo = classDAO.getClassById(classId);
	        int enrolledCount = enrollmentDAO.getEnrollmentCountByClass(classId);
	        
	        if (enrolledCount >= classInfo.getMaxStudents()) {
	            AuthUtil.storeErrorMessage(request, "Lớp học đã đủ số lượng học viên tối đa!");
	            response.sendRedirect(request.getContextPath() + "/tutor/classes?action=view&classId=" + classId);
	            return;
	        }
	        
	        // Cập nhật trạng thái đăng ký sang "approved"
	        boolean success = enrollmentDAO.updateEnrollmentStatus(enrollmentId, "approved");
	        
	        if (success) {
	            // Kiểm tra nếu lớp học đầy sau khi duyệt
	            if (enrolledCount + 1 >= classInfo.getMaxStudents()) {
	                classDAO.updateClassStatus(classId, "full");
	            }
	            
	            AuthUtil.storeSuccessMessage(request, "Đã duyệt đăng ký thành công!");
	        } else {
	            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi duyệt đăng ký!");
	        }
	        
	        response.sendRedirect(request.getContextPath() + "/tutor/classes?action=view&classId=" + classId);
	    }
	    
	    // Từ chối đăng ký
	    private void rejectEnrollment(HttpServletRequest request, HttpServletResponse response, int enrollmentId, int classId) throws IOException {
	        // Cập nhật trạng thái đăng ký sang "rejected"
	        boolean success = enrollmentDAO.updateEnrollmentStatus(enrollmentId, "rejected");
	        
	        if (success) {
	            AuthUtil.storeSuccessMessage(request, "Đã từ chối đăng ký thành công!");
	        } else {
	            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi từ chối đăng ký!");
	        }
	        
	        response.sendRedirect(request.getContextPath() + "/tutor/classes?action=view&classId=" + classId);
	    }
	    
	    // Hoàn thành đăng ký
	    private void completeEnrollment(HttpServletRequest request, HttpServletResponse response, int enrollmentId, int classId) throws IOException {
	        // Kiểm tra trạng thái đăng ký có phải là "approved" không
	        Enrollment enrollment = enrollmentDAO.getEnrollmentById(enrollmentId);
	        
	        if (enrollment == null || !"approved".equals(enrollment.getStatus())) {
	            AuthUtil.storeErrorMessage(request, "Không thể hoàn thành đăng ký này!");
	            response.sendRedirect(request.getContextPath() + "/tutor/classes?action=view&classId=" + classId);
	            return;
	        }
	        
	        // Cập nhật trạng thái đăng ký sang "completed"
	        boolean success = enrollmentDAO.updateEnrollmentStatus(enrollmentId, "completed");
	        
	        if (success) {
	            AuthUtil.storeSuccessMessage(request, "Đã cập nhật trạng thái học viên thành hoàn thành!");
	        } else {
	            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi cập nhật trạng thái học viên!");
	        }
	        
	        response.sendRedirect(request.getContextPath() + "/tutor/classes?action=view&classId=" + classId);
	    }
}
