package com.uteshop.util;

import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Utility class for handling Vietnamese character encoding
 */
public class VietnameseEncodingUtil {
    
    /**
     * Ensure proper UTF-8 encoding for Vietnamese text
     */
    public static String ensureVietnameseEncoding(String text) {
        if (text == null) return null;
        
        try {
            // Check if text is already properly encoded
            if (isValidUTF8(text)) {
                return text;
            }
            
            // Try to fix encoding issues
            byte[] bytes = text.getBytes(StandardCharsets.ISO_8859_1);
            return new String(bytes, StandardCharsets.UTF_8);
        } catch (Exception e) {
            // If all else fails, return original text
            return text;
        }
    }
    
    /**
     * Check if string contains valid UTF-8 characters
     */
    private static boolean isValidUTF8(String text) {
        try {
            byte[] bytes = text.getBytes(StandardCharsets.UTF_8);
            String reconstructed = new String(bytes, StandardCharsets.UTF_8);
            return text.equals(reconstructed);
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * Set Vietnamese text parameter in PreparedStatement with proper encoding
     */
    public static void setVietnameseParameter(PreparedStatement ps, int index, String value) throws SQLException {
        if (value == null) {
            ps.setNull(index, java.sql.Types.NVARCHAR);
        } else {
            ps.setNString(index, value);
        }
    }
    
    /**
     * Get Vietnamese text from ResultSet with proper encoding
     */
    public static String getVietnameseString(ResultSet rs, String columnName) throws SQLException {
        String value = rs.getNString(columnName);
        return ensureVietnameseEncoding(value);
    }
    
    /**
     * Clean and prepare Vietnamese text for database insertion
     */
    public static String prepareVietnameseText(String text) {
        if (text == null || text.trim().isEmpty()) {
            return text;
        }
        
        // Remove any BOM characters
        text = text.replace("\uFEFF", "");
        
        // Normalize Vietnamese text
        text = text.trim();
        
        // Ensure proper encoding
        return ensureVietnameseEncoding(text);
    }
    
    /**
     * Fix corrupted Vietnamese text (replace ? with proper characters)
     */
    public static String fixCorruptedVietnameseText(String corruptedText) {
        if (corruptedText == null) return null;
        
        // Common Vietnamese character replacements - simplified version
        String result = corruptedText;
        
        // Replace common corrupted patterns
        result = result.replace("Ä?", "Đ");
        result = result.replace("Äƒ", "ă");
        result = result.replace("Ã¢", "â");
        result = result.replace("Ãª", "ê");
        result = result.replace("Ã´", "ô");
        result = result.replace("Æ°", "ư");
        result = result.replace("Ã¡", "á");
        result = result.replace("Ã ", "à");
        result = result.replace("Ã©", "é");
        result = result.replace("Ã¨", "è");
        result = result.replace("Ã­", "í");
        result = result.replace("Ã¬", "ì");
        result = result.replace("Ã³", "ó");
        result = result.replace("Ã²", "ò");
        result = result.replace("Ãº", "ú");
        result = result.replace("Ã¹", "ù");
        result = result.replace("Ã½", "ý");
        
        return result;
    }
}