
<#macro kw currentLocale="" locales=[]>

  <div class="relative inline-block text-left">

      <button data-dropdown-toggle="dropdownHover" data-dropdown-trigger="hover" class="inline-flex w-full justify-center gap-x-1.5 bg-white px-3 py-2 text-sm font-semibold text-gray-900" id="menu-button" aria-expanded="true" aria-haspopup="true"
              onmouseover="this.style.color='#0c1b33'" onmouseout="this.style.color=''">
        ${currentLocale}
        <svg class="-mr-1 h-5 w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
          <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
        </svg>
      </button>

    <!--
    Dropdown menu, show/hide based on menu state.

    Entering: "transition ease-out duration-100"
    From: "transform opacity-0 scale-95"
    To: "transform opacity-100 scale-100"
    Leaving: "transition ease-in duration-75"
    From: "transform opacity-100 scale-100"
    To: "transform opacity-0 scale-95"
    -->

    <div id="dropdownHover" class="absolute right-0 z-10 mt-2 w-25 bg-gray-50 hidden origin-top-right bg-gray-50   focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="menu-button" tabindex="-1">
      <div class="py-1" role="none">
          <#list locales as locale>
              <#if currentLocale != locale.label>

                  <a href="${locale.url}" class="text-gray-700 block px-4 py-2 text-sm" role="menuitem" tabindex="-1" id="menu-item${locale.label}"
                     onmouseover="this.style.color='#0c1b33'" onmouseout="this.style.color=''">${locale.label}</a>
              </#if>
          </#list>
        <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
        </div>
    </div>
  </div>
</#macro>
