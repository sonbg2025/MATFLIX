<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.boot.dto.TeamDTO" %>
<% TeamDTO user = (TeamDTO) session.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
    <title>MATFLIX - 레시피</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 공통 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <!-- 메인 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <!-- 폰트어썸 아이콘 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="content">
        <div class="category-section">
            <div class="category-title">한식 (Korean Food)</div>
            <div class="image-grid">
                <c:forEach var="img" items="${korean_food_list}" begin="0" end="3">
                    <a href="recipe_content_view?rc_recipe_id=${img.rc_recipe_id}">
                        <img src="${pageContext.request.contextPath}/upload/${img.uploadPath}/${img.uuid}_${img.fileName}" alt="Korean food image" />
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="category-section">
            <div class="category-title">양식 (American Food)</div>
            <div class="image-grid">
                <c:forEach var="img" items="${american_food_list}" begin="0" end="3">
                    <a href="recipe_content_view?rc_recipe_id=${img.rc_recipe_id}">
                        <img src="${pageContext.request.contextPath}/upload/${img.uploadPath}/${img.uuid}_${img.fileName}" alt="American food image" />
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="category-section">
            <div class="category-title">일식 (Japanese Food)</div>
            <div class="image-grid">
                <c:forEach var="img" items="${japanese_food_list}" begin="0" end="3">
                    <a href="recipe_content_view?rc_recipe_id=${img.rc_recipe_id}">
                        <img src="${pageContext.request.contextPath}/upload/${img.uploadPath}/${img.uuid}_${img.fileName}" alt="Japanese food image" />
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="category-section">
            <div class="category-title">중식 (Chinese Food)</div>
            <div class="image-grid">
                <c:forEach var="img" items="${chinese_food_list}" begin="0" end="3">
                    <a href="recipe_content_view?rc_recipe_id=${img.rc_recipe_id}">
                        <img src="${pageContext.request.contextPath}/upload/${img.uploadPath}/${img.uuid}_${img.fileName}" alt="Chinese food image" />
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="category-section">
            <div class="category-title">디저트 (Dessert)</div>
            <div class="image-grid">
                <c:forEach var="img" items="${dessert_list}" begin="0" end="3">
                    <a href="recipe_content_view?rc_recipe_id=${img.rc_recipe_id}">
                        <img src="${pageContext.request.contextPath}/upload/${img.uploadPath}/${img.uuid}_${img.fileName}" alt="Dessert image" />
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>