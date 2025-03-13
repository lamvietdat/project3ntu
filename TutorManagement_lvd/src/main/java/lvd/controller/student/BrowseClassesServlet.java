package lvd.controller.student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.ClassDAO;
import lvd.dao.EnrollmentDAO;
import lvd.dao.StudentDAO;
import lvd.dao.SubjectDAO;
import lvd.model.ClassInfo;
import lvd.model.Student;
import lvd.model.Subject;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class BrowseClassesServlet
 */
@WebServlet("/student/browse-classes")
public class BrowseClassesServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	    private ClassDAO classDAO = new ClassDAO();
	    private SubjectDAO subjectDAO = new SubjectDAO();
	    private StudentDAO studentDAO = new StudentDAO();
	    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
	    
	    public BrowseClassesServlet() {
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
	            // Kiểm tra xem có action và classId không
	            String action = request.getParameter("action");
	            String classIdStr = request.getParameter("classId");
	            
	            if ("view".equals(action) && classIdStr != null) {
	                // Xem chi tiết một lớp học
	                viewClassDetail(request, response, student, Integer.parseInt(classIdStr));
	            } else {
	                // Lọc theo subject nếu có
	                String subjectIdStr = request.getParameter("subjectId");
	                
	                List<ClassInfo> classes;
	                if (subjectIdStr != null && !subjectIdStr.isEmpty()) {
	                    int subjectId = Integer.parseInt(subjectIdStr);
	                    classes = classDAO.getClassesBySubject(subjectId);
	                } else {
	                    // Lấy danh sách lớp học đang mở
	                    classes = classDAO.getOpenClasses();
	                }
	                
	                request.setAttribute("classes", classes);
	                
	                // Lấy danh sách môn học
	                List<Subject> subjects = subjectDAO.getAllSubjects();
	                request.setAttribute("subjects", subjects);
	                
	                // Chuyển đến trang tìm kiếm lớp học
	                request.getRequestDispatcher("/WEB-INF/views/student/browse-classes.jsp").forward(request, response);
	            }
	        } else {
	            // Nếu không tìm thấy thông tin học viên
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin học viên!");
	            response.sendRedirect(request.getContextPath() + "/home");
	        }
	    }
	    
	    private void viewClassDetail(HttpServletRequest request, HttpServletResponse response, Student student, int classId) throws ServletException, IOException {
	        // Lấy thông tin lớp học
	        ClassInfo classInfo = classDAO.getClassById(classId);
	        
	        if (classInfo != null) {
	            request.setAttribute("classInfo", classInfo);
	            
	            // Kiểm tra học viên đã đăng ký lớp này chưa
	            boolean isEnrolled = enrollmentDAO.isStudentEnrolledInClass(student.getStudentId(), classId);
	            request.setAttribute("isEnrolled", isEnrolled);
	            
	            // Chuyển đến trang chi tiết lớp học
	            request.getRequestDispatcher("/WEB-INF/views/student/class-detail.jsp").forward(request, response);
	        } else {
	            // Nếu không tìm thấy lớp học
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin lớp học!");
	            response.sendRedirect(request.getContextPath() + "/student/browse-classes");
	        }
	    }

}
