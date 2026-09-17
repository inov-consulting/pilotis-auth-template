<#import "components/molecules/locale-provider.ftl" as localeProvider>
<#--
  Canonical layout for every Keycloak login-flow screen (connexion, 2FA,
  mot de passe oublié, réinitialisation, invitation, erreurs, liens expirés…).

  This reproduces the "Pilotis Authentification" reference design: a
  full-bleed two-column layout (white form column + indigo brand column
  with a mini product preview on wide screens, collapsing to a single
  column with a gradient banner on top for narrow screens) — not a
  floating card.

  Nested sections a page can provide:
    - "title" : plain text used in <title> (falls back to realm name only)
    - "form"  : the actual page content (heading, alerts, form, footer links…)
    - "info"  : optional secondary content rendered below "form" — only
                shown when the page passes displayInfo=true.

  A page is responsible for its own heading/description/alerts inside
  "form" — see login.ftl for the reference implementation.
-->
<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
<!DOCTYPE html>

<#-- Attempt to reverse-engineer the current language code, Keycloak does not expose it directly -->
<#assign LANG_CODE = "fr">
<#if .locale??>
    <#assign LANG_CODE = .locale>
</#if>
<#if locale??>
    <#list locale.supported>
        <#items as supportedLocale>
            <#if supportedLocale.label == locale.current>
                <#if supportedLocale.url?contains("?kc_locale=")>
                    <#assign LANG_CODE = supportedLocale.url?keep_after("?kc_locale=")[0..1]>
                </#if>
                <#if supportedLocale.url?contains("&kc_locale=")>
                    <#assign LANG_CODE = supportedLocale.url?keep_after("&kc_locale=")[0..1]>
                </#if>
            </#if>
        </#items>
    </#list>
</#if>

