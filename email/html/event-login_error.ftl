<#import "template.ftl" as layout>
<@layout.htmlEmailLayout accentColor="#dc2626" category="SÉCURITÉ DU COMPTE">

  <!-- Alert banner -->
  <tr>
    <td style="background-color:#fef2f2;border-left:3px solid #dc2626;padding:12px 24px;">
      <p style="margin:0;font-size:13px;color:#dc2626;font-weight:600;font-family:Arial,sans-serif;">✕&nbsp; [ALERTE] Activité suspecte détectée sur votre compte</p>
    </td>
  </tr>

  <!-- Main content -->
  <tr>
    <td style="padding:32px 28px 28px;font-family:Arial,Helvetica,sans-serif;">

      <p style="margin:0 0 12px;font-size:22px;font-weight:700;color:#111827;">Bonjour ${user.firstName!''},</p>
      <p style="margin:0 0 24px;font-size:14px;color:#555555;line-height:1.6;">Nous avons détecté plusieurs tentatives de connexion échouées sur votre compte Pilotis Capital. Si vous êtes à l'origine de ces tentatives, vous pouvez ignorer cet email.</p>

      <!-- Info table -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#f8fafc;border-radius:8px;margin:0 0 20px;overflow:hidden;border:1px solid #e2e8f0;">
        <tr>
          <td style="padding:12px 16px;border-bottom:1px solid #e2e8f0;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6b7280;font-family:Arial,sans-serif;">Dernière tentative</td>
                <td align="right" style="font-size:13px;font-weight:700;color:#1a1a1a;font-family:Arial,sans-serif;">${event.date!''}</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td style="padding:12px 16px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6b7280;font-family:Arial,sans-serif;">Adresse IP</td>
                <td align="right" style="font-size:13px;font-weight:700;color:#1a1a1a;font-family:Arial,sans-serif;">${event.ipAddress!''}</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

      <!-- Red warning box -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 28px;">
        <tr>
          <td style="background-color:#fef2f2;border-left:3px solid #dc2626;border-radius:0 8px 8px 0;padding:12px 16px;">
            <p style="margin:0;font-size:13px;color:#dc2626;line-height:1.5;font-family:Arial,sans-serif;">Si vous ne reconnaissez pas cette activité, votre compte est peut-être ciblé. <strong>Modifiez votre mot de passe immédiatement.</strong></p>
          </td>
        </tr>
      </table>

      <p style="margin:0 0 24px;font-size:12px;color:#9ca3af;text-align:center;font-style:italic;font-family:Arial,sans-serif;">Si vous pensez que votre compte a été compromis, contactez immédiatement votre administrateur Pilotis Capital.</p>

      <p style="margin:0 0 4px;font-size:13px;color:#555555;font-family:Arial,sans-serif;">Cordialement,</p>
      <p style="margin:0;font-size:13px;font-weight:700;color:#1a1a1a;font-family:Arial,sans-serif;">L'équipe Pilotis Capital</p>
    </td>
  </tr>

</@layout.htmlEmailLayout>
