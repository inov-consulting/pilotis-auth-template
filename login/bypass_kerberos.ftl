<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        ${msg("kerberosNotConfiguredTitle")}

    <#elseif section = "form">

        <h1 class="pl-h1" style="margin-bottom:8px;">${msg("kerberosNotConfigured")}</h1>
        <p class="pl-desc" style="margin-bottom:20px;">${msg("bypassKerberosDetail")}</p>

        <form action="${url.loginAction}" method="POST">
            <button class="pl-btn" name="continue" id="kc-login" type="submit"
                    style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                    onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">${msg("doContinue")}</button>
        </form>

        <#if client?? && client.baseUrl?has_content>
            <a class="pl-link-quiet" href="${client.baseUrl}" style="margin:16px auto 0;">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
                ${msg("backToApplication")}
            </a>
        </#if>
    </#if>
</@layout.registrationLayout>
