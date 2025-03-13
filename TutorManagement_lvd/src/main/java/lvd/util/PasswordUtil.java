package lvd.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {
	 // Phương thức mã hóa mật khẩu
    public static String hashPassword(String passwordToHash) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedPassword = md.digest(passwordToHash.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi băm mật khẩu", e);
        }
    }

    // Phương thức xác minh mật khẩu
    public static boolean verifyPassword(String password, String hashedPassword) {
        String newHashedPassword = hashPassword(password);
        return newHashedPassword.equals(hashedPassword);
    }
    
    // Phương thức tạo mật khẩu ngẫu nhiên
    public static String generateRandomPassword(int length) {
        if (length < 8) {
            length = 8; // Mật khẩu tối thiểu 8 ký tự
        }
        
        final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
        final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
        final String NUMBER = "0123456789";
        final String SPECIAL = "!@#$%^&*()_-+=<>?";
        
        final String DATA_FOR_RANDOM_PASSWORD = CHAR_LOWER + CHAR_UPPER + NUMBER + SPECIAL;
        
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);
        
        // Đảm bảo mật khẩu có ít nhất 1 ký tự viết thường, viết hoa, số và ký tự đặc biệt
        sb.append(CHAR_LOWER.charAt(random.nextInt(CHAR_LOWER.length())));
        sb.append(CHAR_UPPER.charAt(random.nextInt(CHAR_UPPER.length())));
        sb.append(NUMBER.charAt(random.nextInt(NUMBER.length())));
        sb.append(SPECIAL.charAt(random.nextInt(SPECIAL.length())));
        
        // Thêm các ký tự ngẫu nhiên còn lại
        for (int i = 4; i < length; i++) {
            sb.append(DATA_FOR_RANDOM_PASSWORD.charAt(random.nextInt(DATA_FOR_RANDOM_PASSWORD.length())));
        }
        
        return sb.toString();
    }
}
