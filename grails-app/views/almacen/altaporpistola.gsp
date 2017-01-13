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


    <title>CARGA DE ARTICULOS</title>

    <style type="text/css">
      
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
         font-family: 'Raleway',sans-serif;
      }

       h1 { color: black; font-family: 'Raleway',sans-serif; font-size: 35px; font-weight: 800; line-height: 55px; margin: 0 0 4px; text-align: center; text-transform: uppercase; 
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
                $('input:radio[name=inlineRadioOptions]').removeAttr('checked');
              } else {
                $('#imei_cel').attr('disabled', 'disabled');
                $('#imei_cel').val('');
                $('#imei_cel').removeAttr('required');
                $('input:radio[name=inlineRadioOptions]').removeAttr('checked');
              }

          });
        });

        var serie = $('#codigos').val();

        
        var ss = 0;
        $('input:radio[name=inlineRadioOptions]').on('change', function() {
          ss = $('input:radio[name=inlineRadioOptions]:checked').val();
          console.log(ss);
        });
        
        $('#imei').on('focus', function() {
          if (ss == 0) {
            swal({
              title: "Error",
              type: "error",
              text: "Debe seleccionar el tipo de producto",
              allowEscapeKey: true,
              imageSize: "20x20"
            });
            return;
          }
        });
        
        //Funcion para agregar automaticamente
        $('#imei').on('keypress', function(e, a){
          var selected = $('input:radio[name=inlineRadioOptions]:checked').val();

          var serie = $('#imei').val()
          
          if (serie.length == 13) {
            console.log("aqui");
            $('#imei_cel').focus();
          } else if (serie.length == selected) {
            $('#aplicar').click();
            $('#imei').val('');
          }

         console.log(selected)
        //$('#aplicar').click();
          
        });
        //termina funcion
        $('#imei_cel').on('keypress', function(e, a){
          var imei_cel = $('#imei_cel').val();

          if(imei_cel.length == 15) {
              console.log(imei_cel.length);
              $('#aplicar').click();
              $('#imei').focus();
              $('#imei').val('');
              $('#imei_cel').val('');
            }
        })


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
                'idProducto': responseInvData.id
              });
            });

            $('#codigos').val('');
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

                confirmDeleting: true,
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
                    { name:  "precioUnitario", title: "Precio", type: 'text', width: 30, filtering: false, editing: false},
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
        });



        $('#save_data').click( function(e) {
          console.log(toTable);
          var testjson = JSON.stringify({series: toTable})
          console.log(testjson);
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
                data: {'tuplas': JSON.stringify(toTable)},
                type:"POST",
                success:function (callback) {
                  console.log(callback)
                   var href = "${createLink(controller: 'almacen', action: 'listaAlmacen')}"
                   location.href = href;
                },
                error:function (json) {
                    console.log("pos hubo un error" + json)
                },
                dataType:"json"
            });
        })
      });
      

    </script>
</head>
<body>
<div class="container"> 
  <div class="row">
    <div class="header">SUMITEL S.A DE C.V</div>
  </div>
  
    <div class="row">
      <h1>AGREGAR PRODUCTOS</h1>
      <hr>
    </div>
    <div class="row">
      <form id="formulario">
        <div class="form-group col-sm-4">
          <label>FACTURA</label>
          <input type="text" class="form-control" id="factura" name="fact">
        </div>
        <div class="form-group col-sm-4">
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
        <div class="form-group col-sm-4">
          <label>Proveedor</label>
          <g:select name="proveedorId" class="form-control"
            from="${Proveedor.findAll()}"
            optionKey="id" optionValue="nombreProveedor"
            noSelection="${['':'Seleccione...']}"/>
        </div>
        <div class="form-group col-sm-4">
          <label class="radio-inline">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="13"> EQUIPO
          </label>
          <label class="radio-inline">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="19"> CHIP
          </label>
          <label class="radio-inline">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="19"> TARJETA
          </label>
        </div>

        <div class="form-group col-sm-8">
          <label>SIM / SERIE</label>
          <input type="text" class="form-control" id="imei" name="code"></input>
        </div>

        <div class="form-group col-sm-4">
          &nbsp;
        </div>
        <div class="form-group col-sm-8">
          <label>IMEI</label>
          <input type="text" disabled class="form-control" id="imei_cel" name="imei_cel" maxlength="15"></input>
        </div>
        <div class="form-group col-sm-12">
          <button type="button" id="aplicar" class="btn btn-xs blue">AGREGAR</button>&nbsp;&nbsp;&nbsp;
          <button type="button" id="limpiar" class="btn btn-xs red">BORRAR</button>
        </div>
    </div>
    <div class="row">
      <div class="col-sm-12 col-md-12">
        <div id="jsgrid_table">
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-8"></div>
      <div class="col-md-4">
        <button type="button" id="save_data" class="btn btn-sm green pull-right">GENERAR ORDEN</button>
      </div>
    </div>
    </form>
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