document.addEventListener('DOMContentLoaded', () => {
  initOtpInputs();
  const pwNew = document.getElementById('pw-new');
  if (pwNew) {
    pwNew.addEventListener('input', () => checkPw(pwNew.value));
  }
});

function initOtpInputs() {
  const otpInputs = Array.from(document.querySelectorAll('.otp-input'));
  const hiddenInput = document.getElementById('otp-hidden');
  if (!otpInputs.length || !hiddenInput) {
    return;
  }

  otpInputs.forEach((inp, idx) => {
    inp.addEventListener('input', () => {
      inp.value = inp.value.replace(/\D/g, '').slice(0, 1);
      inp.classList.toggle('filled', !!inp.value);
      updateOtpHidden(hiddenInput, otpInputs);
      if (inp.value && idx < otpInputs.length - 1) {
        otpInputs[idx + 1].focus();
      }
    });

    inp.addEventListener('keydown', e => {
      if (e.key === 'Backspace' && !inp.value && idx > 0) {
        otpInputs[idx - 1].focus();
        otpInputs[idx - 1].value = '';
        otpInputs[idx - 1].classList.remove('filled');
        updateOtpHidden(hiddenInput, otpInputs);
      }
    });
  });
}

function updateOtpHidden(hiddenInput, otpInputs) {
  hiddenInput.value = otpInputs.map(inp => inp.value || '').join('');
}

function toggleVis(id, btn) {
  const inp = document.getElementById(id);
  if (!inp) return;
  const isHidden = inp.type === 'password';
  inp.type = isHidden ? 'text' : 'password';
  const eyeIcon = btn.querySelector('svg');
  if (!eyeIcon) return;
  eyeIcon.innerHTML = isHidden
    ? '<path d="M17.94 17.94A10.07 10.07 0 0112 20c-7 0-11-8-11-8a18.45 18.45 0 015.06-5.94M9.9 4.24A9.12 9.12 0 0112 4c7 0 11 8 11 8a18.5 18.5 0 01-2.16 3.19m-6.72-1.07a3 3 0 11-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>'
    : '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';
}

function checkPw(val) {
  const rules = [
    { id: 'r-len', test: v => v.length >= 8 },
    { id: 'r-maj', test: v => /[A-Z]/.test(v) },
    { id: 'r-num', test: v => /[0-9]/.test(v) },
    { id: 'r-spe', test: v => /[^A-Za-z0-9]/.test(v) },
  ];
  const segs = ['seg1', 'seg2', 'seg3', 'seg4'];
  const labels = ['', 'Trop faible', 'Faible', 'Bon', 'Fort'];
  const labelColors = ['', '#ef4444', '#f59e0b', '#1e6b3e', '#1e6b3e'];
  const segClass = ['', 'weak', 'weak', 'medium', 'strong'];
  let score = 0;

  rules.forEach(r => {
    const ok = r.test(val);
    if (ok) score++;
    const el = document.getElementById(r.id);
    if (el) {
      el.classList.toggle('ok', ok);
    }
  });

  segs.forEach((id, idx) => {
    const el = document.getElementById(id);
    if (el) {
      el.className = 'pw-seg' + (idx < score && score > 0 ? ' ' + segClass[score] : '');
    }
  });

  const lbl = document.getElementById('pw-label');
  if (lbl) {
    lbl.textContent = val.length > 0 ? labels[score] : '';
    lbl.style.color = labelColors[score] || '';
  }
}
