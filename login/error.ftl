<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        ${msg("errorTitle")}

    <#elseif section = "form">

        <#-- Keycloak funnels many distinct problems through this single generic page:
             an invalid/used/expired action-token link (invitation, password reset…),
             a client configuration error, a generic internal error, etc. -->
        <div class="pl-state">
            <span class="pl-state-icon danger" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            </span>

            <h1>${msg("errorTitle")}</h1>
            <#if message?has_content>
                <p>${kcSanitize(message.summary)?no_esc}</p>
            </#if>

            <div class="pl-state-actions">
                <#assign btnStyle = "display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;text-decoration:none;transition:background 0.15s;">
                <#if client?? && client.baseUrl?has_content>
                    <a class="pl-btn" id="backToApplication" href="${client.baseUrl}" style="${btnStyle}" onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">${msg("backToApplication")}</a>
                <#else>
                    <a class="pl-btn" href="${url.loginUrl!'#'}" style="${btnStyle}" onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">Retour à la connexion</a>
                </#if>
            </div>
        </div>

    </#if>
</@layout.registrationLayout>
