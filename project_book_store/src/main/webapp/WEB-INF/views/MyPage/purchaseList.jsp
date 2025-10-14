<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>구매 기록</title>
<style>
    /* 간단한 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
    }
    th {
        background-color: #2d6cdf;
        color: white;
    }
</style>
</head>
<body>
<h2>구매 내역</h2>

<c:if test="${empty purchaseList}">
    <p>구매 기록이 없습니다.</p>
</c:if>

<c:if test="${not empty purchaseList}">
    <table>
        <thead>
            <tr>
                <th>도서 제목</th>
                <th>저자</th>
                <th>출판사</th>
                <th>구매일</th>
                <th>수량</th>
                <th>가격</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${purchaseList}">
                <tr>
                    <td>${item.book.book_title}</td>
                    <td>${item.book.book_writer}</td>
                    <td>${item.book.book_pub}</td>
                    <td><fmt:formatDate value="${item.purchase_date}" pattern="yyyy-MM-dd" /></td>
                    <td>${item.quantity}</td>
                    <td>${item.book.book_price * item.quantity}원</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

<a href="myinfo">내 정보로 돌아가기</a>

</body>
</html>
