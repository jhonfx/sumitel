<%@ page import="sumitel.Almacen" %>
<%@ page import="sumitel.Proveedor" %>
<%@ page import="sumitel.Inventario" %>
<!DOCTYPE html>
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Articulo')}" />
    
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts/utils', file: 'sumitel_utils.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'validate.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bttn.min.css')}"/>


    <title>CARGA DE ARTICULOS</title>
    <style type="text/css">
      
      @font-face {
        font-family: specialFont;
        src: url(${resource(dir: 'fonts', file: 'DK_High_Tea.otf')});
      }

      .header {
         top: 0 !important;
         width: 100% !important;
         height: 60px !important;   /* Height of the footer */
         background: #9dc1e0 !important;
         float: right;
         font-size: 40px;
         font-weight: 400;
         color: white;
         text-align: center;
         padding: 15px;
         font-family: 'specialFont';
      }

       h1 { 
          color: black; 
          font-family: 'specialFont';
          sans-serif; font-size: 35px; 
          font-weight: 800; 
          line-height: 55px; 
          margin: 0 0 4px; 
          text-align: center; 
          text-transform: uppercase; 
        }

       hr {
          height: 10px;
          border: 0;
          box-shadow: 0 10px 10px -10px #8c8b8b inset;
       }

    </style>
    <script type="text/javascript">
      $(document).ready( function() {

        var responseInvData;
        var tipo_producto;


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

        $('.flexdatalist').flexdatalist({
          minLength: 1,
          valueProperty: '*',
          selectionRequired: true,
        });

        $('#factura').keypress(validateNumber);
        $('#imei_cel').keypress(validateNumber);
        $('#codigos').keypress(validateNumber);


        $('.flexdatalist').on('select:flexdatalist', function(e) {
          var d_list = $(this).val();
          var parse =JSON.parse(d_list);
          console.log(parse);
          var id = parse.value
          var tipoProd = 0;

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
              tipo_producto = tipoProd;
              console.log(tipoProd)
              if (tipoProd === 1 ) {
                $('#imei_cel').removeAttr('disabled');
                $('#imei_cel').attr('required');
                $('#imei').val('');
                $('#imei').attr('disabled', 'disabled');
              } else {
                $('#imei_cel').attr('disabled', 'disabled');
                $('#imei_cel').val('');
                $('#imei_cel').removeAttr('required');
                $('#imei').val('');
                $('#imei').removeAttr('disabled');
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

          var newobject = !format.code ? 0 : format.code.split(/\s+/);  //array of serie/IMEI
          var newobject2 = !format.imei_cel ? [] : format.imei_cel.split(/\s+/);  //array of serie/IMEI
          console.log(newobject);
          console.log(newobject2);
          console.log(responseInvData.articulo)
          if (tipo_producto == 2 && newobject == 0 || tipo_producto == 1 && newobject2 == 0) {
            console.log("newobject");
            swal({
              title: "Error",
              type: "error",
              text: "Falta SIM/SERIE ó IMEI",
              allowEscapeKey: true,
              imageSize: "20x20"
            });
          } else{
            if (tipo_producto == 2) {
              _.each(newobject, function(obj) {
                toTable.push({
                  'series': obj,
                  'imeiCel': 0,
                  'numeroCel': '0000000',
                  'factura': format.fact,
                  'articulo':  responseInvData.articulo,
                  'precioUnitario':  responseInvData.precioUnitario,
                  'precioPublico': responseInvData.precioPublico,
                  'precioSub': responseInvData.precioSub,
                  'totalArticulos': responseInvData.totalArticulos,
                  'idProducto': responseInvData.id
                });
              });
              $('#imei').focus();
              $('#imei').val('');
              
            } else {
               _.each(newobject2, function(obj) {
                toTable.push({
                  'series': 0,
                  'imeiCel': obj,
                  'numeroCel': '0000000',
                  'factura': format.fact,
                  'articulo':  responseInvData.articulo,
                  'precioUnitario':  responseInvData.precioUnitario,
                  'precioPublico': responseInvData.precioPublico,
                  'precioSub': responseInvData.precioSub,
                  'totalArticulos': responseInvData.totalArticulos,
                  'idProducto': responseInvData.id
                });
              });
              $('#imei_cel').focus(); 
              $('#imei_cel').val('');
              
            }
            console.log(toTable);

            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                        return (!filter.series || tupla.series.indexOf(filter.series) > -1)
                        && (!filter.producto || tupla.producto.indexOf(filter.producto) > -1)
                        && (!filter.imeiSim || tupla.imeiSim.indexOf(filter.imeiSim) > -1)
                        && (!filter.imeiCel || tupla.imeiCel.indexOf(filter.imeiCel) > -1);
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
                  $("#jsgrid_table").jsGrid("destroy");
                  toTable = [];
                  return;
                } else {
                  console.log(callback);
                  swal("Nueva factura!", "Se ha generado una nueva factura", "success")
                  setTimeout(function(){
                    var href = "${createLink(controller: 'inventario', action: 'listarArticulos')}"
                    location.href = href;
                  }, 2000);
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
      <hr>
    </div>
    <div class="row">
      <form id="formulario" name="formulario">
        <div class="form-group">
          <label>FACTURA</label>
          <input type="text" class="form-control col-md-4" id="factura" name="fact">
        </div>
        <div class="form-group">
          <label>Producto</label>
          <input type='text'
           placeholder='Elige un producto de inventario'
           class='flexdatalist form-control col-md-4'
           data-min-length='1'
           data-value-property='id'
           list='inventarioList'
           name='inventarioId'>

           <datalist id="inventarioList">
              <g:each in="${Inventario.findAll()}" var="inventarioList">
                  <option value="${inventarioList.id}">${inventarioList.articulo}</option>
              </g:each>
          </datalist>
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
          <textarea type="textarea" class="form-control" id="imei" name="code"></textarea>
        </div>
        <div class="form-group">
          <label>IMEI</label>
          <textarea type="textarea" disabled class="form-control" id="imei_cel" name="imei_cel"></textarea>
        </div>
        <div class="form-group">
          <button type="button" id="aplicar" class="btn bttn-bordered bttn-primary bttn-sm">AGREGAR</button>&nbsp;&nbsp;&nbsp;
          <button type="button" id="limpiar" class="btn bttn-bordered bttn-primary bttn-sm">BORRAR</button>
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
        <button type="button" id="save_data" class="btn bttn-fill bttn-danger bttn-sm pull-right">GENERAR ORDEN</button>
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