<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구매기록 | 책갈피</title>
    
    <!-- 폰트: 전체는 Noto Sans KR -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    
    <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/purchaseList.css">
</head>
<body>
   <header>
    <nav class="nav" aria-label="주요 메뉴">
      <a href="<c:url value='/'/>" class="brand">
        <img src="<c:url value='/resources/img/book_logo.png'/>" alt="책갈피 로고" class="brand-logo"/>
      </a>
      <div class="nav-right">
        <span id="userGreeting" style="color:var(--brand); font-weight:700;">
		  <c:choose>
			<c:when test="true">
			  마이페이지
			</c:when>
		  </c:choose>
        </span>
          <a href="<c:url value='/cart'/>">장바구니</a>
          <a href="<c:url value='/logout'/>">로그아웃</a>
          <span style="color:#666; font-weight:700;">
            ${sessionScope.loginDisplayName}님
      </div>
    </nav>
  </header>

    <!-- Promo Bar -->
    <div class="promo" aria-hidden="true"></div>

   <main class="page-wrap">
       <div class="page-container">
           <h1 class="page-title">마이페이지</h1>
   
           <div class="tab-nav">
               <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage'">정보</button>
               <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">내정보 수정</button>
               <button class="tab-button active" onclick="location.href='${pageContext.request.contextPath}/MyPage/purchaseList'">구매내역</button>
               <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage/withdraw'">회원탈퇴</button>
           </div>
   
           <div class="content-card">
               <div class="content-header">
                   <h2 class="content-title">구매 내역</h2>
               </div>
   
               <div class="table-container">
                   <table class="purchase-table">
                       <thead>
                           <tr>
                               <th>주문번호</th>
                               <th>주문일</th>
                               <th>도서명</th>
                               <th>수량</th>
                               <th>결제금액</th>
                           </tr>
                       </thead>
                       <tbody id="purchaseTableBody">
                    <c:choose>
                      <c:when test="${not empty purchaseList}">
                        <c:forEach var="item" items="${purchaseList}" varStatus="status">
                          <tr data-page="${fn:substringBefore((status.index div 10) + 1, '.')}">
                            <td>#${item.buy_id}</td>
                            <td><fmt:formatDate value="${item.purchase_date}" pattern="yyyy-MM-dd" /></td>
                            <td>${item.book.book_title}</td>
                            <td>${item.quantity}</td>
                            <td>₩${item.book.book_price * item.quantity}</td>
                          </tr>
                        </c:forEach>
                      </c:when>
                      <c:otherwise>
                        <tr>
                          <td colspan="5" style="text-align:center;">구매 내역이 없습니다.</td>
                        </tr>
                      </c:otherwise>
                    </c:choose>
                  </tbody>
                   </table>
               </div>
   
               <div class="pagination" id="pagination"></div>
           </div>
       </div>
   </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            © 책갈피 BRAND · 부산시 부산진구 범내골 · 00-0000-0000 · <a href="mailto:qshop@naver.com">qshop@naver.com</a>
        </div>
    </footer>

    <!-- JavaScript 파일 링크 -->
    <script src="${pageContext.request.contextPath}/resources/js/purchaseList.js"></script>
</body>
</html>
