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
        if (plainPassword == null || plainPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        
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
            System.err.println("PBKDF2 hashing failed, falling back to SHA-256: " + e.getMessage());
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
        
        try {
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
                System.out.println("Warning: Plain text password comparison detected for: " + hashedPassword.substring(0, Math.min(hashedPassword.length(), 5)) + "...");
                return plainPassword.equals(hashedPassword);
            }
        } catch (Exception e) {
            System.err.println("Password verification failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Verify PBKDF2 hashed password
     */
    private static boolean verifyPBKDF2Password(String plainPassword, String hashedPassword) {
        try {
            String[] parts = hashedPassword.split(":");
            if (parts.length != 2) {
                System.err.println("Invalid PBKDF2 format: expected salt:hash");
                return false;
            }
            
            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] expectedHash = Base64.getDecoder().decode(parts[1]);
            
            PBEKeySpec spec = new PBEKeySpec(plainPassword.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
            SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
            byte[] actualHash = factory.generateSecret(spec).getEncoded();
            
            return MessageDigest.isEqual(expectedHash, actualHash);
        } catch (Exception e) {
            System.err.println("PBKDF2 verification failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Fallback SHA-256 password hashing
     */
    private static String hashPasswordSHA256(String plainPassword) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(plainPassword.getBytes("UTF-8"));
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
            throw new RuntimeException("SHA-256 hashing failed", e);
        }
    }
    
    /**
     * Verify SHA-256 hashed password
     */
    private static boolean verifySHA256Password(String plainPassword, String hashedPassword) {
        try {
            String hashedPlain = hashPasswordSHA256(plainPassword);
            return hashedPlain.equals(hashedPassword);
        } catch (Exception e) {
            System.err.println("SHA-256 verification failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Check if a password meets minimum requirements
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 6) {
            return false;
        }
        // Add more validation rules as needed
        return true;
    }
    
    /**
     * Test method to verify password utility is working correctly
     */
    public static void testPasswordUtil() {
        String testPassword = "testPassword123";
        
        // Test PBKDF2 hashing
        String hashedPBKDF2 = hashPassword(testPassword);
        System.out.println("PBKDF2 Hash: " + hashedPBKDF2);
        System.out.println("PBKDF2 Verify: " + verifyPassword(testPassword, hashedPBKDF2));
        
        // Test SHA-256 hashing
        String hashedSHA256 = hashPasswordSHA256(testPassword);
        System.out.println("SHA-256 Hash: " + hashedSHA256);
        System.out.println("SHA-256 Verify: " + verifyPassword(testPassword, hashedSHA256));
        
        // Test wrong password
        System.out.println("Wrong password test: " + verifyPassword("wrongPassword", hashedPBKDF2));
    }
}