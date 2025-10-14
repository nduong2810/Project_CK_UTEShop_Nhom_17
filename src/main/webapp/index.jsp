<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect to the actual home page handled by the GuestServlet
    response.sendRedirect(request.getContextPath() + "/guest/home");
%>
