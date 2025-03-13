package lvd.controller.tutor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.ClassDAO;
import lvd.dao.EnrollmentDAO;
import lvd.dao.SubjectDAO;
import lvd.dao.TutorDAO;
import lvd.model.ClassInfo;
import lvd.model.Enrollment;
import lvd.model.Subject;
import lvd.model.Tutor;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 * Servlet implementation class TutorClassServlet
 */
@WebServlet("/tutor/classes")
public class TutorClassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TutorDAO tutorDAO = new TutorDAO();
    private ClassDAO classDAO = new ClassDAO();
    private SubjectDAO subjectDAO = new SubjectDAO();
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    
    public TutorClassServlet() {
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
            // Kiểm tra xem có action và classId không
            String action = request.getParameter("action");
            String classIdStr = request.getParameter("classId");
            
            if ("view".equals(action) && classIdStr != null) {
                // Xem chi tiết một lớp học
                viewClassDetail(request, response, tutor, Integer.parseInt(classIdStr));
            } else {
                // Hiển thị danh sách lớp học
                viewClasses(request, response, tutor);
            }
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
            
            if ("add".equals(action)) {
                // Thêm lớp học mới
                addClass(request, response, tutor);
            } else if ("update".equals(action)) {
                // Cập nhật thông tin lớp học
                updateClass(request, response, tutor);
            } else if ("updateStatus".equals(action)) {
                // Cập nhật trạng thái lớp học
                updateClassStatus(request, response, tutor);
            } else {
                // Chuyển hướng về trang danh sách lớp học
                response.sendRedirect(request.getContextPath() + "/tutor/classes");
            }
        } else {
            // Nếu không tìm thấy thông tin gia sư
            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin gia sư!");
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    private void viewClasses(HttpServletRequest request, HttpServletResponse response, Tutor tutor) throws ServletException, IOException {
        // Lấy danh sách lớp học của gia sư
        List<ClassInfo> classes = classDAO.getClassesByTutor(tutor.getTutorId());
        request.setAttribute("classes", classes);
        
        // Lấy danh sách môn học
        List<Subject> subjects = subjectDAO.getAllSubjects();
        request.setAttribute("subjects", subjects);
        
        // Chuyển đến trang quản lý lớp học của gia sư
        request.getRequestDispatcher("/WEB-INF/views/tutor/classes.jsp").forward(request, response);
    }
    
    private void viewClassDetail(HttpServletRequest request, HttpServletResponse response, Tutor tutor, int classId) throws ServletException, IOException {
        // Lấy thông tin lớp học
        ClassInfo classInfo = classDAO.getClassById(classId);
        
        // Kiểm tra lớp học có thuộc gia sư này không
        if (classInfo != null && classInfo.getTutorId() == tutor.getTutorId()) {
            request.setAttribute("classInfo", classInfo);
            
            // Lấy danh sách học viên đã đăng ký
            List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsByClass(classId);
            request.setAttribute("enrollments", enrollments);
            
            // Chuyển đến trang chi tiết lớp học
            request.getRequestDispatcher("/WEB-INF/views/tutor/class-detail.jsp").forward(request, response);
        } else {
            // Nếu không tìm thấy lớp học hoặc không thuộc gia sư này
            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin lớp học!");
            response.sendRedirect(request.getContextPath() + "/tutor/classes");
        }
    }
    
    private void addClass(HttpServletRequest request, HttpServletResponse response, Tutor tutor) throws IOException {
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        String className = request.getParameter("className");
        String description = request.getParameter("description");
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        String schedule = request.getParameter("schedule");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        int maxStudents = Integer.parseInt(request.getParameter("maxStudents"));
        
        // Tạo đối tượng ClassInfo
        ClassInfo classInfo = new ClassInfo();
        classInfo.setTutorId(tutor.getTutorId());
        classInfo.setSubjectId(subjectId);
        classInfo.setClassName(className);
        classInfo.setDescription(description);
        classInfo.setStartDate(startDate);
        classInfo.setEndDate(endDate);
        classInfo.setSchedule(schedule);
        classInfo.setPrice(price);
        classInfo.setMaxStudents(maxStudents);
        classInfo.setStatus("open"); // Mặc định là mở đăng ký
        
        // Thêm lớp học vào cơ sở dữ liệu
        boolean success = classDAO.addClass(classInfo);
        
        if (success) {
            AuthUtil.storeSuccessMessage(request, "Thêm lớp học thành công!");
        } else {
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi thêm lớp học!");
        }
        
        response.sendRedirect(request.getContextPath() + "/tutor/classes");
    }
    
    private void updateClass(HttpServletRequest request, HttpServletResponse response, Tutor tutor) throws IOException {
        int classId = Integer.parseInt(request.getParameter("classId"));
        String className = request.getParameter("className");
        String description = request.getParameter("description");
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        String schedule = request.getParameter("schedule");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        int maxStudents = Integer.parseInt(request.getParameter("maxStudents"));
        
        // Lấy thông tin lớp học hiện tại
        ClassInfo classInfo = classDAO.getClassById(classId);
        
        // Kiểm tra lớp học có thuộc gia sư này không
        if (classInfo != null && classInfo.getTutorId() == tutor.getTutorId()) {
            // Cập nhật thông tin
            classInfo.setClassName(className);
            classInfo.setDescription(description);
            classInfo.setStartDate(startDate);
            classInfo.setEndDate(endDate);
            classInfo.setSchedule(schedule);
            classInfo.setPrice(price);
            classInfo.setMaxStudents(maxStudents);
            
            // Cập nhật vào cơ sở dữ liệu
            boolean success = classDAO.updateClass(classInfo);
            
            if (success) {
                AuthUtil.storeSuccessMessage(request, "Cập nhật lớp học thành công!");
            } else {
                AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi cập nhật lớp học!");
            }
        } else {
            AuthUtil.storeErrorMessage(request, "Không tìm thấy lớp học hoặc bạn không có quyền cập nhật!");
        }
        
        response.sendRedirect(request.getContextPath() + "/tutor/classes");
    }
    
    private void updateClassStatus(HttpServletRequest request, HttpServletResponse response, Tutor tutor) throws IOException {
        int classId = Integer.parseInt(request.getParameter("classId"));
        String status = request.getParameter("status");
        
        // Lấy thông tin lớp học hiện tại
        ClassInfo classInfo = classDAO.getClassById(classId);
        
        // Kiểm tra lớp học có thuộc gia sư này không
        if (classInfo != null && classInfo.getTutorId() == tutor.getTutorId()) {
            // Cập nhật trạng thái lớp học
            boolean success = classDAO.updateClassStatus(classId, status);
            
            if (success) {
                AuthUtil.storeSuccessMessage(request, "Cập nhật trạng thái lớp học thành công!");
            } else {
                AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi cập nhật trạng thái lớp học!");
            }
        } else {
            AuthUtil.storeErrorMessage(request, "Không tìm thấy lớp học hoặc bạn không có quyền cập nhật!");
        }
        
        response.sendRedirect(request.getContextPath() + "/tutor/classes");
    }
}