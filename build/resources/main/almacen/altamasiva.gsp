<%@ page import="sumitel.Almacen" %>
<%@ page import="sumitel.Proveedor" %>
<%@ page import="sumitel.Inventario" %>
<!DOCTYPE html>
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Articulo')}" />
    
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery-1.8.3.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts/utils', file: 'sumitel_utils.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'validate.js')}"></script>


    <title>CARGA DE ARTICULOS</title>
    <style>
      .header {
         
         top: 0 !important;
         width: 100% !important;
         height: 60px !important;   /* Height of the footer */
         background: #9dc1e0 !important;
         float: right;
         font-size: 30px;
         color: white;
         text-align: center;
         padding: 15px;
      }
    </style>
    <script type="text/javascript">
      $(document).ready( function() {

        var responseInvData;


        function validateNumber(event) {
            var key = window.event ? event.keyCode : event.which;
            if (event.keyCode === 8 || event.keyCode === 46 || event.keyCode == 32) {
                return true;
            } else if ( key < 48 || key > 57 ) {
                return false;
            } else {
                return true;
            }
        };


        $('#factura').keypress(validateNumber);
        $('#imei_cel').keypress(validateNumber);
        $('#codigos').keypress(validateNumber);


        $('#inventarioId').on('change', function(e) {
          console.log("lo cambie")
          var id = $(this).find('option:selected').val();
          var tipoProd = 0;
          console.log(id)

          $.getJSON('${createLink(controller:"inventario", action:"infoProducto")}', {
              id: id,
              ajax: 'true'
          }, function(response) {
              console.log(response)
              $('#producto').val(response.articulo)
              $('#costosub').val(response.costosub)
              $('#costoPublico').val(response.costoPublico)
              $('#costoUnitario').val(response.costoUnitario)
              $('#totalArticulos').val(response.totalArticulos)
              $('#idProducto').val(id)
              responseInvData = response[0];
              tipoProd = parseInt(responseInvData.tipoArticulo)
              console.log(tipoProd)
              if (tipoProd === 1 ) {
                $('#imei_cel').removeAttr('disabled');
                $('#imei_cel').attr('required');
              } else {
                $('#imei_cel').attr('disabled', 'disabled');
                $('#imei_cel').val('');
                $('#imei_cel').removeAttr('required');
              }

          });
        });

        
        console.log("cargando");
        var toTable = [];
        
        $('#aplicar').click( function(e) {
        console.log(responseInvData);
          var frm = $('#formulario');
          var producto = $('#producto').val();
          var data = JSON.stringify(frm.serializeObject());
          var format = JSON.parse(data);  //data parse

          var newobject = format.code.split(/\s+/);  //array of serie/IMEI
          var newobject2 = !format.imei_cel ? [] : format.imei_cel.split(/\s+/);  //array of serie/IMEI
          console.log(newobject);
          console.log(newobject2);
          console.log(responseInvData.articulo)
          if (newobject == [""] || newobject == null || newobject.length == 0 || newobject == "") {
            console.log("esta vacio")
          } else {
                _.each(newobject, function(obj) {
                  
                  toTable.push({
                    'series': obj,
                    'imeiCel': !newobject2[0] ? 0 : newobject2[0],
                    'numeroCel': '0000000',
                    'factura': format.fact,
                    'articulo':  responseInvData.articulo,
                    'precioUnitario':  responseInvData.precioUnitario,
                    'precioPublico': responseInvData.precioPublico,
                    'precioSub': responseInvData.precioSub,
                    'totalArticulos': responseInvData.totalArticulos,
                    'idProducto': responseInvData.id,
                    'cant': 1
                  });
                });


            $('#codigos').val('');
            $('#imei_cel').val('');
            console.log(toTable);

            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                        return (!filter.series || tupla.series.indexOf(filter.series) > -1)
                        && (!filter.producto || tupla.producto.indexOf(filter.producto) > -1);
                    });
                },

                insertItem: function(insertingClient) {
                    this.clients.push(insertingClient);
                },

                updateItem: function(updatingClient) { },

                deleteItem: function(deletingTuplas) {
                    var tuplasIndex = $.inArray(deletingTuplas, this.tuplas);
                    this.tuplas.splice(tuplasIndex, 1);
                }

              };

              window.db = db;
              db.tuplas = toTable;
          }());

            $( function() {

              /* generate data table */
              $("#jsgrid_table").jsGrid({
                width: "100%",
                height: "600px",

                confirmDeleting: false,
                deleteConfirm: "¿ Deseas borrar este artículo ?",

                filtering: true,
                editing: true,
                inserting: true,
                sorting: true,
                paging: true,
                autoload: true,
                pageSize: 15,
                pageButtonCount: 5,
                
                // data: toTable,
                controller: db,
         
                fields: [
                    { name: "factura", title: "Factura", type: "text", width: 50, filtering: false, editing: false},
                    { name: "series", title: "SIM/SERIE", type: "text", width: 50, editing: false},
                    { name: "imeiCel", title: "IMEI", type: "text", width: 50, editing: false},
                    { name: "articulo", title: "Producto", type: "text", width: 150, editing: false},
                    { name:  "precioUnitario", title: "Precio", type: 'text', width: 40, filtering: false, editing: false},
                    { type: "control", editButton: false, filtering: false}
                ]

                
              });
            });
          }

        });

        $('#limpiar').click( function(e) {
          console.log("limpiando");
          $("#jsgrid_table").jsGrid("destroy");
          toTable = [];
          // $('#table_here').html(template({toTable}));
        });


        $('#save_data').click( function(e) {
          var testjson = JSON.stringify({series: toTable})
          e.preventDefault();
          if($('#factura').val() === "") {
              swal({
                title: "Error",
                type: "error",
                text: "Agregue un numero de factura",
                allowEscapeKey: true,
                imageSize: "20x20"
              });
              $('#factura').attr('required', 'required');
            return;
          } else if ($('#inventarioId').val() === "" || $('#inventarioId').val() === 0) {
              swal({
                title: "Error",
                type: "error",
                text: "Debe seleccionar un producto",
                allowEscapeKey: true,
                imageSize: "20x20"
              });
              $('#inventarioId').attr('required', 'required');
              return;
          } else if ($('#proveedorId').val() === "" || $('#proveedorId').val() === 0) {
              swal({
                title: "Error",
                type: "error",
                text: "Debe seleccionar un proveedor",
                allowEscapeKey: true,
                imageSize: "20x20"
              });
              $('#proveedorId').attr('required', 'required');
              return;
          } else if (toTable.length === 0) {
            swal({
                title: "Error",
                type: "error",
                text: "Debe agregar productos a la factura",
                allowEscapeKey: true,
                imageSize: "20x20"
              });
            console.log("table vacia");
            return;
          }



          $.ajax({
              url:"${createLink(controller:'almacen', action:'saveData')}",
              data: {'factura': $('#factura').val(), 'tuplas': JSON.stringify(toTable)},
              type:"POST",
              success:function (callback) {
                console.log(callback)
                if (callback.error === 303) {
                  swal({
                    title: "Error",
                    type: "error",
                    text: "Ya existe ese numero de factura",
                    allowEscapeKey: true,
                    imageSize: "20x20"
                  });
                  return;
                } else {

                  swal({
                    title: "Nueva Factura",
                    text: "Se generara una factura nueva",
                    type: "info",
                    showCancelButton: true,
                    closeOnConfirm: false,
                    showLoaderOnConfirm: true,
                  },
                  function(){
                    setTimeout(function(){
                      var href = "${createLink(controller: 'inventario', action: 'listarArticulos')}"
                      location.href = href;
                    }, 2000);
                  });
                }
              },
              error:function (error) {
                console.log(error)
              },
              dataType:"json"
          });
          //termina ajax
          
        });

      });

        

    </script>
