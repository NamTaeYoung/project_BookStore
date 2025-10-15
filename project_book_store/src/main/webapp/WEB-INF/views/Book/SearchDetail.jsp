<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .book-image img {
    max-width: 300px;  /* 최대 너비 */
    max-height: 400px; /* 최대 높이 */
    width: auto;       /* 가로 세로 비율 유지 */
    height: auto;
    object-fit: contain; /* 이미지 비율 유지하며 영역 안에 맞춤 */
  }
</style>
</head>
<body>
  <div class="book-detail" style="display: flex; gap: 20px; align-items: flex-start;">
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
      <h2>${book.book_title}</h2>
      <p><strong>저자:</strong> ${book.book_writer}</p>
      <p><strong>출판사:</strong> ${book.book_pub}</p>
      <p><strong>출판일:</strong> <fmt:formatDate value="${book.book_date}" pattern="yyyy-MM-dd"/></p>
      <p><strong>장르:</strong> ${book.genre_name}</p>
      <p><strong>가격:</strong> ${book.book_price} 원</p>
      <p><strong>책소개</strong> <br>${book.book_comm}</p>
      
      <div style="margin-top: 20px; display: flex; gap: 10px;">
		    <!-- 장바구니 담기 버튼 -->
		    <form method="post" action="${pageContext.request.contextPath}/cart/add">
		      <input type="hidden" name="book_id" value="${book.book_id}" />
		      <button type="submit">장바구니 담기</button>
		    </form>
		
		    <!-- 바로 구매 버튼 -->
		    <form method="post" action="${pageContext.request.contextPath}/order/buy">
		      <input type="hidden" name="book_id" value="${book.book_id}" />
		      <button type="submit">바로 구매</button>
		    </form>
	  </div>
    </div>
  </div>
</body>
</html>
