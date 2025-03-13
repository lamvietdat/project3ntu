package lvd.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.ClassDAO;
import lvd.dao.StudentDAO;
import lvd.dao.TutorDAO;
import lvd.dao.UserDAO;
import lvd.model.ClassInfo;
import lvd.model.Student;
import lvd.model.Tutor;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class AdminDashboardServlet
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    private TutorDAO tutorDAO = new TutorDAO();
    private StudentDAO studentDAO = new StudentDAO();
    private ClassDAO classDAO = new ClassDAO();
    
    public AdminDashboardServlet() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra quyền truy cập
        if (!AuthUtil.hasPermission(request, "admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy số lượng người dùng
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("totalUsers", users.size());
        
        // Lấy số lượng gia sư
        List<Tutor> tutors = tutorDAO.getAllTutors();
        request.setAttribute("totalTutors", tutors.size());
        
        // Lấy số lượng học viên
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("totalStudents", students.size());
        
        // Lấy số lượng lớp học
        List<ClassInfo> classes = classDAO.getAllClasses();
        request.setAttribute("totalClasses", classes.size());
        
        // Chuyển đến trang dashboard của admin
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

}
