const grid  = document.getElementById('grid');
const grid2 = document.getElementById('grid2');
const pager = document.getElementById('pager');
const countText = document.getElementById('countText');

function card(b){
  return `
    <div class="card">
      <div class="thumb">
        ${b.image ? `<img src="${b.image}" alt="${b.title}" />` : ''}
        ${b.tag ? `<span class="badge">${b.tag}</span>` : ''}
      </div>
      <div class="info">
        <h3 class="title-sm">${b.title}</h3>
        <p class="author">${b.author}</p>
        <p class="price">${b.price.toLocaleString()}원</p>
      </div>
    </div>
  `;
}


let activeCat = 'all';
let searchQuery = '';

// apply 함수: 카테고리 + 검색어 필터 적용
function apply(){
  let list = books.filter(b => {
    const catMatch = activeCat === 'all' ? true : Number(b.cat) === Number(activeCat);
    const searchMatch = searchQuery === '' ? true :
      b.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      b.author.toLowerCase().includes(searchQuery.toLowerCase());
    return catMatch && searchMatch;
  });

  countText.textContent = `총 ${list.length}권`;
  grid.innerHTML = list.map(card).join('');
}

// 카테고리 버튼 이벤트
document.querySelectorAll('.cat-btn').forEach(btn => {
  btn.addEventListener('click', e => {
    document.querySelectorAll('.cat-btn').forEach(b => b.classList.remove('active'));
    e.currentTarget.classList.add('active');
    activeCat = e.currentTarget.querySelector('input[name="genre_id"]').value;
    apply();
  });
});

// 검색 폼 이벤트
const searchForm = document.getElementById('searchForm');
searchForm.addEventListener('submit', e => {
  e.preventDefault();
  searchQuery = document.getElementById('q').value.trim();
  apply();
});

// 초기 렌더
apply();
