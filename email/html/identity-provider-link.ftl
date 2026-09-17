<#import "template.ftl" as layout>
<@layout.htmlEmailLayout accentColor="#DC2626" category="SÉCURITÉ DU COMPTE">

  <!-- Success banner -->
  <tr>
    <td style="background-color:#F0F9F4;border-left:3px solid #1B6B45;padding:12px 24px;">
      <p style="margin:0;font-size:13px;color:#166534;font-weight:600;font-family:Arial,sans-serif;">→&nbsp; Fournisseur d'identité lié avec succès</p>
    </td>
  </tr>

  <!-- Main content -->
  <tr>
    <td style="padding:32px 32px 28px;font-family:Arial,Helvetica,sans-serif;">

      <p style="margin:0 0 12px;font-size:22px;font-weight:700;color:#1A1A1A;">Bonjour ${user.firstName!''},</p>
      <p style="margin:0 0 24px;font-size:14px;color:#555555;line-height:1.6;">Un fournisseur d'identité externe a été lié avec succès à votre compte Pilotis Capital. Vous pouvez désormais vous connecter en utilisant ce fournisseur.</p>

      <!-- Info table -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#F5F5F0;border-radius:8px;margin:0 0 20px;overflow:hidden;">
        <tr>
          <td style="padding:12px 16px;border-bottom:1px solid #E8E8E4;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6B7280;font-family:Arial,sans-serif;">Fournisseur</td>
                <td align="right">
                  <span style="display:inline-block;background-color:#FFFBEB;color:#B8860B;font-size:11px;font-weight:700;padding:3px 8px;border-radius:4px;text-transform:uppercase;font-family:Arial,sans-serif;letter-spacing:0.05em;">${identityProviderAlias!''}</span>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td style="padding:12px 16px;border-bottom:1px solid #E8E8E4;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6B7280;font-family:Arial,sans-serif;">Compte lié</td>
                <td align="right" style="font-size:13px;font-weight:700;color:#1A1A1A;font-family:Arial,sans-serif;">${identityProviderContext.username!user.email!''}</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td style="padding:12px 16px;">
            <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <td style="font-size:13px;color:#6B7280;font-family:Arial,sans-serif;">Adresse email</td>
                <td align="right" style="font-size:13px;font-weight:700;color:#1A1A1A;font-family:Arial,sans-serif;">${user.email!''}</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

      <!-- Green info box -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 12px;">
        <tr>
          <td style="background-color:#F0F9F4;border-left:3px solid #1B6B45;border-radius:0 6px 6px 0;padding:12px 16px;">
            <p style="margin:0;font-size:13px;color:#166534;line-height:1.5;font-family:Arial,sans-serif;">Vous pouvez vous connecter à Pilotis Capital avec votre compte ${identityProviderAlias!''} sans saisir votre mot de passe manuellement.</p>
          </td>
        </tr>
      </table>

      <!-- Red warning box -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 20px;">
        <tr>
          <td style="background-color:#FFF5F5;border-left:3px solid #DC2626;border-radius:0 6px 6px 0;padding:12px 16px;">
            <p style="margin:0;font-size:13px;color:#DC2626;line-height:1.5;font-family:Arial,sans-serif;">Vous n'êtes pas à l'origine de cette liaison ? Dissociez immédiatement ce fournisseur depuis vos paramètres de sécurité.</p>
          </td>
        </tr>
      </table>

      <!-- Action button -->
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 28px;">
        <tr>
          <td align="center">
            <a href="${link}" style="display:inline-block;background-color:#0c1b33;color:#ffffff;text-decoration:none;font-size:14px;font-weight:700;padding:13px 32px;border-radius:8px;font-family:Arial,sans-serif;">Gérer mes fournisseurs d'identité</a>
          </td>
        </tr>
      </table>

      <p style="margin:0 0 4px;font-size:13px;color:#555555;font-family:Arial,sans-serif;">Cordialement,</p>
      <p style="margin:0;font-size:13px;font-weight:700;color:#1A1A1A;font-family:Arial,sans-serif;">L'équipe Pilotis Capital</p>
    </td>
  </tr>

</@layout.htmlEmailLayout>
