package lvd.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.util.AuthUtil;

import java.io.IOException;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
    
    public LogoutServlet() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xóa thông tin người dùng khỏi session
        AuthUtil.logoutUser(request);
        
        // Chuyển hướng về trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/login");
    }
}