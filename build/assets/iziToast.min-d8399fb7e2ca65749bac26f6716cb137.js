/*
* iziToast | v1.1.1
* http://izitoast.marcelodolce.com
* by Marcelo Dolce.
*/
!function(t,e){"function"==typeof define&&define.amd?define([],e(t)):"object"==typeof exports?module.exports=e(t):t.iziToast=e(t)}("undefined"!=typeof global?global:this.window||this.global,function(t){"use strict";var e={},n="iziToast",o=(document.querySelector("body"),!!/Mobi/.test(navigator.userAgent)),i=/Chrome/.test(navigator.userAgent)&&/Google Inc/.test(navigator.vendor),s="undefined"!=typeof InstallTrigger,r="ontouchstart"in document.documentElement,a=["bottomRight","bottomLeft","bottomCenter","topRight","topLeft","topCenter","center"],l={info:{color:"blue",icon:"ico-info"},success:{color:"green",icon:"ico-check"},warning:{color:"yellow",icon:"ico-warning"},error:{color:"red",icon:"ico-error"}},d=568,c={},u={"class":"",title:"",titleColor:"",message:"",messageColor:"",backgroundColor:"",color:"",icon:"",iconText:"",iconColor:"",image:"",imageWidth:50,zindex:99999,layout:1,balloon:!1,close:!0,rtl:!1,position:"bottomRight",target:"",targetFirst:!0,timeout:5e3,drag:!0,pauseOnHover:!0,resetOnHover:!1,progressBar:!0,progressBarColor:"",animateInside:!0,buttons:{},transitionIn:"fadeInUp",transitionOut:"fadeOut",transitionInMobile:"fadeInUp",transitionOutMobile:"fadeOutDown",onOpen:function(){},onClose:function(){}};"remove"in Element.prototype||(Element.prototype.remove=function(){this.parentNode&&this.parentNode.removeChild(this)});var p=function(t,e,n){if("[object Object]"===Object.prototype.toString.call(t))for(var o in t)Object.prototype.hasOwnProperty.call(t,o)&&e.call(n,t[o],o,t);else if(t)for(var i=0,s=t.length;s>i;i++)e.call(n,t[i],i,t)},m=function(t,e){var n={};return p(t,function(e,o){n[o]=t[o]}),p(e,function(t,o){n[o]=e[o]}),n},v=function(t){var e=document.createDocumentFragment(),n=document.createElement("div");for(n.innerHTML=t;n.firstChild;)e.appendChild(n.firstChild);return e},f=function(t){return"#"==t.substring(0,1)||"rgb"==t.substring(0,3)||"hsl"==t.substring(0,3)},h=function(){return{move:function(t,e,n,o){var r,a=.3,l=180;t.style.transform="translateX("+o+"px)",o>0?(r=(l-o)/l,a>r&&e.hide(m(n,{transitionOut:"fadeOutRight",transitionOutMobile:"fadeOutRight"}),t,"drag")):(r=(l+o)/l,a>r&&e.hide(m(n,{transitionOut:"fadeOutLeft",transitionOutMobile:"fadeOutLeft"}),t,"drag")),t.style.opacity=r,a>r&&((i||s)&&(t.style.left=o+"px"),t.parentNode.style.opacity=a,this.stopMoving(t,null))},startMoving:function(t,e,n,o){o=o||window.event;var i=r?o.touches[0].clientX:o.clientX,s=t.style.transform.replace("px)","");s=s.replace("translateX(","");var a=i-s;t.classList.remove(n.transitionIn),t.classList.remove(n.transitionInMobile),t.style.transition="",r?document.ontouchmove=function(o){o.preventDefault(),o=o||window.event;var i=o.touches[0].clientX,s=i-a;h.move(t,e,n,s)}:document.onmousemove=function(o){o.preventDefault(),o=o||window.event;var i=o.clientX,s=i-a;h.move(t,e,n,s)}},stopMoving:function(t,e){r?document.ontouchmove=function(){}:document.onmousemove=function(){},t.style.transition="transform 0.4s ease, opacity 0.4s ease",t.style.opacity="",t.style.transform="",window.setTimeout(function(){t.style.transition=""},400)}}}(),g=function(t,e,o){var i=!1,s=!1,r=!1,a=null,l=t.querySelector("."+n+"-progressbar div"),d={hideEta:null,maxHideTime:null,currentTime:(new Date).getTime(),updateProgress:function(){if(i=!!t.classList.contains(n+"-paused"),s=!!t.classList.contains(n+"-reseted"),r=!!t.classList.contains(n+"-closed"),s&&(clearTimeout(a),l.style.width="100%",g(t,e,o),t.classList.remove(n+"-reseted")),r&&(clearTimeout(a),t.classList.remove(n+"-closed")),!i&&!s&&!r){d.currentTime=d.currentTime+10;var c=(d.hideEta-d.currentTime)/d.maxHideTime*100;l.style.width=c+"%",(Math.round(c)<0||"object"!=typeof t)&&(clearTimeout(a),o.apply())}}};e.timeout>0&&(d.maxHideTime=parseFloat(e.timeout),d.hideEta=(new Date).getTime()+d.maxHideTime,a=setInterval(d.updateProgress,10))};return e.destroy=function(){p(document.querySelectorAll("."+n+"-wrapper"),function(t,e){t.remove()}),p(document.querySelectorAll("."+n),function(t,e){t.remove()}),document.removeEventListener(n+"-open",{},!1),document.removeEventListener(n+"-close",{},!1),c={}},e.settings=function(t){e.destroy(),c=t,u=m(u,t||{})},p(l,function(t,n){e[n]=function(e){var n=m(c,e||{});n=m(t,n||{}),this.show(n)}}),e.hide=function(t,e,i){var s=m(u,t||{});i=i||!1,"object"!=typeof e&&(e=document.querySelector(e)),e.classList.add(n+"-closed"),(s.transitionIn||s.transitionInMobile)&&(e.classList.remove(s.transitionIn),e.classList.remove(s.transitionInMobile)),o||window.innerWidth<=d?s.transitionOutMobile&&e.classList.add(s.transitionOutMobile):s.transitionOut&&e.classList.add(s.transitionOut);var r=e.parentNode.offsetHeight;if(e.parentNode.style.height=r+"px",e.style.pointerEvents="none",(!o||window.innerWidth>d)&&(e.parentNode.style.transitionDelay="0.2s"),setTimeout(function(){e.parentNode.style.height="0px",e.parentNode.style.overflow="",window.setTimeout(function(){e.parentNode.remove()},1e3)},200),s["class"])try{var a;window.CustomEvent?a=new CustomEvent(n+"-close",{detail:{"class":s["class"]}}):(a=document.createEvent("CustomEvent"),a.initCustomEvent(n+"-close",!0,!0,{"class":s["class"]})),document.dispatchEvent(a)}catch(l){console.warn(l)}"undefined"!=typeof s.onClose&&s.onClose.apply(null,[s,e,i])},e.show=function(t){var e=this,i=m(c,t||{});i=m(u,i);var s=document.createElement("div");s.classList.add(n+"-capsule");var l=document.createElement("div");if(l.classList.add(n),o||window.innerWidth<=d?i.transitionInMobile.length>0&&l.classList.add(i.transitionInMobile):i.transitionIn.length>0&&l.classList.add(i.transitionIn),i.rtl&&l.classList.add(n+"-rtl"),i.color.length>0&&(f(i.color)?l.style.background=i.color:l.classList.add(n+"-color-"+i.color)),i.backgroundColor.length>0&&(l.style.background=i.backgroundColor),i["class"]&&l.classList.add(i["class"]),i.image){var y=document.createElement("div");y.classList.add(n+"-cover"),y.style.width=i.imageWidth+"px",y.style.backgroundImage="url("+i.image+")",l.appendChild(y)}var b;if(i.close?(b=document.createElement("button"),b.classList.add(n+"-close"),l.appendChild(b)):i.rtl?l.style.paddingLeft="30px":l.style.paddingRight="30px",i.progressBar){var w=document.createElement("div");w.classList.add(n+"-progressbar");var L=document.createElement("div");L.style.background=i.progressBarColor,w.appendChild(L),l.appendChild(w),setTimeout(function(){g(l,i,function(){e.hide(i,l)})},300)}else i.progressBar===!1&&i.timeout>0&&setTimeout(function(){e.hide(i,l)},i.timeout);var C=document.createElement("div");if(C.classList.add(n+"-body"),i.image&&(i.rtl?C.style.marginRight=i.imageWidth+10+"px":C.style.marginLeft=i.imageWidth+10+"px"),i.icon){var E=document.createElement("i");E.setAttribute("class",n+"-icon "+i.icon),i.iconText&&E.appendChild(document.createTextNode(i.iconText)),i.rtl?C.style.paddingRight="33px":C.style.paddingLeft="33px",i.iconColor&&(E.style.color=i.iconColor),C.appendChild(E)}var I=document.createElement("strong");i.titleColor.length>0&&(I.style.color=i.titleColor),I.appendChild(v(i.title));var T=document.createElement("p");i.messageColor.length>0&&(T.style.color=i.messageColor),T.appendChild(v(i.message)),i.layout>1&&l.classList.add(n+"-layout"+i.layout),i.balloon&&l.classList.add(n+"-balloon"),C.appendChild(I),C.appendChild(T);var x;if(i.buttons.length>0){x=document.createElement("div"),x.classList.add(n+"-buttons"),T.style.marginRight="15px";var O=0;p(i.buttons,function(t,n){x.appendChild(v(t[0]));var o=x.childNodes;o[O].addEventListener("click",function(n){n.preventDefault();var o=t[1];return new o(e,l)}),O++}),C.appendChild(x)}l.appendChild(C),s.style.visibility="hidden",s.appendChild(l),setTimeout(function(){var t=l.offsetHeight,e=l.currentStyle||window.getComputedStyle(l),n=e.marginTop;n=n.split("px"),n=parseInt(n[0]);var o=e.marginBottom;o=o.split("px"),o=parseInt(o[0]),s.style.visibility="",s.style.height=t+o+n+"px",setTimeout(function(){s.style.height="auto",i.target&&(s.style.overflow="visible")},1e3)},100);var M,N=i.position;if(i.target)M=document.querySelector(i.target),M.classList.add(n+"-target"),i.targetFirst?M.insertBefore(s,M.firstChild):M.appendChild(s);else{if(-1==a.indexOf(i.position))return void console.warn("["+n+"] Incorrect position.\nIt can be › "+a);N=o||window.innerWidth<=d?"bottomLeft"==i.position||"bottomRight"==i.position||"bottomCenter"==i.position?n+"-wrapper-bottomCenter":"topLeft"==i.position||"topRight"==i.position||"topCenter"==i.position?n+"-wrapper-topCenter":n+"-wrapper-center":n+"-wrapper-"+N,M=document.querySelector("."+n+"-wrapper."+N),M||(M=document.createElement("div"),M.classList.add(n+"-wrapper"),M.classList.add(N),document.body.appendChild(M)),"topLeft"==i.position||"topCenter"==i.position||"topRight"==i.position?M.insertBefore(s,M.firstChild):M.appendChild(s)}isNaN(i.zindex)?console.warn("["+n+"] Invalid zIndex."):M.style.zIndex=i.zindex,i.onOpen.apply(null,[i,l]);try{var R;window.CustomEvent?R=new CustomEvent(n+"-open",{detail:{"class":i["class"]}}):(R=document.createEvent("CustomEvent"),R.initCustomEvent(n+"-open",!0,!0,{"class":i["class"]})),document.dispatchEvent(R)}catch(H){console.warn(H)}if(i.animateInside){l.classList.add(n+"-animateInside");var k=200,D=100,S=300;if("bounceInLeft"==i.transitionIn&&(k=400,D=200,S=400),window.setTimeout(function(){I.classList.add("slideIn")},k),window.setTimeout(function(){T.classList.add("slideIn")},D),i.icon&&window.setTimeout(function(){E.classList.add("revealIn")},S),i.buttons.length>0&&x){var B=150;p(x.childNodes,function(t,e){window.setTimeout(function(){t.classList.add("revealIn")},B),B+=B})}}b&&b.addEventListener("click",function(t){t.target;e.hide(i,l,"button")}),i.pauseOnHover&&(l.addEventListener("mouseenter",function(t){this.classList.add(n+"-paused")}),l.addEventListener("mouseleave",function(t){this.classList.remove(n+"-paused")})),i.resetOnHover&&(l.addEventListener("mouseenter",function(t){this.classList.add(n+"-reseted")}),l.addEventListener("mouseleave",function(t){this.classList.remove(n+"-reseted")})),i.drag&&(r?(l.addEventListener("touchstart",function(t){h.startMoving(this,e,i,t)},!1),l.addEventListener("touchend",function(t){h.stopMoving(this,t)},!1)):(l.addEventListener("mousedown",function(t){t.preventDefault(),h.startMoving(this,e,i,t)},!1),l.addEventListener("mouseup",function(t){t.preventDefault(),h.stopMoving(this,t)},!1)))},e});