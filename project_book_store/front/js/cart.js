// cart.js (ES5 호환 버전)
(function(){
  // ===== 공통: 로그인 헤더 토글 =====
  (function(){
    var guestLinks   = document.getElementById('guestLinks');
    var userGreeting = document.getElementById('userGreeting');
    var userNameText = document.getElementById('userNameText');
    var logoutBtn    = document.getElementById('logoutBtn');
    if(!guestLinks) return;

    function renderByAuth(){
      var name = localStorage.getItem('userName');
      if(name){
        if (userNameText) userNameText.textContent = name;
        guestLinks.style.display = 'none';
        if (userGreeting) userGreeting.style.display = 'flex';
      }else{
        if (userGreeting) userGreeting.style.display = 'none';
        guestLinks.style.display = 'flex';
      }
    }
    renderByAuth();
    if (logoutBtn){
      logoutBtn.addEventListener('click', function(e){
        e.preventDefault();
        localStorage.removeItem('userName');
        renderByAuth();
      });
    }
  })();

  // ===== 장바구니 로직 =====
  (function(){
    function fmt(n){ return n.toLocaleString('ko-KR'); }
    function KRW(n){ return '₩' + fmt(n); }

    // DOM
    var cartRows       = document.getElementById('cartRows');
    var emptyState     = document.getElementById('emptyState');
    var selectAll      = document.getElementById('selectAll');
    var selectedCount  = document.getElementById('selectedCount');

    var subtotalText   = document.getElementById('subtotalText');
    var discountText   = document.getElementById('discountText');
    var shippingText   = document.getElementById('shippingText');
    var grandTotalText = document.getElementById('grandTotalText');

    var removeSelectedBtn = document.getElementById('removeSelectedBtn');
    var clearCartBtn      = document.getElementById('clearCartBtn');
    var applyCouponBtn    = document.getElementById('applyCouponBtn');
    var couponInput       = document.getElementById('couponInput');
    var checkoutBtn       = document.getElementById('checkoutBtn');

    // 스토리지 키
    var STORAGE_KEY = 'cart';

    function loadCart(){
      try{
        var raw = localStorage.getItem(STORAGE_KEY);
        return raw ? JSON.parse(raw) : [];
      }catch(e){
        return [];
      }
    }
    function saveCart(items){
      localStorage.setItem(STORAGE_KEY, JSON.stringify(items));
    }

    // 더미 데이터 주입(처음만)
    function ensureSeed(){
      var items = loadCart();
      if(items.length === 0){
        var seed = [
          { id:'B-1001', title:'책장 정리왕', price:4000, qty:1, thumb:'' },
          { id:'B-1002', title:'리딩 트래커', price:3000, qty:2, thumb:'' },
          { id:'B-1003', title:'도서관 매니저', price:2000, qty:1, thumb:'' }
        ];
        saveCart(seed);
      }
    }
    ensureSeed();

    // 선택 상태 (ES5: 객체 맵으로 대체)
    var selectedMap = {}; // id:true/false
    function isSelected(id){ return !!selectedMap[id]; }
    function setSelected(id, v){ selectedMap[id] = !!v; }
    function clearSelected(){ selectedMap = {}; }
    function selectedSize(){
      var k, c=0; for(k in selectedMap){ if(selectedMap.hasOwnProperty(k) && selectedMap[k]) c++; }
      return c;
    }

    // 쿠폰 상태
    var coupon = null; // {code, amount} 또는 {code, rate}

    function render(){
      var items = loadCart();
      cartRows.innerHTML = '';

      if(items.length === 0){
        emptyState.style.display = 'block';
        clearSelected();
        updateSummary();
        updateSelectAll();
        updateSelectedCount();
        return;
      }
      emptyState.style.display = 'none';

      for (var i=0; i<items.length; i++){
        var item = items[i];
        var tr = document.createElement('tr');
        tr.className = 'cart-row';

        var checked = isSelected(item.id);

        // 템플릿 리터럴 대신 문자열 더하기
        var html = ''
          + '<td>'
          +   '<input type="checkbox" class="row-check" data-id="' + item.id + '" ' + (checked ? 'checked' : '') + ' />'
          + '</td>'
          + '<td>'
          +   '<div class="row-flex">'
          +     '<div class="thumb">' + (item.thumb ? ('<img src="' + item.thumb + '" alt="">') : '') + '</div>'
          +     '<div>'
          +       '<p class="title">' + item.title + '</p>'
          +       '<p class="meta">상품코드: ' + item.id + '</p>'
          +     '</div>'
          +   '</div>'
          + '</td>'
          + '<td>'
          +   '<div class="qty-wrap" data-id="' + item.id + '">'
          +     '<button class="qty-btn" data-act="dec" aria-label="수량 감소">−</button>'
          +     '<input class="qty" type="number" min="1" value="' + item.qty + '" inputmode="numeric" />'
          +     '<button class="qty-btn" data-act="inc" aria-label="수량 증가">＋</button>'
          +   '</div>'
          + '</td>'
          + '<td>'
          +   '<div>'
          +     '<strong class="price">' + KRW(item.price * item.qty) + '</strong>'
          +   '</div>'
          + '</td>'
          + '<td>'
          +   '<div class="row-actions">'
          +     '<button class="remove-btn" data-id="' + item.id + '">삭제</button>'
          +   '</div>'
          + '</td>';

        tr.innerHTML = html;
        cartRows.appendChild(tr);
      }

      updateSummary();
      updateSelectAll();
      updateSelectedCount();
    }

    function updateSelectedCount(){
      selectedCount.textContent = '(' + selectedSize() + '개 선택)';
    }

    function updateSelectAll(){
      var items = loadCart();
      if(items.length === 0){
        selectAll.checked = false;
        selectAll.indeterminate = false;
        return;
      }
      var total = items.length;
      var sel = 0;
      for (var i=0;i<items.length;i++){ if(isSelected(items[i].id)) sel++; }
      selectAll.checked = sel === total;
      selectAll.indeterminate = sel > 0 && sel < total;
    }

    function calcTotals(){
      var items = loadCart();
      var sub = 0;
      for (var i=0;i<items.length;i++){ sub += items[i].price * items[i].qty; }
      var discount = 0;

      if(coupon){
        if(coupon.amount) discount += coupon.amount;
        if(coupon.rate)   discount += Math.floor(sub * coupon.rate);
      }
      if(discount > sub) discount = sub;

      // 배송비: 3만원 미만 3,000원
      var shipping = (sub - discount) >= 30000 || sub === 0 ? 0 : 3000;
      var grand = Math.max(0, sub - discount + shipping);

      return { sub: sub, discount: discount, shipping: shipping, grand: grand };
    }

    function updateSummary(){
      var t = calcTotals();
      subtotalText.textContent = KRW(t.sub);
      discountText.textContent = t.discount ? ('- ' + KRW(t.discount)) : '- ₩0';
      shippingText.textContent = KRW(t.shipping);
      grandTotalText.textContent = KRW(t.grand);
    }

    // 이벤트: 개별 체크
    cartRows.addEventListener('change', function(e){
      var cb = e.target && (e.target.classList ? e.target : null);
      if(!cb || !e.target.classList.contains('row-check')) return;
      var id = e.target.getAttribute('data-id');
      setSelected(id, e.target.checked);
      updateSelectAll(); updateSelectedCount();
    });

    // 이벤트: 전체 선택
    selectAll.addEventListener('change', function(){
      var items = loadCart();
      if(selectAll.checked){
        clearSelected();
        for (var i=0;i<items.length;i++){ setSelected(items[i].id, true); }
      }else{
        clearSelected();
      }
      render();
    });

    // 수량 변경 (+/- & 직접 입력) / 삭제
    cartRows.addEventListener('click', function(e){
      var btn = e.target;
      if(btn && btn.classList.contains('qty-btn')){
        var wrap = btn.closest ? btn.closest('.qty-wrap') : null;
        // IE 대비: closest가 없다면 수동 탐색
        if(!wrap){
          var p = btn.parentNode;
          while(p && p !== document && (!p.classList || !p.classList.contains('qty-wrap'))) p = p.parentNode;
          wrap = p;
        }
        var id = wrap.getAttribute('data-id');
        var act = btn.getAttribute('data-act');
        var input = wrap.querySelector('.qty');
        var val = parseInt((input.value || '1'), 10);
        val = isNaN(val) ? 1 : val;
        val = act === 'inc' ? (val+1) : Math.max(1, val-1);
        input.value = val;
        updateItemQty(id, val);
        return;
      }
      if(btn && btn.classList.contains('remove-btn')){
        removeItem(btn.getAttribute('data-id'));
      }
    });

    cartRows.addEventListener('input', function(e){
      var input = e.target;
      if(!input || !input.classList.contains('qty')) return;
      var wrap = input.parentNode;
      while(wrap && wrap !== document && (!wrap.classList || !wrap.classList.contains('qty-wrap'))) wrap = wrap.parentNode;
      var id = wrap.getAttribute('data-id');
      var val = parseInt((input.value || '1'), 10);
      if(isNaN(val) || val < 1) val = 1;
      input.value = val;
      updateItemQty(id, val);
    });

    function updateItemQty(id, qty){
      var items = loadCart();
      var idx = -1;
      for (var i=0;i<items.length;i++){ if(items[i].id === id){ idx = i; break; } }
      if(idx>=0){
        items[idx].qty = qty;
        saveCart(items);
        render();
      }
    }
    function removeItem(id){
      var items = loadCart();
      var next = [];
      for (var i=0;i<items.length;i++){ if(items[i].id !== id) next.push(items[i]); }
      saveCart(next);
      setSelected(id, false);
      render();
    }

    // 선택 삭제
    removeSelectedBtn.addEventListener('click', function(){
      if(selectedSize() === 0){ alert('삭제할 상품을 선택하세요.'); return; }
      if(!confirm('선택한 상품을 삭제하시겠어요?')) return;
      var items = loadCart();
      var next = [];
      for (var i=0;i<items.length;i++){
        if(!isSelected(items[i].id)) next.push(items[i]);
      }
      saveCart(next);
      clearSelected();
      render();
    });

    // 전체 비우기
    clearCartBtn.addEventListener('click', function(){
      if(!confirm('장바구니를 모두 비우시겠어요?')) return;
      saveCart([]);
      clearSelected();
      render();
    });

    // 쿠폰
    applyCouponBtn.addEventListener('click', function(){
      var code = (couponInput.value || '').trim().toUpperCase();
      if(!code){
        coupon = null; updateSummary(); alert('쿠폰 코드를 입력하세요.');
        return;
      }
      if(code === 'SAVE1000'){ coupon = { code: code, amount: 1000 }; }
      else if(code === 'SAVE10'){ coupon = { code: code, rate: 0.10 }; }
      else { coupon = null; alert('유효하지 않은 쿠폰입니다.'); }
      updateSummary();
    });

    // 주문하기 (연동 포인트)
    var ctxMeta = document.querySelector('meta[name="ctx"]');
    var ctx = (ctxMeta && ctxMeta.content) ? ctxMeta.content : '';
    checkoutBtn.addEventListener('click', function(){
      var items = loadCart();
      if(items.length === 0){ alert('장바구니가 비어 있습니다.'); return; }
      // 예: location.href = ctx + '/order/checkout';
      alert('주문 페이지로 이동합니다. (서버 연동 지점)');
    });

    // 최초 렌더
    render();
  })();
})();
