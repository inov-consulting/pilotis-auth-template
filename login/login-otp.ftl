<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("loginTotpOneTime")}

    <#elseif section = "form">

      <style>
        .pl-otp-group { display:flex;gap:8px; }
        .pl-otp-input {
          width:48px;height:48px;box-sizing:border-box;border-radius:8px;border:1px solid var(--border);
          background:#fff;text-align:center;font:inherit;font-size:16px;color:inherit;
        }
        .pl-otp-input.filled { border-color:var(--brand); }
      </style>

      <div style="display:flex;flex-direction:column;gap:20px;">
        <div>
          <a href="${url.loginUrl}" class="pl-link-quiet" style="margin-bottom:24px;">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
            ${msg("backToLogin")}
          </a>
          <div style="text-align:center;">
            <h1 class="pl-h1">${msg("loginTotpOneTime")}</h1>
            <p class="pl-sub">${msg("loginTotpStep3")}</p>
          </div>
        </div>

        <form id="kc-totp-login-form" action="${url.loginAction}" method="post">
          <input id="otp-hidden" name="otp" type="hidden" />

          <div style="display:flex;flex-direction:column;gap:8px;">
            <span class="pl-label">Code de vérification</span>
            <div class="pl-otp-group" role="group" aria-label="Code de vérification à 6 chiffres">
              <input class="pl-otp-input" type="text" inputmode="numeric" maxlength="1" aria-label="Chiffre 1" autocomplete="one-time-code" autofocus />
              <input class="pl-otp-input" type="text" inputmode="numeric" maxlength="1" aria-label="Chiffre 2" />
              <input class="pl-otp-input" type="text" inputmode="numeric" maxlength="1" aria-label="Chiffre 3" />
              <input class="pl-otp-input" type="text" inputmode="numeric" maxlength="1" aria-label="Chiffre 4" />
              <input class="pl-otp-input" type="text" inputmode="numeric" maxlength="1" aria-label="Chiffre 5" />
              <input class="pl-otp-input" type="text" inputmode="numeric" maxlength="1" aria-label="Chiffre 6" />
            </div>
          </div>

          <#if messagesPerField.existsError('totp')>
            <p class="pl-error-text" style="margin-top:10px;" aria-live="polite">${kcSanitize(messagesPerField.get('totp'))?no_esc}</p>
          </#if>

          <button type="submit" name="login" id="kc-login" class="pl-btn"
                  style="margin-top:20px;display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                  onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
            ${msg("doLogIn")}
          </button>
        </form>
      </div>

      <script>
        (function() {
          var inputs = Array.prototype.slice.call(document.querySelectorAll('.pl-otp-input'));
          var hidden = document.getElementById('otp-hidden');

          function syncHidden() {
            if (hidden) hidden.value = inputs.map(function(i){ return i.value; }).join('');
          }

          inputs.forEach(function(inp, idx) {
            inp.addEventListener('input', function() {
              var val = inp.value.replace(/\D/g, '');
              inp.value = val ? val[0] : '';
              inp.classList.toggle('filled', inp.value.length > 0);
              syncHidden();
              if (inp.value && idx < inputs.length - 1) inputs[idx + 1].focus();
            });
            inp.addEventListener('keydown', function(e) {
              if (e.key === 'Backspace' && !inp.value && idx > 0) {
                inputs[idx - 1].focus();
                inputs[idx - 1].value = '';
                inputs[idx - 1].classList.remove('filled');
                syncHidden();
              }
            });
            inp.addEventListener('paste', function(e) {
              e.preventDefault();
              var data = (e.clipboardData || window.clipboardData).getData('text').replace(/\D/g,'').slice(0, 6);
              data.split('').forEach(function(ch, i) {
                if (inputs[i]) { inputs[i].value = ch; inputs[i].classList.add('filled'); }
              });
              syncHidden();
              var next = inputs[Math.min(data.length, inputs.length - 1)];
              if (next) next.focus();
            });
          });
        })();
      </script>
    </#if>
</@layout.registrationLayout>
