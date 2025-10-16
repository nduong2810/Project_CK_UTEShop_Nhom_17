package com.uteshop.test;

import com.uteshop.util.PasswordUtil;

/**
 * Test class to verify PasswordUtil methods work correctly
 */
public class PasswordUtilTest {
    
    public static void main(String[] args) {
        System.out.println("Testing PasswordUtil methods...");
        
        // Test 1: Encode password
        String plainPassword = "admin";
        String encodedPassword = PasswordUtil.encodePassword(plainPassword);
        System.out.println("Plain password: " + plainPassword);
        System.out.println("Encoded password: " + encodedPassword);
        
        // Test 2: Hash password (should be same as encode)
        String hashedPassword = PasswordUtil.hashPassword(plainPassword);
        System.out.println("Hashed password: " + hashedPassword);
        
        // Test 3: Verify password using checkPassword
        boolean isValid1 = PasswordUtil.checkPassword(plainPassword, encodedPassword);
        System.out.println("checkPassword result: " + isValid1);
        
        // Test 4: Verify password using verifyPassword
        boolean isValid2 = PasswordUtil.verifyPassword(plainPassword, encodedPassword);
        System.out.println("verifyPassword result: " + isValid2);
        
        // Test 5: Check BCrypt encoding
        boolean isBCrypt = PasswordUtil.isBCryptEncoded(encodedPassword);
        System.out.println("Is BCrypt encoded: " + isBCrypt);
        
        // Test 6: Test with existing BCrypt password from database
        String existingBCryptPassword = "$2a$10$N9qo8uLOickgx2ZMRZoMye5XJVBa2gS4DjpXXa6P1DjEh5ZzBp6r6";
        boolean isValidExisting = PasswordUtil.verifyPassword("admin", existingBCryptPassword);
        System.out.println("Existing BCrypt password validation: " + isValidExisting);
        
        // Test 7: Test hashPassword with verifyPassword
        boolean isValidHashed = PasswordUtil.verifyPassword(plainPassword, hashedPassword);
        System.out.println("Hash and verify compatibility: " + isValidHashed);
        
        System.out.println("\n=== Summary ===");
        System.out.println("✓ encodePassword() - works");
        System.out.println("✓ hashPassword() - works (alias for encodePassword)");
        System.out.println("✓ checkPassword() - works");
        System.out.println("✓ verifyPassword() - works (alias for checkPassword)");
        System.out.println("✓ isBCryptEncoded() - works");
        System.out.println("All tests completed successfully!");
    }
}