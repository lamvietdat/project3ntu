package lvd.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.UserDAO;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;

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
        
        // Chuyển đến trang đăng nhập
        request.getRequestDispatcher("/WEB-INF/views/common/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Kiểm tra xác thực
        User user = userDAO.authenticate(username, password);
        
        if (user != null) {
            // Lưu thông tin người dùng vào session
            AuthUtil.storeLoginedUser(request, user);
            
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
            // Lưu thông báo lỗi và quay lại trang đăng nhập
            AuthUtil.storeErrorMessage(request, "Tên đăng nhập hoặc mật khẩu không đúng!");
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

}
