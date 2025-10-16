package com.uteshop.util;

import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.SecretKeyFactory;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utility class for password encoding and validation using PBKDF2 or SHA-256
 * Compatible with Jakarta Servlet without Spring Security dependency
 */
public class PasswordUtil {
    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";
    private static final int ITERATIONS = 10000;
    private static final int KEY_LENGTH = 256;
    private static final SecureRandom random = new SecureRandom();
    
    /**
     * Hash a plain text password using PBKDF2
     * @param plainPassword The plain text password
     * @return The hashed password with salt
     */
    public static String hashPassword(String plainPassword) {
        try {
            // Generate salt
            byte[] salt = new byte[16];
            random.nextBytes(salt);
            
            // Hash password
            PBEKeySpec spec = new PBEKeySpec(plainPassword.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
            SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
            byte[] hash = factory.generateSecret(spec).getEncoded();
            
            // Combine salt and hash
            String saltBase64 = Base64.getEncoder().encodeToString(salt);
            String hashBase64 = Base64.getEncoder().encodeToString(hash);
            
            return saltBase64 + ":" + hashBase64;
        } catch (Exception e) {
            // Fallback to simple SHA-256 if PBKDF2 fails
            return hashPasswordSHA256(plainPassword);
        }
    }
    
    /**
     * Verify if a plain text password matches the hashed password
     * @param plainPassword The plain text password
     * @param hashedPassword The hashed password
     * @return true if passwords match, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        
        // Handle different hash formats
        if (hashedPassword.contains(":")) {
            // PBKDF2 format: salt:hash
            return verifyPBKDF2Password(plainPassword, hashedPassword);
        } else if (hashedPassword.startsWith("$2a$")) {
            // BCrypt format - not supported, return false for security
            System.err.println("BCrypt format detected but not supported in this implementation");
            return false;
        } else if (hashedPassword.length() == 64) {
            // SHA-256 format
            return verifySHA256Password(plainPassword, hashedPassword);
        } else {
            // Plain text comparison (for backward compatibility)
            System.out.println("Warning: Plain text password comparison detected");
            return plainPassword.equals(hashedPassword);
        }
    }
    
    /**
     * Verify PBKDF2 hashed password
     */
    private static boolean verifyPBKDF2Password(String plainPassword, String hashedPassword) {
        try {
            String[] parts = hashedPassword.split(":");
            if (parts.length != 2) {
                return false;
            }
            
            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] expectedHash = Base64.getDecoder().decode(parts[1]);
            
            PBEKeySpec spec = new PBEKeySpec(plainPassword.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
            SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
            byte[] actualHash = factory.generateSecret(spec).getEncoded();
            
            return MessageDigest.isEqual(expectedHash, actualHash);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Fallback SHA-256 password hashing
     */
    private static String hashPasswordSHA256(String plainPassword) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(plainPassword.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return plainPassword; // Return plain text as last resort
        }
    }
    
    /**
     * Verify SHA-256 hashed password
     */
    private static boolean verifySHA256Password(String plainPassword, String hashedPassword) {
        String newHash = hashPasswordSHA256(plainPassword);
        return newHash.equals(hashedPassword);
    }
    
    /**
     * Check if a password is already hashed
     * @param password The password to check
     * @return true if it appears to be hashed, false otherwise
     */
    public static boolean isHashed(String password) {
        if (password == null) return false;
        
        return password.contains(":") || // PBKDF2 format
               password.startsWith("$2a$") || // BCrypt format
               (password.length() == 64 && password.matches("[a-f0-9]+")); // SHA-256 format
    }
    
    /**
     * Check if a password is BCrypt encoded (for backward compatibility)
     * @param password The password to check
     * @return true if it's BCrypt encoded, false otherwise
     */
    public static boolean isBCryptEncoded(String password) {
        return password != null && password.startsWith("$2a$") && password.length() == 60;
    }
    
    /**
     * Alias for hashPassword for backward compatibility
     */
    public static String encodePassword(String plainPassword) {
        return hashPassword(plainPassword);
    }
    
    /**
     * Alias for verifyPassword for backward compatibility
     */
    public static boolean checkPassword(String plainPassword, String encodedPassword) {
        return verifyPassword(plainPassword, encodedPassword);
    }
}