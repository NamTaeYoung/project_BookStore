<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<form method="post" action="login_yn">
			<tr height="30">
				<td width="100">
					사용자ID
				</td>
				<td width="100">
					<input type="text" name="user_id">
				</td>
			</tr>
			<tr height="30">
				<td width="100">
					비밀번호
				</td>
				<td width="100">
					<input type="password" name="user_pw">
				</td>
			</tr>
			<tr height="30">
				<td colspan="2" align="center">
					<input type="submit" value="로그인">
					<a href="register">회원가입</a><br>
					<a href="findId">아이디 찾기</a>
					<a href="findPassword">회원가입</a>
				</td>
			</tr>
	</table>
</body>
</html>






