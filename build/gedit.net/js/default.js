/* .js
                      888 ,e,   d8       Y88b Y88 888'Y88 88P'888'Y88 
 e88 888  ,e e,   e88 888  "   d88        Y88b Y8 888 ,'Y P'  888  'Y 
d888 888 d88 88b d888 888 888 d88888     b Y88b Y 888C8       888     
Y888 888 888   , Y888 888 888  888   d8b 8b Y88b  888 ",d     888     
 "88 888  "YeeP"  "88 888 888  888   Y8P 88b Y88b 888,d88     888     
  ,  88P                                                              
 "8",P"                                                             */

/* <http://www.gedit.net/js/default.js>
 * Copyright 2006/2007/2008 Simon Gattner
 * This work is licensed under a Creative Commons Attribution-
 * NonCommercial 3.0 License.
 * Licence: <http://www.gedit.net/CC>
 * Contact: <http://www.gedit.net/Kontakt>                          */

function externalLinks() {
if (!document.getElementsByTagName) return;
var anchors = document.getElementsByTagName("a");
for (var i=0; i<anchors.length; i++)
 {
   var anchor = anchors[i];
   if (anchor.getAttribute("href") &&
       anchor.getAttribute("class") == "extern")
     anchor.target = "_blank";
 }
}


function show_elements()
 {
  var elementNames = show_elements.arguments;
  for (var i=0; i<elementNames.length; i++)
   {
     var elementName = elementNames[i];
     document.getElementById(elementName).style.display='block';
   }
 }

function hide_elements()
 {
  var elementNames = hide_elements.arguments;
  for (var i=0; i<elementNames.length; i++)
   {
     var elementName = elementNames[i];
     document.getElementById(elementName).style.display='none';
   }
 }

function hide_class()
 {
  document.documentElement.className += ' jshide';
 }

window.onload = function()
 {
  //externalLinks();
  hide_class();
 }