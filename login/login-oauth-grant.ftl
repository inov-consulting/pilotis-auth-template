<#import "template.ftl" as layout>
<@layout.registrationLayout bodyClass="oauth"; section>
    <#if section = "title">
        ${msg("oauthGrantTitle")}

    <#elseif section = "form">

        <h1 class="pl-h1" style="margin-bottom:8px;">${msg("oauthGrantRequest")}</h1>
        <p class="pl-desc" style="margin-bottom:16px;">
            ${msg("oauthGrantTitleHtml",(realm.displayName!''))?no_esc}
            <strong><#if client.name??>${advancedMsg(client.name)}<#else>${client.clientId}</#if></strong>.
        </p>

        <ul style="list-style:disc;padding-left:20px;font-size:13px;color:var(--ink);line-height:1.7;margin-bottom:20px;">
            <#if oauth.claimsRequested??>
                <li>
                    ${msg("personalInfo")}
                    <#list oauth.claimsRequested as claim>
                        ${advancedMsg(claim)}<#if claim_has_next>,</#if>
                    </#list>
                </li>
            </#if>
            <#if oauth.accessRequestMessage??>
                <li>${oauth.accessRequestMessage}</li>
            </#if>
            <#if oauth.realmRolesRequested??>
                <#list oauth.realmRolesRequested as role>
                    <li><#if role.description??>${advancedMsg(role.description)}<#else>${advancedMsg(role.name)}</#if></li>
                </#list>
            </#if>
            <#if oauth.resourceRolesRequested??>
                <#list oauth.resourceRolesRequested?keys as resource>
                    <#list oauth.resourceRolesRequested[resource] as clientRole>
                        <li>
                            <#if clientRole.roleDescription??>${advancedMsg(clientRole.roleDescription)}<#else>${advancedMsg(clientRole.roleName)}</#if>
                            — ${msg("inResource")} <strong><#if clientRole.clientName??>${advancedMsg(clientRole.clientName)}<#else>${clientRole.clientId}</#if></strong>
                        </li>
                    </#list>
                </#list>
            </#if>
        </ul>

        <form action="${url.oauthAction}" method="POST">
            <input type="hidden" name="code" value="${oauth.code}">
            <div style="display:flex;gap:10px;">
                <button class="pl-btn" name="accept" id="kc-login" type="submit"
                        style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                        onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">${msg("doYes")}</button>
                <button class="pl-btn pl-btn-outline" name="cancel" id="kc-cancel" type="submit"
                        style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:1px solid #e3e5ec;border-radius:12px;background:#fff;color:inherit;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
                        onmouseover="this.style.background='#f7f7fa'" onmouseout="this.style.background='#fff'">${msg("doNo")}</button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
