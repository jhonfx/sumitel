//# sourceMappingURL=format_number.js.map
window.format=function(b,a){if(!b||isNaN(+a))return a;a="-"==b.charAt(0)?-a:+a;var l=0>a?a=-a:0,e=b.match(/[^\d\-\+#]/g),h=e&&e[e.length-1]||".",e=e&&e[1]&&e[0]||",";b=b.split(h);a=a.toFixed(b[1]&&b[1].length);a=+a+"";var d=b[1]&&b[1].lastIndexOf("0"),c=a.split(".");if(!c[1]||c[1]&&c[1].length<=d)a=(+a).toFixed(d+1);d=b[0].split(e);b[0]=d.join("");var f=b[0]&&b[0].indexOf("0");if(-1<f)for(;c[0].length<b[0].length-f;)c[0]="0"+c[0];else 0==+c[0]&&(c[0]="");a=a.split(".");a[0]=c[0];if(c=d[1]&&d[d.length-
1].length){for(var d=a[0],f="",m=d.length%c,g=0,k=d.length;g<k;g++)f+=d.charAt(g),!((g-m+1)%c)&&g<k-c&&(f+=e);a[0]=f}a[1]=b[1]&&a[1]?h+a[1]:"";return(l?"-":"")+a[0]+a[1]};