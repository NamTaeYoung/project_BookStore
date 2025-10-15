<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 | 책갈피</title>
	<!-- 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

	<!-- 외부 CSS -->
  	<link rel="stylesheet" href="<c:url value='/resources/css/register.css'/>">
</head>
<body>
    <!-- Header -->
    <header>
        <nav class="nav" aria-label="주요 메뉴">
            <a href="<c:url value='/main'/>" class="brand">
            	<img src="<c:url value='/resources/img/book_logo.png'/>" alt="책갈피 로고" class="brand-logo" />
            </a>
            <div class="nav-right">
                <a href="<c:url value='/login'/>">로그인</a>
                <a href="<c:url value='/register'/>" aria-current="page" style="font-weight:700; color:var(--brand)">회원가입</a>
                <a href="#">장바구니</a>
            </div>
        </nav>
    </header>

    <!-- 얇은 갈색 줄 -->
    <div class="promo" aria-hidden="true"></div>

    <!-- Signup -->
    <main class="auth-wrap">
        <section class="auth-card" aria-label="회원가입">
            <!-- 폼 -->
            <div class="auth-form">
                <h1 class="auth-title">회원가입</h1>
                <p class="auth-desc">간단한 정보만 입력하면 도서 관리 서비스를 바로 이용할 수 있어요.</p>

                <form id="signupForm" novalidate>
                    <!-- 이름 / 닉네임 -->
                    <div class="grid-2">
                        <div class="field">
                            <label class="label" for="name">이름</label>
                            <input class="input" id="name" name="name" type="text" placeholder="홍길동" minlength="2"
                                required />
                        </div>
                        <div class="field">
                            <label class="label" for="nickname">닉네임</label>
                            <input class="input" id="nickname" name="nickname" type="text" placeholder="책매니저" />
                        </div>
                    </div>

                    <!-- 아이디 -->
                    <div class="field">
                        <label class="label" for="id">아이디</label>
                        <input class="input" id="id" name="id" type="text" inputmode="text" placeholder="영문/숫자 4~20자"
                            minlength="4" maxlength="20" pattern="^[a-zA-Z0-9_]{4,20}$" required />
                    </div>

                    <!-- 비밀번호 / 확인 -->
                    <div class="grid-2">
                        <div class="field">
                            <label class="label" for="password">비밀번호</label>
                            <input class="input" id="password" name="password" type="password"
                                placeholder="8자 이상, 영문/숫자 조합" minlength="8" required />
                        </div>
                        <div class="field">
                            <label class="label" for="password2">비밀번호 확인</label>
                            <input class="input" id="password2" name="password2" type="password" placeholder="비밀번호 재입력"
                                minlength="8" required />
                        </div>
                    </div>

                    <!-- 이메일 + 인증번호 보내기 -->
                    <div class="field">
                        <label class="label" for="email">이메일</label>
                        <div class="row-inline">
                            <input class="input" id="email" name="email" type="email" inputmode="email"
                                placeholder="you@example.com" required />
                            <button type="button" class="btn-auth" id="btnSend">인증번호 보내기</button>
                        </div>
                    </div>

                    <!-- 인증번호 + 확인 -->
                    <div class="field">
                        <label class="label" for="emailCode">인증번호</label>
                        <div class="row-inline">
                            <input class="input" id="emailCode" name="emailCode" type="text" placeholder="인증번호" />
                            <button type="button" class="btn-auth" id="btnVerify" disabled>인증번호 확인</button>
                        </div>
                    </div>

                    <!-- 전화번호 -->
                    <div class="field">
                        <label class="label" for="phone">휴대폰 번호</label>
                        <input class="input" id="phone" name="phone" type="tel" inputmode="tel"
                            placeholder="010-1234-5678" pattern="^0\\d{1,2}-?\\d{3,4}-?\\d{4}$" />
                    </div>

                    <!-- 우편번호/주소 -->
                    <div class="field">
                        <label class="label" for="postcode">우편번호</label>
                        <div class="row-inline">
                            <input class="input" id="postcode" name="postcode" type="text" inputmode="numeric"
                                placeholder="예) 47212" maxlength="10" />
                            <button type="button" class="btn-auth" id="btnZip">우편번호검색</button>
                        </div>
                    </div>

                    <div class="field">
                        <label class="label" for="address">주소</label>
                        <input class="input" id="address" name="address" type="text" placeholder="도로명 주소" />
                    </div>

                    <div class="field">
                        <label class="label" for="addressDetail">상세주소</label>
                        <input class="input" id="addressDetail" name="addressDetail" type="text" placeholder="동/호수 등" />
                    </div>

                    <!-- 제출 -->
                    <div class="submit">
                        <button type="submit" class="btn btn-primary">회원가입 완료</button>
                        <button type="button" class="btn btn-ghost" onclick="location.href='login.html'">이미 계정이 있으신가요?
                            로그인</button>
                    </div>
                </form>
            </div>

            <!-- 사이드 -->
            <aside class="auth-side" aria-hidden="true">
                <div class="side-top"></div>
                <span class="side-badge">· 책갈피 · </span>
                <h2 class="side-title">읽는 즐거움을 더 간편히</h2>
                <p class="side-text">한 번의 회원가입으로 독서 생활을 더 편리하게.</p>
            </aside>
        </section>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">© 책갈피 BRAND · 부산시 부산진구 범내골 · 00-0000-0000 · qshop@naver.com</div>
    </footer>
    <!-- 외부 JS -->
  	<script src="<c:url value='/resources/js/register.js'/>"></script>
</body>
</html>