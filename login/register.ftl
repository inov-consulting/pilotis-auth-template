<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("registerWithTitle",(realm.displayName!''))}

    <#elseif section = "form">

      <div style="margin-bottom:8px;text-align:center;">
        <h1 class="pl-h1">${msg("registerWithTitle2")}</h1>
        <p class="pl-sub">${msg("registerWithText2")}</p>
      </div>

      <form action="${url.registrationAction}" method="post" style="margin-top:20px;">
        <div style="display:flex;flex-direction:column;gap:16px;">
          <#if !realm.registrationEmailAsUsername>
            <div class="pl-field">
              <label for="username" class="pl-label">${msg("createUsername")}</label>
              <input id="username" type="text" data-qa="username" value="${(register.formData.username!'')}" name="username" placeholder="${msg("username")}" class="pl-input" readonly />
              <#if messagesPerField.existsError('username')>
                <span class="pl-error-text" aria-live="polite">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
              </#if>
            </div>
          </#if>

          <div class="pl-field">
            <label for="firstName" class="pl-label">${msg("firstName")}</label>
            <input type="text" id="firstName" data-qa="firstName" value="${(register.formData.firstName!'')}" name="firstName" class="pl-input" autocomplete="given-name" />
            <#if messagesPerField.existsError('firstName')>
              <span class="pl-error-text" aria-live="polite">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
            </#if>
          </div>

          <div class="pl-field">
            <label for="lastName" class="pl-label">${msg("lastName")}</label>
            <input type="text" id="lastName" data-qa="lastName" value="${(register.formData.lastName!'')}" name="lastName" class="pl-input" autocomplete="family-name" />
            <#if messagesPerField.existsError('lastName')>
              <span class="pl-error-text" aria-live="polite">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
            </#if>
          </div>

          <div class="pl-field">
            <label for="email" class="pl-label">${msg("email")}</label>
            <input type="email" id="email" data-qa="email" value="${(register.formData.email!'')}" name="email" placeholder="prenom.nom@structure.cm" class="pl-input" autocomplete="email" />
            <#if messagesPerField.existsError('email')>
              <span class="pl-error-text" aria-live="polite">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
            </#if>
          </div>

          <#if passwordRequired>
            <div class="pl-field">
              <label for="password" class="pl-label">${msg("createPassword")}</label>
              <input type="password" id="password" data-qa="password" name="password" class="pl-input" autocomplete="new-password" />
              <#if messagesPerField.existsError('password')>
                <span class="pl-error-text" aria-live="polite">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
              </#if>
            </div>

            <div class="pl-field">
              <label for="password-confirm" class="pl-label">${msg("passwordConfirm")}</label>
              <input type="password" id="password-confirm" data-qa="password-confirm" name="password-confirm" class="pl-input" autocomplete="new-password" />
              <#if messagesPerField.existsError('password-confirm')>
                <span class="pl-error-text" aria-live="polite">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
              </#if>
            </div>
          </#if>

          <#if recaptchaRequired??>
            <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
          </#if>
        </div>

        <button type="submit" class="pl-btn"
                style="margin-top:20px;display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">${msg("doRegister")}</button>

        <a href="${url.loginUrl}" class="pl-link-quiet" style="margin:16px auto 0;">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
          ${msg("backToLogin")}
        </a>
      </form>
    </#if>
</@layout.registrationLayout>
