package lvd.controller.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.model.User;
import lvd.util.AuthUtil;

@WebFilter(urlPatterns = {"/admin/*", "/tutor/*", "/student/*"})
public class AuthorizationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Kiểm tra người dùng đã đăng nhập chưa
        User loginedUser = AuthUtil.getLoginedUser(httpRequest);
        if (loginedUser != null) {
            String role = loginedUser.getRole();
            String requestURI = httpRequest.getRequestURI();
            
            // Kiểm tra quyền truy cập
            boolean hasPermission = false;
            
            if (requestURI.contains("/admin/") && "admin".equals(role)) {
                hasPermission = true;
            } else if (requestURI.contains("/tutor/") && "tutor".equals(role)) {
                hasPermission = true;
            } else if (requestURI.contains("/student/") && "student".equals(role)) {
                hasPermission = true;
            }
            
            if (hasPermission) {
                // Nếu có quyền, tiếp tục xử lý request
                chain.doFilter(request, response);
            } else {
                // Nếu không có quyền, chuyển hướng đến trang chủ
                AuthUtil.storeErrorMessage(httpRequest, "Bạn không có quyền truy cập trang này!");
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
            }
        } else {
            // Nếu chưa đăng nhập, chuyển đến AuthenticationFilter xử lý
            chain.doFilter(request, response);
        }
    }
    
    @Override
    public void destroy() {
    }
}
