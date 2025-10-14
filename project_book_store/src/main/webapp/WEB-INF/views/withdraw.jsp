<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<style>
  body { font-family: 'Noto Sans KR', sans-serif; background:#f5f6fa; margin:0; }
  .wrap { max-width: 680px; margin: 60px auto; background:#fff; border:1px solid #e5e7eb; border-radius:10px; padding:30px 28px; }
  h2 { margin:0 0 16px; }
  .notice { background:#f8f9fa; border:1px solid #e5e7eb; border-radius:8px; padding:16px; margin:16px 0 24px; }
  .notice strong { color:#d60000; }
  .form-row { margin:12px 0; }
  .form-row label { display:block; margin-bottom:6px; color:#374151; }
  .form-row input { width:100%; padding:10px 12px; border:1px solid #d1d5db; border-radius:6px; }
  .actions { margin-top:18px; display:flex; gap:12px; }
  .btn { padding:10px 16px; border-radius:8px; border:0; cursor:pointer; }
  .btn-primary { background:#2d6cdf; color:#fff; }
  .btn-secondary { background:#e5e7eb; color:#111827; }
</style>
</head>
<body>
<div class="wrap">
  <h2>회원 탈퇴</h2>

  <div class="notice">
    <p><strong>⚠️ 탈퇴 시 주의사항을 꼭 확인해주세요.</strong></p>
    <ul>
      <li>회원정보 및 계정 내역은 <strong>즉시 삭제</strong>되며 복구할 수 없습니다.</li>
      <li>탈퇴 후 30일 동안 재가입이 제한될 수 있습니다.</li>
      <li>법적 보관 의무에 따라 일부 거래 내역은 일정 기간 보관됩니다.</li>
    </ul>
  </div>

  <form action="${pageContext.request.contextPath}/withdraw_ok" method="post">
    <div class="form-row">
      <label>아이디</label>
      <input type="text" name="user_id" value="${sessionScope.loginId}" readonly />
    </div>
    <div class="form-row">
      <label>본인확인을 위해 비밀번호를 입력해주세요</label>
      <input type="password" name="user_pw" placeholder="비밀번호" />
    </div>
    <div class="actions">
      <button type="submit" class="btn btn-primary">회원 탈퇴</button>
      <a href="${pageContext.request.contextPath}/mypage" class="btn btn-secondary">취소</a>
    </div>
  </form>
</div>

<c:if test="${result == 1}">
  <script>
    alert('탈퇴 처리되었습니다. 이용해주셔서 감사합니다.');
    window.location.href='${pageContext.request.contextPath}/login';
  </script>
</c:if>

<c:if test="${result == 0}">
  <script>
    alert('비밀번호가 일치하지 않아 탈퇴에 실패했습니다.');
  </script>
</c:if>

</body>
</html>
