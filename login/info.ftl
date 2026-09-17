<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        ${message.summary}

    <#elseif section = "form">

        <#-- info.ftl is Keycloak's catch-all "informational" page: it is reused for very
             different situations (password-reset email just sent, email already verified,
             generic notices…). We compare the sanitized summary against the well-known
             default messages to pick a fitting icon/title instead of always claiming
             "check your mailbox". -->
        <#assign summaryText = kcSanitize(message.summary)?no_esc>
        <#assign isPasswordResetSent = message?has_content && (message.summary == msg("emailSendPasswordResetMessage"))>
        <#assign isVerifyEmailSent = message?has_content && (message.summary == msg("emailSendVerificationMessage"))>
        <#assign isEmailFlow = isPasswordResetSent || isVerifyEmailSent>
        <#assign isSuccess = message?has_content && (message.type == "success")>

        <div class="pl-state">
            <span class="pl-state-icon <#if isEmailFlow || isSuccess>success<#else>neutral</#if>" aria-hidden="true">
                <#if isEmailFlow || isSuccess>
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></svg>
                <#else>
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4M12 8h.01"/></svg>
                </#if>
            </span>

            <h1>
                <#if isEmailFlow>Vérifiez votre boîte mail<#else>Information</#if>
            </h1>
            <p>
                <#if isPasswordResetSent>Si un compte Pilotis existe pour cet email, un lien de réinitialisation vient d'être envoyé.
                <#else>${summaryText}
                </#if>
            </p>

            <#-- Required actions list, when Keycloak surfaces pending actions on this page -->
            <#if requiredActions??>
                <ul style="list-style:none;padding:0;margin:14px 0 0;text-align:left;width:100%;max-width:22rem;">
                    <#list requiredActions as reqAction>
                        <li style="font-size:13px;color:var(--muted);padding:4px 0;">${msg("requiredAction.${reqAction}")}</li>
                    </#list>
                </ul>
            </#if>

            <div class="pl-state-actions">
                <#if pageRedirectUri??>
                    <a href="${pageRedirectUri}" class="pl-link-quiet" style="align-self:center;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
                        Retour à la connexion
                    </a>
                <#elseif client?? && client.baseUrl?has_content>
                    <a href="${client.baseUrl}" class="pl-link-quiet" style="align-self:center;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
                        Retour à la connexion
                    </a>
                <#else>
                    <a href="${url.loginUrl!''}" class="pl-link-quiet" style="align-self:center;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"/></svg>
                        Retour à la connexion
                    </a>
                </#if>

                <#if actionUri??>
                    <a href="${actionUri}" class="pl-link-quiet" style="align-self:center;">${msg("proceedWithAction")?no_esc}</a>
                <#elseif isPasswordResetSent && realm.resetPasswordAllowed>
                    <a href="${url.loginResetCredentialsUrl}" class="pl-link-quiet" style="align-self:center;">Renvoyer le lien</a>
                </#if>
            </div>
        </div>

    </#if>
</@layout.registrationLayout>
