// 비번 강도바
        const pw = document.getElementById('password');
        const pw2 = document.getElementById('password2');
        const bar = document.getElementById('pwStrength');
        const form = document.getElementById('signupForm');

        function strength(v) {
            let s = 0;
            if (v.length >= 8) s++;
            if (/[A-Z]/.test(v)) s++;
            if (/[0-9]/.test(v)) s++;
            if (/[^A-Za-z0-9]/.test(v)) s++;
            return Math.min(100, s * 25);
        }
        pw.addEventListener('input', e => {
            const pct = strength(e.target.value);
            bar.style.width = pct + '%';
            bar.style.background = pct >= 75 ? '#2e7d32' : (pct >= 50 ? '#f9a825' : '#c62828');
        });

        // 제출 전 비밀번호 일치 체크
        form.addEventListener('submit', (e) => {
            if (pw.value !== pw2.value) {
                e.preventDefault();
                alert('비밀번호가 일치하지 않습니다.');
                pw2.focus();
            }
        });

        // 이메일 인증(데모): 전송 → 확인 버튼 활성화
        const btnSend = document.getElementById('btnSend');
        const btnVerify = document.getElementById('btnVerify');
        const emailInput = document.getElementById('email');

        btnSend.addEventListener('click', () => {
            if (!emailInput.value) { alert('이메일을 입력해 주세요.'); emailInput.focus(); return; }
            // TODO: 실제 전송 API 연동
            btnVerify.disabled = false;
            alert('인증번호를 발송했습니다. 메일함을 확인해 주세요.');
        });
        btnVerify.addEventListener('click', () => {
            const code = document.getElementById('emailCode').value.trim();
            if (!code) { alert('인증번호를 입력해 주세요.'); return; }
            // TODO: 실제 인증 확인 API 연동
            alert('인증번호 확인(데모): 서버 연동 시 실제 검증을 수행합니다.');
        });

        // 우편번호 검색(데모)
        document.getElementById('btnZip').addEventListener('click', () => {
            // TODO: 다음(카카오) 우편번호 API 연동
            alert('우편번호 검색 모듈 연동 예정입니다.');
        });