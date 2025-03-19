package lvd.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {
    private static final int SALT_LENGTH = 16; // Độ dài muối (bytes)
    private static final String HASH_ALGORITHM = "SHA-256"; // Thuật toán mã hóa
    
    // Phương thức mã hóa mật khẩu với salt ngẫu nhiên
    public static String hashPassword(String passwordToHash) {
        try {
            // Tạo salt ngẫu nhiên
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[SALT_LENGTH];
            random.nextBytes(salt);
            
            // Tạo mã hóa
            MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
            md.update(salt);
            byte[] hashedPassword = md.digest(passwordToHash.getBytes(StandardCharsets.UTF_8));
            
            // Nối salt và password đã mã hóa để lưu trữ
            byte[] saltedHashPassword = new byte[salt.length + hashedPassword.length];
            System.arraycopy(salt, 0, saltedHashPassword, 0, salt.length);
            System.arraycopy(hashedPassword, 0, saltedHashPassword, salt.length, hashedPassword.length);
            
            return Base64.getEncoder().encodeToString(saltedHashPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi băm mật khẩu", e);
        }
    }

    // Phương thức xác minh mật khẩu
    public static boolean verifyPassword(String password, String storedHash) {
        try {
            // Giải mã chuỗi hash đã lưu
            byte[] saltedHashPassword = Base64.getDecoder().decode(storedHash);
            
            // Tách salt và hash
            byte[] salt = new byte[SALT_LENGTH];
            byte[] hash = new byte[saltedHashPassword.length - SALT_LENGTH];
            System.arraycopy(saltedHashPassword, 0, salt, 0, SALT_LENGTH);
            System.arraycopy(saltedHashPassword, SALT_LENGTH, hash, 0, hash.length);
            
            // Tạo hash mới từ mật khẩu nhập vào và salt đã lưu
            MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
            md.update(salt);
            byte[] newHash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            
            // So sánh hai hash
            int diff = hash.length ^ newHash.length;
            for (int i = 0; i < hash.length && i < newHash.length; i++) {
                diff |= hash[i] ^ newHash[i];
            }
            
            return diff == 0;
        } catch (Exception e) {
            return false; // Xử lý ngoại lệ, trả về false nếu có lỗi
        }
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
        
        // Trộn các ký tự để tăng tính ngẫu nhiên
        char[] password = sb.toString().toCharArray();
        for (int i = 0; i < password.length; i++) {
            int randomIndex = random.nextInt(password.length);
            char temp = password[i];
            password[i] = password[randomIndex];
            password[randomIndex] = temp;
        }
        
        return new String(password);
    }
}