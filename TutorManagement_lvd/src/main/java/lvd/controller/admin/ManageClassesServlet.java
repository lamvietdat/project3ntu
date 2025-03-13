package lvd.controller.admin;

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
import lvd.util.AuthUtil;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 * Servlet implementation class ManageClassesServlet
 */
@WebServlet("/admin/classes")
public class ManageClassesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ClassDAO classDAO = new ClassDAO();
    private TutorDAO tutorDAO = new TutorDAO();
    private SubjectDAO subjectDAO = new SubjectDAO();
    
    public ManageClassesServlet() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra quyền truy cập
        if (!AuthUtil.hasPermission(request, "admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy danh sách lớp học
        List<ClassInfo> classes = classDAO.getAllClasses();
        request.setAttribute("classes", classes);
        
        // Lấy danh sách gia sư
        List<Tutor> tutors = tutorDAO.getAllTutors();
        request.setAttribute("tutors", tutors);
        
        // Lấy danh sách môn học
        List<Subject> subjects = subjectDAO.getAllSubjects();
        request.setAttribute("subjects", subjects);
        
        // Chuyển đến trang quản lý lớp học
        request.getRequestDispatcher("/WEB-INF/views/admin/classes.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Kiểm tra quyền truy cập
        if (!AuthUtil.hasPermission(request, "admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            // Thêm lớp học mới
            addClass(request, response);
        } else if ("update".equals(action)) {
            // Cập nhật thông tin lớp học
            updateClass(request, response);
        } else if ("updateStatus".equals(action)) {
            // Cập nhật trạng thái lớp học
            updateClassStatus(request, response);
        } else {
            // Chuyển hướng về trang quản lý lớp học
            response.sendRedirect(request.getContextPath() + "/admin/classes");
        }
    }
    
    private void addClass(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int tutorId = Integer.parseInt(request.getParameter("tutorId"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        String className = request.getParameter("className");
        String description = request.getParameter("description");
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        String schedule = request.getParameter("schedule");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        int maxStudents = Integer.parseInt(request.getParameter("maxStudents"));
        String status = request.getParameter("status");
        
        // Tạo đối tượng ClassInfo
        ClassInfo classInfo = new ClassInfo();
        classInfo.setTutorId(tutorId);
        classInfo.setSubjectId(subjectId);
        classInfo.setClassName(className);
        classInfo.setDescription(description);
        classInfo.setStartDate(startDate);
        classInfo.setEndDate(endDate);
        classInfo.setSchedule(schedule);
        classInfo.setPrice(price);
        classInfo.setMaxStudents(maxStudents);
        classInfo.setStatus(status);
        
        // Thêm lớp học vào cơ sở dữ liệu
        boolean success = classDAO.addClass(classInfo);
        
        if (success) {
            AuthUtil.storeSuccessMessage(request, "Thêm lớp học thành công!");
        } else {
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi thêm lớp học!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/classes");
    }
    
    private void updateClass(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int classId = Integer.parseInt(request.getParameter("classId"));
        String className = request.getParameter("className");
        String description = request.getParameter("description");
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        String schedule = request.getParameter("schedule");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        int maxStudents = Integer.parseInt(request.getParameter("maxStudents"));
        String status = request.getParameter("status");
        
        // Lấy thông tin lớp học hiện tại
        ClassInfo classInfo = classDAO.getClassById(classId);
        
        if (classInfo != null) {
            // Cập nhật thông tin
            classInfo.setClassName(className);
            classInfo.setDescription(description);
            classInfo.setStartDate(startDate);
            classInfo.setEndDate(endDate);
            classInfo.setSchedule(schedule);
            classInfo.setPrice(price);
            classInfo.setMaxStudents(maxStudents);
            classInfo.setStatus(status);
            
            // Cập nhật vào cơ sở dữ liệu
            boolean success = classDAO.updateClass(classInfo);
            
            if (success) {
                AuthUtil.storeSuccessMessage(request, "Cập nhật lớp học thành công!");
            } else {
                AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi cập nhật lớp học!");
            }
        } else {
            AuthUtil.storeErrorMessage(request, "Không tìm thấy lớp học!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/classes");
    }
    
    private void updateClassStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int classId = Integer.parseInt(request.getParameter("classId"));
        String status = request.getParameter("status");
        
        // Cập nhật trạng thái lớp học
        boolean success = classDAO.updateClassStatus(classId, status);
        
        if (success) {
            AuthUtil.storeSuccessMessage(request, "Cập nhật trạng thái lớp học thành công!");
        } else {
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi cập nhật trạng thái lớp học!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/classes");
    }
}
