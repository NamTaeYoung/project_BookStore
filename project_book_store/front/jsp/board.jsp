<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>BRAND – 게시판</title>

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200;300;400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

  <!-- 외부 CSS -->
  <link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>">
</head>
<body>

  <!-- 헤더 & 네비 -->
<header>
  <nav class="nav" aria-label="주요 메뉴">
    <a href="<c:url value='/'/>" class="brand">
      <img src="<c:url value='/resources/img/book_logo.png'/>" alt="책갈피 로고" class="brand-logo"/>
      <span class="brand-text" aria-hidden="true"></span>
    </a>

    <!-- 로그인 전/후 분기 -->
    <div class="nav-right">
      <c:choose>
        <%-- 로그인 전 --%>
        <c:when test="${empty sessionScope.loginId}">
          <a href="<c:url value='/login'/>">로그인</a>
          <a href="<c:url value='/register'/>">회원가입</a>
          <a href="<c:url value='/cart'/>">장바구니</a>
        </c:when>

        <%-- 로그인 후 --%>
        <c:otherwise>
          <a href="<c:url value='/mypage'/>">마이페이지</a>
          <a href="<c:url value='/cart'/>">장바구니</a>
          <a href="<c:url value='/logout'/>">로그아웃</a>
          <span style="color:#666; font-weight:700;">
            ${sessionScope.loginId}님
          </span>
        </c:otherwise>
      </c:choose>
    </div>
  </nav>
</header>

  <!--  메인 콘텐츠 -->
  <main class="main-content">
    <div class="page-header">
      <h1 class="page-title">게시판</h1>
      <p class="page-subtitle">도서관 관련 소식과 정보를 공유하는 공간입니다</p>
    </div> 
   

    <!-- 게시판 컨트롤 -->
    <div class="board-controls">
      <div class="search-box">
        <input type="text" placeholder="제목, 내용으로 검색..." />
        <button type="button">검색</button>
      </div>
      <a href="#" class="write-btn">글쓰기</a>
    </div>

    <!-- 게시판 테이블 -->
    <div class="board-table">
      <!-- 테이블 헤더 -->
      <div class="table-header">
        <div class="table-cell">번호</div>
        <div class="table-cell">제목</div>
        <div class="table-cell">작성자</div>
        <div class="table-cell">작성일</div>
        <div class="table-cell">조회</div>
      </div>
      <!-- 게시글 목록은 JS가 .table-row 를 추가 -->
    </div>

    <!-- 페이지네이션 -->
    <div class="pagination">
      <button disabled>이전</button>
      <button class="active">1</button>
      <button>2</button>
      <button>3</button>
      <button>4</button>
      <button>5</button>
      <button>다음</button>
    </div>
  </main>

  <!-- 외부 JS -->
  <script src="<c:url value='/resources/js/board.js'/>"></script>
</body>
</html>
