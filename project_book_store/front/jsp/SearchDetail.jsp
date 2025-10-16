<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>BRAND – 책 상세정보</title>

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

  <!-- 외부 CSS -->
  <link rel="stylesheet" href="<c:url value='/resources/css/SearchDetail.css'/>">
</head>

<body>
  <!-- Header -->
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

  <!-- Promo Bar -->
  <div class="promo" aria-hidden="true"></div>

  <!-- Page Content -->
  <main class="page-wrap">
    <div class="page-container">
      <!-- Breadcrumb -->
      <nav class="breadcrumb">
        <a href="<c:url value='/main'/>">홈</a> > 
        <a href="<c:url value='/books/monthly'/>">이달의 책</a> > 
        <span><c:out value="${book.title != null ? book.title : '책장 정리왕'}"/></span>
      </nav>

      <!-- Product Detail -->
      <div class="product-detail">
        <div class="product-main">
          <div class="product-image <c:if test='${not empty book.imageUrl}'>has-image</c:if>">
            <c:if test="${not empty book.imageUrl}">
              <img src="<c:url value='${book.imageUrl}'/>" alt="<c:out value='${book.title}'/>">
            </c:if>
            <%-- 이미지가 없으면 회색 배경 + 이모지(기본 CSS) --%>
          </div>

          <div class="product-info">
            <h1 class="product-title">
              <c:out value="${book.title != null ? book.title : '책장 정리왕'}"/>
            </h1>
            <div class="product-price">
              <c:choose>
                <c:when test="${book.price != null}">
                  <c:out value="${book.price}"/>원
                </c:when>
                <c:otherwise>4,000원</c:otherwise>
              </c:choose>
            </div>

            <div class="product-rating">
              <div class="stars" aria-label="별점">
                <div class="star <c:if test='${book.rating >= 1}'>filled</c:if>"></div>
                <div class="star <c:if test='${book.rating >= 2}'>filled</c:if>"></div>
                <div class="star <c:if test='${book.rating >= 3}'>filled</c:if>"></div>
                <div class="star <c:if test='${book.rating >= 4}'>filled</c:if>"></div>
                <div class="star <c:if test='${book.rating >= 5}'>filled</c:if>"></div>
              </div>
              <span class="rating-text">
                <c:out value="${book.rating != null ? book.rating : 0}"/> (<c:out value="${book.reviewCount != null ? book.reviewCount : 0}"/>)
              </span>
            </div>

            <div class="product-description">
              <p>
                <c:out value="${book.description != null ? book.description : '책장을 체계적으로 정리하고 관리할 수 있는 도구입니다. 도서 분류, 위치 추적, 대출 관리 등 다양한 기능을 제공합니다.'}"/>
              </p>
            </div>

            <div class="product-actions">
              <button class="btn btn-primary" id="btnAddToCart">🛒 장바구니 담기</button>
              <button class="btn btn-secondary" id="btnBuyNow">💳 바로 구매</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Product Tabs -->
      <div class="product-tabs">
        <div class="tab-nav">
          <button class="tab-button active" data-tab="details">도서정보</button>
          <button class="tab-button" data-tab="reviews">리뷰 (<c:out value="${book.reviewCount != null ? book.reviewCount : 0}"/>)</button>
          <button class="tab-button" data-tab="shipping">배송정보</button>
        </div>

        <!-- 도서 정보 -->
        <div id="detailsContent" class="tab-content active">
          <h3>도서 정보</h3>

          <div class="book-details-section">
            <h4>도서 상세 정보</h4>
            <div class="book-details-grid">
              <div class="book-detail-item"><span class="detail-label">저자</span><span class="detail-value"><c:out value="${book.author != null ? book.author : '김도서'}"/></span></div>
              <div class="book-detail-item"><span class="detail-label">출판사</span><span class="detail-value"><c:out value="${book.publisher != null ? book.publisher : '책갈피 출판사'}"/></span></div>
              <div class="book-detail-item"><span class="detail-label">출간일</span><span class="detail-value"><c:out value="${book.publishedAt != null ? book.publishedAt : '2024년 1월 15일'}"/></span></div>
              <div class="book-detail-item"><span class="detail-label">페이지</span><span class="detail-value"><c:out value="${book.pages != null ? book.pages : 320}"/>페이지</span></div>
              <div class="book-detail-item"><span class="detail-label">ISBN</span><span class="detail-value"><c:out value="${book.isbn != null ? book.isbn : '978-89-1234-567-8'}"/></span></div>
              <div class="book-detail-item"><span class="detail-label">분야</span><span class="detail-value"><c:out value="${book.category != null ? book.category : '컴퓨터/IT, 도서관리'}"/></span></div>
              <div class="book-detail-item"><span class="detail-label">판형</span><span class="detail-value"><c:out value="${book.size != null ? book.size : 'A5 (148×210mm)'}"/></span></div>
              <div class="book-detail-item"><span class="detail-label">언어</span><span class="detail-value"><c:out value="${book.lang != null ? book.lang : '한국어'}"/></span></div>
            </div>
          </div>

          <div class="book-intro-section">
            <h4>도서 소개</h4>
            <div class="book-intro-content">
              <p>
                <c:out value="${book.intro1 != null ? book.intro1 : '개인 도서관을 체계적으로 관리하고 싶어하는 모든 사람들을 위한 실용적인 가이드입니다.'}"/>
              </p>
              <p>
                <c:out value="${book.intro2 != null ? book.intro2 : '바코드 스캔, 클라우드 관리, 독서 진도 추적 등 현대적 도구 활용법을 상세히 설명합니다.'}"/>
              </p>
            </div>
          </div>

          <div class="book-toc-section">
            <h4>목차 미리보기</h4>
            <div class="toc-content">
              <div class="toc-chapter">
                <h5>1부. 도서 관리의 기초</h5>
                <ul>
                  <li>1장. 도서 분류의 원리</li>
                  <li>2장. 바코드 시스템 구축</li>
                  <li>3장. 디지털 카탈로그 만들기</li>
                </ul>
              </div>
              <div class="toc-chapter">
                <h5>2부. 실전 관리법</h5>
                <ul>
                  <li>4장. 대출/반납 시스템</li>
                  <li>5장. 독서 진도 관리</li>
                  <li>6장. 통계 및 분석</li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <!-- 리뷰 -->
        <div id="reviewsContent" class="tab-content">
          <h3>고객 리뷰</h3>
          <div class="review-summary">
            <div class="rating-overview">
              <div class="rating-score">
                <span class="score-number"><c:out value="${book.rating != null ? book.rating : '0.0'}"/></span>
                <div class="score-stars">
                  <span class="star">★</span><span class="star">★</span><span class="star">★</span><span class="star">★</span><span class="star">★</span>
                </div>
                <span class="score-text"><c:out value="${book.reviewCount != null ? book.reviewCount : 0}"/>개 리뷰</span>
              </div>
            </div>
            <div class="rating-breakdown">
              <div class="rating-item"><span class="rating-label">5점</span><div class="rating-bar"><div class="bar-fill" style="width:0%"></div></div><span class="rating-count">0</span></div>
              <div class="rating-item"><span class="rating-label">4점</span><div class="rating-bar"><div class="bar-fill" style="width:0%"></div></div><span class="rating-count">0</span></div>
              <div class="rating-item"><span class="rating-label">3점</span><div class="rating-bar"><div class="bar-fill" style="width:0%"></div></div><span class="rating-count">0</span></div>
              <div class="rating-item"><span class="rating-label">2점</span><div class="rating-bar"><div class="bar-fill" style="width:0%"></div></div><span class="rating-count">0</span></div>
              <div class="rating-item"><span class="rating-label">1점</span><div class="rating-bar"><div class="bar-fill" style="width:0%"></div></div><span class="rating-count">0</span></div>
            </div>
          </div>

          <div class="review-write-section">
            <h4>리뷰 작성하기</h4>
            <div class="review-form">
              <div class="form-group">
                <label>평점</label>
                <div class="star-rating">
                  <input type="radio" name="rating" value="5" id="star5"><label for="star5">★</label>
                  <input type="radio" name="rating" value="4" id="star4"><label for="star4">★</label>
                  <input type="radio" name="rating" value="3" id="star3"><label for="star3">★</label>
                  <input type="radio" name="rating" value="2" id="star2"><label for="star2">★</label>
                  <input type="radio" name="rating" value="1" id="star1"><label for="star1">★</label>
                </div>
              </div>
              <div class="form-group">
                <label for="reviewText">리뷰 내용</label>
                <textarea id="reviewText" placeholder="상품에 대한 솔직한 리뷰를 작성해주세요." rows="4"></textarea>
              </div>
              <button class="btn btn-primary" id="btnSubmitReview">리뷰 등록</button>
            </div>
          </div>

          <div class="review-list">
            <div class="no-reviews">
              <h4>아직 등록된 리뷰가 없습니다</h4>
              <p>첫 번째 리뷰를 작성해보세요!</p>
            </div>
          </div>
        </div>

        <!-- 배송정보 -->
        <div id="shippingContent" class="tab-content">
          <h3>배송 정보</h3>

          <div class="shipping-section">
            <h4>물리적 배송</h4>
            <div class="shipping-info-card">
              <div class="info-row"><span class="info-label">배송 방법</span><span class="info-value">택배 (CJ대한통운)</span></div>
              <div class="info-row"><span class="info-label">배송 시간</span><span class="info-value">주문 후 1-2일 (영업일 기준)</span></div>
              <div class="info-row"><span class="info-label">배송비</span><span class="info-value">3,000원 (5만원 이상 구매시 무료)</span></div>
              <div class="info-row"><span class="info-label">배송 지역</span><span class="info-value">전국 (제주도, 도서산간 지역 포함)</span></div>
            </div>

            <div class="shipping-notice">
              <h5>배송 안내</h5>
              <ul>
                <li>오후 2시 이전 주문시 당일 발송 (영업일 기준)</li>
                <li>배송 추적은 주문번호로 가능합니다.</li>
                <li>배송 중 파손시 즉시 교환해드립니다.</li>
                <li>부재중으로 인한 반송시 재배송비가 발생할 수 있습니다.</li>
              </ul>
            </div>
          </div>

          <div class="shipping-section">
            <h4>반품/교환 정책</h4>
            <div class="return-policy">
              <div class="policy-item"><div class="policy-content"><strong>반품/교환 기간</strong><p>상품 수령 후 7일 이내 (단, 상품의 내용을 확인하기 위하여 포장을 훼손한 경우는 제외)</p></div></div>
              <div class="policy-item"><div class="policy-content"><strong>반품/교환 비용</strong><p>고객 변심의 경우 왕복 배송비 6,000원, 상품 불량의 경우 무료</p></div></div>
              <div class="policy-item"><div class="policy-content"><strong>문의처</strong><p>고객센터: 1588-0000 (평일 09:00-18:00)</p></div></div>
            </div>
          </div>
        </div>
      </div>

      <!-- Related Products -->
      <div class="related-section">
        <h2 class="related-title">관련 상품</h2>
        <div class="related-grid">
          <div class="related-card" onclick="location.href='<c:url value="/product/2"/>'">
            <div class="related-image"></div>
            <h3 class="related-title-text">리딩 트래커</h3>
            <p class="related-price">3,000원</p>
          </div>
          <div class="related-card" onclick="location.href='<c:url value="/product/3"/>'">
            <div class="related-image"></div>
            <h3 class="related-title-text">도서관 매니저</h3>
            <p class="related-price">2,000원</p>
          </div>
          <div class="related-card" onclick="location.href='<c:url value="/product/4"/>'">
            <div class="related-image"></div>
            <h3 class="related-title-text">스마트 도서 추천</h3>
            <p class="related-price">5,000원</p>
          </div>
        </div>
      </div>
    </div>
  </main>

  <!-- Footer -->
  <footer class="footer">
    <div class="footer-container">
      <div class="footer-brand">BRAND</div>
      <div class="footer-info">
        BRAND | 대표자 : 홍길동 | 사업자번호 : 123-34-56789<br>
        통신판매업 : 0000-부산시-0000호 | 개인정보보호책임자 : 홍길동 | 이메일 : qshop@naver.com<br>
        전화번호: 00-0000-0000 | 주소 : 부산시 부산진구 범내골
      </div>
    </div>
  </footer>

  <!-- 외부 JS -->
  <script src="<c:url value='/resources/js/SearchDetail.js'/>"></script>
</body>
</html>
