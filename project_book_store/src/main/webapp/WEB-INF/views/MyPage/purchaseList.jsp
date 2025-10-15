<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
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
    <!-- Header -->
    <header>
        <nav class="nav" aria-label="주요 메뉴">
            <a href="${pageContext.request.contextPath}/main" class="brand">
                <img src="${pageContext.request.contextPath}/resources/img/book_logo.png" alt="책갈피 로고" class="brand-logo" />
            </a>
            <div class="nav-right">
                <span id="userGreeting" style="color:var(--brand); font-weight:700;">${sessionScope.userName}님 반갑습니다</span>
                <a href="#" onclick="logout()">로그아웃</a>
                <a href="${pageContext.request.contextPath}/cart">장바구니</a>
            </div>
        </nav>
    </header>

    <!-- Promo Bar -->
    <div class="promo" aria-hidden="true"></div>

    <!-- Page Content -->
    <main class="page-wrap">
        <div class="page-container">
            <!-- Page Title -->
            <h1 class="page-title">마이페이지</h1>

            <!-- Tab Navigation -->
            <div class="tab-nav">
                <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage/info'">정보</button>
                <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">내정보 수정</button>
                <button class="tab-button active" onclick="location.href='${pageContext.request.contextPath}/mypage/purchase'">구매내역</button>
                <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage/withdraw'">회원탈퇴</button>
            </div>

            <!-- Content Card -->
            <div class="content-card">
                <!-- Content Header -->
                <div class="content-header">
                    <h2 class="content-title">구매 내역</h2>
                    <div class="search-controls">
                        <input type="text" class="search-input" placeholder="주문번호/도서명 검색..." id="searchInput">
                        <button class="search-btn" onclick="performSearch()">검색</button>
                        <select class="status-select" id="statusFilter">
                            <option value="">전체 상태</option>
                            <option value="completed">결제완료</option>
                            <option value="shipping">배송중</option>
                            <option value="refunded">환불완료</option>
                        </select>
                    </div>
                </div>

                <!-- Purchase History Table -->
                <div class="table-container">
                    <table class="purchase-table">
                        <thead>
                            <tr>
                                <th>주문번호</th>
                                <th>주문일</th>
                                <th>도서명</th>
                                <th>수량</th>
                                <th>결제금액</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody id="purchaseTableBody">
                            <!-- 페이지 1 데이터 (10개) -->
                            <tr data-page="1">
                                <td>#20251001-0001</td>
                                <td>2025-10-01</td>
                                <td>모던 자바 인 액션</td>
                                <td>1</td>
                                <td>₩ 34,200</td>
                                <td><span class="status-badge status-completed">결제완료</span></td>
                            </tr>
                            <tr data-page="1">
                                <td>#20250928-0007</td>
                                <td>2025-09-28</td>
                                <td>클린 아키텍처</td>
                                <td>1</td>
                                <td>₩ 27,900</td>
                                <td><span class="status-badge status-shipping">배송중</span></td>
                            </tr>
                            <tr data-page="1">
                                <td>#20250920-0003</td>
                                <td>2025-09-20</td>
                                <td>데이터베이스 첫걸음</td>
                                <td>2</td>
                                <td>₩ 39,600</td>
                                <td><span class="status-badge status-refunded">환불완료</span></td>
                            </tr>
                            <tr data-page="1">
                                <td>#20250915-0005</td>
                                <td>2025-09-15</td>
                                <td>이펙티브 자바</td>
                                <td>1</td>
                                <td>₩ 28,800</td>
                                <td><span class="status-badge status-completed">결제완료</span></td>
                            </tr>
                            <tr data-page="1">
                                <td>#20250910-0002</td>
                                <td>2025-09-10</td>
                                <td>스프링 부트와 AWS로 혼자 구현하는 웹 서비스</td>
                                <td>1</td>
                                <td>₩ 32,400</td>
                                <td><span class="status-badge status-shipping">배송중</span></td>
                            </tr>
                            <tr data-page="1">
                                <td>#20250905-0006</td>
                                <td>2025-09-05</td>
                                <td>Vue.js 완벽 가이드</td>
                                <td>1</td>
                                <td>₩ 36,900</td>
                                <td><span class="status-badge status-completed">결제완료</span></td>
                            </tr>
                            <tr data-page="1">
                                <td>#20250830-0004</td>
                                <td>2025-08-30</td>
                                <td>파이썬 프로그래밍</td>
                                <td>1</td>
                                <td>₩ 29,700</td>
                                <td><span class="status-badge status-shipping">배송중</span></td>
                            </tr>
                            <tr data-page="1">
                                <td>#20250825-0008</td>
                                <td>2025-08-25</td>
                                <td>HTTP 완벽 가이드</td>
                                <td>1</td>
                                <td>₩ 45,000</td>
                                <td><span class="status-badge status-completed">결제완료</span></td>
                            </tr>
                            <tr data-page="1">
                                <td>#20250820-0009</td>
                                <td>2025-08-20</td>
                                <td>리팩토링 2판</td>
                                <td>1</td>
                                <td>₩ 38,700</td>
                                <td><span class="status-badge status-shipping">배송중</span></td>
                            </tr>

                            <!-- 페이지 2 데이터 (숨김) -->
                            <tr data-page="2" style="display: none;">
                                <td>#20250815-0010</td>
                                <td>2025-08-15</td>
                                <td>자바스크립트 완벽 가이드</td>
                                <td>1</td>
                                <td>₩ 52,200</td>
                                <td><span class="status-badge status-completed">결제완료</span></td>
                            </tr>
                            <tr data-page="2" style="display: none;">
                                <td>#20250810-0011</td>
                                <td>2025-08-10</td>
                                <td>Node.js 교과서</td>
                                <td>2</td>
                                <td>₩ 67,800</td>
                                <td><span class="status-badge status-refunded">환불완료</span></td>
                            </tr>
                            <tr data-page="2" style="display: none;">
                                <td>#20250805-0012</td>
                                <td>2025-08-05</td>
                                <td>React를 다루는 기술</td>
                                <td>1</td>
                                <td>₩ 41,400</td>
                                <td><span class="status-badge status-shipping">배송중</span></td>
                            </tr>
                            <tr data-page="2" style="display: none;">
                                <td>#20250730-0013</td>
                                <td>2025-07-30</td>
                                <td>알고리즘 문제 해결 전략</td>
                                <td>1</td>
                                <td>₩ 48,600</td>
                                <td><span class="status-badge status-completed">결제완료</span></td>
                            </tr>
                            <tr data-page="2" style="display: none;">
                                <td>#20250725-0014</td>
                                <td>2025-07-25</td>
                                <td>컴퓨터 구조와 원리</td>
                                <td>1</td>
                                <td>₩ 33,300</td>
                                <td><span class="status-badge status-refunded">환불완료</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="pagination" id="pagination">
                    <!-- 동적으로 생성됨 -->
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            © 책갈피 BRAND · 부산시 부산진구 범내골 · 00-0000-0000 · qshop@naver.com
        </div>
    </footer>

    <!-- JavaScript 파일 링크 -->
    <script src="${pageContext.request.contextPath}/resources/js/purchaseList.js"></script>
</body>
</html>