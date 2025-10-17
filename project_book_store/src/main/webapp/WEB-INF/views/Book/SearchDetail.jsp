<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>책갈피 – 책 상세정보</title>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">

<!-- 외부 CSS -->
<link rel="stylesheet"
	href="<c:url value='/resources/css/SearchDetail.css'/>">
<meta name="ctx" content="${pageContext.request.contextPath}" />
<c:if test="${not empty _csrf}">
	<meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
</c:if>
</head>

<body>
	<!-- Header -->
	<header>
		<nav class="nav" aria-label="주요 메뉴">
			<a href="<c:url value='/'/>" class="brand"> <img
				src="<c:url value='/resources/img/book_logo.png'/>" alt="책갈피 로고"
				class="brand-logo" />
			</a>

			<!-- 로그인 전/후 분기 -->
			<div class="nav-right">
				<c:choose>
					<c:when test="${empty sessionScope.loginDisplayName}">
						<a href="<c:url value='/login'/>">로그인</a>
						<a href="<c:url value='/register'/>">회원가입</a>
						<a href="<c:url value='/cart'/>">장바구니</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/mypage'/>">마이페이지</a>
						<a href="<c:url value='/cart'/>">장바구니</a>
						<a href="<c:url value='/logout'/>">로그아웃</a>
						<span style="color: #666; font-weight: 700;">
							${sessionScope.loginDisplayName}님 </span>
					</c:otherwise>
				</c:choose>
			</div>
		</nav>
	</header>


	<!-- Page Content -->
	<main class="page-wrap">

		<!-- 상단 그라디언트 헤더 -->
<section class="detailhead">
  <div class="detailsubwrap">
    <h1 class="title">도서 상세정보</h1>
    <p class="meta subnote">책갈피가 엄선한 도서 정보를 한눈에 확인하세요.</p>
  </div>
</section>
		<div class="page-container">
			<div class="product-detail">
				<p class="breadcrumb in-card">
					홈 &gt; 도서 &gt;
					<c:out value="${book.book_title}" />
				</p>
				<div class="product-main">
					<div
						class="product-image <c:if test='${not empty book.book_image_path}'>has-image</c:if>">
						<c:choose>
							<c:when test="${not empty book.book_image_path}">
								<img src="<c:url value='${book.book_image_path}'/>"
									alt="<c:out value='${book.book_title}'/>">
							</c:when>
							<c:otherwise>
								<div class="placeholder">이미지 없음</div>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="product-info">
						<h1 class="product-title">
							<c:out value="${book.book_title}" />
						</h1>

						<div class="product-price">
							<c:choose>
								<c:when test="${book.book_price != null}">
									<fmt:formatNumber value="${book.book_price}" pattern="#,###" />원
              </c:when>
								<c:otherwise>가격 정보 없음</c:otherwise>
							</c:choose>
						</div>

						<div class="product-description">
							<p>
								<c:out
									value="${book.book_comm != null ? book.book_comm : '도서 소개 정보가 없습니다.'}" />
							</p>
						</div>

						<div class="product-actions">
							<button class="btn btn-primary" id="btnAddToCart" type="button">🛒장바구니 담기</button>
							<button class="btn btn-secondary" id="btnBuyNow" type="button">💳구매하기</button>
						</div>

						<%-- 장바구니 폼 --%>
						<form id="cartForm" method="post"
							action="${pageContext.request.contextPath}/cartAdd"
							style="display: none">
							<input type="hidden" name="book_id" value="${book.book_id}" /> <input
								type="hidden" name="quantity" value="1" />
							<c:if test="${not empty _csrf}">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
							</c:if>
						</form>

						<form id="buyForm" method="post"
							action="${pageContext.request.contextPath}/order/buy"
							style="display: none">
							<input type="hidden" name="book_id" value="${book.book_id}" />
							<c:if test="${not empty _csrf}">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
							</c:if>
						</form>
					</div>
				</div>
			</div>

			<!-- 도서 상세 정보 -->
			<div class="book-details-section">
				<h3>도서 상세 정보</h3>
				<div class="book-details-grid">
					<div class="book-detail-item">
						<span class="detail-label">저자</span><span class="detail-value"><c:out
								value="${book.book_writer}" /></span>
					</div>
					<div class="book-detail-item">
						<span class="detail-label">출판사</span><span class="detail-value"><c:out
								value="${book.book_pub}" /></span>
					</div>

					<div class="book-detail-item">
						<span class="detail-label">출간일</span> <span class="detail-value">
							<c:choose>
								<c:when test="${not empty book.book_date}">
									<fmt:formatDate value="${book.book_date}" pattern="yyyy-MM-dd" />
								</c:when>
								<c:otherwise>정보 없음</c:otherwise>
							</c:choose>
						</span>
					</div>

					<div class="book-detail-item">
						<span class="detail-label">ISBN</span> <span
							class="detail-value mono"><c:out value="${book.book_isbn}" /></span>
					</div>

					<div class="book-detail-item">
						<span class="detail-label">장르</span> <span class="detail-value">
							<span class="badge-genre"> <c:choose>
									<c:when test="${book.genre_id == 1}">소설</c:when>
									<c:when test="${book.genre_id == 2}">에세이</c:when>
									<c:when test="${book.genre_id == 3}">인문/사회</c:when>
									<c:when test="${book.genre_id == 4}">과학/기술</c:when>
									<c:when test="${book.genre_id == 5}">경제/경영</c:when>
									<c:otherwise>기타</c:otherwise>
								</c:choose>
						</span>
						</span>
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
				BRAND | 대표자 : 홍길동 | 사업자번호 : 123-34-56789<br> 개인정보보호책임자 : 홍길동 |
				이메일 : qshop@naver.com<br> 전화번호: 00-0000-0000 | 주소 : 부산시 부산진구
				범내골
			</div>
		</div>
	</footer>

	<script>
  // 스프링이 컨텍스트 경로까지 붙여서 안전한 절대경로를 만들어 줌
  const CART_URL = '<c:url value="/cartAdd"/>';
  const BUY_URL  = '<c:url value="/order/buy"/>'; // 필요 시

  // CSRF (사용 중일 때만 존재)
  const csrfToken  = document.querySelector('meta[name="_csrf"]')?.content;
  const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

  // 서버에서 book_id를 그대로 받음
  const BOOK_ID = ${book.book_id};

  document.getElementById('btnAddToCart').addEventListener('click', async () => {
    try {
      const headers = { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' };
      if (csrfToken && csrfHeader) headers[csrfHeader] = csrfToken;

      const res  = await fetch(CART_URL, {
        method: 'POST',
        headers,
        body: 'book_id=' + encodeURIComponent(BOOK_ID)
      });
      const text = (await res.text()).trim();

      if (text === 'success') {
        alert('장바구니 담기 완료!');
      } else {
        alert(text || '장바구니 담기 실패');
      }
    } catch (e) {
      console.error(e);
      alert('네트워크 오류로 실패했습니다.');
    }
  });

  document.getElementById('btnBuyNow').addEventListener('click', () => {
    // 필요 시 BUY_URL로 처리
    alert('구매하기는 추후 연동 예정입니다.');
  });
</script>

</body>
</html>