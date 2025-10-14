<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
  <h2>마이페이지</h2>
  <table border="1" cellpadding="8">
    <tr><th>아이디</th><td>${user.user_id}</td></tr>
    <tr><th>이름</th><td>${user.user_name}</td></tr>
    <tr><th>닉네임</th><td>${user.user_nickname}</td></tr>
    <tr><th>이메일</th><td>${user.user_email}</td></tr>
    <tr><th>전화번호</th><td>${user.user_phone_num}</td></tr>
    <tr><th>주소</th><td>${user.user_address} ${user.user_detail_address}</td></tr>
    <tr><th>가입일</th><td>${user.reg_date}</td></tr>
  </table>
  <br>
  <a href="${pageContext.request.contextPath}/mypage/edit">회원정보 수정</a>
  <a href="${pageContext.request.contextPath}/withdraw">회원 탈퇴</a>
  <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
</body>
</html>
