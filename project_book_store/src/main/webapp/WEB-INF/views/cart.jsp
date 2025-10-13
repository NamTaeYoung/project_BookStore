<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>장바구니</title>
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; background-color: #f5f6fa; margin: 0; display: flex; height: 100vh; }
    .sidebar { width: 250px; background-color: #ffffff; border-right: 1px solid #ddd; padding-top: 30px; display: flex; flex-direction: column; align-items: center; }
    .profile { background-color: #2d6cdf; color: white; font-size: 30px; font-weight: bold; width: 100px; height: 100px; border-radius: 50%; display: flex; justify-content: center; align-items: center; margin-bottom: 10px; }
    .sidebar h2 { margin-bottom: 40px; font-size: 18px; }
    .menu-link { width: 80%; text-decoration: none; color: black; padding: 12px; margin: 8px 0; font-size: 16px; text-align: left; border-radius: 8px; display: block; }
    .menu-link:hover, .menu-link.active { background-color: #e6f0ff; color: #2d6cdf; font-weight: bold; }
    .content { flex-grow: 1; padding: 40px; overflow-y: auto; }
    .cart-box { background-color: white; border-radius: 10px; padding: 40px; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
    h2 { margin-bottom: 30px; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
    th, td { border-bottom: 1px solid #ddd; padding: 12px; text-align: center; }
    th { background-color: #f1f3f5; font-weight: bold; }
    td img { width: 60px; height: 80px; object-fit: cover; }
    .total-box { display: flex; justify-content: space-between; align-items: center; padding: 20px; border-top: 1px solid #ddd; font-size: 18px; }
    .total-box strong { font-size: 20px; color: #2d6cdf; }
    .order-btn { background-color: #2d6cdf; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-size: 16px; cursor: pointer; }
    .order-btn:hover { background-color: #1d4fc2; }
    .empty { text-align: center; color: #555; padding: 100px 0; font-size: 18px; }
  </style>
</head>
<body>
  <div class="sidebar">
    <div class="profile">OOO</div>
    <h2>OOO 님</h2>

    <a href="mypage.jsp" class="menu-link">내 정보</a>
    <a href="purchase.jsp" class="menu-link">구매기록</a>
    <a href="edit.jsp" class="menu-link">정보 수정</a>
    <a href="password.jsp" class="menu-link">비밀번호 변경</a>
    <a href="cart.jsp" class="menu-link active">장바구니</a>
    <a href="withdraw.jsp" class="menu-link">회원탈퇴</a>
  </div>

  <div class="content">
    <div class="cart-box">
      <h2>장바구니</h2>

      <table>
        <thead>
          <tr>
            <th>상품</th>
            <th>상품명</th>
            <th>수량</th>
            <th>가격</th>
            <th>합계</th>
            <th>삭제</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><img src="images/book1.jpg" alt="상품 이미지"></td>
            <td>모던 자바 인 액션</td>
            <td>1</td>
            <td>25,000원</td>
            <td>25,000원</td>
            <td><button style="background:none;border:none;color:red;cursor:pointer;">삭제</button></td>
          </tr>
          <tr>
            <td><img src="images/book2.jpg" alt="상품 이미지"></td>
            <td>Clean Code</td>
            <td>2</td>
            <td>30,000원</td>
            <td>60,000원</td>
            <td><button style="background:none;border:none;color:red;cursor:pointer;">삭제</button></td>
          </tr>
        </tbody>
      </table>

      <div class="total-box">
        <div>총 2개 상품</div>
        <div><strong>총 합계: 85,000원</strong></div>
        <button class="order-btn">주문하기</button>
      </div>
    </div>
  </div>
</body>
</html>

