// 페이지 로드 시 사용자 이름 설정 및 페이지네이션 초기화
document.addEventListener('DOMContentLoaded', function() {
  const userName = localStorage.getItem('userName') || '홍길동';
  document.getElementById('userGreeting').textContent = userName + '님 반갑습니다';
  
  // 페이지네이션 초기화
  initializePagination();
});

// 페이지네이션 초기화
function initializePagination() {
  const pagination = document.getElementById('pagination');
  const rows = document.querySelectorAll('#purchaseTableBody tr');
  
  // 페이지별 데이터 그룹화
  const pageData = {};
  rows.forEach(row => {
    const page = row.getAttribute('data-page');
    if (!pageData[page]) {
      pageData[page] = [];
    }
    pageData[page].push(row);
  });
  
  const totalPages = Object.keys(pageData).length;
  
  // 페이지네이션 HTML 생성
  let paginationHTML = '';
  
  // 이전 버튼
  paginationHTML += '<button class="pagination-btn" onclick="changePage(-1)" id="prevBtn" disabled><span>&lt;</span></button>';
  
  // 페이지 번호 버튼들
  for (let i = 1; i <= totalPages; i++) {
    const activeClass = i === 1 ? 'active' : '';
    paginationHTML += `<button class="pagination-btn ${activeClass}" onclick="changePage(${i})" data-page="${i}">${i}</button>`;
  }
  
  // 다음 버튼
  paginationHTML += '<button class="pagination-btn" onclick="changePage(1)" id="nextBtn"><span>&gt;</span></button>';
  
  pagination.innerHTML = paginationHTML;
  
  // 첫 번째 페이지 표시
  showPage(1);
}

// 특정 페이지 표시
function showPage(pageNumber) {
  const rows = document.querySelectorAll('#purchaseTableBody tr');
  
  // 모든 행 숨기기
  rows.forEach(row => {
    row.style.display = 'none';
  });
  
  // 선택된 페이지의 행들만 표시
  rows.forEach(row => {
    if (row.getAttribute('data-page') === pageNumber.toString()) {
      row.style.display = '';
    }
  });
  
  // 활성 페이지 버튼 업데이트
  document.querySelectorAll('.pagination-btn[data-page]').forEach(btn => {
    btn.classList.remove('active');
  });
  
  const activeBtn = document.querySelector(`.pagination-btn[data-page="${pageNumber}"]`);
  if (activeBtn) {
    activeBtn.classList.add('active');
  }
  
  // 이전/다음 버튼 상태 업데이트
  const prevBtn = document.getElementById('prevBtn');
  const nextBtn = document.getElementById('nextBtn');
  const totalPages = document.querySelectorAll('.pagination-btn[data-page]').length;
  
  prevBtn.disabled = pageNumber === 1;
  nextBtn.disabled = pageNumber === totalPages;
}

// 검색 기능 (검색 버튼 클릭 또는 엔터키)
function performSearch() {
  const searchTerm = document.getElementById('searchInput').value.toLowerCase().trim();
  const currentPage = getCurrentPage();
  const rows = document.querySelectorAll('#purchaseTableBody tr');
  
  rows.forEach(row => {
    const rowPage = row.getAttribute('data-page');
    
    // 현재 페이지가 아니면 숨김
    if (rowPage !== currentPage.toString()) {
      row.style.display = 'none';
      return;
    }
    
    // 현재 페이지의 행에 대해서만 검색 적용
    const orderNumber = row.cells[0].textContent.toLowerCase();
    const bookTitle = row.cells[2].textContent.toLowerCase();
    
    if (searchTerm === '' || orderNumber.includes(searchTerm) || bookTitle.includes(searchTerm)) {
      row.style.display = '';
    } else {
      row.style.display = 'none';
    }
  });
}

// 엔터키로 검색
document.getElementById('searchInput').addEventListener('keypress', function(e) {
  if (e.key === 'Enter') {
    performSearch();
  }
});

// 상태 필터
document.getElementById('statusFilter').addEventListener('change', function() {
  const selectedStatus = this.value;
  const currentPage = getCurrentPage();
  const rows = document.querySelectorAll('#purchaseTableBody tr');
  
  rows.forEach(row => {
    const rowPage = row.getAttribute('data-page');
    
    // 현재 페이지가 아니면 숨김
    if (rowPage !== currentPage.toString()) {
      row.style.display = 'none';
      return;
    }
    
    // 현재 페이지의 행에 대해서만 상태 필터 적용
    if (selectedStatus === '') {
      row.style.display = '';
    } else {
      const statusBadge = row.querySelector('.status-badge');
      const statusClass = statusBadge.className;
      
      if (selectedStatus === 'completed' && statusClass.includes('status-completed')) {
        row.style.display = '';
      } else if (selectedStatus === 'shipping' && statusClass.includes('status-shipping')) {
        row.style.display = '';
      } else if (selectedStatus === 'refunded' && statusClass.includes('status-refunded')) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    }
  });
});

// 현재 활성 페이지 가져오기
function getCurrentPage() {
  const activeBtn = document.querySelector('.pagination-btn.active[data-page]');
  return activeBtn ? parseInt(activeBtn.getAttribute('data-page')) : 1;
}

// 페이지 변경
function changePage(page) {
  if (page === -1) {
    // 이전 페이지
    const currentPage = getCurrentPage();
    if (currentPage > 1) {
      showPage(currentPage - 1);
    }
  } else if (page === 1 && event.target.id === 'nextBtn') {
    // 다음 페이지
    const currentPage = getCurrentPage();
    const totalPages = document.querySelectorAll('.pagination-btn[data-page]').length;
    if (currentPage < totalPages) {
      showPage(currentPage + 1);
    }
  } else if (typeof page === 'number') {
    // 특정 페이지로 이동
    showPage(page);
  }
}

// 로그아웃
function logout() {
  if (confirm('정말 로그아웃 하시겠습니까?')) {
    localStorage.removeItem('userName');
    localStorage.removeItem('isLoggedIn');
    location.href = 'main.html';
  }
}