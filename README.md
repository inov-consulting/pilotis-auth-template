# Pilotis — Keycloak UI theme

Custom Keycloak theme for **Pilotis** (login, account and email screens). It
reproduces the "Pilotis Authentification" reference design — a full-bleed
two-column layout (white form column + an indigo brand column with a mini
product preview on wide screens) — and covers every authentication state a
user can land on, not just the happy path.

> Historical note: this theme started life under other names (`esigmap`,
> `WENZE`, a Sénégal public-procurement portal). Traces of that history used to
> leak into the UI (placeholder domains, orange branding, dead message keys).
> The `login/` theme has been consolidated and re-branded for Pilotis; see
> [Known limitations](#known-limitations--follow-ups) for what's still pending
> in `account/`.

## Repository layout

```
.
├── META-INF/keycloak-themes.json   # Declares the "pilotis" theme (login, account, email)
├── login/                          # Login theme (the one covered in depth below)
├── account/                        # Account console theme (legacy, needs a follow-up pass)
├── email/                          # Transactional email templates (FreeMarker + text)
└── .gitlab-ci.yml                  # rsync + docker cp deploy to the qualification VPS
```

Each of `login/`, `account/`, `email/` is a standard Keycloak theme type:

```
login/
├── theme.properties        # parent=base, styles/scripts to load on every page
├── template.ftl            # ⭐ single shared layout (see "Design system" below)
├── login.ftl, login-otp.ftl, login-reset-password.ftl, …   # one file per screen
├── messages/                # messages_fr.properties (primary), _en, _ar
├── components/
│   ├── atoms/                # small building blocks (mostly legacy/unused, see below)
│   └── molecules/            # locale-provider.ftl (language switcher), identity-provider.ftl
└── resources/
    ├── css/                 # esigmap.css (compiled Tailwind bundle, see caveat below), reset-flow.css
    ├── js/                  # esigmap.js (bundled vendor JS), password-toggle.js, reset-flow.js, jquery, alpine
    └── images/              # logo, favicons, TOTP app icons
```

## The login theme, screen by screen

Every screen shares one layout (`login/template.ftl`): a full-bleed grid, a
white form column (logo, centered form, copyright line) on the left, and — on
screens ≥1024px — an indigo/violet brand column with two decorative blurred
blobs and a mini "Pilotis" product preview card (sidebar nav + stat tiles).
On narrow screens the brand column is replaced by a compact gradient banner
above the form. There used to be **three** different, duplicated layouts in
this theme (`template.ftl`, `template_login.ftl`, `reset-flow-layout.ftl`,
plus a completely different Tailwind-based one for secondary pages) — they
are now merged into this single one.

| Screen | File | Notes |
|---|---|---|
| Connexion | `login.ftl` | Username/email + password, remember-me, forgot-password link, invite-only notice when self-registration is off. |
| Compte désactivé / verrouillé | `login.ftl` | Detected from Keycloak's own `accountDisabledMessage` / `accountTemporarilyDisabledMessage`; swaps the form for a dedicated full-panel state instead of a generic error banner. |
| Vérification en deux étapes (OTP) | `login-otp.ftl` | 6 separate digit boxes wired to a single hidden `otp` field, paste support, backspace navigation. Copy is TOTP-specific ("open your authenticator app") rather than claiming an email/SMS code was sent, since Keycloak's TOTP flow doesn't send or resend anything. |
| Mot de passe oublié | `login-reset-password.ftl` | Email form, pre-fills the last attempted username on validation error. |
| E-mail envoyé / confirmations diverses | `info.ftl` | Keycloak reuses this single template for very different notices (reset email sent, email already verified, generic info…) — the content adapts its icon/title/CTA based on the actual message instead of always claiming "check your mailbox". |
| Nouveau mot de passe | `login-update-password.ftl` | Used both for self-service reset and for the first sign-in after an admin invitation. |
| Activation de compte / invitation | `login-update-profile.ftl` | Shown right after an invited user opens their link. Displays an identity card (avatar initials, name, email) built from the real `user` data before the editable fields — Keycloak doesn't combine "update profile" and "set password" into a single request, so the password step still happens on the next screen (`login-update-password.ftl`). |
| Lien expiré | `login-page-expired.ftl` **(new)** | Previously missing — Keycloak was silently falling back to the parent theme's default page for every expired reset/invitation link. |
| Erreur générique / lien invalide ou déjà utilisé | `error.ftl` | Keycloak funnels "invalid token", "already used" and other one-off errors through this page; it now gets the same icon/title/CTA treatment as the rest of the theme instead of a bare, unstyled alert. |
| Vérification d'adresse e-mail | `login-verify-email.ftl` | |
| Configuration TOTP | `login-config-totp.ftl` | **Fixed a real bug**: the 6 digit boxes were never wired to the hidden `totp` field, so submitting TOTP setup always failed. |
| Confirmation de liaison IdP | `login-idp-link-confirm.ftl` | |
| Consentement OAuth | `login-oauth-grant.ftl` | |
| Kerberos non configuré | `bypass_kerberos.ftl` | |
| Inscription / CGU | `register.ftl`, `terms.ftl` | Only reachable if the realm has self-registration enabled; re-skinned from a leftover orange "supplier registration" look to the Pilotis brand. |

Keycloak doesn't natively distinguish *why* an invitation/reset link is
unusable (expired vs. already used vs. revoked all funnel through
`login-page-expired.ftl` or the generic `error.ftl`, using whatever message
Keycloak itself provides) — so those specific sub-states from the reference
design aren't separately routable pages here without custom backend logic
(a token/event listener). The pages that **do** exist are styled to match.

### Design system (`login/template.ftl`)

All the CSS lives in one `<style>` block inside `template.ftl`:
- **Colors** are defined as CSS custom properties using `oklch()` (matching
  the reference design 1:1 — e.g. `--brand: oklch(0.4 0.17 275)`), not hex.
  This requires a browser with `oklch()` support (Chrome 111+, Safari 15.4+,
  Firefox 113+ — i.e. anything from 2023 onward); there is no hex fallback.
- **Typography** is "Inter Tight", loaded from Google Fonts
  (`fonts.googleapis.com`) with a `system-ui` fallback. **This means the
  login page needs outbound internet access to render the intended font** —
  in a fully air-gapped deployment it will silently fall back to the
  system font instead of failing, but if pixel-exact typography matters
  there, self-host the font files and swap the `<link>` tags in
  `template.ftl` for a local `@font-face`.
- **Component classes** (`pl-*`, chosen to avoid clashing with Keycloak's own
  `kc-*`/`pf-*` classes): `.pl-h1` / `.pl-sub` / `.pl-desc` for typography,
  `.pl-field` / `.pl-label` / `.pl-input` / `.pl-input-wrap` for form fields,
  `.pl-btn` / `.pl-btn-outline` for buttons, `.pl-notice` for inline banners,
  `.pl-state` / `.pl-state-icon` / `.pl-state-actions` for full-panel states
  (disabled account, expired link…), `.pl-identity-card` for the invitation
  screen's user summary. Every page composes its content from these classes
  instead of hand-rolling inline styles per page.

**Why not Tailwind for new markup?** `esigmap.css` is a pre-compiled,
tree-shaken Tailwind bundle checked into the repo — there is no build step in
CI (see `.gitlab-ci.yml`) to regenerate it. Any Tailwind utility class that
isn't already present in that compiled file (including arbitrary-value
classes like `hover:text-[#0c1b33]`) silently renders with **no effect**.
That's why every login screen uses the `pl-*` classes / inline styles instead
of Tailwind classes — it removes the dependency on a build step that doesn't
exist yet. If you introduce a real Tailwind build pipeline later, this
constraint goes away.

