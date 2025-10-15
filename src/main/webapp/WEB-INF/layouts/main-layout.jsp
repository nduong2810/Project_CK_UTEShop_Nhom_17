<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'>UTESHOP - Nền tảng thương mại điện tử</sitemesh:write></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Loading Screen -->
    <div id="loader-wrapper">
        <div class="loader"></div>
        <p class="loader-text">Đang tải trang...</p>
    </div>

    <!-- Main Page Content (Initially Hidden) -->
    <div id="page-content" style="visibility: hidden; opacity: 0;">
        <!-- Header -->
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
        
        <!-- Main Content -->
        <main class="container-fluid p-0">
            <sitemesh:write property='body'/>
        </main>
        
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>