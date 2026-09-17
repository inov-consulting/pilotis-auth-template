<#import "template.ftl" as layout>
<@layout.htmlEmailLayout accentColor="#0c1b33" category="SÉCURITÉ DU COMPTE">

  <!-- Main content -->
  <tr>
    <td style="padding:32px 28px 28px;font-family:Arial,Helvetica,sans-serif;">

      <p style="margin:0 0 12px;font-size:22px;font-weight:700;color:#111827;">Bonjour ${user.firstName!''},</p>
      <p style="margin:0 0 24px;font-size:14px;color:#555555;line-height:1.6;">Nous avons reçu une demande de réinitialisation du mot de passe de votre compte Pilotis Capital. Cliquez sur le bouton ci-dessous pour choisir un nouveau mot de passe.</p>

      <!-- Action button -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 16px;">
        <tr>
          <td align="center">
            <a href="${link}" style="display:inline-block;background-color:#0c1b33;color:#ffffff;text-decoration:none;font-size:14px;font-weight:700;padding:13px 32px;border-radius:9px;font-family:Arial,sans-serif;">Réinitialiser mon mot de passe</a>
          </td>
        </tr>
      </table>

      <!-- Expiry warning -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 20px;">
        <tr>
          <td style="background-color:#fffbeb;border:1px solid #fde68a;border-radius:8px;padding:12px 16px;">
            <p style="margin:0;font-size:13px;color:#92400e;line-height:1.5;font-family:Arial,sans-serif;">⚠&nbsp; Ce lien est valable ${linkExpirationFormatter(linkExpiration)!'1 heure'}. Passé ce délai, vous devrez effectuer une nouvelle demande.</p>
          </td>
        </tr>
      </table>

      <!-- Request details -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#f8fafc;border-radius:8px;margin:0 0 20px;overflow:hidden;">
        <tr>
          <td style="padding:12px 16px;border-bottom:1px solid #e2e8f0;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6b7280;font-family:Arial,sans-serif;">Demandé le</td>
                <td align="right" style="font-size:13px;font-weight:700;color:#1a1a1a;font-family:Arial,sans-serif;">${.now?string["dd MMMM yyyy 'à' HH'h'mm"]}</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td style="padding:12px 16px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6b7280;font-family:Arial,sans-serif;">Compte</td>
                <td align="right" style="font-size:13px;font-weight:700;color:#1a1a1a;font-family:Arial,sans-serif;">${user.email!''}</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

      <p style="margin:0 0 24px;font-size:12px;color:#9ca3af;text-align:center;font-style:italic;font-family:Arial,sans-serif;">Vous n'êtes pas à l'origine de cette demande ?<br/>Ignorez cet email. Votre mot de passe actuel reste inchangé.</p>

      <p style="margin:0 0 4px;font-size:13px;color:#555555;font-family:Arial,sans-serif;">Cordialement,</p>
      <p style="margin:0;font-size:13px;font-weight:700;color:#1a1a1a;font-family:Arial,sans-serif;">L'équipe Pilotis Capital</p>
    </td>
  </tr>

</@layout.htmlEmailLayout>
