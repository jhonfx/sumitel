//# sourceMappingURL=jsgrid.field.select.js.map
(function(d,g,h){function k(a){this.items=[];this.selectedIndex=-1;this.textField=this.valueField="";a.valueField&&a.items.length&&(this.valueType=typeof a.items[0][a.valueField]);this.sorter=this.valueType;l.call(this,a)}var l=d.NumberField;k.prototype=new l({align:"center",valueType:"number",itemTemplate:function(a){var b=this.items,e=this.valueField,c=this.textField,b=e?g.grep(b,function(b,c){return b[e]===a})[0]||{}:b[a],c=c?b[c]:b;return c===h||null===c?"":c},filterTemplate:function(){if(!this.filtering)return"";
var a=this._grid,b=this.filterControl=this._createSelect();if(this.autosearch)b.on("change",function(b){a.search()});return b},insertTemplate:function(){return this.inserting?this.insertControl=this._createSelect():""},editTemplate:function(a){if(!this.editing)return this.itemTemplate(a);var b=this.editControl=this._createSelect();a!==h&&b.val(a);return b},filterValue:function(){var a=this.filterControl.val();return"number"===this.valueType?parseInt(a||0,10):a},insertValue:function(){var a=this.insertControl.val();
return"number"===this.valueType?parseInt(a||0,10):a},editValue:function(){var a=this.editControl.val();return"number"===this.valueType?parseInt(a||0,10):a},_createSelect:function(){var a=g("<select>"),b=this.valueField,e=this.textField,c=this.selectedIndex;g.each(this.items,function(d,f){var h=b?f[b]:d;f=e?f[e]:f;g("<option>").attr("value",h).text(f).appendTo(a).prop("selected",c===d)});a.prop("disabled",!!this.readOnly);return a}});d.fields.select=d.SelectField=k})(jsGrid,jQuery);