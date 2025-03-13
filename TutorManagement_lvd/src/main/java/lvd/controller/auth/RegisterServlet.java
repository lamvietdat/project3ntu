package lvd.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.StudentDAO;
import lvd.dao.TutorDAO;
import lvd.dao.UserDAO;
import lvd.model.Student;
import lvd.model.Tutor;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	    private UserDAO userDAO = new UserDAO();
	    private TutorDAO tutorDAO = new TutorDAO();
	    private StudentDAO studentDAO = new StudentDAO();
	    
	    public RegisterServlet() {
	        super();
	    }
	    
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Kiểm tra nếu đã đăng nhập thì chuyển hướng về trang chủ
	        if (AuthUtil.isUserLogined(request)) {
	            response.sendRedirect(request.getContextPath() + "/home");
	            return;
	        }
	        
	        // Chuyển đến trang đăng ký
	        request.getRequestDispatcher("/WEB-INF/views/common/register.jsp").forward(request, response);
	    }
	    
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        request.setCharacterEncoding("UTF-8");
	        
	        String username = request.getParameter("username");
	        String password = request.getParameter("password");
	        String confirmPassword = request.getParameter("confirmPassword");
	        String email = request.getParameter("email");
	        String fullName = request.getParameter("fullName");
	        String phone = request.getParameter("phone");
	        String address = request.getParameter("address");
	        String role = request.getParameter("role");
	        
	        // Kiểm tra mật khẩu xác nhận
	        if (!password.equals(confirmPassword)) {
	            AuthUtil.storeErrorMessage(request, "Mật khẩu xác nhận không khớp!");
	            response.sendRedirect(request.getContextPath() + "/register");
	            return;
	        }
	        
	        // Kiểm tra username đã tồn tại chưa
	        if (userDAO.isUsernameExists(username)) {
	            AuthUtil.storeErrorMessage(request, "Tên đăng nhập đã tồn tại!");
	            response.sendRedirect(request.getContextPath() + "/register");
	            return;
	        }
	        
	        // Kiểm tra email đã tồn tại chưa
	        if (userDAO.isEmailExists(email)) {
	            AuthUtil.storeErrorMessage(request, "Email đã tồn tại!");
	            response.sendRedirect(request.getContextPath() + "/register");
	            return;
	        }
	        
	        // Tạo đối tượng User
	        User user = new User();
	        user.setUsername(username);
	        user.setPassword(password); // Trong môi trường thực tế, nên mã hóa mật khẩu
	        user.setEmail(email);
	        user.setFullName(fullName);
	        user.setPhone(phone);
	        user.setAddress(address);
	        user.setRole(role);
	        
	        // Thêm người dùng vào cơ sở dữ liệu
	        boolean addUserSuccess = userDAO.addUser(user);
	        
	        if (addUserSuccess) {
	            // Lấy thông tin user vừa thêm
	            User newUser = userDAO.authenticate(username, password);
	            
	            if (newUser != null) {
	                // Nếu đăng ký là gia sư
	                if ("tutor".equals(role)) {
	                    Tutor tutor = new Tutor();
	                    tutor.setUserId(newUser.getUserId());
	                    tutor.setStatus("active");
	                    tutorDAO.addTutor(tutor);
	                }
	                // Nếu đăng ký là học viên
	                else if ("student".equals(role)) {
	                    Student student = new Student();
	                    student.setUserId(newUser.getUserId());
	                    studentDAO.addStudent(student);
	                }
	                
	                // Lưu thông báo thành công
	                AuthUtil.storeSuccessMessage(request, "Đăng ký thành công! Vui lòng đăng nhập.");
	                response.sendRedirect(request.getContextPath() + "/login");
	            } else {
	                // Lưu thông báo lỗi và quay lại trang đăng ký
	                AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi đăng ký!");
	                response.sendRedirect(request.getContextPath() + "/register");
	            }
	        } else {
	            // Lưu thông báo lỗi và quay lại trang đăng ký
	            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi đăng ký!");
	            response.sendRedirect(request.getContextPath() + "/register");
	        }
	    }

}
