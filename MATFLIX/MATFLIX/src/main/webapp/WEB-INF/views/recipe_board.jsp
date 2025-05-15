<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<html>
<head>
    <style>
        .recipe_grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .recipe_card {
            width: 270px;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            font-family: sans-serif;
        }
        .recipe_card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .recipe_card p {
            padding: 10px;
            margin: 0;
            font-size: 14px;
        }
        .div_page ul {
            display: flex;
            list-style: none;
        }
    </style>
    <style>
    .star-display {
        color: #ffc107;
        font-size: 1.2em;
    }
    .star-display .empty {
        color: #ddd;
    }
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<button class="add_recipe_btn" onclick="location.href='insert_recipe'"><i class="fas fa-plus"></i> 새 레시피 등록</button>

<!-- 검색창 -->
<form method="get" id="searchForm">
    <select name="rc_type">
        <option value="" <c:out value="${pageMaker.cri.rc_type == null ? 'selected':''}"/>>전체</option>
        <option value="T" <c:out value="${pageMaker.cri.rc_type eq 'T' ? 'selected':''}"/>>제목</option>
        <option value="C" <c:out value="${pageMaker.cri.rc_type eq 'C' ? 'selected':''}"/>>내용</option>
        <option value="TC" <c:out value="${pageMaker.cri.rc_type eq 'TC' ? 'selected':''}"/>>제목 or 내용</option>
    </select>

    <!-- Criteria 를 이용해서 키워드 값을 넘김 -->
    <input type="text" name="rc_keyword" value="${pageMaker.cri.rc_keyword}">
    <!-- 전체검색중 4페이지에서 내용을 88 키워드로 검색시 안나올때 처리 -->
    <input type="hidden" name="rc_pageNum" value="1">
    <input type="hidden" name="rc_amount" value="${pageMaker.cri.rc_amount}">
    <button>입력</button>
</form>
<div class="recipe_grid">
    <c:forEach var="recipe" items="${recipe_list_all}">
        <c:set var="recipe_id" value="${recipe.rc_recipe_id}" />
        <a href="recipe_content_view?rc_recipe_id=${recipe.rc_recipe_id}">
            <div class="recipe_card">
                <c:set var="found_image" value="false" />
                <c:forEach var="attach" items="${file_list_all}">
                    <c:if test="${!found_image && attach.rc_recipe_id == recipe_id && attach.image}">
                        <img src="/upload/${attach.uploadPath}/${attach.uuid}_${attach.fileName}" alt="${recipe.rc_name}" />
                        <c:set var="found_image" value="true" />
                    </c:if>
                </c:forEach>

                <p>
                    ${recipe.rc_recipe_id}. ${recipe.rc_name} <br/>
                    작성자: 
                    <c:forEach var="mem" items="${mem_list}">
                        <c:if test="${mem.mf_no == recipe.mf_no}">
                            ${mem.mf_nickname}
                        </c:if>
                    </c:forEach>
                </p>
                <!-- 평균 별점 표시 -->
                <c:if test="${not empty recipe.star_score}">
                    <div class="star-display">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= recipe.star_score}">
                                    &#9733; <!-- filled star -->
                                </c:when>
                                <c:when test="${i - 1 < recipe.star_score && recipe.star_score < i}">
                                    &#9733; <!-- half star로 대체할 수도 있음 -->
                                </c:when>
                                <c:otherwise>
                                    <span class="empty">&#9733;</span> <!-- empty star -->
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        (${recipe.star_score}점)
                    </div>
                </c:if>
            </div>
        </a>
    </c:forEach>
</div>

<h3>${pageMaker}</h3>
<div class="div_page">
    <ul>
        <c:if test="${pageMaker.rc_prev}">
            <li class="paginate_button">
                <a href="${pageMaker.rc_startPage -1}">
                    [Previous]
                </a>
            </li>
        </c:if>

        <c:forEach var="num" begin="${pageMaker.rc_startPage}" end="${pageMaker.rc_endPage}">
            <li class="paginate_button" ${pageMaker.cri.rc_pageNum==num ? "style='color: red;'" :""}>
                <a href="${num}">
                    [${num}]
                </a>&nbsp;&nbsp;&nbsp;&nbsp;
            </li>
        </c:forEach>

        <c:if test="${pageMaker.rc_next}">
            <li class="paginate_button">
                <a href="${pageMaker.rc_endPage +1}">
                    [Next]
                </a>
            </li>
        </c:if>
    </ul>
</div>
<form id="actionForm" action="recipe_board" method="get">
    <input type="hidden" name="rc_pageNum" value="${pageMaker.cri.rc_pageNum}">
    <input type="hidden" name="rc_amount" value="${pageMaker.cri.rc_amount}">
    <input type="hidden" name="rc_type" value="${pageMaker.cri.rc_type}">
    <input type="hidden" name="rc_keyword" value="${pageMaker.cri.rc_keyword}">
</form>
</body>
</html>
<script>
var actionForm = $("#actionForm");
    // 페이지번호 처리
    $(".paginate_button a").on("click", function (e) {
        e.preventDefault();
        console.log("click~!!!");
        console.log("@# href =>" + $(this).attr("href"));
        actionForm.find("input[name='rc_pageNum']").val($(this).attr("href"));

        // actionForm.submit();

        //버그 처리(게시글 클릭후 뒤로가기 누른후 다른 페이지 클릭할때 content_view가 작동되는것을 해결)
        actionForm.attr("action", "recipe_board").submit();
    }); // end of paginate_button click

    var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function () {
				// alert("검색");

				// 키워드 입력 받을 조건
				if (searchForm.find("option:selected").val() != ""&& !searchForm.find("input[name='rc_keyword']").val()) {
					alert("키워드를 입력하세요.");
					return false;
				}

				searchForm.attr("action", "recipe_board").submit();
			}); // end of searchForm click

			// type 콤보박스 변경
			$("#searchForm select").on("change", function () {
				if (searchForm.find("option:selected").val() == "") {
					// 키워드를 널값으로 변경
					searchForm.find("input[name='rc_keyword']").val("");
				}
			}); // end of searchForm click 2
</script>