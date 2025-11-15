<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.alluringdecors.bean.ContentBean" %>
<%@ page import="java.util.Map" %>
<%
    ContentBean contentBean = new ContentBean();
    String aboutContent = contentBean.getContentByKey("about_us");
    Map<String, String> allContent = contentBean.getAllContent();
    request.setAttribute("aboutContent", aboutContent);
    request.setAttribute("allContent", allContent);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Alluring Decors</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>        
        <c:if test="${not empty allContent}">
            <section class="content-sections" style="padding: 4rem 2rem; background: #f8f9fa;">
                <div class="container">
                    <h3 style="text-align: center; color: #164e31; margin-bottom: 3rem; font-size: 2rem;">About Alluring Decors</h3>
                   
                    <div class="content-grid" style="display: grid; gap: 2rem; max-width: 800px; margin: 0 auto;">
                        <c:forEach var="content" items="${allContent}">
                            <div class="content-item" style="background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                                <h4 style="color: #164e31; margin-bottom: 1rem; text-transform: capitalize;">${content.key.replace('_', ' ')}</h4>
                                <p style="color: #666; line-height: 1.6;">${content.value}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </c:if>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>