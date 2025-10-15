<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>BRAND – 책 찾아보기</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200;300;400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<c:url value='/resources/css/kategorie.css'/>">
</head>
<body>

  <header>
    <nav class="nav" aria-label="주요 메뉴">
      <a href="<c:url value='/main'/>" class="brand">
        <img src="<c:url value='/resources/img/book_logo.png'/>" alt="책갈피 로고" class="brand-logo" />
      </a>
      <div class="nav-right">
        <a href="<c:url value='/login'/>">로그인</a>
        <a href="<c:url value='/register'/>">회원가입</a>
        <a href="<c:url value='/cart'/>">장바구니</a>
      </div>
    </nav>
  </header>

  <!-- 서브 헤더 -->
  <section class="subhead">
    <div class="subwrap">
      <div>
        <h1 class="title">책 찾아보기</h1>
        <div class="meta"><span id="countText">총 0권</span> · 카테고리/정렬로 골라보세요</div>
      </div>
      <div class="controls">
        <select id="sortSelect" class="select" aria-label="정렬">
          <option value="popular">인기순</option>
          <option value="new">최신순</option>
          <option value="low">가격 낮은순</option>
          <option value="high">가격 높은순</option>
        </select>
      </div>
    </div>
  </section>

  <!-- 카테고리 -->
  <div class="cats" role="navigation" aria-label="카테고리">
    <div class="cats-inner">
      <button class="cat-btn active" data-cat="all">전체</button>
      <button class="cat-btn" data-cat="novel">소설</button>
      <button class="cat-btn" data-cat="essay">에세이</button>
      <button class="cat-btn" data-cat="humanity">인문/사회</button>
      <button class="cat-btn" data-cat="science">과학/기술</button>
      <button class="cat-btn" data-cat="economy">경제/경영</button>
    </div>
  </div>

  <!-- 리스트 -->
  <main class="section">
    <div class="container">
      <h2 class="section-title">전체 도서</h2>

      <div id="grid" class="grid"></div>
      <div id="grid2" class="grid hidden" style="margin-top:24px;"></div>

      <div class="pager" id="pager" style="display:none;">
        <button class="page-btn active" data-page="1">1</button>
        <button class="page-btn" data-page="2">2</button>
      </div>
    </div>
  </main>

  <footer class="k-footer">
    <div class="nav k-foot-inner">
      <div class="k-foot-brand">BRAND</div>
      <div class="k-foot-copy">© BRAND BookStore</div>
    </div>
  </footer>

  <script src="<c:url value='/resources/js/kategorie.js'/>"></script>
</body>
</html>