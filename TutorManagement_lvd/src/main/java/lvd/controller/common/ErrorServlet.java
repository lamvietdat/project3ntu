package lvd.controller.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.util.AuthUtil;

import java.io.IOException;

/**
 * Servlet implementation class ErrorServlet
 */
@WebServlet("/error")
public class ErrorServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
    
    public ErrorServlet() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đảm bảo encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Lấy thông tin lỗi
        String errorMessage = (String) request.getAttribute("javax.servlet.error.message");
        if (errorMessage == null || errorMessage.isEmpty()) {
            // Lấy thông báo lỗi từ session nếu có
            errorMessage = AuthUtil.getStoredErrorMessage(request);
            
            if (errorMessage == null || errorMessage.isEmpty()) {
                errorMessage = "Đã xảy ra lỗi không xác định!";
            }
        }
        
        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("/views/common/error.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
