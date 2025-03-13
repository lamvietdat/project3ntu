package lvd.controller.student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.ClassDAO;
import lvd.dao.EnrollmentDAO;
import lvd.dao.PaymentDAO;
import lvd.dao.StudentDAO;
import lvd.model.ClassInfo;
import lvd.model.Enrollment;
import lvd.model.Payment;
import lvd.model.Student;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class EnrollmentServlet
 */
@WebServlet("/student/enrollments")
public class EnrollmentServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	    private StudentDAO studentDAO = new StudentDAO();
	    private ClassDAO classDAO = new ClassDAO();
	    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
	    private PaymentDAO paymentDAO = new PaymentDAO();
	    
	    public EnrollmentServlet() {
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
	            // Kiểm tra xem có action và enrollmentId không
	            String action = request.getParameter("action");
	            String enrollmentIdStr = request.getParameter("enrollmentId");
	            
	            if ("view".equals(action) && enrollmentIdStr != null) {
	                // Xem chi tiết một đăng ký
	                viewEnrollmentDetail(request, response, student, Integer.parseInt(enrollmentIdStr));
	            } else {
	                // Hiển thị danh sách đăng ký
	                List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsByStudent(student.getStudentId());
	                request.setAttribute("enrollments", enrollments);
	                
	                // Chuyển đến trang danh sách đăng ký
	                request.getRequestDispatcher("/WEB-INF/views/student/my-enrollments.jsp").forward(request, response);
	            }
	        } else {
	            // Nếu không tìm thấy thông tin học viên
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin học viên!");
	            response.sendRedirect(request.getContextPath() + "/home");
	        }
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
	            String action = request.getParameter("action");
	            
	            if ("enroll".equals(action)) {
	                // Đăng ký lớp học
	                enrollClass(request, response, student);
	            } else if ("pay".equals(action)) {
	                // Thanh toán học phí
	                payTuition(request, response, student);
	            } else {
	                // Chuyển hướng về trang danh sách đăng ký
	                response.sendRedirect(request.getContextPath() + "/student/enrollments");
	            }
	        } else {
	            // Nếu không tìm thấy thông tin học viên
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin học viên!");
	            response.sendRedirect(request.getContextPath() + "/home");
	        }
	    }
	    
	    private void viewEnrollmentDetail(HttpServletRequest request, HttpServletResponse response, Student student, int enrollmentId) throws ServletException, IOException {
	        // Lấy thông tin đăng ký
	        Enrollment enrollment = enrollmentDAO.getEnrollmentById(enrollmentId);
	        
	        // Kiểm tra đăng ký có thuộc về học viên này không
	        if (enrollment != null && enrollment.getStudentId() == student.getStudentId()) {
	            request.setAttribute("enrollment", enrollment);
	            
	            // Lấy các thanh toán của đăng ký này
	            List<Payment> payments = paymentDAO.getPaymentsByEnrollment(enrollmentId);
	            request.setAttribute("payments", payments);
	            
	            // Chuyển đến trang chi tiết đăng ký
	            request.getRequestDispatcher("/WEB-INF/views/student/enrollment-detail.jsp").forward(request, response);
	        } else {
	            // Nếu không tìm thấy đăng ký hoặc không thuộc về học viên này
	            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin đăng ký!");
	            response.sendRedirect(request.getContextPath() + "/student/enrollments");
	        }
	    }
	    
	    private void enrollClass(HttpServletRequest request, HttpServletResponse response, Student student) throws IOException {
	        int classId = Integer.parseInt(request.getParameter("classId"));
	        
	        // Kiểm tra lớp học có tồn tại và đang mở không
	        ClassInfo classInfo = classDAO.getClassById(classId);
	        if (classInfo == null || !"open".equals(classInfo.getStatus())) {
	            AuthUtil.storeErrorMessage(request, "Lớp học không tồn tại hoặc không mở đăng ký!");
	            response.sendRedirect(request.getContextPath() + "/student/browse-classes");
	            return;
	        }
	        
	        // Kiểm tra học viên đã đăng ký lớp này chưa
	        if (enrollmentDAO.isStudentEnrolledInClass(student.getStudentId(), classId)) {
	            AuthUtil.storeErrorMessage(request, "Bạn đã đăng ký lớp học này rồi!");
	            response.sendRedirect(request.getContextPath() + "/student/browse-classes?action=view&classId=" + classId);
	            return;
	        }
	        
	        // Kiểm tra số lượng học viên đã đăng ký
	        int enrolledStudents = enrollmentDAO.getEnrollmentCountByClass(classId);
	        if (enrolledStudents >= classInfo.getMaxStudents()) {
	            AuthUtil.storeErrorMessage(request, "Lớp học đã đủ số lượng học viên!");
	            response.sendRedirect(request.getContextPath() + "/student/browse-classes?action=view&classId=" + classId);
	            return;
	        }
	        
	        // Tạo đối tượng Enrollment
	        Enrollment enrollment = new Enrollment();
	        enrollment.setStudentId(student.getStudentId());
	        enrollment.setClassId(classId);
	        enrollment.setStatus("pending"); // Mặc định là chờ duyệt
	        
	        // Thêm đăng ký vào cơ sở dữ liệu
	        boolean success = enrollmentDAO.addEnrollment(enrollment);
	        
	        if (success) {
	            AuthUtil.storeSuccessMessage(request, "Đăng ký lớp học thành công! Vui lòng đợi xác nhận từ gia sư.");
	            response.sendRedirect(request.getContextPath() + "/student/enrollments");
	        } else {
	            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi đăng ký lớp học!");
	            response.sendRedirect(request.getContextPath() + "/student/browse-classes?action=view&classId=" + classId);
	        }
	    }
	    
	    private void payTuition(HttpServletRequest request, HttpServletResponse response, Student student) throws IOException {
	        int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
	        String paymentMethod = request.getParameter("paymentMethod");
	        
	        // Lấy thông tin đăng ký
	        Enrollment enrollment = enrollmentDAO.getEnrollmentById(enrollmentId);
	        
	        // Kiểm tra đăng ký có thuộc về học viên này không và trạng thái có phải là approved không
	        if (enrollment != null && enrollment.getStudentId() == student.getStudentId() && "approved".equals(enrollment.getStatus())) {
	            // Lấy thông tin lớp học để biết học phí
	            ClassInfo classInfo = enrollment.getClassInfo();
	            
	            // Tạo mã giao dịch ngẫu nhiên
	            String transactionId = "TRX" + System.currentTimeMillis();
	            
	            // Tạo đối tượng Payment
	            Payment payment = new Payment();
	            payment.setEnrollmentId(enrollmentId);
	            payment.setAmount(classInfo.getPrice());
	            payment.setPaymentMethod(paymentMethod);
	            payment.setStatus("completed"); // Giả sử thanh toán thành công ngay
	            payment.setTransactionId(transactionId);
	            
	            // Thêm thanh toán vào cơ sở dữ liệu
	            boolean success = paymentDAO.addPayment(payment);
	            
	            if (success) {
	                // Cập nhật trạng thái đăng ký thành completed
	                enrollmentDAO.updateEnrollmentStatus(enrollmentId, "completed");
	                
	                AuthUtil.storeSuccessMessage(request, "Thanh toán học phí thành công!");
	            } else {
	                AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi thanh toán học phí!");
	            }
	            
	            response.sendRedirect(request.getContextPath() + "/student/enrollments?action=view&enrollmentId=" + enrollmentId);
	        } else {
	            // Nếu không tìm thấy đăng ký hoặc không thuộc về học viên này hoặc chưa được duyệt
	            AuthUtil.storeErrorMessage(request, "Không thể thanh toán cho đăng ký này!");
	            response.sendRedirect(request.getContextPath() + "/student/enrollments");
	        }
	    }
}
