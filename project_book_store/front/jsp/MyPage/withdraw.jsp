<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴 | 책갈피</title>
    
    <!-- 폰트: 전체는 Noto Sans KR -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    
    <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/withdraw.css">
</head>
<body>
    <!-- 헤더 -->
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

    <!-- 본문 -->
    <main class="page-wrap">
        <div class="page-container">
            <!-- Page Title -->
            <h1 class="page-title">마이페이지</h1>

            <!-- Tab Navigation -->
            <div class="tab-nav">
                <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage/info'">정보</button>
                <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">내정보 수정</button>
                <button class="tab-button" onclick="location.href='${pageContext.request.contextPath}/mypage/purchase'">구매내역</button>
                <button class="tab-button active" onclick="switchTab('withdraw')">회원탈퇴</button>
            </div>

            <!-- Content Card -->
            <div class="content-card">
                <div class="withdraw-container">
                    <h2 class="withdraw-title">회원 탈퇴</h2>
                    
                    <!-- 주의사항 -->
                    <div class="warning-box">
                        <div class="warning-header">
                            <div class="warning-icon">!</div>
                            <p class="warning-text">탈퇴 시 주의사항을 꼭 확인해주세요.</p>
                        </div>
                        <ul class="warning-list">
                            <li>회원정보 및 계정 내역은 <strong>즉시 삭제</strong>되며 복구할 수 없습니다.</li>
                            <li>탈퇴 후 30일 동안 재가입이 제한될 수 있습니다.</li>
                            <li>법적 보관 의무에 따라 일부 거래 내역은 일정 기간 보관됩니다.</li>
                        </ul>
                    </div>

                    <!-- 탈퇴 폼 -->
                    <form id="withdrawForm">
                        <div class="form-group">
                            <label class="form-label" for="userId">아이디</label>
                            <input type="text" id="userId" class="form-input" value="${sessionScope.userId}" disabled>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="userPassword">본인확인을 위해 비밀번호를 입력해주세요</label>
                            <input type="password" id="userPassword" class="form-input" placeholder="비밀번호" required>
                        </div>

                        <div class="button-group">
                            <button type="submit" class="btn btn-primary">회원 탈퇴</button>
                            <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/mypage/info'">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <!-- 푸터 -->
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

    <!-- JavaScript 파일 링크 -->
    <script src="${pageContext.request.contextPath}/resources/js/withdraw.js"></script>
</body>
</html>