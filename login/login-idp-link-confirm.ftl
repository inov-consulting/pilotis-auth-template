<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <#if section = "title">
    ${msg("confirmLinkIdpTitle")}

  <#elseif section = "form">

    <h1 class="pl-h1" style="margin-bottom:20px;text-align:center;">${msg("ipsLinkTitle")}</h1>

    <form action="${url.loginAction}" method="post" style="display:flex;flex-direction:column;gap:12px;">
      <button type="submit" name="submitAction" id="linkAccount" value="linkAccount" class="pl-btn"
              style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:0;border-radius:12px;background:#4338ca;color:#fff;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
              onmouseover="this.style.background='#372aa8'" onmouseout="this.style.background='#4338ca'">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13.19 8.688a4.5 4.5 0 011.242 7.244l-4.5 4.5a4.5 4.5 0 01-6.364-6.364l1.757-1.757m13.35-.622l1.757-1.757a4.5 4.5 0 00-6.364-6.364l-4.5 4.5a4.5 4.5 0 001.242 7.244"/></svg>
        ${msg("confirmLinkIdpContinue", idpDisplayName)}
      </button>

      <p style="text-align:center;font-size:12px;color:var(--muted);margin:0;">${msg("or")}</p>

      <button type="submit" name="submitAction" id="updateProfile" value="updateProfile" class="pl-btn pl-btn-outline"
              style="display:flex;align-items:center;justify-content:center;gap:8px;height:44px;width:100%;border:1px solid #e3e5ec;border-radius:12px;background:#fff;color:inherit;font:inherit;font-size:0.9rem;font-weight:500;cursor:pointer;transition:background 0.15s;"
              onmouseover="this.style.background='#f7f7fa'" onmouseout="this.style.background='#fff'">
        ${msg("confirmLinkIdpReviewProfile")}
      </button>
    </form>
  </#if>
</@layout.registrationLayout>
