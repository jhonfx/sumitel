<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Almacen')}" />
    
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery-1.8.3.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>

    <title>LISTAR ARTCULOS</title>
    <script type="text/javascript">
      $(document).ready( function() {
        console.log("inciando");
        
        var response = [];
        $.ajax({
          url: "${createLink(controller: 'almacen', action:'listaalmacen')}",
          type: "GET",
          success: function(json) {
            console.log(json.rows)
            $( function() {

              /* generate data table */
              $("#datos_list").jsGrid({
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
                
                data: json.rows,
                // controller: db,
         
                fields: [
                    { name: "factura", type: "text", width: 50, filtering: false, editing: false},
                    { name: "serie", type: "text", width: 50, editing: false},
                    { name: "descripcion", type: "text", width: 150, editing: false},
                    { type: "control", editButton: false, filtering: false}
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
    <div class="row">
      sdadsa
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