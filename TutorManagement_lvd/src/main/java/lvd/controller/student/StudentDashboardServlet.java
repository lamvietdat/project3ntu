package lvd.controller.student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.EnrollmentDAO;
import lvd.dao.StudentDAO;
import lvd.model.Enrollment;
import lvd.model.Student;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class StudentDashboardServlet
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	    private StudentDAO studentDAO = new StudentDAO();
	    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
	    
	    public StudentDashboardServlet() {
	        super();
	    }
	    
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Kiểm tra quyền truy cập
	        if (!AuthUtil.hasPermission(request, "student")) {
	            response.sendRedirect(request.getContextPath() + "/login");
	            return;
	        }
	        
	        // Lấy thông tin học viên hiện tại
	        User currentUser = AuthUtil.getLoginedUser(request);
	        Student student = studentDAO.getStudentByUserId(currentUser.getUserId());
	        
	        if (student != null) {
	            request.setAttribute("student", student);
	            
	            // Lấy danh sách đăng ký lớp học
	            List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsByStudent(student.getStudentId());
	            request.setAttribute("enrollments", enrollments);
	            
	            // Chuyển đến trang dashboard của học viên
	            request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
	        } else {
	            // Nếu không tìm thấy thông tin học viên
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin học viên!");
	            response.sendRedirect(request.getContextPath() + "/home");
	        }
	    }

}
