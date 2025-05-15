<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 공통 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <!-- 푸터 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <!-- 폰트어썸 아이콘 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<!-- 푸터 -->
<footer class="footer">
    <div class="container">
        <div class="footer_content">
            <div class="footer_logo">
                <img src="${pageContext.request.contextPath}/image/MATFLIX.png" alt="MATFLIX 로고">
                <h3>MATFLIX</h3>
            </div>
            <div class="footer_links">
                <div class="footer_section">
                    <h4>서비스 안내</h4>
                    <ul>
                        <li><a href="#">이용약관</a></li>
                        <li><a href="#">개인정보처리방침</a></li>
                        <li><a href="#">서비스 소개</a></li>
                    </ul>
                </div>
                <div class="footer_section">
                    <h4>고객 지원</h4>
                    <ul>
                        <li><a href="#">자주 묻는 질문</a></li>
                        <li><a href="#">문의하기</a></li>
                        <li><a href="#">피드백</a></li>
                    </ul>
                </div>
                <div class="footer_section">
                    <h4>소셜 미디어</h4>
                    <div class="social_icons">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer_bottom">
            <p>&copy; 2023 MATFLIX. All rights reserved.</p>
        </div>
    </div>
</footer>
</body>
</html>