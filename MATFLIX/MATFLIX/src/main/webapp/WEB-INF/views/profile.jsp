<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MATFLIX - 프로필</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      $(document).ready(function() {
        $('.tab_btn[data-tab="account_settings"]').on('click', function() {
          window.location.href = '/account';
        });
      });
    </script>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="mypage_container">
        &lt;!-- 프로필 섹션 -->
        <section class="profile_section">
            <div class="profile_header">
                <div class="profile_image_large">
                    <img src="${pageContext.request.contextPath}/resources/image/MATFLIX.png" alt="프로필 이미지">
                    <button class="edit_profile_image"><i class="fas fa-camera"></i></button>
                </div>
                <div class="profile_info_container">
                    <div class="profile_info">
                        <h2>
                            ${user.getMf_nickname()}
                            <form action="${pageContext.request.contextPath}/nickname_form" method="get" style="display:inline;">
                                <input type="hidden" name="mf_id" value="${user.getMf_id()}"/>
                                <button type="submit" class="edit_profile_btn tab_btn">
                                    <i class="fas fa-edit user_nick_name"></i>닉네임 수정
                                </button>
                            </form>
                        </h2>
                    </div>

                    <div class="user_bio">안녕하세요! 맛있는 요리를 사랑하는 요리 초보입니다.</div>
                    <div class="profile_stats">
                        <div class="stat_item">
                            <span class="stat_number">15</span>
                            <span class="stat_label">레시피</span>
                        </div>
                        <div class="stat_item">
                            <span class="stat_number">142</span>
                            <span class="stat_label">팔로워</span>
                        </div>
                        <div class="stat_item">
                            <span class="stat_number">56</span>
                            <span class="stat_label">팔로잉</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        &lt;!-- 탭 메뉴 -->
        <div class="mypage_tabs">
            <a href="my_recipe" class="active">내 레시피</a>
            <a href="${pageContext.request.contextPath}/favorites/recipe/myFavoriteRecipes">나의 즐겨찾기</a>
            <button class="tab_btn" data-tab="liked_recipes">추천한 레시피</button>
            <button class="tab_btn" data-tab="account_settings">계정 설정</button>
        </div>

        &lt;!-- 내 게시글 목록 -->
        <div class="profile_board_list">
            <c:forEach var="board" items="${profile_board_list}">
                <div class="profile_board_item">
                    <div class="profile_board_title">
                        <a href="content_view?pageNum=1&amount=10&type=&keyword=&boardNo=${board.boardNo}">
                            ${board.boardTitle}
                        </a>
                    </div>
                    <div class="profile_board_stats">
                        <span><i class="fas fa-heart"></i> 추천 ${board.recommend_count}</span>
                        <span><i class="fas fa-eye"></i> 조회 ${board.boardHit}</span>
                    </div>
                    <div class="profile_board_date">
                        <i class="far fa-calendar-alt"></i> ${board.boardDate}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>