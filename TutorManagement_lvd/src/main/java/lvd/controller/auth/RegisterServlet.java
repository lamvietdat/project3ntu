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
import lvd.util.PasswordUtil;

import java.io.IOException;

/**
 * Servlet xử lý đăng ký người dùng mới
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
        request.getRequestDispatcher("/views/common/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Đảm bảo xử lý tiếng Việt
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            
            // Lấy thông tin từ form
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");
            
            // Kiểm tra thông tin bắt buộc
            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                fullName == null || fullName.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {
                
                AuthUtil.storeErrorMessage(request, "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect(request.getContextPath() + "/register");
                return;
            }
            
            // Kiểm tra mật khẩu có đủ mạnh không (ít nhất 6 ký tự)
            if (password.length() < 6) {
                AuthUtil.storeErrorMessage(request, "Mật khẩu phải có ít nhất 6 ký tự!");
                response.sendRedirect(request.getContextPath() + "/register");
                return;
            }
            
            // Kiểm tra mật khẩu xác nhận
            if (!password.equals(confirmPassword)) {
                AuthUtil.storeErrorMessage(request, "Mật khẩu xác nhận không khớp!");
                response.sendRedirect(request.getContextPath() + "/register");
                return;
            }
            
            // Kiểm tra tên đăng nhập có hợp lệ không (chỉ chứa chữ cái, số và dấu gạch dưới)
            if (!username.matches("^[a-zA-Z0-9_]+$")) {
                AuthUtil.storeErrorMessage(request, "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới!");
                response.sendRedirect(request.getContextPath() + "/register");
                return;
            }
            
            // Kiểm tra email có đúng định dạng không
            if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                AuthUtil.storeErrorMessage(request, "Email không đúng định dạng!");
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
            
            // Kiểm tra vai trò hợp lệ
            if (!role.equals("student") && !role.equals("tutor")) {
                AuthUtil.storeErrorMessage(request, "Vai trò không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/register");
                return;
            }
            
            // Mã hóa mật khẩu
            String hashedPassword = PasswordUtil.hashPassword(password);
            
            // Tạo đối tượng User
            User user = new User();
            user.setUsername(username);
            user.setPassword(hashedPassword);
            user.setEmail(email);
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole(role);
            
            // Thêm người dùng vào cơ sở dữ liệu
            boolean addUserSuccess = userDAO.addUser(user);
            
            if (addUserSuccess) {
                // Lấy thông tin user vừa thêm
                User newUser = userDAO.getUserByUsername(username);
                
                if (newUser != null) {
                    boolean roleSuccess = false;
                    
                    // Nếu đăng ký là gia sư
                    if ("tutor".equals(role)) {
                        Tutor tutor = new Tutor();
                        tutor.setUserId(newUser.getUserId());
                        tutor.setStatus("active");
                        roleSuccess = tutorDAO.addTutor(tutor);
                    }
                    // Nếu đăng ký là học viên
                    else if ("student".equals(role)) {
                        Student student = new Student();
                        student.setUserId(newUser.getUserId());
                        roleSuccess = studentDAO.addStudent(student);
                    }
                    
                    if (roleSuccess) {
                        // Lưu thông báo thành công
                        AuthUtil.storeSuccessMessage(request, "Đăng ký thành công! Vui lòng đăng nhập.");
                        response.sendRedirect(request.getContextPath() + "/login");
                    } else {
                        // Xóa user vừa tạo nếu không tạo được vai trò
                        userDAO.deleteUser(newUser.getUserId());
                        AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi tạo vai trò người dùng!");
                        response.sendRedirect(request.getContextPath() + "/register");
                    }
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
        } catch (Exception e) {
            e.printStackTrace();
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/register");
        }
    }
}