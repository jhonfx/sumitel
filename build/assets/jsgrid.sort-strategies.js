//# sourceMappingURL=jsgrid.sort-strategies.js.map
(function(d,e,f){var c=function(a){return"undefined"!==typeof a&&null!==a};d.sortStrategies={string:function(a,b){return c(a)||c(b)?c(a)?c(b)?(""+a).localeCompare(""+b):1:-1:0},number:function(a,b){return a-b},date:function(a,b){return a-b},numberAsString:function(a,b){return parseFloat(a)-parseFloat(b)}}})(jsGrid,jQuery);