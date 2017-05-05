<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'ListaAlmacen')}" />
    
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'spin.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery.modal.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'accounting.min.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ring.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.modal.css')}"/>

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

    </style>


    <script type="text/javascript">

      $(document).ready( function() {
        console.log("inciando");
        $('#contenedor').hide();

        var response = [];
        $.ajax({
          url: "${createLink(controller: 'almacen', action:'obtenerAlmacen')}",
          type: "GET",
          beforeSend: function() {
            $('.div_cargando').show();
            
          },
          error: function() {
            console.log("tuvimos un error al cargar los datos")
          },
          success: function(json) {
            
            $('.div_cargando').hide();

            $('#button_tupla').on('click', function(e, target) {
              // console.log("dando click")
              var id = target.val();
              // console.log(id);
            })
            var tuplas = json.rows

            var tuplasFilter = _.filter(tuplas, function(tupla, index, tuplas) {
              return  tupla.imeiSim == '8952020516197792158'
            });

            // console.log(tuplasFilter);
            
            
            /*Start data for table*/
            $( function() {


            var result = json.rows;
            var tamanio = result.length
            var customHeight = 36*50;

      
            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                      // console.log(tupla)
                        return (!filter.numeroFactura || tupla.numeroFactura === filter.numeroFactura)
                        && (!filter.articulo || (tupla.articulo === filter.articulo))
                        && (!filter.remision || tupla.remision.indexOf(filter.remision) > -1)
                        && (!filter.imeiSim || tupla.imeiSim.indexOf(filter.imeiSim) > -1)
                        && (!filter.imeiCel || tupla.imeiCel.indexOf(filter.imeiCel) > -1);
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
                  // console.log("format date")
                  // console.log(value)
                    return new Date(value).toLocaleDateString();
                }
            });
         
            jsGrid.fields.myDateField = MyDateField;

              /* generate data table */
              $("#datos_list").jsGrid({
                width: "100%",
                height: "600px",

                confirmDeleting: false,
                deleteConfirm: "¿ Deseas borrar este artículo ?",

                filtering: true,
                editing: false,
                inserting: false,
                sorting: true,
                paging: true,
                autoload: true,
                pageSize: 80,
                pageButtonCount: 5,
                onDataLoaded: function(args) {
                  var rows = args.grid.data.length;
                  console.log(rows.length)
                  $('#totals_simseries').html('<span style="font-size: 22px;">TOTAL: '+ rows +'</span>')
                },
                
                //data: json.rows,
                controller: db,
         
                fields: [
                    { name: "numeroFactura", title: '# Factura', type: "number", width: 50, editing: false},
                    { name: "fechaCompra", title: 'Fecha Compra', type: "myDateField", width: 50, editing: false},
                    { name: "imeiSim", title: 'SIM / SERIE', type: "text", width: 100, editing: false, filtering: true},
                    { name: "edit", title: '', type: "text", width: 60, editing: false, filtering: true, itemTemplate: function(_, item) {
                      return item.remision;
                    }},
                    { name: "imeiCel", title: 'IMEI', type: "text", width: 100, editing: false, filtering: true},
                    { name: "articulo", title: 'Producto', type: "text", width: 150, editing: false, filtering: true},
                    { name: "remision", title: 'Remisión', type: "text", width: 100, editing: false, itemTemplate: function(_, item) {
                      return item.remision;
                    }},
                    { title: 'Info', width: 70, editing: false,  itemTemplate: function(_, item) {
                    return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' class='btn btn-primary btn-sm'>Ver Detalle</button>")
                      .on("click", function(e) {
                          console.log(item)

                          console.log("click en boton de descxripcion")
                          var target = $('#buttonTupla-'+item.id+'').data('idtupla');
                          console.log(target);

                          var results = $.each(db.tuplas, function(e, tupla) {
                            console.log(tupla)
                            if (tupla.id == target) {
                              $('#contenedor')
                              .append('<form>')
                              .append('<div class="form-group">')
                              .append('<label for="articulo">Producto:</label>')
                              .append('<input readonly type="text" class="form-control" id="articulo" value="'+ tupla.articulo +'"/>')
                              .append('<label for="costosub">Costo Sub:</label>')
                              .append('<input readonly type="text" class="form-control" id="costosub" value="'+ accounting.formatMoney(tupla.costoSub) +'"/> ')
                              .append('<label for="costounitario">Costo Unitario:</label>')
                              .append('<input readonly type="text" class="form-control" id="costounitario" value="'+ accounting.formatMoney(tupla.costoUnitario) +'"/> ')
                              .append('<label for="preciopublico">Precio publico:</label>')
                              .append('<input readonly type="text" class="form-control" id="preciopublico" value="'+ accounting.formatMoney(tupla.precioPublico) +'"/> ')
                              .append('<label for="preciopublico">Proveedor:</label>')
                              .append('<input readonly type="text" class="form-control" id="preciopublico" value="'+ tupla.proveedor +'"/> ')
                              .append('<label for="preciopublico">Almacén:</label>')
                              .append('<input readonly type="text" class="form-control" id="preciopublico" value="'+ tupla.almacen +'"/> ')
                              .append('<label for="preciopublico">Fecha Entrega:</label>')
                              .append('<input readonly type="text" class="form-control" id="preciopublico" value="'+ new Date(tupla.fechaEntrega).toLocaleDateString() +'"/> ')
                              .append('</div>')
                              .append('</form>')
                              $('#contenedor').modal('show');
                              var costouni = parseFloat($('#costounitario').val());
                              console.log(costouni);
                              var frm = accounting.formatMoney(costouni);
                              console.log(frm);
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
        


      });
    </script>
    
</head>
<body>
<div class="container"> 
  <div class="row">
    <div class="header">SUMITEL S.A DE C.V</div>
  </div>
  <div class="row">
      <h1>ALMACÉN</h1>
      <hr>
      <div id="datos_list"></div>
      <div id="totals_simseries"></div>
      <div>&nbsp</div>
      <div id="contenedor"></div>
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