</head>
<body>
<div class="container"> 
  <div class="row">
    <div class="header">SUMITEL S.A DE C.V</div>
  </div>
  
  <div class="col-md-12">
    <div class="row">
      <h1>AGREGAR PRODUCTOS</h1>
    </div>
    <div class="row">
      <form id="formulario" name="formulario">
        <div class="form-group">
          <label>FACTURA</label>
          <input type="text" class="form-control col-md-6" id="factura" name="fact">
        </div>
        <div class="form-group">
          <label>Producto</label>
          <g:select name="inventarioId" class="form-control col-md-4" id="inventarioId"
            from="${Inventario.findAll()}"
            optionKey="id" optionValue="articulo"
            noSelection="${['':'Seleccione...']}"/>
            <input type="hidden" name="producto" id="producto">
            <input type="hidden" name="costosub" id="costosub">
            <input type="hidden" name="costoPublico" id="costoPublico">
            <input type="hidden" name="costoUnitario" id="costoUnitario">
            <input type="hidden" name="totalArticulos" id="totalArticulos">
            <input type="hidden" name="idProducto" id="idProducto">
        </div>
        <div class="form-group">
          <label>Proveedor</label>
          <g:select name="proveedorId" id="proveedorId" class="form-control col-md-4"
            from="${Proveedor.findAll()}"
            optionKey="id" optionValue="nombreProveedor"
            noSelection="${['':'Seleccione...']}"/>
        </div>
        <div class="form-group">
          <label>SERIE</label>
          <textarea type="textarea" class="form-control" id="codigos" name="code"></textarea>
        </div>
        <div class="form-group">
          <label>IMEI</label>
          <input type="text" disabled class="form-control" id="imei_cel" name="imei_cel" maxlength="16"></input>
        </div>
        <div class="form-group">
          <label>Telefono</label>
          <input type="text" disabled class="form-control" id="tel_cel" name="tel_cel"></textarea>
        </div>
        <div class="form-group">
          <button type="button" id="aplicar" class="btn btn-xs blue">AGREGAR</button>&nbsp;&nbsp;&nbsp;
          <button type="button" id="limpiar" class="btn btn-xs red">BORRAR</button>
        </div>
      
    </div>
    <div class="row">
    <div class="col-sm-12">
      <div id="jsgrid_table"></div>
    </div>
    </div>
    <div class="row">
      <div class="col-md-8"></div>
      <div class="col-md-4">
        <button type="submit" name="submit" id="save_data" class="btn pull-right btn-sm green">GENERAR ORDEN</button>
      </div>
    </div>
    </form>
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