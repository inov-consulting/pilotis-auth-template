<#import "/assets/providers/providers.ftl" as providerIcons>

<#macro kw providers=[]>
  <p class="pt-2 separate text-center text-secondary-600 text-sm">
    ${msg("identity-provider-login-label")}
  </p>

  <div class="gap-4 mt-3 items-center place-content-center text-center  grid grid-cols-${providers?size}">
    <#list providers as provider>
      <#switch provider.alias>
        <#case "apple">
          <#assign colorClass="hover:bg-provider-apple/10">
          <#break>
        <#case "bitbucket">
          <#assign colorClass="hover:bg-provider-bitbucket/10">
          <#break>
        <#case "discord">
          <#assign colorClass="hover:bg-provider-discord/10">
          <#break>
        <#case "facebook">
          <#assign colorClass="hover:bg-provider-facebook/10">
          <#break>
        <#case "github">
          <#assign colorClass="hover:bg-provider-github/10">
          <#break>
        <#case "gitlab">
          <#assign colorClass="hover:bg-provider-gitlab/10">
          <#break>
        <#case "google">
          <#assign colorClass="hover:bg-provider-google/10">
          <#break>
        <#case "instagram">
          <#assign colorClass="hover:bg-provider-instagram/10">
          <#break>
        <#case "linkedin">
          <#assign colorClass="hover:bg-provider-linkedin/10">
          <#break>
        <#case "linkedin-openid-connect">
          <#assign colorClass="hover:bg-provider-linkedin/10">
          <#break>
        <#case "microsoft">
          <#assign colorClass="hover:bg-provider-microsoft/10">
          <#break>
        <#case "oidc">
          <#assign colorClass="hover:bg-provider-oidc/10">
          <#break>
        <#case "openshift-v3">
          <#assign colorClass="hover:bg-provider-openshift/10">
          <#break>
        <#case "openshift-v4">
          <#assign colorClass="hover:bg-provider-openshift/10">
          <#break>
        <#case "paypal">
          <#assign colorClass="hover:bg-provider-paypal/10">
          <#break>
        <#case "slack">
          <#assign colorClass="hover:bg-provider-slack/10">
          <#break>
        <#case "stackoverflow">
          <#assign colorClass="hover:bg-provider-stackoverflow/10">
          <#break>
        <#case "twitter">
          <#assign colorClass="hover:bg-provider-twitter/10">
          <#break>
        <#default>
          <#assign colorClass="hover:bg-secondary-100">
      </#switch>

      <a
        class="${colorClass} border border-secondary-200 flex justify-center py-2 rounded-lg hover:border-transparent"
        data-provider="${provider.alias}"
        href="${provider.loginUrl}"
        type="button"
      >
        <#if providerIcons[provider.alias]??>
          <div class="h-6 w-6">
            <#if provider.alias == 'linkedin-openid-connect'>
                <@providerIcons[linkedin] />
            <#else>
                <@providerIcons[provider.alias] />
            </#if>
          </div>
        <#else>
          <div class="h-6 w-6">
           <#if provider.alias == 'linkedin-openid-connect'>
               <@providerIcons['linkedin'] />
           <#else>
           ${provider.displayName!}
           </#if></div>
        </#if>

      </a>
    </#list>
  </div>
</#macro>
