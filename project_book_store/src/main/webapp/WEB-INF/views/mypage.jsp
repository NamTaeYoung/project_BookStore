<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f5f6fa; margin: 0; display: flex; height: 100vh; }
        .sidebar { width: 250px; background-color: #ffffff; border-right: 1px solid #ddd; padding-top: 30px; display: flex; flex-direction: column; align-items: center; }
        .profile { background-color: #2d6cdf; color: white; font-size: 30px; font-weight: bold; width: 100px; height: 100px; border-radius: 50%; display: flex; justify-content: center; align-items: center; margin-bottom: 10px; }
        .sidebar h2 { margin-bottom: 40px; font-size: 18px; }
        .menu-link { width: 80%; text-decoration: none; color: black; padding: 12px; margin: 8px 0; font-size: 16px; text-align: left; border-radius: 8px; display: block; }
        .menu-link:hover, .menu-link.active { background-color: #e6f0ff; color: #2d6cdf; font-weight: bold; }
        .content { flex-grow: 1; padding: 40px; }
        .info-box { background-color: white; border-radius: 10px; padding: 30px; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        .info-header { display: flex; justify-content: space-between; margin-bottom: 30px; }
        .info-header div { background-color: #f1f3f5; border-radius: 10px; padding: 15px 25px; text-align: center; }
        .info-header div h3 { margin: 0; }
        table { width: 100%; border-collapse: collapse; }
        td { padding: 10px 0; }
        td:first-child { width: 150px; font-weight: bold; }
        .edit-btn { display: inline-block; margin-top: 20px; background-color: #2d6cdf; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; }
        .edit-btn:hover { background-color: #1d4fc2; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">OOO</div>
        <h2>OOO 님</h2>

        <a href="mypage.jsp" class="menu-link active">내 정보</a>
        <a href="loan.jsp" class="menu-link">대출 현황 & 기록</a>
        <a href="edit.jsp" class="menu-link">정보 수정</a>
        <a href="password.jsp" class="menu-link">비밀번호 변경</a>
        <a href="withdraw.jsp" class="menu-link">회원탈퇴</a>
    </div>

    <div class="content">
        <div class="info-box" id="info">
            <h2>내 정보</h2>
            <div class="info-header">
                <div>
                    <h3>1</h3>
                    <p>대출 중인 도서</p>
                </div>
                <div>
                    <h3>2</h3>
                    <p>연체 도서</p>
                </div>
                <div>
                    <h3>5</h3>
                    <p>총 대출 이력</p>
                </div>
            </div>

            <table>
                <tr><td>이름</td><td>OOO</td></tr>
                <tr><td>아이디</td><td>abcdef</td></tr>
                <tr><td>이메일</td><td>aaaa@money.com</td></tr>
                <tr><td>전화번호</td><td>010-1234-5678</td></tr>
                <tr><td>가입일</td><td>2025-10-13 11:31:10</td></tr>
                <tr><td>주소</td><td>부산 진구</td></tr>
            </table>

            <a href="edit.jsp" class="edit-btn">정보 수정</a>
        </div>
    </div>
</body>
</html>

