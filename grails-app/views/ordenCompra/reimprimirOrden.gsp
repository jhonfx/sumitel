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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'iziModal.min.css')}"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <title>REIMPRIMIR NOTA</title>

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

       .btn-white {
        color: white;
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


               $("#datos_simseries").jsGrid({
                  width: "100%",
                  height: "800px",
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
                    console.log(rows)
                    if (rows.cancelada == 0) {

                    }
                    $('.btn-cancel').html('<span style="font-size: 22px;">TOTAL: '+ rows +'</span>')
                  },
                  
                  data: tuplas,
                  //controller: db2,
           
                  fields: [
                      { name: "numeroOrden", title: 'Orden', type: "number", width: 30, editing: false},
                      { name: "nombreCliente", title: 'Cliente', type: "text", width: 30, editing: false},
                      { name: "usuarioCreacion", title: 'Usuario', type: "text", width: 40, editing: false, filtering: true},
                      { name: "fechaCreacion", title: 'Fecha', type: "date", width: 40, filtering: false},
                      { title: 'Reimprimir', width: 10, editing: false,  itemTemplate: function(_, tupla) {

                        return $("<button type='button' id='reimprimirOrden-"+tupla.id+"' data-idtupla='"+ tupla.numeroOrden +"' data-idcliente='"+tupla.idCliente+"' class='btn bttn-bordered bttn-success bttn-sm'><i class='fa fa-print' aria-hidden='true'></i></button>").on("click", function(e) {

                          var target = $('#reimprimirOrden-'+tupla.id+'').data('idtupla');
                          console.log(target);

                          var href = "${createLink(controller: 'ordenCompra', action: 'printOrdenCompleta')}" +"?remision=" + target;
                          var specialurl = window.location.origin + href;
                          window.open(specialurl, '_blank');

                          

                          });
                        }
                      },
                      { title: 'Cancelar', width: 10, editing: false,  itemTemplate: function(_, tupla) {

                        if (tupla.cancelada === 1) {
                          return $("<button type='button' id='tuplaCancelada' class='btn bttn-bordered bttn-danger bttn-sm btn-cancel btn-white' disabled><i class='fa fa-close' aria-hidden='true'></i></button>")
                        } else {
                          return $("<button type='button' id='cancelarTupla-"+tupla.id+"' data-idtupla='"+ tupla.numeroOrden +"' data-idcliente='"+ tupla.idCliente +"' class='btn bttn-bordered bttn-success bttn-sm btn-cancel'><i class='fa fa-check' aria-hidden='true'></i></button>").on("click", function(e) {
                              $.ajax({
                                url: '${createLink(controller: "almacen", action:"cancelarOrdenCompra")}',
                                data: {id: tupla.numeroOrden, idcliente: tupla.idCliente},
                                type: "POST",
                                success: function(resp) {
                                    console.log(resp);
                                    location.reload()
                                },
                                error: function(err) {
                                  console.log(err)
                                  location.reload()
                                },
                                dataType: "json"
                              });
                            });
                          }
                        }
                      },
                    ]
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
      <h1>REIMPRIMIR ORDEN</h1>
      <hr>
  </div>
  <div class="row">
    &nbsp;
  </div>
  <div class="row">
      <div class="col-sm-12">
        <div id="datos_list"></div>
        <div id="datos_list_final"></div>
        <div id="datos_simseries" class="col-sm-12"></div>
        <div id="contenedor_sims" class="col-sm-"></div>
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