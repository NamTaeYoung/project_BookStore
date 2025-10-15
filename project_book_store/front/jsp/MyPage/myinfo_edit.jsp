<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>내정보 수정 | 책갈피</title>

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

  <!-- 분리된 CSS -->
  <link rel="stylesheet" href="<c:url value='/resources/css/myinfo_edit.css'/>">
</head>
<body>
  <!-- 헤더 -->
  <header>
    <nav class="nav" aria-label="주요 메뉴">
      <a href="<c:url value='/main'/>" class="brand">
        <img src="<c:url value='/resources/img/book_logo.png'/>" alt="책갈피 로고" class="brand-logo" />
        <span class="brand-text" aria-hidden="true"></span>
      </a>
      <div class="nav-right">
        <span id="userGreeting" style="color:var(--brand); font-weight:700;">
          <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">${sessionScope.loginUser}님 반갑습니다</c:when>
            <c:otherwise>마이페이지</c:otherwise>
          </c:choose>
        </span>
          <a href="<c:url value='/cart'/>">장바구니</a>
          <a href="<c:url value='/logout'/>">로그아웃</a>
          <span style="color:#666; font-weight:700;">
            ${sessionScope.loginId}님
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
        <button class="tab-button" onclick="location.href='<c:url value="/mypage#info"/>'">정보</button>
        <button class="tab-button active" onclick="switchTab('edit', event)">내정보 수정</button>
        <button class="tab-button" onclick="location.href='<c:url value="/mypage/purchases"/>'">구매내역</button>
        <button class="tab-button" onclick="location.href='<c:url value="/mypage#withdraw"/>'">회원탈퇴</button>
      </div>

      <!-- Content Card -->
      <div class="content-card">
        <!-- 내정보 수정 -->
        <form class="card" id="formEdit" method="post" action="<c:url value='/mypage/edit'/>" novalidate>
          <div class="card-head">
            <h3 class="card-title">내정보 수정</h3>
            <div class="toolbar">
              <button type="submit" class="btn">저장</button>
              <button type="button" class="btn secondary" onclick="location.href='<c:url value="/mypage#info"/>'">취소</button>
            </div>
          </div>

          <div class="card-body">
            <div class="grid-2">
              <div>
                <label for="name">이름</label>
                <input id="name" name="user_name" type="text" value="${user.user_name}" required />
              </div>
              <div>
                <label for="nickname">닉네임</label>
                <input id="nickname" name="user_nickname" type="text" value="${user.user_nickname}" />
              </div>
              <div>
                <label for="email">이메일</label>
                <input id="email" name="user_email" type="email" value="${user.user_email}" required />
              </div>
              <div>
                <label for="tel">전화번호</label>
                <input id="tel" name="user_phone_num" type="tel" placeholder="010-0000-0000" value="${user.user_phone_num}" />
              </div>
              <div>
                <label for="zip">우편번호</label>
                <input id="zip" name="user_post_num" type="text" value="${user.user_post_num}" />
              </div>
              <div>
                <label for="addr">주소</label>
                <input id="addr" name="user_address" type="text" value="${user.user_address}" />
              </div>
              <div class="grid-2" style="grid-column:1/-1;">
                <div>
                  <label for="addr2">상세 주소</label>
                  <input id="addr2" name="user_detail_address" type="text" value="${user.user_detail_address}" />
                </div>
                <div>
                  <label for="birth">생년월일</label>
                  <input id="birth" name="birth" type="date" value="${user.birth}" />
                </div>
              </div>
            </div>

            <hr class="divider">

            <div class="grid-2">
              <div>
                <label for="pw">새 비밀번호</label>
                <input id="pw" name="newPw" type="password" autocomplete="new-password" />
              </div>
              <div>
                <label for="pw2">새 비밀번호 확인</label>
                <input id="pw2" name="newPwConfirm" type="password" autocomplete="new-password" />
              </div>
            </div>
            <p class="muted tip">비밀번호 변경은 선택 사항입니다. 변경 시 8~20자, 영문/숫자/특수문자 조합을 권장해요.</p>

            <!-- (선택) Spring Security 사용 시 CSRF 토큰 -->
            <c:if test="${not empty _csrf}">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </c:if>
          </div>
        </form>
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

  <!-- 분리된 JS -->
  <script src="<c:url value='/resources/js/myinfo_edit.js'/>"></script>
  
</body>
</html>
