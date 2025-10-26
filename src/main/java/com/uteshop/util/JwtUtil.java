package com.uteshop.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;
import java.util.Date;

/**
 * Phiên bản tương thích JJWT 0.12.6 (Servlet, không dùng API)
 * Giữ nguyên toàn bộ logic sinh và xác thực token.
 */
public class JwtUtil {

    // 🔑 Khóa bí mật (Base64 hoặc chuỗi ngẫu nhiên ≥ 32 ký tự)
    private static final String SECRET_KEY = "uteshop-secret-key-1234567890-UTEShopKey2025!@#";
    private static final long EXPIRATION_TIME = 24 * 60 * 60 * 1000; // 24h

    /** Tạo SecretKey từ chuỗi */
    private static SecretKey getSigningKey() {
        // Nếu khóa là chuỗi thường (không phải Base64), chỉ cần getBytes()
        byte[] keyBytes = SECRET_KEY.getBytes();
        return Keys.hmacShaKeyFor(keyBytes);
    }

    /** ✅ Sinh JWT */
    public static String generateToken(String username, String role) {
        return Jwts.builder()
                .subject(username)
                .claim("role", role)
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(getSigningKey()) // HMAC SHA key
                .compact();
    }

    /** ✅ Xác thực JWT và trả về Claims */
    public static Claims validateToken(String token) throws JwtException {
        return Jwts.parser()
                .verifyWith(getSigningKey()) // kiểm tra chữ ký
                .build()
                .parseSignedClaims(token)
                .getPayload(); // phần dữ liệu
    }
}
