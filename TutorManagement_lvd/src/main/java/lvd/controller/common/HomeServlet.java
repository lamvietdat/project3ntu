package lvd.controller.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.ClassDAO;
import lvd.dao.SubjectDAO;
import lvd.dao.TutorDAO;
import lvd.model.ClassInfo;
import lvd.model.Subject;
import lvd.model.Tutor;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet({"/home", ""})
public class HomeServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	    private ClassDAO classDAO = new ClassDAO();
	    private TutorDAO tutorDAO = new TutorDAO();
	    private SubjectDAO subjectDAO = new SubjectDAO();
	    
	    public HomeServlet() {
	        super();
	    }
	    
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Lấy danh sách lớp học đang mở đăng ký
	        List<ClassInfo> openClasses = classDAO.getOpenClasses();
	        request.setAttribute("openClasses", openClasses);
	        
	        // Lấy danh sách gia sư
	        List<Tutor> tutors = tutorDAO.getAllTutors();
	        request.setAttribute("tutors", tutors);
	        
	        // Lấy danh sách môn học
	        List<Subject> subjects = subjectDAO.getAllSubjects();
	        request.setAttribute("subjects", subjects);
	        
	        // Chuyển đến trang chủ
	        request.getRequestDispatcher("/WEB-INF/views/common/home.jsp").forward(request, response);
	    }
}
