<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Inventario')}" />

    <title>LISTAR ARTCULOS</title>
    <script type="text/javascript">
      $(document).ready( function() {
        console.log("inciando");
        
        var response = [];
        $.ajax({
          url: "${createLink(controller: 'inventario', action:'obtenerListaArticulos')}",
          type: "GET",
          success: function(json) {




            var result = json.rows;
            var tamanio = result.length
            var customHeight = 36*30;

      
            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                        return (!filter.articulo || tupla.articulo.indexOf(filter.articulo) > -1)
                        && (!filter.totalArticulos || tupla.totalArticulos == filter.totalArticulos)
                        && (!filter.precioSub || tupla.precioSub == filter.precioSub)
                        && (!filter.costoSub || tupla.costoSub == filter.costoSub)
                        && (!filter.fechaCreacion.from || new Date(tupla.fechaCreacion) >= filter.fechaCreacion.from) 
                        && (!filter.fechaCreacion.to || new Date(tupla.fechaCreacion) <= filter.fechaCreacion.to)
                    });
                },

              };

              window.db = db;
              db.tuplas = result;
            }());

            var DateField = function(config) {
    jsGrid.Field.call(this, config);
};

var DateField = function(config) {
    jsGrid.Field.call(this, config);
};

DateField.prototype = new jsGrid.Field({
    sorter: function(date1, date2) {
        return new Date(date1) - new Date(date2);
    },    
    
    itemTemplate: function(value) {
        return new Date(value).toDateString();
    },
    
    filterTemplate: function() {
        var now = new Date();
        this._fromPicker = $("<input>").datepicker({ defaultDate: now.setFullYear(now.getFullYear() - 1) });
        this._toPicker = $("<input>").datepicker({ defaultDate: now.setFullYear(now.getFullYear() + 1) });
        return $("<div>").append(this._fromPicker).append(this._toPicker);
    },
    
    insertTemplate: function(value) {
        return this._insertPicker = $("<input>").datepicker({ defaultDate: new Date() });
    },
    
    editTemplate: function(value) {
        return this._editPicker = $("<input>").datepicker().datepicker("setDate", new Date(value));
    },
    
    insertValue: function() {
        return this._insertPicker.datepicker("getDate").toISOString();
    },
    
    editValue: function() {
        return this._editPicker.datepicker("getDate").toISOString();
    },
    
    filterValue: function() {
        return {
            from: this._fromPicker.datepicker("getDate"),
            to: this._toPicker.datepicker("getDate")
        };
    }
});

jsGrid.fields.date = DateField;


            $( function() {

              /* generate data table */
              $("#datos_list").jsGrid({
                width: "100%",
                height: customHeight,

                confirmDeleting: true,
                deleteConfirm: "¿ Deseas borrar este artículo ?",

                filtering:true,
                editing: true,
                sorting: true,
                paging: true,
                autoload: true,

                pageSize: 30,
                pageButtonCount: 5,
                
                //data: json.rows,
                controller: db,
         
                fields: [
                    { name: "articulo", type: "text", width: 110,  editing: false},
                    { name: "precioSub", type: "number", width: 30,  editing: false},
                    { name: "precioPublico", type: "number", width: 30,  editing: false},
                    { name: "precioUnitario", type: "number", width: 30,  editing: false},
                    { name: "totalArticulos", type: "number", width: 30,  editing: false},
                    { name: "costoSub", type: "number", width: 30,  editing: false},
                    { name: "costoPublico", type: "number", width: 30,  editing: false},
                    { name: "costoUnitario", type: "number", width: 30,  editing: false},
                    { name: "usuarioCreacion", type: "text", width: 50,  editing: false},
                    { name: "fechaCreacion", type: "date", width: 50,  editing: false},
                    { type: "control", editButton: false}
                ]

                
              });
            });
          },
          error: function(error) {
            console.log(error);
          },
          dataType: "json"
        });
        console.log(response)


      });
    </script>
    
</head>
<body>
<div class="container"> 
  <div class="col-md-12">
    <div class="row">
      <h1>LISTAR ARTICULOS</h1>
    </div>
    <div class="row" id="datos_list">
    </div>
  </div>
</div>
  

  