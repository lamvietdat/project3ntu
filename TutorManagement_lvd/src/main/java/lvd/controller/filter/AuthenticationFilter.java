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
import lvd.util.AuthUtil;

@WebFilter(urlPatterns = {"/admin/*", "/tutor/*", "/student/*"})
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Kiểm tra người dùng đã đăng nhập chưa
        if (AuthUtil.isUserLogined(httpRequest)) {
            // Nếu đã đăng nhập, tiếp tục xử lý request
            chain.doFilter(request, response);
        } else {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            String loginURL = httpRequest.getContextPath() + "/login";
            
            // Lưu URL hiện tại để sau khi đăng nhập có thể quay lại
            String requestURI = httpRequest.getRequestURI();
            String queryString = httpRequest.getQueryString();
            String redirectURL = requestURI + (queryString != null ? "?" + queryString : "");
            
            httpRequest.getSession().setAttribute("redirectURL", redirectURL);
            
            httpResponse.sendRedirect(loginURL);
        }
    }
    
    @Override
    public void destroy() {
    }
}
