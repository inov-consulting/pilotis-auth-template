<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("forgotPasswordTitle")}

    <#elseif section = "form">

      <div style="display:flex;flex-direction:column;gap:20px;">
        <div>
          <a href="${url.loginUrl}" class="pl-link-quiet" style="margin-bottom:24px;">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
            ${msg("backToLogin")}
          </a>
          <div style="text-align:center;">
            <h1 class="pl-h1">${msg("forgotPasswordTitle")}</h1>
            <p class="pl-sub">${msg("forgotPasswordInstruction")}</p>
          </div>
        </div>

        <#if message?has_content && (message.type == "error")>
          <div class="pl-notice danger">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            ${kcSanitize(message.summary)?no_esc}
          </div>
        </#if>

        <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
          <div class="pl-field">
            <label for="username" class="pl-label">E-mail</label>
            <div class="pl-input-wrap">
              <svg class="pl-input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/>
              </svg>
              <input
                type="email"
                id="username"
                name="username"
                value="<#if auth?? && auth.attemptedUsername?? >${auth.attemptedUsername}</#if>"
                placeholder="${msg("emailPlaceholder")}"
                class="pl-input has-icon-left"<#if messagesPerField.existsError('email')> data-error="true"</#if>
                autofocus
                autocomplete="email"
                autocapitalize="none"
                autocorrect="off"
                required
              />
            </div>
            <#if messagesPerField.existsError('email')>
              <p class="pl-error-text" aria-live="polite">${kcSanitize(messagesPerField.get('email'))?no_esc}</p>
            </#if>
          </div>

          <button type="submit" class="pl-btn"
                  style="margin-top:20px;display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                  onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
            ${msg("sendButton")}
          </button>
        </form>
      </div>
    </#if>
</@layout.registrationLayout>
