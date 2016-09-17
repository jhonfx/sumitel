<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Inventario')}" />

    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'spin.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery-1.8.3.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery.modal.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ring.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.modal.css')}"/>

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
                        && (!filter.precioPublico || tupla.precioPublico == filter.precioPublico)
                        && (!filter.precioUnitario || tupla.precioUnitario == filter.precioUnitario)
                        && (!filter.costoPublico || tupla.costoPublico == filter.costoPublico)
                        && (!filter.costoUnitario || tupla.costoUnitario == filter.costoUnitario)
                        // && (!filter.fechaCreacion.from || new Date(tupla.fechaCreacion) >= filter.fechaCreacion.from) 
                        // && (!filter.fechaCreacion.to || new Date(tupla.fechaCreacion) <= filter.fechaCreacion.to)
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
                    { name: "articulo", filtering: true, title:'Producto', type: "text", width: 110,  editing: false},
                    // { name: "precioSub", type: "number", width: 30,  editing: false},
                    { name: "precioPublico", filtering: true, title:'Precio Publico', type: "number", width: 30,  editing: false},
                    { name: "precioUnitario", filtering: false,title: 'Precio Unitario', type: "number", width: 30,  editing: false},
                    { name: "totalArticulos", filtering: true, title: 'Total', type: "number", width: 30,  editing: false},
                    // { name: "costoSub", type: "number", width: 30,  editing: false},
                    { name: "costoPublico", filtering: true, title: 'Costo Publico',type: "number", width: 30,  editing: false},
                    { name: "costoUnitario", filtering: false, title: 'Costo Unitario', type: "number", width: 30,  editing: false, itemTemplate: function(value) {
                        return value.toFixed(2) + "$"; 
                      }
                    },
                    // { name: "usuarioCreacion", type: "text", width: 50,  editing: false},
                    // { name: "fechaCreacion", type: "date", width: 50,  editing: false},
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
<script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jsgrid.core.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jsgrid.load-indicator.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jsgrid.load-strategies.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jsgrid.sort-strategies.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jsgrid.field.js')}"></script>

  <script type="text/javascript" src="${resource(dir: 'javascripts', file: '/fields/jsgrid.field.text.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: '/fields/jsgrid.field.number.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: '/fields/jsgrid.field.select.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: '/fields/jsgrid.field.checkbox.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: '/fields/jsgrid.field.control.js')}"></script>
</body>
</html>