<html class="${properties.kcHtmlClass!}" lang="${LANG_CODE}" dir="<#if LANG_CODE == 'ar'>rtl<#else>ltr</#if>">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}" />
        </#list>
    </#if>

    <title><#nested "title"> - ${realm.displayName!'Pilotis'}</title>

    <link rel="shortcut icon" href="${url.resourcesPath}/images/favicon.ico" type="image/x-icon" />
    <link rel="apple-touch-icon-precomposed" sizes="152x152" href="${url.resourcesPath}/images/logotype/apple-touch-icon-ipad-retina-152x152.png">
    <link rel="apple-touch-icon-precomposed" sizes="60x60" href="${url.resourcesPath}/images/logotype/apple-touch-icon-iphone-60x60.png">
    <link rel="apple-touch-icon-precomposed" sizes="120x120" href="${url.resourcesPath}/images/logotype/apple-touch-icon-iphone-retina-120x120.png">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter+Tight:wght@400;500;600;700&display=swap" rel="stylesheet">

    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>

    <style>
      :root {
        /* Plain hex/rgba everywhere (not oklch()) so colors — especially button
           backgrounds — render identically on every browser, with no risk of a
           silently-ignored custom property on older engines. */
        --brand: #4338ca;
        --brand-hover: #372aa8;
        --brand-dark: #211c4d;
        --blob-1: #a855f7;
        --blob-2: #38bdf8;
        --ink: #1f2333;
        --ink-soft: rgba(31, 35, 51, 0.8);
        --muted: #666e80;
        --muted-2: #9aa1b0;
        --border: #e3e5ec;
        --surface-soft: #f7f7fa;
        --chip-bg: #e7e8f0;
        --chip-ink: #4b5165;
        --danger: #dc2626;
        --danger-bg: rgba(220, 38, 38, 0.1);
        --success: #15803d;
        --success-bg: rgba(21, 128, 61, 0.1);
        --stat-green: #16a34a;
      }

      *, *::before, *::after { box-sizing: border-box; }
      html, body { margin: 0; padding: 0; min-height: 100%; }
      body {
        font-family: 'Inter Tight', system-ui, -apple-system, 'Segoe UI', sans-serif;
        -webkit-font-smoothing: antialiased;
        color: var(--ink);
      }
      a { color: var(--brand); }
      a:hover { color: var(--brand-hover); }
      input::placeholder { color: var(--muted-2); }
      input:focus-visible {
        outline: 2px solid rgba(67, 56, 202, 0.35);
        outline-offset: 1px;
        border-color: rgba(67, 56, 202, 0.6) !important;
      }

      .pl-shell { display: grid; grid-template-columns: 1fr; min-height: 100dvh; background: #fff; color: var(--ink); font-size: 14px; }
      .pl-form-col { display: flex; flex-direction: column; overflow-y: auto; }

      /* Narrow-screen brand banner, replaced by the right column on wide screens */
      .pl-mobile-banner {
        position: relative;
        overflow: hidden;
        background: linear-gradient(165deg, var(--brand-dark), var(--brand));
        padding: 40px 24px;
        color: #fff;
      }
      .pl-mobile-banner::before {
        content: ""; position: absolute; inset: 0; opacity: 0.1; pointer-events: none;
        background-image: radial-gradient(circle at 1px 1px, white 1px, transparent 0);
        background-size: 20px 20px;
      }
      .pl-mobile-banner p { position: relative; margin: 0; font-size: 1.35rem; line-height: 1.15; font-weight: 600; }

      .pl-form-area { display: flex; flex: 1; flex-direction: column; padding: 32px 24px; }
      .pl-topbar { display: flex; justify-content: flex-end; margin-bottom: 4px; }
      .pl-form-center { margin: 0 auto; display: flex; width: 100%; max-width: 384px; flex: 1; flex-direction: column; align-items: center; justify-content: center; }
      .pl-logo { height: 44px; width: auto; }
      .pl-form-slot { margin-top: 44px; width: 100%; }
      .pl-copyright { padding-top: 40px; text-align: center; font-size: 12px; color: var(--muted); }

      /* Right column — brand / product preview, desktop only */
      .pl-right-col { display: none; }
      @media (min-width: 1024px) {
        .pl-mobile-banner { display: none; }
        .pl-shell { grid-template-columns: 1fr 1fr; }
        .pl-right-col {
          display: block; position: relative; overflow: hidden;
          background: linear-gradient(165deg, var(--brand-dark), var(--brand)); color: #fff;
        }
      }
      .pl-blob { position: absolute; border-radius: 999px; filter: blur(64px); pointer-events: none; }
      .pl-blob-1 { top: -128px; right: -96px; width: 26rem; height: 26rem; opacity: 0.4; background: var(--blob-1); }
      .pl-blob-2 { top: 160px; left: -112px; width: 20rem; height: 20rem; opacity: 0.3; background: var(--blob-2); }
      .pl-dots { position: absolute; inset: 0; opacity: 0.1; pointer-events: none; background-image: radial-gradient(circle at 1px 1px, white 1px, transparent 0); background-size: 28px 28px; }
      .pl-right-copy { position: relative; max-width: 32rem; padding: 64px 48px 0; }
      .pl-right-copy h2 { margin: 0; font-size: clamp(1.7rem, 2.4vw, 2.1rem); line-height: 1.15; font-weight: 600; }
      .pl-right-copy h2 .pl-nowrap { white-space: nowrap; }
      .pl-right-copy p { margin: 16px 0 0; font-size: 15px; line-height: 1.6; color: rgba(255,255,255,0.75); }

      .pl-preview {
        position: absolute; top: 52%; right: -3rem; bottom: -3rem; left: 56px;
        display: flex; overflow: hidden; border-top-left-radius: 16px;
        border: 1px solid rgba(227, 229, 236, 0.6); background: #fff; color: var(--ink);
        box-shadow: 0 25px 50px -12px rgba(0,0,0,0.35);
      }
      .pl-preview-nav { display: flex; width: 192px; flex-shrink: 0; flex-direction: column; gap: 4px; border-right: 1px solid var(--border); background: rgba(247, 247, 250, 0.6); padding: 16px; }
      .pl-preview-nav p.brand { margin: 0 0 12px; padding: 0 8px; font-size: 15px; font-weight: 700; letter-spacing: -0.02em; color: var(--brand); }
      .pl-preview-nav-item { display: flex; align-items: center; gap: 10px; border-radius: 6px; padding: 8px 10px; font-size: 12.5px; font-weight: 500; color: var(--muted); }
      .pl-preview-nav-item.active { background: rgba(67, 56, 202, 0.1); color: var(--brand); }
      .pl-preview-nav-item svg { width: 16px; height: 16px; flex-shrink: 0; }
      .pl-preview-body { flex: 1; padding: 28px; }
      .pl-preview-body > p.title { margin: 0; font-size: 18px; font-weight: 600; }
      .pl-preview-body > p.sub { margin: 4px 0 0; max-width: 20rem; font-size: 12.5px; color: var(--muted); }
      .pl-preview-stats { margin-top: 20px; display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
      .pl-preview-stat { border: 1px solid var(--border); border-radius: 12px; padding: 16px; }
      .pl-preview-stat p.value { margin: 0; font-size: 24px; font-weight: 700; }
      .pl-preview-stat p.label { margin: 2px 0 0; font-size: 12px; color: var(--muted); }

      /* ── Shared form building blocks, used across every login screen ── */
      .pl-eyebrow { font-size: 11px; font-weight: 600; color: var(--brand); letter-spacing: 0.08em; text-transform: uppercase; margin: 0 0 8px; }
      .pl-h1 { margin: 0; font-size: 1.6rem; line-height: 1.15; font-weight: 600; letter-spacing: -0.02em; }
      .pl-sub { margin: 8px auto 0; max-width: 24rem; font-size: 13.5px; line-height: 1.6; color: var(--muted); }
      .pl-desc { font-size: 13.5px; line-height: 1.6; color: var(--muted); }

      .pl-field { display: flex; flex-direction: column; gap: 6px; }
      .pl-label { font-size: 12.5px; font-weight: 500; color: var(--ink-soft); }
      .pl-input-wrap { position: relative; display: flex; align-items: center; }
      .pl-input-icon { position: absolute; left: 12px; width: 16px; height: 16px; color: var(--muted); pointer-events: none; display: flex; }
      .pl-input {
        height: 44px; width: 100%; box-sizing: border-box; border-radius: 12px;
        border: 1px solid var(--border); background: #fff; padding: 0 12px; font: inherit; font-size: 14px; color: inherit;
      }
      .pl-input.has-icon-left { padding-left: 40px; }
      .pl-input.has-icon-right { padding-right: 40px; }
      .pl-input[data-error="true"] { border-color: var(--danger); }
      .pl-error-text { font-size: 11px; color: var(--danger); }
      .pl-input-toggle {
        position: absolute; right: 4px; display: flex; border: 0; background: none; border-radius: 6px;
        padding: 8px; color: var(--muted); cursor: pointer;
      }
      .pl-input-toggle:hover { background: var(--surface-soft); }

      .pl-checkbox-row { display: flex; width: fit-content; cursor: pointer; align-items: center; gap: 8px; padding: 4px 0; }
      .pl-checkbox-row input { width: 16px; height: 16px; accent-color: var(--brand); }
      .pl-checkbox-row span { font-size: 12.5px; color: var(--muted); }

      .pl-btn {
        display: flex; align-items: center; justify-content: center; gap: 8px;
        height: 44px; width: 100%; border: 0; border-radius: 12px;
        background: var(--brand); color: #fff; font: inherit; font-size: 0.9rem; font-weight: 500;
        cursor: pointer; text-decoration: none; transition: background 0.15s;
      }
      .pl-btn:hover { background: var(--brand-hover); }
      .pl-btn:disabled { opacity: 0.6; cursor: not-allowed; }
      .pl-btn svg { width: 16px; height: 16px; flex-shrink: 0; }
      .pl-btn-outline { background: #fff; border: 1px solid var(--border); color: inherit; }
      .pl-btn-outline:hover { background: var(--surface-soft); }

      .pl-link-quiet {
        display: inline-flex; cursor: pointer; width: fit-content; align-items: center; gap: 6px;
        font-size: 12.5px; font-weight: 500; color: var(--muted); text-decoration: none;
      }
      .pl-link-quiet:hover { color: var(--ink); }
      .pl-link-quiet svg { width: 13px; height: 13px; }

      .pl-notice { display: flex; align-items: center; gap: 10px; border-radius: 12px; padding: 12px 14px; font-size: 12.5px; font-weight: 500; }
      .pl-notice svg { width: 16px; height: 16px; flex-shrink: 0; }
      .pl-notice.neutral { background: var(--surface-soft); color: var(--muted); font-weight: 400; }
      .pl-notice.success { background: var(--success-bg); color: var(--success); }
      .pl-notice.danger { background: var(--danger-bg); color: var(--danger); }

      /* Full-panel "state" screens: disabled account, expired link, revoked invitation… */
      .pl-state { display: flex; flex-direction: column; align-items: center; text-align: center; }
      .pl-state-icon { margin-bottom: 20px; display: flex; width: 48px; height: 48px; align-items: center; justify-content: center; border-radius: 999px; flex-shrink: 0; }
      .pl-state-icon svg { width: 22px; height: 22px; }
      .pl-state-icon.danger { background: var(--danger-bg); color: var(--danger); }
      .pl-state-icon.success { background: var(--success-bg); color: var(--success); }
      .pl-state-icon.neutral { background: var(--surface-soft); color: var(--muted); }
      .pl-state h1 { margin: 0; font-size: 1.35rem; font-weight: 600; letter-spacing: -0.02em; }
      .pl-state p { margin: 8px 0 0; max-width: 22rem; font-size: 13.5px; line-height: 1.6; color: var(--muted); }
      .pl-state-actions { margin-top: 24px; width: 100%; display: flex; flex-direction: column; gap: 10px; }

      .pl-identity-card { display: flex; align-items: center; gap: 12px; border-radius: 12px; background: var(--surface-soft); padding: 14px; }
      .pl-identity-avatar { display: flex; width: 40px; height: 40px; flex-shrink: 0; align-items: center; justify-content: center; border-radius: 999px; background: #fff; box-shadow: 0 0 0 1px rgba(0,0,0,0.05); font-size: 14px; font-weight: 600; color: var(--brand); }
      .pl-identity-info { min-width: 0; flex: 1; }
      .pl-identity-info p { margin: 0; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
      .pl-identity-info p.name { font-size: 14px; font-weight: 600; }
      .pl-identity-info p.email { margin-top: 2px; font-size: 12.5px; color: var(--muted); }
      .pl-identity-chip { flex-shrink: 0; border-radius: 999px; background: var(--chip-bg); padding: 4px 10px; font-size: 11.5px; color: var(--chip-ink); }

      .pl-spinner { animation: pl-spin 0.8s linear infinite; }
      @keyframes pl-spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
    </style>
</head>
<body class="${bodyClass}">
  <div class="pl-shell">
    <div class="pl-form-col">

      <div class="pl-mobile-banner">
        <p>Le pilotage réglementaire, sans zone d'ombre.</p>
      </div>

      <div class="pl-form-area">
        <#if realm.internationalizationEnabled && locale?? && locale.supported?size gt 1>
          <div class="pl-topbar">
            <@localeProvider.kw currentLocale=locale.current locales=locale.supported />
          </div>
        </#if>

        <div class="pl-form-center">
          <img class="pl-logo" src="${url.resourcesPath}/images/reporting/logo-pilotis.svg" alt="Pilotis" />

          <div class="pl-form-slot">
            <#nested "form">
            <#if displayInfo>
              <div id="kc-info" style="margin-top:20px;">
                <#nested "info">
              </div>
            </#if>
          </div>
        </div>

        <p class="pl-copyright">© ${.now?string("yyyy")} Pilotis. Tous droits réservés.</p>
      </div>
    </div>

    <div class="pl-right-col">
      <div class="pl-blob pl-blob-1"></div>
      <div class="pl-blob pl-blob-2"></div>
      <div class="pl-dots"></div>

      <div class="pl-right-copy">
        <h2><span class="pl-nowrap">Le pilotage réglementaire,</span><br>sans zone d'ombre.</h2>
        <p>Chaque obligation de marché financier CEMAC/COSUMAF est suivie, tracée et rattachée à un responsable, du texte source jusqu'à sa validation.</p>
      </div>

      <div class="pl-preview">
        <div class="pl-preview-nav">
          <p class="brand">Pilotis</p>
          <div class="pl-preview-nav-item active">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m3 17 2 2 4-4"/><path d="m3 7 2 2 4-4"/><path d="M13 6h8M13 12h8M13 18h8"/></svg>
            Pile de validation
          </div>
          <div class="pl-preview-nav-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"/><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4z"/></svg>
            Saisies
          </div>
          <div class="pl-preview-nav-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"><path d="m6 14 1.5-2.9A2 2 0 0 1 9.24 10H20a2 2 0 0 1 1.94 2.5l-1.55 6a2 2 0 0 1-1.94 1.5H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h3.9a2 2 0 0 1 1.69.9l.81 1.2a2 2 0 0 0 1.67.9H18a2 2 0 0 1 2 2v2"/></svg>
            Dossiers assignés
          </div>
          <div class="pl-preview-nav-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7z"/><path d="M14 2v5h5"/><path d="M12 11v6M9 14h6"/></svg>
            Nouveau dossier
          </div>
          <div class="pl-preview-nav-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7z"/><path d="M14 2v5h5"/><path d="M9 13h6M9 17h4"/></svg>
            Contestations
          </div>
          <div class="pl-preview-nav-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M19 8v6M22 11h-6"/></svg>
            Demandes de consultation
          </div>
        </div>
        <div class="pl-preview-body">
          <p class="title">Pile de validation</p>
          <p class="sub">Les saisies transmises par les collaborateurs, avec l'appréciation de l'agent IA.</p>
          <div class="pl-preview-stats">
            <div class="pl-preview-stat">
              <p class="value">216</p>
              <p class="label">Obligations suivies</p>
            </div>
            <div class="pl-preview-stat">
              <p class="value" style="color:var(--stat-green);">7</p>
              <p class="label">Lignes d'activité</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
</#macro>
