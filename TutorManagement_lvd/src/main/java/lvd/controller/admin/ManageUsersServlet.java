package lvd.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.UserDAO;
import lvd.model.User;
import lvd.util.AuthUtil;
import lvd.util.PasswordUtil;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class ManageUsersServlet
 */
@WebServlet("/admin/users")
public class ManageUsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    
    public ManageUsersServlet() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra quyền truy cập
        if (!AuthUtil.hasPermission(request, "admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy danh sách người dùng
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        
        // Chuyển đến trang quản lý người dùng
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Kiểm tra quyền truy cập
        if (!AuthUtil.hasPermission(request, "admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            // Thêm người dùng mới
            addUser(request, response);
        } else if ("update".equals(action)) {
            // Cập nhật thông tin người dùng
            updateUser(request, response);
        } else if ("delete".equals(action)) {
            // Xóa người dùng
            deleteUser(request, response);
        } else if ("resetPassword".equals(action)) {
            // Đặt lại mật khẩu
            resetPassword(request, response);
        } else {
            // Chuyển hướng về trang quản lý người dùng
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    
    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        
        // Kiểm tra username đã tồn tại chưa
        if (userDAO.isUsernameExists(username)) {
            AuthUtil.storeErrorMessage(request, "Tên đăng nhập đã tồn tại!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        // Kiểm tra email đã tồn tại chưa
        if (userDAO.isEmailExists(email)) {
            AuthUtil.storeErrorMessage(request, "Email đã tồn tại!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        // Tạo đối tượng User
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole(role);
        
        // Thêm người dùng vào cơ sở dữ liệu
        boolean success = userDAO.addUser(user);
        
        if (success) {
            AuthUtil.storeSuccessMessage(request, "Thêm người dùng thành công!");
        } else {
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi thêm người dùng!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        
        // Lấy thông tin người dùng hiện tại
        User user = userDAO.getUserById(userId);
        
        if (user != null) {
            // Cập nhật thông tin
            user.setEmail(email);
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole(role);
            
            // Cập nhật vào cơ sở dữ liệu
            boolean success = userDAO.updateUser(user);
            
            if (success) {
                AuthUtil.storeSuccessMessage(request, "Cập nhật người dùng thành công!");
            } else {
                AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi cập nhật người dùng!");
            }
        } else {
            AuthUtil.storeErrorMessage(request, "Không tìm thấy người dùng!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        // Kiểm tra người dùng hiện tại
        User currentUser = AuthUtil.getLoginedUser(request);
        if (currentUser.getUserId() == userId) {
            AuthUtil.storeErrorMessage(request, "Không thể xóa tài khoản đang đăng nhập!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        // Thực hiện xóa người dùng
        boolean success = userDAO.deleteUser(userId);
        
        if (success) {
            AuthUtil.storeSuccessMessage(request, "Xóa người dùng thành công!");
        } else {
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi xóa người dùng!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        // Tạo mật khẩu mới
        String newPassword = PasswordUtil.generateRandomPassword(8);
        
        // Cập nhật mật khẩu
        boolean success = userDAO.updatePassword(userId, newPassword);
        
        if (success) {
            AuthUtil.storeSuccessMessage(request, "Đặt lại mật khẩu thành công! Mật khẩu mới: " + newPassword);
        } else {
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi đặt lại mật khẩu!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

}
