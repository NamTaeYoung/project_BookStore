function check_ok(){

	var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;
	
	// 폼 이름에 name 값으로 찾아감
	if(reg_frm.user_id.value==""){
		alert("아이디를 써주세요.");
		reg_frm.user_id.focus();//입력안할때 깜빡임
		return;
	}
	if(reg_frm.user_id.value.length< 4){
			alert("아이디는 4글자이상이어야 합니다.");
			reg_frm.user_id.focus();
			return;
		}
	if(reg_frm.user_pw.value.length==0){
			alert("패스워드는 반드시 입력해야 합니다.");
			reg_frm.user_pw.focus();
			return;
		}
	if(reg_frm.user_pw.value.length==0){
			alert("패스워드는 반드시 입력해야 합니다.");
			reg_frm.user_pw.focus();
			return;
		}
	if (!passwordRegex.test(reg_frm.user_pw.value)) {
        alert("비밀번호는 8~16자, 영문자, 숫자, 특수문자를 모두 포함해야 합니다.");
        reg_frm.user_pw.focus();
        return;
    }

    // 비밀번호 일치 검사
    if (reg_frm.user_pw.value !== reg_frm.pwd_check.value) {
        alert("패스워드가 일치하지 않습니다.");
        reg_frm.pwd_check.focus();
        return;
    }
	
	if(reg_frm.user_name.value.length==0){
			alert("이름을 써주세요.");
			reg_frm.user_name.focus();
			return;
		}
	if(reg_frm.user_email.value.length==0){
			alert("Email을 써주세요.");
			reg_frm.user_email.focus();
			return;
		}
	// 폼이 reg_frm에서 action 속성의 파일을 호출
	document.reg_frm.submit();
}

//우편번호 검색
function chk_post(){
	new daum.Postcode(
		{
			oncomplete : function(data) {
			   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	 
	           // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	           var fullAddr = ''; // 최종 주소 변수
	           var extraAddr = ''; // 조합형 주소 변수

	           // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	           if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	               fullAddr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	            if (data.userSelectedType === 'R') {
	                //법정동명이 있을 경우 추가한다.
	                if (data.bname !== '') {
	                     extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if (data.buildingName !== '') {
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('user_post_num').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('user_address').value = fullAddr;

	 
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById('user_detail_address').focus();
	        }
	    }).open();
	}
	