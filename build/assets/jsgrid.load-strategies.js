//# sourceMappingURL=jsgrid.load-strategies.js.map
(function(e,f,g){function c(a){this._grid=a}function d(a){this._grid=a;this._itemsCount=0}c.prototype={firstDisplayIndex:function(){var a=this._grid;return a.option("paging")?(a.option("pageIndex")-1)*a.option("pageSize"):0},lastDisplayIndex:function(){var a=this._grid,b=a.option("data").length;return a.option("paging")?Math.min(a.option("pageIndex")*a.option("pageSize"),b):b},itemsCount:function(){return this._grid.option("data").length},openPage:function(a){this._grid.refresh()},loadParams:function(){return{}},
sort:function(){this._grid._sortData();this._grid.refresh();return f.Deferred().resolve().promise()},finishLoad:function(a){this._grid.option("data",a)},finishInsert:function(a){var b=this._grid;b.option("data").push(a);b.refresh()},finishDelete:function(a,b){a=this._grid;a.option("data").splice(b,1);a.reset()}};d.prototype={firstDisplayIndex:function(){return 0},lastDisplayIndex:function(){return this._grid.option("data").length},itemsCount:function(){return this._itemsCount},openPage:function(a){this._grid.loadData()},
loadParams:function(){var a=this._grid;return{pageIndex:a.option("pageIndex"),pageSize:a.option("pageSize")}},sort:function(){return this._grid.loadData()},finishLoad:function(a){this._itemsCount=a.itemsCount;this._grid.option("data",a.data)},finishInsert:function(a){this._grid.search()},finishDelete:function(a,b){this._grid.search()}};e.loadStrategies={DirectLoadingStrategy:c,PageLoadingStrategy:d}})(jsGrid,jQuery);