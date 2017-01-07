<%@ page import="sumitel.Cliente" %>
<!DOCTYPE html>
<html>
    <head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'ordenCompra.label', default: 'OrdenCompra')}" />
            
    <asset:stylesheet src="application.css"/>
    
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery-1.8.3.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'print.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'print.css')}"/>

    <script type="text/javascript">
      $(document).ready( function() {
        
        

        $('#onSearch').click( function() {
        var response = [];
        var numfact = $('#fact').val();
        $.ajax({
          url: "${createLink(controller: 'ordenCompra', action:'searchFactura')}" + "?fact=" + numfact,
          type: "GET",
          success: function(json) {

            var result = json.rows
            if (result.length == 0) {
                console.log("no hay nada")
            } else {
                console.log("si hay datos")
                $('#grid_container').removeClass('hidden')
            }
            console.log(result);
            var tamanio = result.length
            console.log(tamanio)
            var customHeight = (tamanio*25)*2;

      
            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                        console.log(tupla);
                        return (!filter.articulo || tupla.articulo.indexOf(filter.articulo) > -1)
                        && (!filter.imeisim || tupla.imeisim.indexOf(filter.imeisim) > -1);
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

            var MyDateField = function(config) {
                jsGrid.Field.call(this, config);
            };

            MyDateField.prototype = new jsGrid.Field({
                sorter: function(date1, date2) {
                    return new Date(date1) - new Date(date2);
                },
         
                itemTemplate: function(value) {
                  // console.log("format date")
                  // console.log(value)
                    return new Date(value).toLocaleDateString();
                }
            });
         
            jsGrid.fields.myDateField = MyDateField;

            function MoneyField(config) {
                jsGrid.NumberField.call(this, config);
            }

            MoneyField.prototype = new jsGrid.NumberField({

                itemTemplate: function(value) {
                  var string = value
                    return string;
                },

                filterValue: function() {
                    return parseFloat(this.filterControl.val() || 0);
                },

                insertValue: function() {
                    return parseFloat(this.insertControl.val() || 0);
                },

                editValue: function() {
                    return parseFloat(this.editControl.val() || 0);
                }

            });

            jsGrid.fields.money = MoneyField;

            $( function() {

              /* generate data table */
              $("#jsgrid_table").jsGrid({
                width: "100%",
                height: "800px",

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
                    { name: "fechaCompra", filtering: true, title:'Fecha Compra', type: "myDateField", width: 110,  editing: false},
                    { name: "articulo", filtering: true, title:'Producto', type: "text", width: 190,  editing: false},
                    { name: "imeisim", filtering: true, title:'IMEI', type: "text", width: 130,  editing: false},
                    { name: "imeicel", filtering: true, title:'SIM', type: "text", width: 130,  editing: false},
                    { name: "precioPublico", filtering: true, title:'Precio', type: "money", width: 70,  editing: false},
                    { name: "almacen", filtering: true, title:'Almacen', type: "text", width: 70,  editing: false},
                ]
              });
            });
          },
          error: function(error) {
            console.log(error);
          },
          dataType: "json"
        });
      });


        /*Crear una orden */
        $('#createOrder').on( 'click', function() {
            console.log("click para crear orden")

            $.ajax({
              url: "${createLink(controller: 'ordenCompra', action:'generarOrden')}",
              data: {fact: $('#fact').val(), name: $('#name').val(), ciudad: $('#ciudad').val(), estado: $('#estado').val()},
              type: "POST",
              success: function(json) { 
                console.log(json)
                var href = "${createLink(controller: 'ordenCompra', action: 'printOrden')}" +"?factura=" + json.factura;
                //location.href = href;
                window.open(href, '_blank');
              }
            });
        });

        $('#client_name').on('change', function(e) {
            var id = $(this).find('option:selected').val();

            $.getJSON('${createLink(controller: "ordenCompra", action:"searchClientInfo")}', {
                  id: id,
                  ajax: 'true'
              }, function(response) {
                  
                  $('#name').val(response[0].nombre)
                  $('#ciudad').val(response[0].ciudad)
                  $('#estado').val(response[0].estado)

              });

        });
    });
    </script>
    </head>
    <body>

        <div class="container" id="principal_container">
            <div class="row">
                <div class="col-sm-12">
                    <label>Buscar Factura:</label>
                </div>
                <div class="col-sm-12">
                    <input type="text" class="col-sm-4" onkeypress="return numbersOnly(event)" name="fact" id="fact">
                    <button class="searh_btn btn" style="margin-left: 10px" type="button" id="onSearch">Buscar</button>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-4">
                    &nbsp;
                </div>
            </div>
            <div class="row">
                <div class="col-sm-5">
                <label>Cliente:</label>
                <g:select name="clientId" id="client_name" class="form-control col-sm-4"
                from="${Cliente.findAll()}"
                optionKey="id" optionValue="nombre"
                noSelection="${['':'Seleccione un cliente...']}"/>
                </div>
                <input type="hidden" id="name">
                <input type="hidden" id="ciudad">
                <input type="hidden" id="estado">
            </div>
            <br>
            <div class="row hidden" id="grid_container">
              <div class="col-sm-12 col-md-12">
                <div id="jsgrid_table">
                </div>
              </div>
              <div class="col-sm-12">
                <button class="btn pull-right" type="button" id="createOrder">Generar Orden</button>
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
