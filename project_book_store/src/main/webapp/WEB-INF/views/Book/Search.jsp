<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>도서 목록/검색</title>
<style>
body {
   font-family: Arial, sans-serif;
   padding: 24px;
}

form {
   margin-bottom: 16px;
   display: flex;
   gap: 8px;
   align-items: center;
}

input[type=text] {
   width: 280px;
   padding: 8px;
}

button {
   padding: 8px 12px;
   cursor: pointer;
}

/* 탭 스타일 */
.tabs {
   display: flex;
   gap: 10px;
   flex-wrap: wrap;
   margin: 8px 0 16px;
   padding-bottom: 8px;
   border-bottom: 1px solid #e5e5e5
}

.tab {
   padding: 6px 14px;
   border: 1px solid #ddd;
   border-radius: 9999px;
   text-decoration: none;
   color: #333;
   background: #fff;
   font-weight: 600;
   transition: .2s
}

.tab:hover {
   background: #f6f6f6
}

.tab.active {
   background: #333;
   color: #fff;
   border-color: #333
}

.book-card {
   border: 1px solid #ccc;
   padding: 10px;
   margin-bottom: 15px;
   display: flex;
   gap: 15px;
}

.book-info {
   flex-grow: 1;
}

.book-image img {
   width: 150px;
   height: auto;
   object-fit: contain;
}

.book-info h3 a {
   text-decoration: none;
   color: inherit;
}

.book-info h3 a:hover {
   text-decoration: underline;
   color: #333;
}

.hint {
   color: #666;
   margin: 8px 0 16px
}
</style>
</head>
<body>
   <h2>도서 목록</h2>

   <%-- 현재 선택된 장르 --%>
   <c:set var="selId"
      value="${empty selectedGenreId ? (empty param.genre_id ? 0 : param.genre_id) : selectedGenreId}" />
   <c:set var="trimQ" value="${empty q ? '' : fn:trim(q)}" />

   <%-- 폼 action도 c:url로 --%>
   <c:url var="searchAction" value="/Search" />
   <form method="get" action="${searchAction}">
      <input type="text" name="q" value="${fn:escapeXml(trimQ)}"
         placeholder="제목 또는 저자로 검색" /> <input type="hidden" name="genre_id"
         value="${selId}" />
      <button type="submit">검색</button>
   </form>

   <div class="tabs">
      <%-- 전체 탭 --%>
      <c:url var="allUrl" value="/Search">
         <c:param name="q" value="${trimQ}" />
         <c:param name="genre_id" value="0" />
      </c:url>
      <!-- ❌ ${pageContext.request.contextPath} 붙이지 말기 -->
      <a href="${allUrl}" class="tab ${selId == 0 ? 'active' : ''}">전체</a>

      <%-- 장르 탭 --%>
      <c:forEach var="genre" items="${genreList}">
         <c:url var="gUrl" value="/Search">
            <c:param name="q" value="${trimQ}" />
            <c:param name="genre_id" value="${genre.genre_id}" />
         </c:url>
         <!-- ❌ 여기에도 contextPath 다시 붙이면 안 됨 -->
         <a href="${gUrl}"
            class="tab ${selId == genre.genre_id ? 'active' : ''}">
            ${genre.genre_name} </a>
      </c:forEach>
   </div>



   <c:choose>
      <%-- 검색 전 초기 화면: 안내 멘트만 표시 --%>
      <c:when test="${showInitial}">
         <p class="hint">검색어를 입력하거나 위의 장르 탭을 선택해 보세요.</p>
      </c:when>

      <%-- 결과 없음 --%>
      <c:when test="${empty bookList}">
         <p>표시할 도서가 없습니다.</p>
      </c:when>

      <%-- 결과 목록 --%>
      <c:otherwise>
         <c:forEach var="book" items="${bookList}">
            <div class="book-card">
               <div class="book-image">
                  <c:choose>
                     <c:when test="${not empty book.book_image_path}">
                        <img src="${book.book_image_path}" alt="책 사진" />
                     </c:when>
                     <c:otherwise>
                        <img src="https://via.placeholder.com/150?text=No+Image"
                           alt="기본 이미지" />
                     </c:otherwise>
                  </c:choose>
               </div>

               <div class="book-info">
                  <c:url var="detailUrl" value="/SearchDetail">
                     <c:param name="book_id" value="${book.book_id}" />
                  </c:url>

                  <h3>
                     <a href="${detailUrl}"> ${book.book_title} </a>
                  </h3>
                  <p>
                     <strong>저자:</strong> ${book.book_writer}
                  </p>
                  <p>
                     <strong>출판사:</strong> ${book.book_pub}
                  </p>
                  <p>
                     <strong>출판일:</strong>
                     <c:choose>
                        <c:when test="${not empty book.book_date}">
                           <fmt:formatDate value="${book.book_date}" pattern="yyyy-MM-dd" />
                        </c:when>
                        <c:otherwise>날짜 정보 없음</c:otherwise>
                     </c:choose>
                  </p>
                  <p>
                     <strong>장르:</strong> ${book.genre_name}
                  </p>
                  <p>
                     <strong>가격:</strong> ${book.book_price} 원
                  </p>

                  <form method="post"
                     action="${pageContext.request.contextPath}/cartAdd"
                     onsubmit="return addCartAlert(this);">
                     <input type="hidden" name="book_id" value="${book.book_id}" />
                     <button type="submit">장바구니</button>
                  </form>

                  <script>
                     function addCartAlert(form) {
                        alert('장바구니에 담겼습니다!');

                        // AJAX 요청
                        const xhr = new XMLHttpRequest();
                        xhr.open(form.method, form.action, true);
                        xhr.setRequestHeader('Content-Type',
                              'application/x-www-form-urlencoded');

                        // form 데이터 읽어서 전송
                        const formData = new FormData(form);
                        const params = new URLSearchParams(formData)
                              .toString();
                        xhr.send(params);

                        return false; // 폼 실제 제출 막기
                     }
                  </script>

               </div>
            </div>
         </c:forEach>
      </c:otherwise>
   </c:choose>
</body>
</html>
