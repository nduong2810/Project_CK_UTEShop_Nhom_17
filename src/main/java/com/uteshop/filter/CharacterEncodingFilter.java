package com.uteshop.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Filter to ensure UTF-8 character encoding for all HTTP requests and responses
 * This is crucial for proper handling of Vietnamese text
 */
public class CharacterEncodingFilter implements Filter {
    
    private String encoding = "UTF-8";
    private boolean forceEncoding = false;
    
    @Override
    public void init(FilterConfig config) throws ServletException {
        String encodingParam = config.getInitParameter("encoding");
        if (encodingParam != null) {
            this.encoding = encodingParam;
        }
        
        String forceEncodingParam = config.getInitParameter("forceEncoding");
        if (forceEncodingParam != null) {
            this.forceEncoding = Boolean.parseBoolean(forceEncodingParam);
        }
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Force UTF-8 encoding for request
        if (forceEncoding || request.getCharacterEncoding() == null) {
            request.setCharacterEncoding(encoding);
        }
        
        // Force UTF-8 encoding for response
        response.setCharacterEncoding(encoding);
        
        // Set proper content type headers
        String acceptHeader = httpRequest.getHeader("Accept");
        String userAgent = httpRequest.getHeader("User-Agent");
        
        // Set response headers to ensure proper encoding
        httpResponse.setHeader("Content-Type", "text/html; charset=" + encoding);
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setHeader("Expires", "0");
        
        // Additional headers for Vietnamese character support
        if (acceptHeader != null && acceptHeader.contains("text/html")) {
            httpResponse.setContentType("text/html; charset=" + encoding);
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // No cleanup needed
    }
}