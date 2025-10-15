<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>BRAND – 도서 관리의 혁신</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200;300;400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

  <!-- 페이지 전용 CSS -->
  <link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>">
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
        <c:when test="${empty sessionScope.loginUser}">
          <a href="<c:url value='/login'/>">로그인</a>
          <a href="<c:url value='/register'/>">회원가입</a>
          <a href="<c:url value='/cart'/>">장바구니</a>
        </c:when>

        <%-- 로그인 후 --%>
        <c:otherwise>
          <span style="color:#666; font-weight:700;">
            ${sessionScope.loginUser}님 환영해요!
          </span>
          <a href="<c:url value='/mypage'/>">마이페이지</a>
          <a href="<c:url value='/cart'/>">장바구니</a>
          <a href="<c:url value='/logout'/>">로그아웃</a>
        </c:otherwise>
      </c:choose>
    </div>
  </nav>
</header>

<!-- 상단 프로모션 -->
<div class="promo" role="note" aria-label="프로모션">
  <div class="promo-content">
    <div class="promo-nav">
      <a href="<c:url value='/category'/>" class="nav-category">카테고리</a>
      <a href="<c:url value='/board'/>" class="nav-board">게시판</a>
    </div>
  </div>
</div>

<main>
  <!-- 히어로: 로그인 전/후 문구/버튼만 다르게 -->
  <section class="hero">
    <div class="hero-content">
      <c:choose>
        <c:when test="${empty sessionScope.loginUser}">
          <h1>온라인 서점에 오신 것을 환영합니다</h1>
          <p>다양한 도서를 만나보세요</p>
        </c:when>
        <c:otherwise>
          <h1>${sessionScope.loginUser}님, 오늘도 반가워요 👋</h1>
          <p>관심사 기반 추천과 최근 본 도서를 이어서 확인해보세요</p>
        </c:otherwise>
      </c:choose>

      <div class="main-search">
        <div class="search-box">
          <input type="text" class="search-input" placeholder="도서명, 저자명으로 검색하세요..." />
          <button class="search-button" aria-label="검색">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                 stroke-linecap="round" stroke-linejoin="round">
              <circle cx="11" cy="11" r="7"></circle>
              <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
          </button>
        </div>
      </div>

      <!-- 로그인 후엔 CTA 버튼 하나 더 -->
      <c:if test="${not empty sessionScope.loginUser}">
        <a class="btn" href="<c:url value='/mypage'/>">내 서재로 가기</a>
      </c:if>
    </div>
  </section>

  <!-- 이달의 책 / 개인화 추천 섹션 제목 분기 -->
  <section class="products-section">
    <div class="products-container">
      <c:choose>
        <c:when test="${empty sessionScope.loginUser}">
          <h2 class="section-title">이달의 책 😊</h2>
        </c:when>
        <c:otherwise>
          <h2 class="section-title">${sessionScope.loginUser}님을 위한 추천 📚</h2>
        </c:otherwise>
      </c:choose>

      <!-- 기존 카드 그대로 사용(나중에 서버데이터 바인딩하면 됨) -->
      <div class="products-grid" id="productsGrid">
        <div class="product-card">
          <div class="product-image"></div>
          <div class="product-info">
            <h3 class="product-title">책장 정리왕</h3>
            <div class="product-price">4,000원</div>
            <div class="product-rating">
              <div class="stars">
                <div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div>
              </div>
              <span class="rating-text">0 (0)</span>
            </div>
          </div>
        </div>

        <div class="product-card">
          <div class="product-image"></div>
          <div class="product-info">
            <h3 class="product-title">리딩 트래커</h3>
            <div class="product-price">3,000원</div>
            <div class="product-rating">
              <div class="stars">
                <div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div>
              </div>
              <span class="rating-text">0 (0)</span>
            </div>
          </div>
        </div>

        <div class="product-card">
          <div class="product-image"></div>
          <div class="product-info">
            <h3 class="product-title">도서관 매니저</h3>
            <div class="product-price">2,000원</div>
            <div class="product-rating">
              <div class="stars">
                <div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div>
              </div>
              <span class="rating-text">0 (0)</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 숨김 추가 카드(그대로) -->
      <div class="products-grid hidden" id="additionalProducts" style="margin-top: 40px;">
        <div class="product-card">
          <div class="product-image"></div>
          <div class="product-info">
            <h3 class="product-title">스마트 도서 추천</h3>
            <div class="product-price">5,000원</div>
            <div class="product-rating">
              <div class="stars">
                <div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div>
              </div>
              <span class="rating-text">0 (0)</span>
            </div>
          </div>
        </div>

        <div class="product-card">
          <div class="product-image"></div>
          <div class="product-info">
            <h3 class="product-title">독서 통계 분석</h3>
            <div class="product-price">3,500원</div>
            <div class="product-rating">
              <div class="stars">
                <div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div>
              </div>
              <span class="rating-text">0 (0)</span>
            </div>
          </div>
        </div>

        <div class="product-card">
          <div class="product-image"></div>
          <div class="product-info">
            <h3 class="product-title">도서 대출 관리</h3>
            <div class="product-price">2,500원</div>
            <div class="product-rating">
              <div class="stars">
                <div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div><div class="star"></div>
              </div>
              <span class="rating-text">0 (0)</span>
            </div>
          </div>
        </div>
      </div>

      <button class="load-more-btn" id="loadMoreBtn">더보기</button>
    </div>
  </section>

  <!-- 책 속 한 줄 (로그인 전/후 모두 노출, 필요하면 분기해도 됨) -->
  <section class="quotes-section">
    <div class="quotes-container">
      <div class="quotes-header">
        <h2 class="quotes-title">책 속 한 줄</h2>
        <p class="quotes-sub">
          <c:choose>
            <c:when test="${empty sessionScope.loginUser}">오늘의 문장을 골라 담아보세요 ✨</c:when>
            <c:otherwise>${sessionScope.loginUser}님 취향의 한 문장 ✨</c:otherwise>
          </c:choose>
        </p>
      </div>

      <!-- (기존 카드들 동일) -->
      <div class="q-wrap">
        <div class="q-track" id="quotesTrack">
          <!-- 카드들… (생략: 기존과 동일) -->
        </div>
        <div class="q-nav">
          <button type="button" class="q-btn" id="quotesPrev" aria-label="이전">‹</button>
          <button type="button" class="q-btn" id="quotesNext" aria-label="다음">›</button>
        </div>
      </div>
    </div>
  </section>

  <!-- 후기 / FAQ (그대로) -->
  <section class="testimonials-section">…</section>
  <section class="faq-section">…</section>
</main>

<!-- 푸터 -->
<footer class="footer">…</footer>

<!-- 페이지 전용 JS -->
<script src="<c:url value='/resources/js/main.js'/>"></script>
</body>
</html>
