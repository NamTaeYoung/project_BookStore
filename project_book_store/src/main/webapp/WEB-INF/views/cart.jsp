<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style>
	body {
		font-family: 'Noto Sans KR', sans-serif;
		background-color: #f4f1ed;
		margin: 0;
		padding: 0;
	}
	
	.cart-container {
		width: 800px;
		margin: 50px auto;
		background-color: #fff8f0;
		border-radius: 10px;
		box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
		padding: 30px;
	}
	
	h2 {
		margin-bottom: 20px;
		color: #5c3a21;
	}
	
	table {
		width: 100%;
		border-collapse: collapse;
	}
	
	th, td {
		text-align: center;
		padding: 12px;
		border-bottom: 1px solid #e0d4c1;
	}
	
	th {
		background-color: #d7b899;
		color: #fff;
	}
	
	.product-info {
		display: flex;
		align-items: center;
		gap: 10px;
		justify-content: flex-start;
	}
	
	.product-info img {
		width: 50px;
		height: 50px;
		border-radius: 4px;
		background-color: #ccc;
	}
	
	input[type=number] {
		width: 50px;
		padding: 5px;
		text-align: center;
	}
	
	.summary {
		text-align: right;
		margin-top: 20px;
		color: #5c3a21;
	}
	
	.summary p {
		margin: 5px 0;
	}
	
	.summary strong {
		font-size: 18px;
	}
	
	.order-button {
		margin-top: 30px;
		text-align: center;
	}
	
	.order-button button {
		background-color: #1e80ff;
		color: white;
		border: none;
		padding: 15px 40px;
		border-radius: 5px;
		font-size: 16px;
		cursor: pointer;
	}
	
	.order-button button:hover {
		background-color: #1669d4;
	}
</style>

<script>
	function updatePrice(row) {
	    const quantity = row.querySelector(".quantity").value;
	    const unitPrice = parseInt(row.querySelector(".unit-price").dataset.price);
	    const totalPriceEl = row.querySelector(".total-price");
	    totalPriceEl.innerText = (quantity * unitPrice).toLocaleString() + "원";
	
	    updateSummary();
	}
	
	function updateSummary() {
	    const rows = document.querySelectorAll(".cart-row");
	    let total = 0;
	
	    rows.forEach(row => {
	        if (row.querySelector(".select-item").checked) {
	            const quantity = parseInt(row.querySelector(".quantity").value);
	            const price = parseInt(row.querySelector(".unit-price").dataset.price);
	            total += quantity * price;
	        }
	    });
	
	    const delivery = total >= 50000 ? 0 : 3000;
	
	    document.getElementById("product-price").innerText = total.toLocaleString() + "원";
	    document.getElementById("delivery-price").innerText = delivery === 0 ? "무료" : delivery.toLocaleString() + "원";
	    document.getElementById("total-price").innerText = (total + delivery).toLocaleString() + "원";
	}
	
	function deleteSelectedItems() {
	    const rows = document.querySelectorAll(".cart-row");
	    rows.forEach(row => {
	        const checkbox = row.querySelector(".select-item");
	        if (checkbox.checked) {
	            row.remove();
	        }
	    });
	    updateSummary();
	}
	
	window.onload = () => {
	    updateSummary();
	}
</script>
</head>
<body>

	<form class="cart-container" method="post" action="/cart">
		<h2>장바구니</h2>
		<div style="text-align: right; margin-bottom: 10px;">
			<button type="button" onclick="deleteSelectedItems()"
				style="background-color: #b94e4e; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer;">
				선택 삭제
			</button>
		</div>
		<table>
		    <tr>
		        <th><input type="checkbox"
		            onclick="document.querySelectorAll('.select-item').forEach(cb => cb.checked = this.checked); updateSummary();"></th>
		        <th>상품정보</th>
		        <th>수량</th>
		        <th>가격</th>
		    </tr>
		
		    <c:forEach var="item" items="${cartList}">
			    <tr class="cart-row">
			        <td><input type="checkbox" class="select-item" checked onchange="updateSummary()"></td>
			        <td class="product-info">
			            <img src="${item.book.book_image_path != null ? item.book.book_image_path : '/resources/images/default-book.png'}" alt="${item.book.book_title}">
			            <span>${item.book.book_title}</span>
			        </td>
			        <td>
			            <input type="number" class="quantity" value="${item.quantity}" min="1" onchange="updatePrice(this.closest('tr'))">
			        </td>
			        <td class="unit-price" data-price="${item.book.book_price}">
			            <span class="total-price">${item.book.book_price * item.quantity}원</span>
			        </td>
			    </tr>
			</c:forEach>
		</table>

		<div class="summary">
			<div class="price-row" style="display: flex; justify-content: space-between; align-items: center;">
		        <span style="color: #a87954; font-size: 13px; background-color: #fff0e0; padding: 4px 10px; border-radius: 5px;">
		            5만원 이상 구매 시 <strong>배송비 무료</strong>
		        </span>
		        <p style="margin: 0;">상품가격: <span id="product-price"></span></p>
		    </div>
			<p>
				배송비: <span id="delivery-price"></span>
			</p>
			<p>
				<strong>결제금액: <span id="total-price"></span></strong>
			</p>
		</div>

		<div class="order-button">
			<button type="button">주문하기</button>
		</div>
	</form>

</body>
</html>
