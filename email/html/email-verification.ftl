<#import "template.ftl" as layout>
<@layout.htmlEmailLayout accentColor="#0c1b33" category="VÉRIFICATION DU COMPTE">

  <!-- Main content -->
  <tr>
    <td style="padding:32px 28px 28px;font-family:Arial,Helvetica,sans-serif;">

      <p style="margin:0 0 12px;font-size:22px;font-weight:700;color:#111827;">Bonjour ${user.firstName!''},</p>
      <p style="margin:0 0 24px;font-size:14px;color:#555555;line-height:1.6;">Pour finaliser votre inscription sur Pilotis Capital, nous devons vérifier que cette adresse email vous appartient.</p>

      <!-- Verification code box -->
      <#if code??>
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 20px;">
        <tr>
          <td style="background-color:#f8fafc;border-radius:10px;padding:24px;text-align:center;border:1px solid #e2e8f0;">
            <p style="margin:0 0 10px;font-size:10px;color:#9ca3af;text-transform:uppercase;letter-spacing:0.12em;font-family:Arial,sans-serif;">CODE DE VÉRIFICATION</p>
            <p style="margin:0;font-size:38px;font-weight:700;color:#0c1b33;letter-spacing:0.3em;font-family:'Courier New',Courier,monospace;">${code}</p>
          </td>
        </tr>
      </table>
      </#if>

      <!-- Action button -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 16px;">
        <tr>
          <td align="center">
            <a href="${link}" style="display:inline-block;background-color:#0c1b33;color:#ffffff;text-decoration:none;font-size:14px;font-weight:700;padding:13px 32px;border-radius:9px;font-family:Arial,sans-serif;">Vérifier mon adresse email</a>
          </td>
        </tr>
      </table>

      <!-- Expiry warning -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 20px;">
        <tr>
          <td style="background-color:#fffbeb;border:1px solid #fde68a;border-radius:8px;padding:12px 16px;">
            <p style="margin:0;font-size:13px;color:#92400e;line-height:1.5;font-family:Arial,sans-serif;">⚠&nbsp; Ce lien est valable 15 minutes. Passé ce délai, une nouvelle vérification sera nécessaire.</p>
          </td>
        </tr>
      </table>

      <p style="margin:0 0 24px;font-size:12px;color:#9ca3af;text-align:center;font-style:italic;font-family:Arial,sans-serif;">Vous n'avez pas créé de compte sur Pilotis Capital ?<br/>Ignorez cet email. Aucune action n'est requise.</p>

      <p style="margin:0 0 4px;font-size:13px;color:#555555;font-family:Arial,sans-serif;">Cordialement,</p>
      <p style="margin:0;font-size:13px;font-weight:700;color:#1a1a1a;font-family:Arial,sans-serif;">L'équipe Pilotis Capital</p>
    </td>
  </tr>

</@layout.htmlEmailLayout>
