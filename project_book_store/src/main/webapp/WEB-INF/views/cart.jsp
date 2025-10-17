<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  
  <title>장바구니 | 책갈피</title>

  <meta name="ctx" content="${pageContext.request.contextPath}"/>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200;300;400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="<c:url value='/resources/css/cart.css'/>">
</head>
<body>
  <header>
    <nav class="nav" aria-label="주요 메뉴">
      <a href="<c:url value='/main'/>" class="brand">
        <img src="<c:url value='/resources/img/book_logo.png'/>" alt="책갈피 로고" class="brand-logo" />
        <span class="brand-text" aria-hidden="true"></span>
      </a>
      <div class="nav-right">
          <a href="<c:url value='/mypage'/>">마이페이지</a>
          <span id="userGreeting" style="color:var(--brand); font-weight:700;">
          <c:choose>
            <c:when test="${not empty sessionScope.loginUser}"></c:when>
            <c:otherwise>장바구니</c:otherwise>
          </c:choose>
        </span>
          <a href="<c:url value='/logout'/>">로그아웃</a>
          <span style="color:#666; font-weight:700;">
            ${sessionScope.loginId}님
      </div>
    </nav>
  </header>
  
  <div class="promo" aria-hidden="true"></div>
  
  <section class="page-hero">
    <div class="page-hero-inner">
      <div>
        <h1 class="page-title">장바구니</h1>
        <p class="page-sub">담아둔 상품을 확인하고 주문을 진행하세요.</p>
      </div>
    </div>
  </section>

<form id="orderForm" method="post" action="${pageContext.request.contextPath}/orderBooks">
  <main class="cart-section">
    <div class="cart-container">
      <section class="card" aria-labelledby="cartTitle">
        <div class="card-header">
          <input type="checkbox" id="selectAll" />
          <label for="selectAll" class="select-all">전체 선택</label>
          <span class="muted" id="selectedCount">(0개 선택)</span>
          <div style="margin-left:auto; display:flex; gap:8px;">
            <button class="btn btn-ghost" id="removeSelectedBtn" title="선택 삭제">선택 삭제</button>
            <button class="btn btn-ghost" id="clearCartBtn" title="비우기">전체 비우기</button>
          </div>
        </div>

        <div id="cartBody">
          <table class="cart-table" aria-describedby="cartTitle">
            <thead class="cart-head">
              <tr>
                <th style="width:36px;"></th>
                <th>상품정보</th>
                <th style="width:160px;">수량</th>
                <th style="width:140px;">가격</th>
              </tr>
            </thead>
            <tbody id="cartRows">
              <c:if test="${not empty cartList}">
                <c:forEach var="item" items="${cartList}">
                  <tr data-cart-id="${item.cart_id}">
                    <td><input type="checkbox" class="cart-checkbox" value="${item.book.book_id}" /></td>
                    <td class="product-info">
                      <img src="${item.book.book_image_path}"
     							alt="${item.book.book_title}" class="product-thumb"/>
                      <div>
                        <p class="product-name">${item.book.book_title}</p>
                        <p class="product-option">${item.book.book_writer}</p>
                      </div>
                    </td>
                    <td>
                      <input type="number" class="quantity-input" value="${item.quantity}" min="1" max="99" />
                    </td>
                    <td class="price">₩${item.book.book_price * item.quantity}</td>
                  </tr>
                </c:forEach>
              </c:if>
              <c:if test="${empty cartList}">
                <tr>
                  <td colspan="5" style="text-align:center; color:#666;">장바구니에 담긴 상품이 없습니다.</td>
                </tr>
              </c:if>
            </tbody>
          </table>
          <div id="emptyState" class="empty" style="display:none;">
            <div class="emoji">🛒</div>
            아직 담긴 상품이 없어요.<br />
            <a href="<c:url value='/category'/>" class="btn btn-brand" style="margin-top:14px;">상품 보러가기</a>
          </div>
        </div>
      </section>

      <aside class="summary">
        <div class="card">
          <div class="card-header">
            <h2 class="card-title" id="summaryTitle">주문 요약</h2>
          </div>
          <div class="card-body" aria-labelledby="summaryTitle">
            <div class="summary-line"><span>상품 금액</span><strong id="subtotalText">₩0</strong></div>
            <div class="summary-line"><span>배송비</span><strong id="shippingText">₩0</strong></div>
            <hr style="border:none; border-top:1px solid #eee; margin:6px 0;">
            <div class="summary-line summary-total"><span>전체 주문 금액</span><span id="grandTotalText">₩0</span></div>
            <p class="fine">₩30,000 이상 구매 시 무료배송</p>
            <div class="cart-ctas">
              <a class="btn btn-ghost cta-full" href="<c:url value='/search'/>">계속 쇼핑하기</a>
              <button class="btn btn-brand cta-full" id="checkoutBtn">주문하기</button>
            </div>
          </div>
        </div>
      </aside>
    </div>
  </main>
</form>

<script defer src="<c:url value='/resources/js/cart.js'/>"></script>
</body>
</html>
