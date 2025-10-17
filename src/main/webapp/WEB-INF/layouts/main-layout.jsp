<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UTESHOP - Nền tảng mua sắm sinh viên HCMUTE</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main-styles.css">
</head>
<body>
    <!-- Include Header for non-auth pages -->
    <c:set var="authPath" value="${pageContext.request.contextPath}/auth/" />
    <c:if test="${!fn:startsWith(pageContext.request.requestURI, authPath)}">
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
    </c:if>
    
    <!-- Main content - SiteMesh 3 will automatically replace body content -->
    
    <!-- Include Footer for non-auth pages -->
    <c:if test="${!fn:startsWith(pageContext.request.requestURI, authPath)}">
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </c:if>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>