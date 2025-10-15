// 페이지 로드 시 사용자 이름 설정
document.addEventListener('DOMContentLoaded', function() {
  const userName = localStorage.getItem('userName') || '홍길동';
  document.getElementById('userGreeting').textContent = userName + '님 반갑습니다';
});

// 로그아웃
function logout() {
  if (confirm('정말 로그아웃 하시겠습니까?')) {
    localStorage.removeItem('userName');
    localStorage.removeItem('isLoggedIn');
    location.href = '${pageContext.request.contextPath}/main';
  }
}

// 탭 전환 (회원탈퇴만 현재 페이지에서 처리)
function switchTab(tab) {
  // 회원탈퇴 탭만 현재 페이지에서 처리
  if(tab === 'withdraw') {
    // 모든 탭 버튼에서 active 클래스 제거
    document.querySelectorAll('.tab-button').forEach(btn => {
      btn.classList.remove('active');
    });
    
    // 클릭된 탭에 active 클래스 추가
    event.target.classList.add('active');
    
    console.log('회원탈퇴 탭 활성화');
  }
}

// 회원탈퇴 폼 처리
document.getElementById('withdrawForm').addEventListener('submit', function(e) {
  e.preventDefault();
  
  const password = document.getElementById('userPassword').value.trim();
  
  if (!password) {
    alert('비밀번호를 입력해주세요.');
    return;
  }
  
  // 실제로는 서버에서 비밀번호 확인 후 탈퇴 처리
  if (confirm('정말로 회원탈퇴를 진행하시겠습니까?\n탈퇴 후에는 복구가 불가능합니다.')) {
    // TODO: 서버에 탈퇴 요청 전송
    alert('회원탈퇴가 완료되었습니다.\n이용해 주셔서 감사합니다.');
    
    // 로그아웃 처리
    localStorage.removeItem('userName');
    localStorage.removeItem('isLoggedIn');
    location.href = '${pageContext.request.contextPath}/main';
  }
});