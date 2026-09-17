<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=(social?? && social.displayInfo??)?then(social.displayInfo,false); section>

    <#if section = "title">
        ${msg("loginHeading",(realm.displayName!''))}

    <#elseif section = "form">

        <#assign hasFieldError = messagesPerField.existsError('username','password')>

        <#-- Keycloak signals a disabled / brute-force-locked account through the generic error
             message, so we compare against the (already localized) default strings to swap in a
             dedicated full-panel state instead of the plain credentials error banner. -->
        <#assign isDisabledAccount = message?has_content && (message.type == "error") && (message.summary == msg("accountDisabledMessage"))>
        <#assign isTemporarilyDisabled = message?has_content && (message.type == "error") && (message.summary == msg("accountTemporarilyDisabledMessage"))>
        <#assign isPasswordUpdated = message?has_content && (message.type == "success")>

        <#if isDisabledAccount || isTemporarilyDisabled>

            <#-- ══════════ Compte désactivé / verrouillé ══════════ -->
            <div class="pl-state">
                <span class="pl-state-icon danger" aria-hidden="true">
                    <#if isDisabledAccount>
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13c0 5-3.5 7.5-8 9-4.5-1.5-8-4-8-9V5l8-3 8 3z"/><line x1="4" y1="4" x2="20" y2="20"/></svg>
                    <#else>
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
                    </#if>
                </span>
                <#if isDisabledAccount>
                    <h1>Votre accès a été désactivé</h1>
                    <p>Un administrateur a désactivé ce compte. Rapprochez-vous de votre super admin pour le réactiver.</p>
                <#else>
                    <h1>Compte temporairement bloqué</h1>
                    <p>Trop de tentatives de connexion ont échoué. Réessayez dans quelques minutes ou réinitialisez votre mot de passe.</p>
                </#if>
                <div class="pl-state-actions">
                    <#if realm.resetPasswordAllowed>
                        <a class="pl-btn" href="${url.loginResetCredentialsUrl}"
                           style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;text-decoration:none;transition:background 0.15s;"
                           onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">Réinitialiser mon mot de passe</a>
                    </#if>
                    <a class="pl-btn pl-btn-outline" href="${url.loginUrl}"
                       style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:1px solid #e3e5ec;border-radius:12px;background:#fff;color:inherit;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;text-decoration:none;transition:background 0.15s;"
                       onmouseover="this.style.background='#f7f7fa'" onmouseout="this.style.background='#fff'">Retour à la connexion</a>
                </div>
            </div>

        <#else>

            <#-- ══════════ Connexion ══════════ -->
            <div style="display:flex;flex-direction:column;gap:20px;">
              <div style="margin-bottom:8px;text-align:center;">
                <h1 class="pl-h1">${msg("loginHeading")}</h1>
                <p class="pl-sub">Accès réservé aux comptes invités par votre administrateur.</p>
              </div>

              <#if isPasswordUpdated>
                <div class="pl-notice success">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></svg>
                  ${kcSanitize(message.summary)?no_esc}
                </div>
              </#if>

              <#-- Session expired / info warning -->
              <#if message?has_content && (message.type == "warning")>
                <div class="pl-notice neutral" style="color:var(--danger);background:var(--danger-bg);font-weight:500;">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/></svg>
                  ${kcSanitize(message.summary)?no_esc}
                </div>
              </#if>

              <#-- Credentials error -->
              <#if message?has_content && (message.type == "error") && !hasFieldError>
                <div class="pl-notice danger">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                  ${kcSanitize(message.summary)?no_esc}
                </div>
              </#if>

              <form id="kc-form-login" action="${url.loginAction}" method="post" onsubmit="fcSubmit(this)">
                <div style="display:flex;flex-direction:column;gap:16px;">

                  <#-- Email / Username field -->
                  <div class="pl-field">
                      <label class="pl-label">
                          <#if realm.loginWithEmailAllowed && realm.registrationEmailAsUsername>
                              E-mail
                          <#elseif !realm.loginWithEmailAllowed>
                              ${msg("username")}
                          <#else>
                              ${msg("usernameOrEmail")}
                          </#if>
                      </label>
                      <div class="pl-input-wrap">
                        <svg class="pl-input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                          <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/>
                        </svg>
                        <#if realm.loginWithEmailAllowed && realm.registrationEmailAsUsername>
                            <#if usernameEditDisabled??>
                                <input type="email" name="username" value="${(login.username!'')}" class="pl-input has-icon-left" readonly />
                            <#else>
                                <input type="email" name="username" value="${(login.username!'')}" class="pl-input has-icon-left"<#if hasFieldError> data-error="true"</#if> placeholder="prenom.nom@structure.cm" autofocus autocomplete="email" />
                            </#if>
                        <#elseif !realm.loginWithEmailAllowed>
                            <#if usernameEditDisabled??>
                                <input type="text" name="username" value="${(login.username!'')}" class="pl-input has-icon-left" readonly />
                            <#else>
                                <input type="text" name="username" value="${(login.username!'')}" class="pl-input has-icon-left"<#if hasFieldError> data-error="true"</#if> autofocus autocomplete="username" />
                            </#if>
                        <#else>
                            <#if usernameEditDisabled??>
                                <input type="text" name="username" id="username" value="${(login.username!'')}" class="pl-input has-icon-left" readonly />
                            <#else>
                                <input type="text" name="username" id="username" value="${(login.username!'')}" class="pl-input has-icon-left"<#if hasFieldError> data-error="true"</#if> placeholder="prenom.nom@structure.cm" autofocus autocomplete="off" />
                            </#if>
                        </#if>
                      </div>
                      <#if hasFieldError && messagesPerField.existsError('username')>
                          <p class="pl-error-text">${kcSanitize(messagesPerField.get('username'))?no_esc}</p>
                      </#if>
                  </div>

                  <#-- Password field -->
                  <div class="pl-field">
                      <div style="display:flex;align-items:center;justify-content:space-between;gap:12px;">
                          <label class="pl-label">${msg("password")}</label>
                          <#if realm.resetPasswordAllowed>
                              <a href="${url.loginResetCredentialsUrl}" class="pl-link-quiet" style="margin:0;">${msg("doForgotPassword")}</a>
                          </#if>
                      </div>
                      <div class="pl-input-wrap">
                          <input id="password" name="password" type="password"
                                 data-has-toggle="true"
                                 class="pl-input has-icon-right"<#if hasFieldError> data-error="true"</#if>
                                 placeholder="••••••••"
                                 autocomplete="current-password" />
                          <button type="button" class="pl-input-toggle" onclick="fcTogglePwd()" aria-label="Afficher/masquer le mot de passe">
                              <svg id="fc-pwd-eye" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                                  <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/>
                                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                              </svg>
                          </button>
                      </div>
                      <#if hasFieldError && messagesPerField.existsError('password')>
                          <p class="pl-error-text">${kcSanitize(messagesPerField.get('password'))?no_esc}</p>
                      </#if>
                  </div>
                </div>

                <#if realm.rememberMe && !usernameEditDisabled??>
                  <label class="pl-checkbox-row">
                      <input type="checkbox" id="rememberMe" name="rememberMe" <#if login.rememberMe??>checked</#if> />
                      <span>${msg("rememberMe")}</span>
                  </label>
                </#if>

                <button id="fc-btn" type="submit" class="pl-btn"
                        style="margin-top:4px;display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                        onmouseover="if(!this.disabled)this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">
                    <svg id="fc-btn-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg>
                    <span id="fc-btn-text">${msg("doLogIn")}</span>
                    <span id="fc-btn-spin" style="display:none;">
                        <svg class="pl-spinner" style="width:16px;height:16px;" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="12" cy="12" r="10" stroke="rgba(255,255,255,0.35)" stroke-width="3"/>
                            <path d="M12 2a10 10 0 0110 10" stroke="#ffffff" stroke-width="3" stroke-linecap="round"/>
                        </svg>
                    </span>
                </button>

                <#-- Registration link, or invite-only notice when self-registration is disabled -->
                <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
                    <p style="margin:8px 0 0;text-align:center;font-size:12.5px;color:var(--muted);">
                        ${msg("noEsigmapAccount")}
                        <a style="font-weight:500;" href="${url.registrationUrl}">${msg("registerLink")}</a>
                    </p>
                <#elseif !usernameEditDisabled??>
                    <p style="margin:8px 0 0;text-align:center;font-size:12.5px;line-height:1.6;color:var(--muted);">
                        Vous n'avez pas encore de compte ? Contactez votre administrateur : l'accès à Pilotis se fait uniquement sur invitation.
                    </p>
                </#if>
              </form>
            </div>

            <script>
            function fcSubmit(form) {
                var btn = document.getElementById('fc-btn');
                var icon = document.getElementById('fc-btn-icon');
                var txt = document.getElementById('fc-btn-text');
                var spin = document.getElementById('fc-btn-spin');
                if (btn && txt && spin) {
                    if (icon) icon.style.display = 'none';
                    txt.style.display = 'none';
                    spin.style.display = 'flex';
                    btn.disabled = true;
                }
            }
            function fcTogglePwd() {
                var inp = document.getElementById('password');
                var eye = document.getElementById('fc-pwd-eye');
                if (!inp) return;
                if (inp.type === 'password') {
                    inp.type = 'text';
                    eye.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88"/>';
                } else {
                    inp.type = 'password';
                    eye.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>';
                }
            }
            </script>

        </#if>
    </#if>
</@layout.registrationLayout>
