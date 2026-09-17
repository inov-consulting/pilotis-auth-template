<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <#if section = "title">
    ${msg("passwordResetTitle")}

  <#elseif section = "form">

    <#-- Serves both the self-service "forgot password" flow and the first-connection
         step for accounts created/invited by an administrator. -->
    <div style="display:flex;flex-direction:column;gap:20px;">
      <div style="margin-bottom:8px;text-align:center;">
        <h1 class="pl-h1">Choisissez un nouveau mot de passe</h1>
        <p class="pl-sub">Il remplacera immédiatement l'ancien pour tous vos accès Pilotis.</p>
      </div>

      <form id="kc-passwd-update-form" action="${url.loginAction}" method="post" onsubmit="return validatePasswordForm(event);">
        <div style="display:flex;flex-direction:column;gap:16px;">

          <div class="pl-field">
            <label for="pw-new" class="pl-label">${msg("passwordNew")}</label>
            <div class="pl-input-wrap">
              <input id="pw-new" name="password-new" type="password"
                data-has-toggle="true"
                class="pl-input has-icon-right"
                placeholder="••••••••"
                autocomplete="new-password" required minlength="8"
                oninput="validatePasswordForm();" />
              <button type="button" class="pl-input-toggle" onclick="fcToggle('pw-new','eye-new')" aria-label="Afficher/masquer le mot de passe">
                <svg id="eye-new" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/>
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                </svg>
              </button>
            </div>
            <span style="font-size:11px;color:var(--muted);">8 caractères minimum, au moins une majuscule et un chiffre.</span>
          </div>

          <div class="pl-field">
            <label for="pw-confirm" class="pl-label">${msg("passwordNewConfirm")!msg("passwordConfirm")}</label>
            <div class="pl-input-wrap">
              <input id="pw-confirm" name="password-confirm" type="password"
                data-has-toggle="true"
                class="pl-input has-icon-right"
                placeholder="••••••••"
                autocomplete="new-password" required
                oninput="validatePasswordForm();" />
              <button type="button" class="pl-input-toggle" onclick="fcToggle('pw-confirm','eye-confirm')" aria-label="Afficher/masquer le mot de passe">
                <svg id="eye-confirm" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/>
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                </svg>
              </button>
            </div>
            <span id="confirm-error" class="pl-error-text" style="display:none;" aria-live="polite"></span>
          </div>
        </div>

        <button type="submit" id="kc-submit" class="pl-btn"
                style="margin-top:20px;display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                onmouseover="if(!this.disabled)this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="15" r="4"/><path d="m10.85 12.15 8.15-8.15 2 2-2 2 2 2-3 3-2-2"/></svg>
          Réinitialiser le mot de passe
        </button>
      </form>
    </div>

    <script>
      var EYE_OPEN = '<path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>';
      var EYE_CLOSED = '<path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88"/>';
      function fcToggle(inputId, eyeId) {
        var inp = document.getElementById(inputId);
        var eye = document.getElementById(eyeId);
        if (!inp || !eye) return;
        if (inp.type === 'password') { inp.type = 'text'; eye.innerHTML = EYE_CLOSED; }
        else { inp.type = 'password'; eye.innerHTML = EYE_OPEN; }
      }
      function validatePasswordForm(event) {
        var pw = document.getElementById('pw-new'), cf = document.getElementById('pw-confirm');
        var btn = document.getElementById('kc-submit'), err = document.getElementById('confirm-error');
        if (!pw || !cf) return true;
        var meetsRules = pw.value.length >= 8;
        var matches = pw.value.length > 0 && pw.value === cf.value;
        var valid = meetsRules && matches;
        if (btn) { btn.disabled = !valid; btn.style.opacity = valid ? '1' : '0.7'; btn.style.cursor = valid ? 'pointer' : 'not-allowed'; }
        if (err) {
          if (!pw.value || !cf.value) { err.textContent = ''; err.style.display = 'none'; }
          else if (!meetsRules) { err.textContent = 'Le mot de passe doit contenir au moins 8 caractères.'; err.style.display = 'block'; }
          else if (!matches) { err.textContent = 'Les mots de passe ne correspondent pas.'; err.style.display = 'block'; }
          else { err.textContent = ''; err.style.display = 'none'; }
        }
        if (event && !valid) { event.preventDefault(); return false; }
        return valid;
      }
      document.addEventListener('DOMContentLoaded', function() { validatePasswordForm(); });
    </script>
  </#if>
</@layout.registrationLayout>
