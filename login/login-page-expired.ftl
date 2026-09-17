<#-- Shown whenever an action link (password reset, email verification, admin invitation…)
     is opened after it has expired. Keycloak renders this dedicated template instead of
     the generic error.ftl. -->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        Lien expiré

    <#elseif section = "form">

        <div class="pl-state">
            <span class="pl-state-icon danger" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
            </span>
            <h1>Ce lien n'est plus valide</h1>
            <p>Les liens de sécurité (réinitialisation, invitation, vérification…) expirent après un certain délai. Recommencez depuis l'écran de connexion pour en obtenir un nouveau.</p>

            <div class="pl-state-actions">
                <a class="pl-btn" id="loginRestartLink" href="${url.loginRestartFlowUrl}"
                   style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;text-decoration:none;transition:background 0.15s;"
                   onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">Recommencer la connexion</a>
                <a class="pl-btn pl-btn-outline" id="loginContinueLink" href="${url.loginAction}"
                   style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:1px solid #e3e5ec;border-radius:12px;background:#fff;color:inherit;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;text-decoration:none;transition:background 0.15s;"
                   onmouseover="this.style.background='#f7f7fa'" onmouseout="this.style.background='#fff'">Continuer la connexion en cours</a>
            </div>
        </div>

    </#if>
</@layout.registrationLayout>
