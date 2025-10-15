<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>도서 목록/검색</title>
<style>
body { font-family: Arial, sans-serif; padding: 24px; }
form { margin-bottom: 16px; }
input[type=text] { width: 280px; padding: 8px; }
button { padding: 8px 12px; }
.book-card { border: 1px solid #ccc; padding: 10px; margin-bottom: 15px; display: flex; gap: 15px; }
.book-info { flex-grow: 1; }
.book-image img { width: 150px; height: auto; object-fit: contain; }
.book-info h3 a { text-decoration: none; color: inherit; }
.book-info h3 a:hover { text-decoration: none; color: inherit; }
</style>
</head>
<body>
<h2>도서 목록</h2>

<form method="get" action="${pageContext.request.contextPath}/Search">
    <input type="text" name="q" value="${fn:escapeXml(q)}" placeholder="제목 또는 저자로 검색" />
    <select name="genre_id">
        <option value="" ${selectedGenreId == null ? 'selected' : ''}>전체 장르</option>
        <c:forEach var="genre" items="${genreList}">
            <option value="${genre.genre_id}" ${genre.genre_id == selectedGenreId ? 'selected' : ''}>
                ${genre.genre_name}
            </option>
        </c:forEach>
    </select>
    <button type="submit">검색</button>
</form>

<c:choose>
    <c:when test="${empty bookList}">
        <p>표시할 도서가 없습니다.</p>
    </c:when>
    <c:otherwise>
        <c:forEach var="book" items="${bookList}">
            <div class="book-card">
                <div class="book-image">
                    <c:choose>
                        <c:when test="${not empty book.book_image_path}">
                            <img src="${book.book_image_path}" alt="책 사진" />
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/150?text=No+Image" alt="기본 이미지" />
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="book-info">
                    <h3>
                        <a href="${pageContext.request.contextPath}/SearchDetail?book_id=${book.book_id}">
                            ${book.book_title}
                        </a>
                    </h3>
                    <p><strong>저자:</strong> ${book.book_writer}</p>
                    <p><strong>출판사:</strong> ${book.book_pub}</p>
                    <p><strong>출판일:</strong>
                        <c:choose>
                            <c:when test="${not empty book.book_date}">
                                <fmt:formatDate value="${book.book_date}" pattern="yyyy-MM-dd" />
                            </c:when>
                            <c:otherwise>날짜 정보 없음</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>장르:</strong> ${book.genre_name}</p>
                    <p><strong>가격:</strong> ${book.book_price} 원</p>

                    <!-- 장바구니 버튼 폼 -->
                    <form method="post" action="${pageContext.request.contextPath}/cart.jsp">
                        <input type="hidden" name="book_id" value="${book.book_id}" />
                        <button type="submit">장바구니</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
</html>