### Internationalization

`login/messages/` ships `fr` (primary/default), `en` and `ar` properties
files, and the language switcher (`components/molecules/locale-provider.ftl`)
is wired up. That said, most of the copy on each screen is **hardcoded in
French directly in the `.ftl` files**, matching how this theme was already
written before this pass — only the handful of strings already wrapped in
`${msg(...)}` (buttons, field labels, a few titles) actually change with the
locale. Fully internationalizing every screen would mean rewriting each page
to source every string from `messages_*.properties`; that's a deliberate,
larger follow-up rather than something folded silently into this pass.

## Local preview

The fastest way to see changes without touching a shared environment is to
mount this repo into a throwaway Keycloak container.

**PowerShell (recommended on Windows):**

```powershell
docker run --rm -p 8080:8080 `
  -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin `
  -v "${PWD}:/opt/keycloak/themes/pilotis" `
  quay.io/keycloak/keycloak:latest start-dev
```

**macOS / Linux / WSL:**

```bash
docker run --rm -p 8080:8080 \
  -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin \
  -v "$(pwd):/opt/keycloak/themes/pilotis" \
  quay.io/keycloak/keycloak:latest start-dev
```

**Git Bash on Windows:** the command above looks identical but usually
**silently fails** there. Git Bash's MSYS layer rewrites any argument that
looks like a Unix path before handing it to a native `.exe` like
`docker.exe` — so the container-side path `/opt/keycloak/themes/pilotis`
gets mangled into something like `C:\Program Files\Git\opt\keycloak\...`,
the bind mount lands nowhere Keycloak looks, and it silently falls back to
its own bundled default theme. No error is printed; the login page just
never picks up this theme. Either run the PowerShell version above instead,
or keep using Git Bash but disable the path rewriting for that one command:

```bash
MSYS_NO_PATHCONV=1 docker run --rm -p 8080:8080 \
  -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin \
  -v "$(pwd):/opt/keycloak/themes/pilotis" \
  quay.io/keycloak/keycloak:latest start-dev
