//# sourceMappingURL=sumitel_utils.js.map
$(document).ready(function(){$.fn.decimals=function(){return this.each(function(){this.value?isNaN(parseFloat(this.value))||(this.value=parseFloat(this.value).toFixed(2)):this.innerHTML&&!isNaN(parseFloat(this.innerHTML))&&(this.innerHTML=parseFloat(this.innerHTML).toFixed(2))})};$.fn.serializeObject=function(){var a={},b=this.serializeArray();$.each(b,function(){void 0!==a[this.name]?(a[this.name].push||(a[this.name]=[a[this.name]]),a[this.name].push(this.value||"")):a[this.name]=this.value||""});
return a};$.fn.isEmpty=function(a,b){return null==a||void 0==a||(b?!1:""==a)};$.fn.validarFecha=function(a){if(!/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/.test(a))return!1;var b=parseInt(a.substring(0,2),10),c=parseInt(a.substring(3,5),10);if(1>b||31<b||1>c||12<c)return!1;a=parseInt(a.substring(6),10);return 2==c?$.fn.esBisiesto(a)?!(29<b):!(28<b):4==c||6==c||9==c||11==c?!(30<b):!0};$.fn.esBisiesto=function(a){return 0==parseInt(a,10)%4?0==parseInt(a,10)%100?0==parseInt(a,10)%400?!0:!1:!0:!1}});
function numbersOnly(a){var b,c;if(window.event)b=window.event.keyCode;else if(a)b=a.which;else return!0;c=String.fromCharCode(b);return null==b||0==b||8==b||9==b||13==b||27==b?!0:-1<"0123456789".indexOf(c)?!0:/\./g.test(getTarget(a).value)||"."!=c?!1:!0}function getTarget(a){var b;a||(a=window.event);a.target?b=a.target:a.srcElement&&(b=a.srcElement);3==b.nodeType&&(b=b.parentNode);return b}
function limitLengthWithDecimals(a,b,c){var d=a.value,e=parseInt(b);b=parseInt(c);-1<d.indexOf(".")?(d=d.split("."),0<d.length&&(e=d[0].substring(0,e),c=".",isNaN(d[1])||(c+=d[1].substring(0,b)),a.value=e+c)):a.value=d.substring(0,e)}function limitLengthInput(a,b){var c=a.value,d=parseInt(b);-1<c.indexOf(".")?(c=c.split("."),0<c.length&&(d=c[0].substring(0,d),a.value=d)):a.value=c.substring(0,d)}function replaceCaracteres(a){a=a.replace(",","");return a=a.replace("$","")}
function replaceAll(a,b,c){for(;-1!=a.toString().indexOf(b);)a=a.toString().replace(b,c);return a}function isKeyCodeANumbericKey(a){return 48<=a&&57>=a||96<=a&&105>=a};