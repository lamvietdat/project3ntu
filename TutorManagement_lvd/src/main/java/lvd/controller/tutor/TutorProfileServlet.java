package lvd.controller.tutor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lvd.dao.TutorDAO;
import lvd.dao.UserDAO;
import lvd.model.Tutor;
import lvd.model.User;
import lvd.util.AuthUtil;

import java.io.IOException;
import java.math.BigDecimal;

/**
 * Servlet implementation class TutorProfileServlet
 */
@WebServlet("/tutor/profile")
public class TutorProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TutorDAO tutorDAO = new TutorDAO();
    private UserDAO userDAO = new UserDAO();
    
    public TutorProfileServlet() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra quyền truy cập
        if (!AuthUtil.hasPermission(request, "tutor")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy thông tin gia sư hiện tại
        User currentUser = AuthUtil.getLoginedUser(request);
        Tutor tutor = tutorDAO.getTutorByUserId(currentUser.getUserId());
        
        if (tutor != null) {
            request.setAttribute("tutor", tutor);
            request.getRequestDispatcher("/WEB-INF/views/tutor/profile.jsp").forward(request, response);
        } else {
            // Nếu không tìm thấy thông tin gia sư
            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin gia sư!");
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Kiểm tra quyền truy cập
        if (!AuthUtil.hasPermission(request, "tutor")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy thông tin gia sư hiện tại
        User currentUser = AuthUtil.getLoginedUser(request);
        Tutor tutor = tutorDAO.getTutorByUserId(currentUser.getUserId());
        
        if (tutor != null) {
            String action = request.getParameter("action");
            
            if ("updateProfile".equals(action)) {
                // Cập nhật thông tin cá nhân
                updateProfile(request, response, currentUser, tutor);
            } else if ("changePassword".equals(action)) {
                // Đổi mật khẩu
                changePassword(request, response, currentUser);
            } else {
                response.sendRedirect(request.getContextPath() + "/tutor/profile");
            }
        } else {
            // Nếu không tìm thấy thông tin gia sư
            AuthUtil.storeErrorMessage(request, "Không tìm thấy thông tin gia sư!");
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User currentUser, Tutor tutor) throws IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String qualification = request.getParameter("qualification");
            String experience = request.getParameter("experience");
            BigDecimal hourlyRate = new BigDecimal(request.getParameter("hourlyRate"));
            String bio = request.getParameter("bio");
            
            // Kiểm tra dữ liệu đầu vào
            if (email == null || email.trim().isEmpty() ||
                fullName == null || fullName.trim().isEmpty() ||
                qualification == null || qualification.trim().isEmpty() ||
                experience == null || experience.trim().isEmpty()) {
                
                AuthUtil.storeErrorMessage(request, "Vui lòng điền đầy đủ thông tin bắt buộc!");
                response.sendRedirect(request.getContextPath() + "/tutor/profile");
                return;
            }
            
            // Kiểm tra email nếu thay đổi
            if (!email.equals(currentUser.getEmail()) && userDAO.isEmailExists(email)) {
                AuthUtil.storeErrorMessage(request, "Email đã được sử dụng bởi người dùng khác!");
                response.sendRedirect(request.getContextPath() + "/tutor/profile");
                return;
            }
            
            // Cập nhật thông tin User
            currentUser.setEmail(email);
            currentUser.setFullName(fullName);
            currentUser.setPhone(phone);
            currentUser.setAddress(address);
            
            boolean userUpdateSuccess = userDAO.updateUser(currentUser);
            
            // Cập nhật thông tin Tutor
            tutor.setQualification(qualification);
            tutor.setExperience(experience);
            tutor.setHourlyRate(hourlyRate);
            tutor.setBio(bio);
            
            boolean tutorUpdateSuccess = tutorDAO.updateTutor(tutor);
            
            if (userUpdateSuccess && tutorUpdateSuccess) {
                // Cập nhật thông tin người dùng trong session
                AuthUtil.storeLoginedUser(request, currentUser);
                AuthUtil.storeSuccessMessage(request, "Cập nhật thông tin cá nhân thành công!");
            } else {
                AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi cập nhật thông tin cá nhân!");
            }
            
            response.sendRedirect(request.getContextPath() + "/tutor/profile");
        } catch (NumberFormatException e) {
            AuthUtil.storeErrorMessage(request, "Phí theo giờ không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/tutor/profile");
        } catch (Exception e) {
            e.printStackTrace();
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/tutor/profile");
        }
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, User currentUser) throws IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Kiểm tra mật khẩu hiện tại
        if (!currentUser.getPassword().equals(currentPassword)) {
            AuthUtil.storeErrorMessage(request, "Mật khẩu hiện tại không đúng!");
            response.sendRedirect(request.getContextPath() + "/tutor/profile");
            return;
        }
        
        // Kiểm tra mật khẩu xác nhận
        if (!newPassword.equals(confirmPassword)) {
            AuthUtil.storeErrorMessage(request, "Mật khẩu xác nhận không khớp!");
            response.sendRedirect(request.getContextPath() + "/tutor/profile");
            return;
        }
        
        // Cập nhật mật khẩu
        boolean success = userDAO.updatePassword(currentUser.getUserId(), newPassword);
        
        if (success) {
            // Cập nhật thông tin người dùng trong session
            currentUser.setPassword(newPassword);
            AuthUtil.storeLoginedUser(request, currentUser);
            AuthUtil.storeSuccessMessage(request, "Đổi mật khẩu thành công!");
        } else {
            AuthUtil.storeErrorMessage(request, "Đã xảy ra lỗi khi đổi mật khẩu!");
        }
        
        response.sendRedirect(request.getContextPath() + "/tutor/profile");
    }

}
