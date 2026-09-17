(function () {
  // Add a show/hide toggle button for every password field
  function enhancePasswordInput(input) {
    if (!input || input.dataset.hasToggle === 'true') return;
    input.dataset.hasToggle = 'true';

    // Create a wrapper to position the toggle neatly if not using a utility wrapper
    var wrapper = input.closest('.pwd-wrapper');
    if (!wrapper) {
      wrapper = document.createElement('div');
      wrapper.className = 'pwd-wrapper relative';
      input.parentNode.insertBefore(wrapper, input);
      wrapper.appendChild(input);
    } else {
      wrapper.classList.add('relative');
    }

    // Create button
    var btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'pwd-toggle';
    btn.setAttribute('aria-label', 'Afficher le mot de passe');
    btn.setAttribute('title', 'Afficher / masquer');
    btn.innerHTML = getEye(false);

    // Insert button
    wrapper.appendChild(btn);

    // Events
    btn.addEventListener('click', function () {
      var isText = input.type === 'text';
      input.type = isText ? 'password' : 'text';
      btn.innerHTML = getEye(!isText);
      btn.setAttribute('aria-label', isText ? 'Afficher le mot de passe' : 'Masquer le mot de passe');
    });

    // Keyboard helper: Ctrl+\ to toggle while focused
    input.addEventListener('keydown', function (e) {
      if ((e.ctrlKey || e.metaKey) && (e.key === '\\' || e.key === '|')) {
        e.preventDefault();
        btn.click();
      }
    });
  }

  function getEye(shown) {
    // Heroicons outline SVGs, minimal
    if (shown) {
      // eye slash
      return '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">\
<path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 15.338 6.454 18 12 18c1.63 0 3.06-.246 4.29-.68m3.73-2.1C21.053 13.91 22.066 12.99 22.066 12 20.774 8.662 17.546 6 12 6c-.9 0-1.742.08-2.53.232M3 3l18 18" />\
</svg>';
    }
    // eye
    return '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">\
<path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.644C3.423 7.51 7.36 5 12 5s8.577 2.51 9.964 6.678c.07.207.07.437 0 .644C20.577 16.49 16.64 19 12 19S3.423 16.49 2.036 12.322z" />\
<path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />\
</svg>';
  }

  function scan() {
    var inputs = document.querySelectorAll('input[type="password"]');
    inputs.forEach(enhancePasswordInput);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', scan);
  } else {
    scan();
  }
})();