```

You can sanity-check the mount actually landed where expected with
`docker inspect <container> --format '{{json .Mounts}}'` — `Destination`
should read exactly `/opt/keycloak/themes/pilotis`.

Then, in the admin console (`http://localhost:8080`): **Realm settings →
Themes**, set Login theme (and Account / Email theme if needed) to `pilotis`,
save, and open the realm's login page in a private window. Keycloak caches
compiled templates — restart the container (or disable theme caching in
`start-dev`, which is the default) after editing `.ftl` files.

To exercise the different states described above without a full mail server:
- **Disabled account**: disable a test user from the admin console, then try
  to log in as them.
- **OTP**: enable "Configure OTP" as a required action for a test user.
- **Forgot password / reset**: enable "Forgot password" on the realm; a
  console/dev mail server (e.g. MailHog, or Keycloak's `start-dev` which logs
  emails) lets you grab the reset link without a real SMTP setup.
- **Invitation**: create a user from the admin console with "Update Password"
  + "Update Profile" required actions and no password set, then use "Send
  email" or "Impersonate"/copy the generated action link.
- **Expired / already used link**: same as above, but wait for the link's
  configured lifespan to elapse, or open it twice.

## Deployment

`.gitlab-ci.yml` deploys on every push to `main`: it `rsync`s the repository
to `$THEME_PATH` on the qualification VPS, then `docker cp`s it into the
running Keycloak container's `themes/` directory. `$THEME_PATH` currently
points at a folder named `wenze_keycloak_ui` — that's a leftover from the
theme's previous name; it does **not** need to match the `name` declared in
`META-INF/keycloak-themes.json` (`pilotis`) for Keycloak's folder-based theme
provider, but keeping infrastructure paths and theme names aligned is good
hygiene. Rename it during a planned maintenance window (it means clearing the
target directory and re-running the pipeline), not silently.

## Known limitations / follow-ups

- **`account/` theme**: still uses the old `esigmap.css`/`esigmap.js` bundle
  and hasn't been re-skinned to match the new login screens. It is now at
  least *declared* in `META-INF/keycloak-themes.json` (it was missing from
  the `types` list before, so it could never be selected from the admin
  console) but its actual pages still need the same design pass `login/` just
  got.
- **`resources/js/reset-flow.js` and `resources/css/reset-flow.css`**: mostly
  superseded by the inline `<script>`/`<style>` blocks in the individual
  `.ftl` files (which is where the real, working logic lives). They're kept
  because `theme.properties` still loads them and nothing has verified they
  are fully safe to delete; they no longer drive any visible behaviour.
- **`esigmap.js`**: a large pre-bundled vendor script of unclear origin,
  loaded on every page. It wasn't touched — treat it as a black box until
  someone confirms what actually depends on it.
- **Right-column copy**: "Le pilotage réglementaire, sans zone d'ombre." and
  the CEMAC/COSUMAF description come straight from the reference design.
  Swap them in `template.ftl` (`.pl-right-copy`) if the product's real
  positioning differs.
- **Google Fonts dependency**: see the font note under
  [Design system](#design-system-logintemplateftl) above.
- **i18n coverage**: see [Internationalization](#internationalization) above.
#   p i l o t i s - a u t h - t e m p l a c e  
 