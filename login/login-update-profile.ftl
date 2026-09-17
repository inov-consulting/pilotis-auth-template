<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <#if section = "title">
    ${msg("loginProfileTitle")}

  <#elseif section = "form">

    <#-- Reached either from the account console, or as the very first step after an
         administrator invitation, once the invite link has been opened. -->
    <#assign displayName = ((user.firstName!'') + ' ' + (user.lastName!''))?trim>
    <#if displayName == ''><#assign displayName = (user.username!'')></#if>
    <#assign initials = "">
    <#list displayName?split(" ") as part>
      <#if part?has_content && initials?length lt 2><#assign initials = initials + part[0]?upper_case></#if>
    </#list>

    <div style="display:flex;flex-direction:column;gap:20px;">
      <div style="margin-bottom:8px;text-align:center;">
        <h1 class="pl-h1">Activez votre accès</h1>
        <p class="pl-sub">${msg("updateProfileMessage")}</p>
      </div>

      <#if displayName?has_content>
        <div class="pl-identity-card">
          <span class="pl-identity-avatar">${initials}</span>
          <div class="pl-identity-info">
            <p class="name">${displayName}</p>
            <#if user.email?has_content><p class="email">${user.email}</p></#if>
          </div>
        </div>
      </#if>

      <#if messagesPerField.existsError('username','email','firstName','lastName')>
        <div class="pl-notice danger">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
          ${kcSanitize(messagesPerField.getFirstError('username','email','firstName','lastName'))?no_esc}
        </div>
      </#if>

      <form id="kc-update-profile-form" action="${url.loginAction}" method="post">
        <div style="display:flex;flex-direction:column;gap:16px;">

          <#-- Username (si modifiable) -->
          <#if user.editUsernameAllowed>
            <div class="pl-field">
              <label for="username" class="pl-label">${msg("username")}</label>
              <input type="text" id="username" name="username"
                     value="${(user.username!'')}"
                     class="pl-input"<#if messagesPerField.existsError('username')> data-error="true"</#if>
                     readonly />
              <#if messagesPerField.existsError('username')>
                <span class="pl-error-text">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
              </#if>
            </div>
          </#if>

          <#-- Email -->
          <div class="pl-field">
            <label for="email" class="pl-label">${msg("email")}</label>
            <input type="email" id="email" name="email"
                   value="${(user.email!'')}"
                   placeholder="prenom.nom@structure.cm"
                   class="pl-input"<#if messagesPerField.existsError('email')> data-error="true"</#if>
                   readonly />
            <#if messagesPerField.existsError('email')>
              <span class="pl-error-text">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
            </#if>
          </div>

          <#-- Prénom -->
          <div class="pl-field">
            <label for="firstName" class="pl-label">${msg("firstName")}</label>
            <input type="text" id="firstName" name="firstName"
                   value="${(user.firstName!'')}"
                   class="pl-input"<#if messagesPerField.existsError('firstName')> data-error="true"</#if>
                   autocomplete="given-name" />
            <#if messagesPerField.existsError('firstName')>
              <span class="pl-error-text">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
            </#if>
          </div>

          <#-- Nom -->
          <div class="pl-field">
            <label for="lastName" class="pl-label">${msg("lastName")}</label>
            <input type="text" id="lastName" name="lastName"
                   value="${(user.lastName!'')}"
                   class="pl-input"<#if messagesPerField.existsError('lastName')> data-error="true"</#if>
                   autocomplete="family-name" />
            <#if messagesPerField.existsError('lastName')>
              <span class="pl-error-text">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
            </#if>
          </div>
        </div>

        <button type="submit" class="pl-btn"
                style="margin-top:20px;display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13c0 5-3.5 7.5-8 9-4.5-1.5-8-4-8-9V5l8-3 8 3z"/><path d="m9 12 2 2 4-4"/></svg>
          ${msg("doSubmit")}
        </button>

        <p style="margin:8px 0 0;text-align:center;font-size:12.5px;line-height:1.6;color:var(--muted);">
          En continuant, vous confirmez être bien la personne invitée par votre administrateur.
        </p>
      </form>
    </div>
  </#if>
</@layout.registrationLayout>
