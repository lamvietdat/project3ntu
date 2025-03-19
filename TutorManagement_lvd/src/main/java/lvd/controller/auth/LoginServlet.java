package lvd.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lvd.dao.UserDAO;
import lvd.model.User;
import lvd.util.AuthUtil;
import lvd.util.PasswordUtil;

import java.io.IOException;
import java.util.UUID;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    
    public LoginServlet() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra nếu đã đăng nhập thì chuyển hướng về trang chủ
        if (AuthUtil.isUserLogined(request)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Tạo CSRF token mới cho form đăng nhập
        String csrfToken = UUID.randomUUID().toString();
        HttpSession session = request.getSession();
        session.setAttribute("csrfToken", csrfToken);
        request.setAttribute("csrfToken", csrfToken);
        
        // Chuyển đến trang đăng nhập
        request.getRequestDispatcher("/WEB-INF/views/common/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Đảm bảo encoding UTF-8 cho request
            request.setCharacterEncoding("UTF-8");
            
            // Kiểm tra CSRF token
            String csrfToken = request.getParameter("csrfToken");
            String sessionToken = (String) request.getSession().getAttribute("csrfToken");
            
            if (csrfToken == null || sessionToken == null || !csrfToken.equals(sessionToken)) {
                AuthUtil.storeErrorMessage(request, "Phiên làm việc không hợp lệ. Vui lòng thử lại!");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            // Lấy thông tin đăng nhập
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            // Kiểm tra đầu vào
            if (username == null || username.trim().isEmpty() || 
                password == null || password.trim().isEmpty()) {
                AuthUtil.storeErrorMessage(request, "Vui lòng nhập tên đăng nhập và mật khẩu!");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            // Kiểm tra số lần đăng nhập sai
            HttpSession session = request.getSession();
            Integer loginAttempts = (Integer) session.getAttribute("loginAttempts");
            
            if (loginAttempts != null && loginAttempts >= 5) {
                // Kiểm tra thời gian khóa
                Long lockTime = (Long) session.getAttribute("lockTime");
                long currentTime = System.currentTimeMillis();
                
                // Nếu thời gian khóa vẫn còn hiệu lực (10 phút)
                if (lockTime != null && currentTime - lockTime < 10 * 60 * 1000) {
                    long remainingTime = (lockTime + 10 * 60 * 1000 - currentTime) / 1000 / 60;
                    AuthUtil.storeErrorMessage(request, "Tài khoản tạm thời bị khóa. Vui lòng thử lại sau " + remainingTime + " phút.");
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                } else {
                    // Đã hết thời gian khóa, reset số lần đăng nhập
                    session.removeAttribute("loginAttempts");
                    session.removeAttribute("lockTime");
                    loginAttempts = 0;
                }
            }
            
            if (loginAttempts == null) {
                loginAttempts = 0;
            }
            
            // Kiểm tra xác thực
            User user = userDAO.getUserByUsername(username);
            
            if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
                // Đăng nhập thành công, reset số lần đăng nhập
                session.removeAttribute("loginAttempts");
                session.removeAttribute("lockTime");
                
                // Tạo CSRF token mới
                String newCsrfToken = UUID.randomUUID().toString();
                session.setAttribute("csrfToken", newCsrfToken);
                
                // Thiết lập thời gian truy cập gần nhất
                session.setAttribute("lastAccessTime", System.currentTimeMillis());
                
                // Lưu thông tin người dùng vào session
                AuthUtil.storeLoginedUser(request, user);
                
                // Lấy URL redirect nếu có
                String redirectURL = (String) session.getAttribute("redirectURL");
                if (redirectURL != null && !redirectURL.isEmpty()) {
                    session.removeAttribute("redirectURL");
                    response.sendRedirect(redirectURL);
                    return;
                }
                
                // Chuyển hướng theo vai trò
                switch (user.getRole()) {
                    case "admin":
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                        break;
                    case "tutor":
                        response.sendRedirect(request.getContextPath() + "/tutor/dashboard");
                        break;
                    case "student":
                        response.sendRedirect(request.getContextPath() + "/student/dashboard");
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/home");
                        break;
                }
            } else {
                // Tăng số lần đăng nhập sai
                loginAttempts++;
                session.setAttribute("loginAttempts", loginAttempts);
                
                if (loginAttempts >= 5) {
                    // Đã đăng nhập sai 5 lần, khóa tài khoản
                    session.setAttribute("lockTime", System.currentTimeMillis());
                    AuthUtil.storeErrorMessage(request, "Bạn đã nhập sai mật khẩu quá nhiều lần. Tài khoản tạm thời bị khóa trong 10 phút.");
                } else {
                    // Lưu thông báo lỗi và quay lại trang đăng nhập
                    AuthUtil.storeErrorMessage(request, "Tên đăng nhập hoặc mật khẩu không đúng!");
                }
                
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } catch (Exception e) {
            e.printStackTrace();
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi đăng nhập: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}