/*
 * id/version: viCard v0.4
 * autor/copyright: Simon Gattner
 * date/location: 09-07-11 Berlin Germany
 * contact/url: http://gedit.net/
 * licence: BY-NC-SA
 *   http://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_GB
 */

// toggles
function toggle()
  {
    var els = toggle.arguments;
    var elsLen = els.length;
    for (var i = 0; i < elsLen; i++)
      {
        var el = document.getElementById(els[i]);
        if(el)
          {
             if(el.style.display != 'none')
              {
                el.style.display  = 'none';
              }
             else
              {
                el.style.display = '';
              }
          }
      }
  }
function addClass(cl)
 {
  document.documentElement.className += ' '+cl;
 }
// onload functions
window.onload = function loadExHTML()
  {
    addClass('jsshow'); //show js functionality
    if(typeof window.loadInHTML == 'function')
      {
        loadInHTML(); //innerHTML onload
      }
  }