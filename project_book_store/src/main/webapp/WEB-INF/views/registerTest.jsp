<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/register.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
<script>
let checkIdOk = false;
let emailOk = false;
$(function(){
    $("#checkId").click(function(){
        const user_id = $("#user_id").val().trim();

    	if(reg_frm.user_id.value==""){
    		alert("아이디를 써주세요.");
    		reg_frm.user_id.focus();//입력안할때 깜빡임
    		return;
    	}

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/checkId", // contextPath 자동 반영
            data: { "user_id": user_id },
            dataType: "text", // text로 받기
            success: function(result){
                if (result.trim() === "N") {
                    $("#result_checkId").text("사용 가능한 아이디입니다.")
                        .css("color", "green");
                    	checkIdOk = true; //통과 
                    $("#user_pw").focus();
                } else {
                    $("#result_checkId").text("이미 사용 중인 아이디입니다.")
                        .css("color", "red");
                    $("#user_id").val("").focus();
                    checkIdOk = false; //실패 
                }
            },
            error: function(xhr, status, error){
                alert("서버 오류: " + error);
            }
        });
    });
});
</script>
</head>
<body>
	<table border="1" align="center">
		<form name="reg_frm" method="post" action="register_ok">
			<tr height="50">
				<td align="center" colspan="2">
					<h1>회원 가입 신청</h1>
					'*표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr height="30">
				<td width="80">user ID</td>
				<td><input type="text" size="30" name="user_id" id="user_id" placeholder="아이디는 4글자 이상이여야 합니다.">*
				<input type="button" id="checkId" value="중복검사"><br>
				<div><span id="result_checkId" style="font-size:12px;"></span></div>
				</td>
				
			</tr>
			<tr height="30">
				<td width="80">암호</td>
				<td><input type="password" size="30" name="user_pw" placeholder="8글자 이상의 숫자,특수문자를 포함시켜주세요">*</td>
			</tr>
			<tr height="30">
				<td width="80">암호 확인</td>
				<td><input type="password" size="30" name="pwd_check">*</td>
			</tr>
			<tr height="30">
				<td width="80">이 름</td>
				<td><input type="text" size="30" name="user_name">*</td>
			</tr>
			<tr height="30">
				<td width="80">닉네임</td>
				<td><input type="text" size="30" name="user_nickname"></td>
			</tr>
			<tr height="30">
				<td width="80">E-mail</td>
				<td>
					<input type="email" size="40" name="user_email" id="user_email">*
					<input type="button" value="인증번호 보내기" onclick="sendAuthCode()">
				</td>
			</tr>
			<tr height="30">
				<td width="80">인증번호</tSd>
				<td>
					<input type="text" size="10" name="user_email_chk" id="user_email_chk" placeholder="인증번호" disabled>
					<input type="button" value="인증번호 확인" onclick="verifyAuthCode()" disabled>
				</td>
			</tr>
			<tr height="30">
				<td width="80">전화번호</td>
				<td><input type="tel" size="30" name="user_phone_num" placeholder="000-0000-0000형식으로 입력하세요.">*</td>
			</tr>
			<tr height="30">
				<td width="80">주소</td>
				<td><input type="text" size="10" name="user_post_num" id="user_post_num">
					<input type="button" value="우편번호검색" onclick="chk_post()" ><br>
				    <input type="text" size="30" name="user_address" id="user_address" placeholder="주소"><br>
				    <input type="text" size="30" name="user_detail_address" id="user_detail_address" placeholder="상세주소">
				</td>
			</tr>
			<tr height="30">
				<td colspan="2" align="center">
				<input type="button" value="등록" onclick="check_ok()" id="register_btn">
				<input type="reset"  value="다시입력">
				<input type="button" value="가입안함" onclick="location='login'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>