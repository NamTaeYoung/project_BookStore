// ===================== Search 페이지 스크립트 =====================
const grid  = document.getElementById('grid');
const grid2 = document.getElementById('grid2');
const pager = document.getElementById('pager');
const countText = document.getElementById('countText');

// JSP에서 전달한 컨텍스트 경로(없으면 빈 문자열)
const metaTag = document.querySelector('meta[name="ctx"]');
const ctx = metaTag ? metaTag.content : '';

// 카드 템플릿: 제목/썸네일 클릭 시 상세 페이지로 이동
function card(b){
  const id     = b.id || b.book_id;
  const title  = b.title || b.book_title || '';
  const author = b.author || b.book_writer || b.writer || '';
  const price  = Number(b.price || b.book_price || 0);
  const image  = b.image || b.book_image_path || '';
  const tag    = b.tag || b.book_comm || '';
  const href   = ctx + "/SearchDetail?book_id=" + id;  // ✅ JSP 안전 버전

  let html = "";
  html += '<div class="card">';
  html += '  <a class="thumb" href="' + href + '" aria-label="' + title + '">';
  if (image) {
    html += '    <img src="' + image + '" alt="' + title + '">';
  } else {
    html += '    <div class="placeholder"></div>';
  }
  if (tag) {
    html += '    <span class="badge">' + tag + '</span>';
  }
  html += '  </a>';
  html += '  <div class="info">';
  html += '    <h3 class="title-sm"><a class="book-link" href="' + href + '">' + title + '</a></h3>';
  html += '    <p class="author">' + author + '</p>';
  html += '    <div class="info-bottom">';
  html += '      <p class="price">' + price.toLocaleString() + '원</p>';
  html += '      <button class="cart-btn" data-book-id="' + id + '">';
  html += '        <svg viewBox="0 0 24 24" fill="none">';
  html += '          <path d="M6 6h15l-1.5 8.5a2 2 0 0 1-2 1.5H9a2 2 0 0 1-2-1.5L5 3H2" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>';
  html += '        </svg>담기</button>';
  html += '    </div>';
  html += '  </div>';
  html += '</div>';
  return html;
}

let activeCat = 'all';
let searchQuery = '';

// 장바구니 버튼 이벤트 등록
function bindCartButtons() {
  const buttons = document.querySelectorAll(".cart-btn");
  buttons.forEach(function(btn){
    btn.addEventListener("click", function() {
      const bookId = this.dataset.bookId;
      if (!confirm("장바구니에 담으시겠습니까?")) return;

      fetch(ctx + "/cartAdd", {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
        body: "book_id=" + encodeURIComponent(bookId)
      })
      .then(res => res.text())
      .then(() => alert("장바구니에 담겼습니다!"))
      .catch(err => {
        console.error(err);
        alert("장바구니 담기 실패");
      });
    });
  });
}

// apply() — 책 리스트 렌더링 후 버튼 이벤트 다시 연결
function apply(){
  const list = books.filter(function(b){
    const catId = (b.cat || b.genre_id);
    const catMatch = activeCat === 'all' ? true : Number(catId) === Number(activeCat);
    const t = (b.title || b.book_title || '').toLowerCase();
    const a = (b.author || b.book_writer || b.writer || '').toLowerCase();
    const q = (searchQuery || '').toLowerCase();
    const searchMatch = q === '' ? true : (t.includes(q) || a.includes(q));
    return catMatch && searchMatch;
  });

  countText.textContent = "총 " + list.length + "권";
  grid.innerHTML = list.map(card).join('');
  bindCartButtons();
}

// 검색 이벤트
const searchForm = document.getElementById('searchForm');
if (searchForm) {
  searchForm.addEventListener('submit', function(e){
    e.preventDefault();
    searchQuery = document.getElementById('q').value.trim();
    apply();
  });
}

// 초기 렌더링
apply();
