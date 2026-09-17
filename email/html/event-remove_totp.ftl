<#import "template.ftl" as layout>
<@layout.htmlEmailLayout accentColor="#D97706" category="SÉCURITÉ DU COMPTE">

  <!-- Warning banner -->
  <tr>
    <td style="background-color:#FFFBEB;border-left:3px solid #D97706;padding:12px 24px;">
      <p style="margin:0;font-size:13px;color:#92400E;font-weight:600;font-family:Arial,sans-serif;">⚠&nbsp; [ATTENTION] Niveau de sécurité réduit — 2FA désactivée</p>
    </td>
  </tr>

  <!-- Main content -->
  <tr>
    <td style="padding:32px 32px 28px;font-family:Arial,Helvetica,sans-serif;">

      <p style="margin:0 0 12px;font-size:22px;font-weight:700;color:#1A1A1A;">Bonjour ${user.firstName!''},</p>
      <p style="margin:0 0 24px;font-size:14px;color:#555555;line-height:1.6;">L'authentification à deux facteurs a été désactivée sur votre compte Pilotis Capital. Votre compte est désormais protégé uniquement par votre mot de passe.</p>

      <!-- Info table -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#F5F5F0;border-radius:8px;margin:0 0 20px;overflow:hidden;">
        <tr>
          <td style="padding:12px 16px;border-bottom:1px solid #E8E8E4;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6B7280;font-family:Arial,sans-serif;">Désactivée le</td>
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

      <!-- Orange info box -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 28px;">
        <tr>
          <td style="background-color:#FFFBEB;border-left:3px solid #D97706;border-radius:0 6px 6px 0;padding:12px 16px;">
            <p style="margin:0;font-size:13px;color:#92400E;line-height:1.5;font-family:Arial,sans-serif;">Sans la double authentification, votre compte est plus vulnérable aux accès non autorisés. Nous vous recommandons de la réactiver dès que possible.</p>
          </td>
        </tr>
      </table>

      <p style="margin:0 0 4px;font-size:13px;color:#555555;font-family:Arial,sans-serif;">Cordialement,</p>
      <p style="margin:0;font-size:13px;font-weight:700;color:#1A1A1A;font-family:Arial,sans-serif;">L'équipe Pilotis Capital</p>
    </td>
  </tr>

</@layout.htmlEmailLayout>
