<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f5f6fa;
      margin: 0;
      display: flex;
      height: 100vh;
    }

    /* 사이드바 */
    .sidebar {
      width: 250px;
      background-color: #ffffff;
      border-right: 1px solid #ddd;
      padding-top: 30px;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .profile {
      background-color: #2d6cdf;
      color: white;
      font-size: 30px;
      font-weight: bold;
      width: 100px;
      height: 100px;
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 10px;
    }

    .sidebar h2 {
      margin-bottom: 40px;
      font-size: 18px;
    }

    .menu-link {
      width: 80%;
      text-decoration: none;
      color: black;
      padding: 12px;
      margin: 8px 0;
      font-size: 16px;
      text-align: left;
      border-radius: 8px;
      display: block;
    }

    .menu-link:hover, .menu-link.active {
            background-color: #e6f0ff;
            color: #2d6cdf;
            font-weight: bold;
        }

    

    /* 메인 콘텐츠 */
    .content {
      flex-grow: 1;
      padding: 40px;
    }

    .withdraw-box {
      background-color: white;
      border-radius: 10px;
      padding: 40px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
      max-width: 800px;
      margin: 0 auto;
    }

    h2 {
      margin-bottom: 20px;
    }

    .notice {
      background-color: #f8f9fa;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 30px;
      border: 1px solid #ddd;
    }

    .notice strong {
      color: #d60000;
    }

    .input-box {
      background-color: #f8f9fa;
      padding: 30px;
      border-radius: 10px;
      text-align: center;
    }

    input {
      width: 250px;
      padding: 10px;
      margin: 5px;
      border: 1px solid #ccc;
      border-radius: 6px;
    }

    .withdraw-btn {
      background-color: #2d6cdf;
      color: white;
      border: none;
      padding: 12px 30px;
      font-size: 16px;
      border-radius: 8px;
      cursor: pointer;
      margin-top: 10px;
    }

    .withdraw-btn:hover {
      background-color: #1d4fc2;
    }
  </style>

<script>
	function confirmWithdraw(form) {
		if (confirm('정말 탈퇴하시겠습니까?\n회원정보는 복구되지 않습니다.')) {
			form.submit();
		}
	}
</script>
</head>
<body>
	<div class="sidebar">
		<div class="profile">${userInitial != null ? userInitial : 'U'}</div>
		<h2>${userName != null ? userName : '사용자'} 님</h2>

		<a href="mypage.jsp" class="menu-link">내 정보</a> 
		<a href="purchaseList.jsp" class="menu-link">구매기록</a> 
		<a href="editProfile.jsp" class="menu-link">정보 수정</a> 
		<a href="password.jsp" class="menu-link">비밀번호 변경</a> 
		<a href="cart.jsp" class="menu-link">장바구니</a> 
		<a href="withdraw.jsp" class="menu-link active">회원탈퇴</a>
	</div>

	<div class="content">
		<div class="withdraw-box">
			<h2>회원탈퇴 안내</h2>

			<div class="notice">
				<p>
					<strong>⚠️ 탈퇴 시 주의사항을 꼭 확인해주세요.</strong>
				</p>
				<ul>
					<li>회원정보 및 계정 내역은 <strong>즉시 삭제</strong>되며 복구할 수 없습니다.</li>
					<li>탈퇴 후 30일 동안 재가입이 제한됩니다.</li>
					<li>법적 보관 의무에 따라 일부 거래 내역은 일정 기간 보관될 수 있습니다.</li>
				</ul>
			</div>

			<h3>본인확인을 위해 비밀번호를 입력해주세요.</h3>
			<form method="post" action="withdrawConfirm.do" onsubmit="event.preventDefault(); confirmWithdraw(this);">
				<div class="input-box">
					<input type="text" name="userId" value="${userId != null ? userId : 'ID'}" readonly><br>
					<input type="password" name="userPw" placeholder="비밀번호" required><br>
					<button type="submit" class="withdraw-btn">회원탈퇴</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
