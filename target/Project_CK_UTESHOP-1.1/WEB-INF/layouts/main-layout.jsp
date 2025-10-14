<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><decorator:title default="UTESHOP"/></title>
    <decorator:head/>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main class="container-fluid p-0">
    <decorator:body/>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
