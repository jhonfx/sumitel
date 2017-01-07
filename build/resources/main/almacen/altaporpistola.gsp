<%@ page import="sumitel.Almacen" %>
<%@ page import="sumitel.Proveedor" %>
<%@ page import="sumitel.Inventario" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
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
         background: #e8ebec !important;
         float: right;
      }

    </style>

    <script type="text/javascript">
      $(document).ready( function() {

        var responseInvData;

        $('#inventarioId').on('change', function(e) {
          console.log("lo cambie")
          var id = $(this).find('option:selected').val();
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
          });
        });

        var serie = $('#codigos').val();
        
        $('#imei').on('keypress', function(e, a){
          var selected = $('input:radio[name=inlineRadioOptions]:checked').val();
          var serie = $('#imei').val()

          if (serie.length == selected) {
            $('#aplicar').click();
            $('#imei').val('');
          }

         console.log(selected)
        //$('#aplicar').click();
          
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
          console.log(newobject);
          console.log(responseInvData.articulo)
          if (newobject == [""] || newobject == null || newobject.length == 0 || newobject == "") {
            console.log("esta vacio")
          } else {
            _.each(newobject, function(obj) {
              toTable.push({
                'series': obj,
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
                height: "400px",

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
                    { name: "factura", type: "text", width: 50, filtering: false, editing: false},
                    { name: "series", type: "text", width: 50, editing: false},
                    { name: "articulo", type: "text", width: 150, editing: false},
                    { name:  "precioUnitario", type: 'text', width: 30, filtering: false, editing: false},
                    { type: "control", editButton: false, filtering: false}
                ]

                
              });
            });
          }

        });

        $('#limpiar').click( function(e) {
          console.log("limpiando");
          toTable = [];
          $('#table_here').html("");
          // $("#jsgrid_table").jsGrid("refresh");
          // $('#table_here').html(template({toTable}));
        });



        $('#save_data').click( function(e) {
          console.log(toTable);
          var testjson = JSON.stringify({series: toTable})
          console.log(testjson);

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
  <!---div class="row">
    <div class="header">header</div>
  </div--->
  
    <div class="row">
      <h1>AGREGAR PRODUCTOS</h1>
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
            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="15"> EQUIPO
          </label>
          <label class="radio-inline">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="13"> CHIP
          </label>
          <label class="radio-inline">
            <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="12"> TARJETA
          </label>
        </div>

        <div class="form-group col-sm-8">
          <label>IMEI / SERIE</label>
          <input type="text" class="form-control" id="imei" name="code"></input>
        </div>
        <div class="form-group col-sm-12">
          <button type="button" id="aplicar" class="btn">AGREGAR</button>
          <button type="button" id="limpiar" class="btn">BORRAR</button>
        </div>
      </form>
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
        ${name}
        <button type="button" id="save_data" class="btn pull-right">GENERAR ORDEN</button>
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