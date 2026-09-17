<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
  <#if section = "title">
    ${msg("loginTotpTitle")}

  <#elseif section = "form">

    <h1 class="pl-h1" style="margin-bottom:16px;">${msg("loginTotpTitle")}</h1>

    <ol style="padding-left:18px;font-size:13px;color:var(--ink);line-height:1.7;margin-bottom:8px;">
      <li>
        <p style="margin-bottom:10px;">${msg("loginTotpStep1")}</p>
        <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:8px;margin-bottom:16px;">
          <a target="_blank" rel="noopener" href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=fr&gl=US" style="display:flex;align-items:center;gap:8px;border:1px solid var(--border);border-radius:10px;padding:8px;text-decoration:none;color:var(--ink);font-size:12px;">
            <img src="${url.resourcesPath}/images/google_auth.png" width="28" height="28" style="border-radius:6px;" alt="" />
            Google Authenticator
          </a>
          <a target="_blank" rel="noopener" href="https://authy.com/download/" style="display:flex;align-items:center;gap:8px;border:1px solid var(--border);border-radius:10px;padding:8px;text-decoration:none;color:var(--ink);font-size:12px;">
            <img src="${url.resourcesPath}/images/authy.png" width="28" height="28" style="border-radius:6px;" alt="" />
            Microsoft Authenticator
          </a>
          <a target="_blank" rel="noopener" href="https://freeotp.github.io/" style="display:flex;align-items:center;gap:8px;border:1px solid var(--border);border-radius:10px;padding:8px;text-decoration:none;color:var(--ink);font-size:12px;">
            <img src="${url.resourcesPath}/images/free_otp.png" width="28" height="28" style="border-radius:6px;" alt="" />
            Free OTP
          </a>
        </div>
      </li>
      <li style="margin-bottom:10px;">
        <p>
          ${msg("loginTotpStep2")}<br/>
          <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="QR code de configuration OTP" style="margin:10px 0;" /><br />
          <span style="font-family:ui-monospace,monospace;font-size:12px;background:var(--surface-soft);padding:4px 8px;border-radius:6px;">${totp.totpSecretEncoded}</span>
        </p>
      </li>
      <li><p>${msg("loginTotpStep3")}</p></li>
    </ol>

    <form action="${url.loginAction}" id="kc-totp-settings-form" method="post">
        <#if messagesPerField.existsError('totp')>
          <p class="pl-error-text" aria-live="polite">${kcSanitize(messagesPerField.get('totp'))?no_esc}</p>
        </#if>
      <input type="hidden" id="totp" name="totp" autocomplete="off" />
      <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />

      <div style="display:flex;justify-content:center;gap:8px;margin:8px 0 20px;">
        <input class="pl-otp-input" style="width:40px;height:48px;box-sizing:border-box;border-radius:8px;border:1px solid var(--border);text-align:center;font-size:18px;font-family:inherit;" type="text" inputmode="numeric" id="first" maxlength="1" />
        <input class="pl-otp-input" style="width:40px;height:48px;box-sizing:border-box;border-radius:8px;border:1px solid var(--border);text-align:center;font-size:18px;font-family:inherit;" type="text" inputmode="numeric" id="second" maxlength="1" />
        <input class="pl-otp-input" style="width:40px;height:48px;box-sizing:border-box;border-radius:8px;border:1px solid var(--border);text-align:center;font-size:18px;font-family:inherit;" type="text" inputmode="numeric" id="third" maxlength="1" />
        <input class="pl-otp-input" style="width:40px;height:48px;box-sizing:border-box;border-radius:8px;border:1px solid var(--border);text-align:center;font-size:18px;font-family:inherit;" type="text" inputmode="numeric" id="fourth" maxlength="1" />
        <input class="pl-otp-input" style="width:40px;height:48px;box-sizing:border-box;border-radius:8px;border:1px solid var(--border);text-align:center;font-size:18px;font-family:inherit;" type="text" inputmode="numeric" id="fifth" maxlength="1" />
        <input class="pl-otp-input" style="width:40px;height:48px;box-sizing:border-box;border-radius:8px;border:1px solid var(--border);text-align:center;font-size:18px;font-family:inherit;" type="text" inputmode="numeric" id="sixth" maxlength="1" />
      </div>

      <button type="submit" class="pl-btn"
              style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
              onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">${msg("doSubmit")}</button>
    </form>

    <script>
      (function () {
        var ids = ['first', 'second', 'third', 'fourth', 'fifth', 'sixth'];
        var inputs = ids.map(function (id) { return document.getElementById(id); }).filter(Boolean);
        var hidden = document.getElementById('totp');
        function sync() { if (hidden) hidden.value = inputs.map(function (i) { return i.value; }).join(''); }
        inputs.forEach(function (inp, idx) {
          inp.addEventListener('input', function () {
            inp.value = inp.value.replace(/\D/g, '').slice(0, 1);
            sync();
            if (inp.value && idx < inputs.length - 1) inputs[idx + 1].focus();
          });
          inp.addEventListener('keydown', function (e) {
            if (e.key === 'Backspace' && !inp.value && idx > 0) {
              inputs[idx - 1].focus();
              inputs[idx - 1].value = '';
              sync();
            }
          });
        });
      })();
    </script>
  </#if>
</@layout.registrationLayout>
