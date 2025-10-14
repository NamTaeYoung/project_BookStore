<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
</head>
<body>
  <h2>로그인 성공!</h2>
  <p><strong>${sessionScope.loginId}</strong> 님 환영합니다 🎉</p>
  <hr>
  <a href="${pageContext.request.contextPath}/mypage">마이페이지</a>
  <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
  <a href="${pageContext.request.contextPath}/cart">장바구니</a>
</body>
</html>
