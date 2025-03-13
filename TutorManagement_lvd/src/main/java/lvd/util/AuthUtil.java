package lvd.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lvd.model.User;

public class AuthUtil {
	// Lưu thông tin người dùng vào session
    public static void storeLoginedUser(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute("loginedUser", user);
    }
    
    // Lấy thông tin người dùng đã đăng nhập từ session
    public static User getLoginedUser(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return (User) session.getAttribute("loginedUser");
    }
    
    // Kiểm tra người dùng đã đăng nhập chưa
    public static boolean isUserLogined(HttpServletRequest request) {
        return getLoginedUser(request) != null;
    }
    
    // Xóa thông tin người dùng khỏi session
    public static void logoutUser(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
    }
    
    // Lưu thông tin lỗi
    public static void storeErrorMessage(HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("errorMessage", message);
    }
    
    // Lấy thông tin lỗi
    public static String getStoredErrorMessage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String message = (String) session.getAttribute("errorMessage");
        session.removeAttribute("errorMessage"); // Xóa sau khi lấy
        return message;
    }
    
    // Lưu thông tin thành công
    public static void storeSuccessMessage(HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", message);
    }
    
    // Lấy thông tin thành công
    public static String getStoredSuccessMessage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String message = (String) session.getAttribute("successMessage");
        session.removeAttribute("successMessage"); // Xóa sau khi lấy
        return message;
    }
    
 // Kiểm tra người dùng có quyền truy cập không
    public static boolean hasPermission(HttpServletRequest request, String requiredRole) {
        User loginedUser = getLoginedUser(request);
        
        if (loginedUser == null) {
            return false;
        }
        
        String userRole = loginedUser.getRole();
        
        // Admin có thể truy cập tất cả
        if ("admin".equals(userRole)) {
            return true;
        }
        
        // Kiểm tra quyền cụ thể
        return userRole.equals(requiredRole);
    }
}
