<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        ${msg("termsTitle")}

    <#elseif section = "form">

        <div style="margin-bottom:8px;text-align:center;">
            <h1 class="pl-h1">${msg("termsTitle")}</h1>
            <p class="pl-sub">${msg("termsIntro")}</p>
        </div>

        <div id="kc-terms-text" style="max-height:320px;overflow-y:auto;border:1px solid var(--border);border-radius:12px;padding:16px;font-size:13px;color:var(--ink);line-height:1.6;margin:20px 0;">
            ${msg("termsText")?no_esc}
            ${msg("termsTextHtml")?no_esc}
        </div>

        <form action="${url.loginAction}" method="POST">
            <button class="pl-btn" name="accept" id="kc-accept" type="submit"
                    style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                    onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">${msg("doAccept")}</button>
        </form>
    </#if>
</@layout.registrationLayout>
