// 비밀번호 보기/숨기기 토글
document.querySelectorAll('.password-toggle').forEach(button => {
  button.addEventListener('click', function() {
    const input = this.previousElementSibling;
    if (input.type === 'password') {
      input.type = 'text';
      this.style.backgroundImage = 'url(\'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="%23333" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>\')';
    } else {
      input.type = 'password';
      this.style.backgroundImage = 'url(\'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="%23333" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>\')';
    }
  });
});

// 로그인 폼 제출
document.getElementById('loginForm').addEventListener('submit', function(e) {
  e.preventDefault();
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;

  if (!email || !password) {
    alert('아이디와 비밀번호를 모두 입력해주세요.');
    return;
  }
  alert('로그인 기능은 준비 중입니다. (아이디: ' + email + ')');
});

// 모달 관련 함수
function showAccountFindModal() {
  document.getElementById('accountFindModal').style.display = 'block';
}
function closeModal(modalId) {
  document.getElementById(modalId).style.display = 'none';
}
function switchTab(tab) {
  const idForm = document.getElementById('idFindForm');
  const passwordForm = document.getElementById('passwordFindForm');
  const idTab = document.querySelector('.tab-button[onclick="switchTab(\'id\')"]');
  const passwordTab = document.querySelector('.tab-button[onclick="switchTab(\'password\')"]');
  if (tab === 'id') {
    idForm.style.display = 'block';
    passwordForm.style.display = 'none';
    idTab.classList.add('active');
    passwordTab.classList.remove('active');
  } else {
    idForm.style.display = 'none';
    passwordForm.style.display = 'block';
    idTab.classList.remove('active');
    passwordTab.classList.add('active');
  }
}
window.onclick = function(event) {
  const accountModal = document.getElementById('accountFindModal');
  if (event.target == accountModal) {
    accountModal.style.display = 'none';
  }
}
function findId(event) {
  event.preventDefault();
  const email = document.getElementById('findName').value;
  if (!email) {
    alert('이메일을 입력해주세요.');
    return;
  }
  const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  if (!emailPattern.test(email)) {
    alert('이메일 양식을 다시 확인해주세요.');
    return;
  }
  alert('이메일로 전송되었습니다.');
  closeModal('accountFindModal');
}
function findPassword(event) {
  event.preventDefault();
  const id = document.getElementById('findId').value;
  const email = document.getElementById('findEmail').value;
  if (!id || !email) {
    alert('아이디와 이메일을 모두 입력해주세요.');
    return;
  }
  alert('비밀번호를 이메일로 발송되었습니다.\n입력된 정보: 아이디(' + id + '), 이메일(' + email + ')');
  closeModal('accountFindModal');
}
