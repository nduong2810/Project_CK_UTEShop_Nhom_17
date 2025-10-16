package com.uteshop.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * Utility class for password encoding and validation using BCrypt
 */
public class PasswordUtil {
    private static final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    
    /**
     * Encode a plain text password using BCrypt
     * @param plainPassword The plain text password
     * @return The BCrypt encoded password
     */
    public static String encodePassword(String plainPassword) {
        return passwordEncoder.encode(plainPassword);
    }
    
    /**
     * Hash a plain text password using BCrypt
     * This is an alias for encodePassword() for backward compatibility
     * @param plainPassword The plain text password
     * @return The BCrypt encoded password
     */
    public static String hashPassword(String plainPassword) {
        return encodePassword(plainPassword);
    }
    
    /**
     * Check if a plain text password matches the encoded password
     * @param plainPassword The plain text password
     * @param encodedPassword The BCrypt encoded password
     * @return true if passwords match, false otherwise
     */
    public static boolean checkPassword(String plainPassword, String encodedPassword) {
        return passwordEncoder.matches(plainPassword, encodedPassword);
    }
    
    /**
     * Verify if a plain text password matches the encoded password
     * This is an alias for checkPassword() for backward compatibility
     * @param plainPassword The plain text password
     * @param encodedPassword The BCrypt encoded password
     * @return true if passwords match, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String encodedPassword) {
        return checkPassword(plainPassword, encodedPassword);
    }
    
    /**
     * Check if a password is already BCrypt encoded
     * @param password The password to check
     * @return true if it's BCrypt encoded, false otherwise
     */
    public static boolean isBCryptEncoded(String password) {
        return password != null && password.startsWith("$2a$") && password.length() == 60;
    }
    
    /**
     * Get the BCrypt encoder instance
     * @return BCryptPasswordEncoder instance
     */
    public static BCryptPasswordEncoder getEncoder() {
        return passwordEncoder;
    }
}