<#import "template.ftl" as layout>
<@layout.htmlEmailLayout accentColor="#DC2626" category="SÉCURITÉ DU COMPTE">

  <!-- Success banner -->
  <tr>
    <td style="background-color:#F0F9F4;border-left:3px solid #1B6B45;padding:12px 24px;">
      <p style="margin:0;font-size:13px;color:#166534;font-weight:600;font-family:Arial,sans-serif;">✓&nbsp; Authentification à deux facteurs activée</p>
    </td>
  </tr>

  <!-- Main content -->
  <tr>
    <td style="padding:32px 32px 28px;font-family:Arial,Helvetica,sans-serif;">

      <p style="margin:0 0 12px;font-size:22px;font-weight:700;color:#1A1A1A;">Bonjour ${user.firstName!''},</p>
      <p style="margin:0 0 24px;font-size:14px;color:#555555;line-height:1.6;">L'authentification à deux facteurs (2FA) a été activée avec succès sur votre compte Pilotis Capital. Votre compte bénéficie désormais d'une protection renforcée.</p>

      <!-- Info table -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#F5F5F0;border-radius:8px;margin:0 0 20px;overflow:hidden;">
        <tr>
          <td style="padding:12px 16px;border-bottom:1px solid #E8E8E4;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6B7280;font-family:Arial,sans-serif;">Activée le</td>
                <td align="right" style="font-size:13px;font-weight:700;color:#1A1A1A;font-family:Arial,sans-serif;">${event.date!''}</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td style="padding:12px 16px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6B7280;font-family:Arial,sans-serif;">Adresse IP</td>
                <td align="right" style="font-size:13px;font-weight:700;color:#1A1A1A;font-family:Arial,sans-serif;">${event.ipAddress!''}</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

      <!-- Orange warning: backup codes -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 28px;">
        <tr>
          <td style="background-color:#FFFBEB;border-left:3px solid #D97706;border-radius:0 6px 6px 0;padding:12px 16px;">
            <p style="margin:0 0 4px;font-size:13px;color:#92400E;font-weight:700;font-family:Arial,sans-serif;">Conservez vos codes de secours</p>
            <p style="margin:0;font-size:13px;color:#92400E;line-height:1.5;font-family:Arial,sans-serif;">Si vous perdez accès à votre application d'authentification, ces codes vous permettront de récupérer votre compte. Ils ne seront affichés qu'une seule fois.</p>
          </td>
        </tr>
      </table>

      <p style="margin:0 0 24px;font-size:12px;color:#9CA3AF;text-align:center;font-style:italic;font-family:Arial,sans-serif;">Vous n'êtes pas à l'origine de cette activation ?<br/>Contactez immédiatement votre administrateur.</p>

      <p style="margin:0 0 4px;font-size:13px;color:#555555;font-family:Arial,sans-serif;">Cordialement,</p>
      <p style="margin:0;font-size:13px;font-weight:700;color:#1A1A1A;font-family:Arial,sans-serif;">L'équipe Pilotis Capital</p>
    </td>
  </tr>

</@layout.htmlEmailLayout>
