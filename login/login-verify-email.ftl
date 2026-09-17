<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("emailVerificationTitle")}

    <#elseif section = "form">

        <div class="pl-state">
            <span class="pl-state-icon neutral" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75"/>
                </svg>
            </span>

            <h1>${msg("emailVerificationTitle")}</h1>
            <p>${msg("emailVerifyInstruction1",user.email)?no_esc}</p>
            <p style="margin-top:10px;">
                ${msg("emailVerifyInstruction2")}
                <a href="${url.loginAction}">${msg("doClickHere")}</a>
                ${msg("emailVerifyInstruction3")}
            </p>

            <div class="pl-state-actions">
                <a class="pl-btn pl-btn-outline" href="${url.loginUrl}"
                   style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:1px solid #e3e5ec;border-radius:12px;background:#fff;color:inherit;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;text-decoration:none;transition:background 0.15s;"
                   onmouseover="this.style.background='#f7f7fa'" onmouseout="this.style.background='#fff'">${msg("backToLogin")}</a>
            </div>
        </div>

    </#if>
</@layout.registrationLayout>
