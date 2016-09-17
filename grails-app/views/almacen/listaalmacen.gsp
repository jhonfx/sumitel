<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Almacen')}" />
    
    
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'spin.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery-1.8.3.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery.modal.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ring.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.modal.css')}"/>

    <title>LISTAR ARTCULOS</title>

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
      

      var opts = {
          lines: 13 // The number of lines to draw
        , length: 28 // The length of each line
        , width: 14 // The line thickness
        , radius: 42 // The radius of the inner circle
        , scale: 1 // Scales overall size of the spinner
        , corners: 1 // Corner roundness (0..1)
        , color: '#000' // #rgb or #rrggbb or array of colors
        , opacity: 0.25 // Opacity of the lines
        , rotate: 0 // The rotation offset
        , direction: 1 // 1: clockwise, -1: counterclockwise
        , speed: 1 // Rounds per second
        , trail: 60 // Afterglow percentage
        , fps: 20 // Frames per second when using setTimeout() as a fallback for CSS
        , zIndex: 0 // The z-index (defaults to 2000000000)
        , className: 'spinner' // The CSS class to assign to the spinner
        , top: '300px'
        , left: '50%' // Left position relative to parent
        , shadow: false // Whether to render a shadow
        , hwaccel: false // Whether to use hardware acceleration
        , position: 'absolute' // Element positioning
      }


      $(document).ready( function() {
        console.log("inciando");
        $('#contenedor').hide();

        var response = [];
        $.ajax({
          url: "${createLink(controller: 'almacen', action:'obtenerAlmacen')}",
          type: "GET",
          beforeSend: function() {
            $('#spin').show()
            
          },
          error: function() {
            console.log("tuvimos un error al cargar los datos")
          },
          success: function(json) {
            console.log(json.rows)
            $('#spin').hide()

            $('#button_tupla').on('click', function(e, target) {
              console.log("dando click")
              var id = target.val();
              console.log(id);
            })
            var tuplas = json.rows

            var tuplasFilter = _.filter(tuplas, function(tupla, index, tuplas) {
              return  tupla.imeiSim == '8952020516197792158'
            });

            console.log(tuplasFilter);
            
            
            /*Start data for table*/
            $( function() {


            var result = json.rows;
            var tamanio = result.length
            var customHeight = 36*30;

      
            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                      console.log(tupla)
                        return (!filter.numeroFactura || tupla.numeroFactura === filter.numeroFactura)
                        && (!filter.imeiSim || tupla.imeiSim.indexOf(filter.imeiSim) > -1);
                    });
                },

              };

              window.db = db;
              db.tuplas = result;
            }());

    var MyDateField = function(config) {
        jsGrid.Field.call(this, config);
    };

    MyDateField.prototype = new jsGrid.Field({
        sorter: function(date1, date2) {
            return new Date(date1) - new Date(date2);
        },
 
        itemTemplate: function(value) {
          console.log("format date")
          console.log(value)
            return new Date(value).toLocaleDateString();
        }
    });
 
    jsGrid.fields.myDateField = MyDateField;

              /* generate data table */
              $("#datos_list").jsGrid({
                width: "100%",
                height: "600px",

                confirmDeleting: true,
                deleteConfirm: "¿ Deseas borrar este artículo ?",

                filtering: true,
                editing: false,
                inserting: false,
                sorting: true,
                paging: true,
                autoload: true,
                pageSize: 80,
                pageButtonCount: 5,
                
                //data: json.rows,
                controller: db,
         
                fields: [
                    { name: "numeroFactura", title: '# Factura', type: "number", width: 50, editing: false},
                    { name: "fechaCompra", title: 'Fecha Compra', type: "myDateField", width: 50, editing: false},
                    { name: "imeiSim", title: 'Imei / Sim', type: "text", width: 100, editing: false, filtering: true},
                    { name: "articulo", title: 'Producto', type: "text", width: 150, editing: false, filtering: false},
                    { name: "remision", title: 'Remisión', type: "text", width: 100, editing: false, itemTemplate: function(_, item) {
                      return item.remision;
                    }},
                    { title: 'Info', width: 70, editing: false,  itemTemplate: function(_, item) {
                    return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' class='btn btn-primary btn-sm'>Ver Detalle</button>")
                      .on("click", function(e) {
                          //alert(item.imeiSim)

                          console.log("click en boton de descxripcion")
                          var target = $('#buttonTupla-'+item.id+'').data('idtupla');
                          var results = $.each(db.tuplas, function(e, tupla) {

                            if (tupla.id == target) {
                              $('#contenedor')
                              .append('<form>')
                              .append('<div class="form-group">')
                              .append('<label for="articulo">Producto:</label>')
                              .append('<input readonly type="text" class="form-control" id="articulo" value="'+ tupla.articulo +'"/>')
                              .append('<label for="costosub">Costo Sub:</label>')
                              .append('<input readonly type="text" class="form-control" id="costosub" value="'+ tupla.costoSub +'"/> ')
                              .append('<label for="costounitario">Costo Unitario:</label>')
                              .append('<input readonly type="text" class="form-control" id="costounitario" value="'+ tupla.costoUnitario +'"/> ')
                              .append('<label for="preciopublico">Precio publico:</label>')
                              .append('<input readonly type="text" class="form-control" id="preciopublico" value="'+ tupla.precioPublico +'"/> ')
                              .append('<label for="preciopublico">Proveedor:</label>')
                              .append('<input readonly type="text" class="form-control" id="preciopublico" value="'+ tupla.proveedor +'"/> ')
                              .append('<label for="preciopublico">Almacén:</label>')
                              .append('<input readonly type="text" class="form-control" id="preciopublico" value="'+ tupla.almacen +'"/> ')
                              .append('<label for="preciopublico">Fecha Entrega:</label>')
                              .append('<input readonly type="text" class="form-control" id="preciopublico" value="'+ new Date(tupla.fechaEntrega).toLocaleDateString() +'"/> ')
                              .append('</div>')
                              .append('</form>')
                              $('#contenedor').modal('show');
                            }
                          });


                          $('#contenedor').on($.modal.BEFORE_CLOSE, function(event, modal) {
                            $('#contenedor').html("");
                            console.log("cerrando");
                          });                          

                      });
                    }}
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
  <div class="row">
    <div class="header">SUMITEL S.A DE C.V</div>
  </div>
  <div class="col-sm-6 col-md-7">
    <div class="row">
      <h1>LISTA ALMACEN</h1>
    </div>
    <div id="spin" class='uil-ring-css' style='transform:scale(0.99);'><div></div></div>
    <div class="row" id="datos_list">
    </div>
    <div class="row">
      <div class="modal" id="contenedor">
      
    </div>
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