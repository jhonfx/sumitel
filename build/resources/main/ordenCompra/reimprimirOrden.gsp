<%@ page import="sumitel.OrdenCompra" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Reimprimir Orden')}" />
    
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'spin.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery.modal.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'accounting.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'numeral.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ring.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.modal.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bttn.min.css')}"/>

    <title>ARTCULOS ALMACEN</title>

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

       

       #contenedor_sims {
        width: auto;
       }

    </style>


    <script type="text/javascript">


      $.ajax({
          url: "${createLink(controller: 'ordenCompra', action:'datosOrdenCompleta')}",
          type: "GET",
          error: function() {
            
          },
          success: function(json) {
            
            var tuplas = json
            console.log(tuplas);

            $(function(){
               (function() {
              
                var db2 = {

                  loadData: function(filter) {
                    
                    return $.grep(tuplas.rows, function(tupla) {
                        
                        if (filter.imeiSim === tupla.imeiSim) {
                          console.log("es el mismo");
                        }
                        // console.log(tupla)
                        return (!filter.imeiSim || tupla.imeiSim.indexOf(filter.imeiSim) > -1)
                    });
                  },

                };

                window.db2 = db2;
                db2.tuplas = tuplas.rows;
              }());

               $("#datos_simseries").jsGrid({
                  width: "750px",
                  height: "600px",
                  filtering: true,
                  editing: false,
                  inserting: false,
                  sorting: true,
                  paging: true,
                  autoload: true,
                  pageSize: 80,
                  pageButtonCount: 5,
                  
                  //data: imeiSimCel.rows,
                  controller: db2,
           
                  fields: [
                      { name: "factura", title: 'Factura', type: "number", width: 30, editing: false},
                      { name: "articulo", title: 'Articulo', type: "text", width: 30, editing: false},
                      { name: "imeiSim", title: 'SIM / SERIE', type: "text", width: 40, editing: false, filtering: true},
                      { title: 'Info', width: 20, editing: false,  itemTemplate: function(_, item) {

                      
                      }}
                  ]
                });
            });
          }
      });
    </script>
    
</head>
<body>
<div class="container "> 
  <div class="row">
    <div class="header">SUMITEL S.A DE C.V</div>
  </div>
  <div class="row">
      <h1>NOTA COMPLETA</h1>
      <hr>
  </div>
  <div class="row">
    &nbsp;
  </div>
  <div class="row">
      <div id="datos_list"></div>
      <div id="datos_list_final"></div>
      <div id="datos_simseries"></div>
      <div id="contenedor_sims" class="col-sm-"></div>
      <button type="button" id="aplicar_orden" class="btn bttn-fill bttn-danger bttn-sm pull-right">Aplicar</button>
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