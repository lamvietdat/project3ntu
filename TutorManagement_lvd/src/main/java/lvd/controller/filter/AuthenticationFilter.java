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
import jakarta.servlet.http.HttpSession;
import lvd.util.AuthUtil;

@WebFilter(urlPatterns = {"/admin/*", "/tutor/*", "/student/*"})
public class AuthenticationFilter implements Filter {
    
    // Thời gian timeout cho session tính bằng giây (30 phút)
    private static final int SESSION_TIMEOUT = 30 * 60;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Thiết lập thời gian timeout cho session
        HttpSession session = httpRequest.getSession();
        session.setMaxInactiveInterval(SESSION_TIMEOUT);
        
        // Kiểm tra người dùng đã đăng nhập chưa
        if (AuthUtil.isUserLogined(httpRequest)) {
            // Kiểm tra session đã hết hạn chưa
            if (isSessionTimeout(session)) {
                // Hủy session hiện tại
                AuthUtil.logoutUser(httpRequest);
                
                // Thông báo và chuyển hướng đến trang đăng nhập
                AuthUtil.storeErrorMessage(httpRequest, "Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại.");
                String loginURL = httpRequest.getContextPath() + "/login";
                httpResponse.sendRedirect(loginURL);
                return;
            }
            
            // Cập nhật thời gian truy cập gần nhất
            session.setAttribute("lastAccessTime", System.currentTimeMillis());
            
            // Nếu đã đăng nhập và session còn hiệu lực, tiếp tục xử lý request
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
    
    // Kiểm tra xem session đã hết hạn chưa
    private boolean isSessionTimeout(HttpSession session) {
        Long lastAccessTime = (Long) session.getAttribute("lastAccessTime");
        if (lastAccessTime == null) {
            return false; // Session mới, chưa có lastAccessTime
        }
        
        long currentTime = System.currentTimeMillis();
        long elapsedTime = (currentTime - lastAccessTime) / 1000; // Chuyển đổi thành giây
        
        return elapsedTime > SESSION_TIMEOUT;
    }
}