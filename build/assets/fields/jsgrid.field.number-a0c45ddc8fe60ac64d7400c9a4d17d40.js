//# sourceMappingURL=jsgrid.field.number.js.map
(function(a,d,e){function b(a){c.call(this,a)}var c=a.TextField;b.prototype=new c({sorter:"number",align:"right",readOnly:!1,filterValue:function(){return parseInt(this.filterControl.val()||0,10)},insertValue:function(){return parseInt(this.insertControl.val()||0,10)},editValue:function(){return parseInt(this.editControl.val()||0,10)},_createTextBox:function(){return d("<input>").attr("type","number").prop("readonly",!!this.readOnly)}});a.fields.number=a.NumberField=b})(jsGrid,jQuery);