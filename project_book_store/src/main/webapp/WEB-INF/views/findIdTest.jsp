<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="${pageContext.request.contextPath}/resources/js/find.js"></script>
</head>
<body>
	<table border="1" align="center">
        <form name="find_id_frm" method="post">
            <tr height="50">
                <td colspan="2" align="center">
                    <h1>아이디 찾기</h1>
                </td>
            </tr>
            <tr height="30">
                <td width="80">E-mail</td>
                <td><input type="email" size="30" name="user_email" id="find_email"></td>
            </tr>
            <tr height="30">
                <td colspan="2" align="center">
                    <input type="button" value="아이디 찾기" onclick="findId()">
                </td>
            </tr>
        </form>
    </table>
</body>
</html>