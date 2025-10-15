// 더미 데이터: 실제 연동 시 서버 응답으로 교체
const books = [
  {id:1,title:"해리 포터와 마법사의 돌",author:"J.K. 롤링",price:12000,rating:4.8,cat:"novel",tag:"베스트"},
  {id:2,title:"작별하지 않는다",author:"한강",price:13500,rating:4.6,cat:"novel"},
  {id:3,title:"아주 작은 습관의 힘",author:"제임스 클리어",price:15000,rating:4.7,cat:"economy"},
  {id:4,title:"사피엔스",author:"유발 하라리",price:18000,rating:4.9,cat:"humanity",tag:"추천"},
  {id:5,title:"코스모스",author:"칼 세이건",price:17000,rating:4.8,cat:"science"},
  {id:6,title:"총 균 쇠",author:"재레드 다이아몬드",price:19000,rating:4.7,cat:"humanity"},
  {id:7,title:"부의 인문학",author:"대니얼 서스킨드",price:16000,rating:4.3,cat:"economy"},
  {id:8,title:"미드나잇 라이브러리",author:"매트 헤이그",price:14000,rating:4.5,cat:"novel"},
  {id:9,title:"자기만의 방",author:"버지니아 울프",price:11000,rating:4.2,cat:"essay"},
  {id:10,title:"우리는 모두 죽는다",author:"베스 애너스트",price:12500,rating:4.1,cat:"essay"},
  {id:11,title:"현대물리학 산책",author:"브라이언 그린",price:22000,rating:4.6,cat:"science"},
  {id:12,title:"린 분석",author:"알리스터 크롤",price:21000,rating:4.4,cat:"economy"}
];

const grid  = document.getElementById('grid');
const grid2 = document.getElementById('grid2');
const pager = document.getElementById('pager');
const countText = document.getElementById('countText');
const sortSelect = document.getElementById('sortSelect');

function card(b){
  return `
    <div class="card">
      <div class="thumb">${b.tag?`<span class="badge">${b.tag}</span>`:''}</div>
      <div class="info">
        <h3 class="title-sm">${b.title}</h3>
        <p class="author">${b.author}</p>
        <p class="price">${b.price.toLocaleString()}원</p>
        <div class="rating">
          <div class="stars">${'<div class="star"></div>'.repeat(5)}</div>
          <span>${b.rating.toFixed(1)}</span>
        </div>
      </div>
    </div>
  `;
}

let activeCat = 'all';
let currentSort = 'popular';

function apply(){
  let list = books.filter(b => activeCat==='all' ? true : b.cat===activeCat);

  switch(currentSort){
    case 'new' : list = list.slice().reverse(); break; // 데모: 역순=최신
    case 'low' : list = list.slice().sort((a,b)=>a.price-b.price); break;
    case 'high': list = list.slice().sort((a,b)=>b.price-a.price); break;
    default    : list = list.slice().sort((a,b)=>b.rating-a.rating); // 인기=평점
  }

  countText.textContent = `총 ${list.length}권`;

  const first = list.slice(0,6);
  const second = list.slice(6,12);
  grid.innerHTML  = first.map(card).join('');
  grid2.innerHTML = second.map(card).join('');

  const hasSecond = second.length>0;
  grid2.classList.toggle('hidden', !hasSecond);
  pager.style.display = hasSecond ? 'flex' : 'none';

  // 페이저 초기화
  [...pager.querySelectorAll('.page-btn')].forEach((b,i)=>{
    b.classList.toggle('active', i===0);
  });
  window.scrollTo({top:0, behavior:'smooth'});
}

// 카테고리
document.querySelectorAll('.cat-btn').forEach(btn=>{
  btn.addEventListener('click', e=>{
    document.querySelectorAll('.cat-btn').forEach(b=>b.classList.remove('active'));
    e.currentTarget.classList.add('active');
    activeCat = e.currentTarget.dataset.cat;
    apply();
  });
});

// 정렬
sortSelect.addEventListener('change', e=>{
  currentSort = e.target.value;
  apply();
});

// 페이지 버튼
pager.addEventListener('click', e=>{
  if(!e.target.classList.contains('page-btn')) return;
  const page = e.target.dataset.page;
  [...pager.querySelectorAll('.page-btn')].forEach(b=>b.classList.remove('active'));
  e.target.classList.add('active');
  if(page==='1'){ grid.classList.remove('hidden'); grid2.classList.add('hidden'); }
  else{ grid.classList.add('hidden'); grid2.classList.remove('hidden'); grid2.scrollIntoView({behavior:'smooth'}); }
});

// 초기 렌더
apply();