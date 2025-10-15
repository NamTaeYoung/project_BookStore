<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
  <h2>회원정보 수정</h2>
  <form action="${pageContext.request.contextPath}/mypage/update" method="post">
    <table border="1" cellpadding="8">
      <tr><th>아이디</th><td>${user.user_id}</td></tr>
      <tr><th>이름</th><td><input type="text" name="user_name" value="${user.user_name}"></td></tr>
      <tr><th>닉네임</th><td><input type="text" name="user_nickname" value="${user.user_nickname}"></td></tr>
      <tr><th>이메일</th><td><input type="text" name="user_email" value="${user.user_email}"></td></tr>
      <tr><th>전화번호</th><td><input type="text" name="user_phone_num" value="${user.user_phone_num}"></td></tr>
      <tr><th>주소</th><td><input type="text" name="user_address" value="${user.user_address}"></td></tr>
      <tr><th>상세주소</th><td><input type="text" name="user_detail_address" value="${user.user_detail_address}"></td></tr>
    </table>
    <br>
    <button type="submit">저장</button>
    <a href="${pageContext.request.contextPath}/mypage">취소</a>
  </form>
</body>
</html>
