<%@ page import="sumitel.Cliente" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Almacen')}" />
    
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

      $(document).ready( function() {
        console.log("inciando");
        

        var response = [];
        var imeiSimCel = [];
        var id_tupla_odc;
        var id_sim_serie;
        var obj_seleccionados = [];
        var imeis = [];
        var series = [];
        var ids = [];
        //Aplica la orden de compra
        $('#aplicar_orden').on('click', function() {
          var clent = $('#client_name').val();
          console.log(clent)
          if (clent == "") {
            swal({
              title: "Error",
              text: "Debe seleccionar un cliente",
              allowEscapeKey: true,
              imageSize: "20x20"
            });
            return;
          }
          
          
          $.each(obj_seleccionados, function(e, tpla) {
              ids.push({'id': tpla.id})
            if (tpla.id_sim_serie !== undefined) {
              ids.push({'id': tpla.id_sim_serie});
            }
          });
          
          

          //Generar orden e imprimir
          $.ajax({
            url: "${createLink(controller: 'ordenCompra', action:'generarOrdenCompleta')}",
            // data: {imeis: imeis, seriesim: series, name: "Karen Medina", ciudad: "Toluca", estado: "Mexico"},
            data: {idCliente: clent, obj: JSON.stringify(obj_seleccionados), name: $('#name').val(), ciudad: $('#ciudad').val(), estado: $('#estado').val(), ids: JSON.stringify(ids)},
            type: "POST",
            success: function(json) { 
              
              ids =[]; 

              
                var href = "${createLink(controller: 'ordenCompra', action: 'printOrdenCompleta')}" +"?remision=" + json.remision;
                var specialurl = window.location.origin + href;
                console.log(specialurl);
                window.open(specialurl, '_blank');

                var href = "${createLink(controller: 'almacen', action: 'listaparaorden')}";
                var specialurl = window.location.origin + href;
                location.reload()

                // var href2 = "${createLink(controller: 'inventario', action: 'listarArticulos')}"
                // location.href = href2;
            }
          });
        });

        //Info del cliente que va en el combo box
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
        //Termina info del cliente

        //Carga inicial de los datos del almacen
        $.ajax({
          url: "${createLink(controller: 'almacen', action:'obtenerAlmacen2')}",
          type: "GET",
          error: function() {
            
          },
          success: function(json) {
            console.log("almacen")
            console.log(json);

            $('.div_cargando').hide();
            $("#contenedor_sims").hide();

            $.ajax({
              url: "${createLink(controller: 'almacen', action:'obtenerArticulosDos')}",
              type: "GET",
              error: function() {
                
              },
              success: function(json) {
                
                imeiSimCel = json;
                
                console.log(obj_seleccionados);
                console.log(imeiSimCel)

                $(function() {

                  (function() {
              
                    var db2 = {

                      loadData: function(filter) {
                        
                          return $.grep(imeiSimCel.rows, function(tupla) {
                              
                              if (filter.imeiSim === tupla.imeiSim) {
                                console.log("es el mismo");
                              }
                              // console.log(tupla)
                              return (!filter.imeiSim || tupla.imeiSim.indexOf(filter.imeiSim) > -1)
                          });
                      },

                    };

                    window.db2 = db2;
                    db2.tuplas = imeiSimCel.rows;
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

                          return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' data-idserie='"+ item.imeiSim +"' class='btn bttn-bordered bttn-success bttn-sm'>OK</button>")
                            .on("click", function(e) {

                                var target = $('#buttonTupla-'+item.id+'').data('idtupla');
                                $.each(imeiSimCel.rows, function(e, tupla) {
                                  if (target == tupla.id) {
                                    
                                    $.each(obj_seleccionados, function(e, row) {
                                      
                                      if (id_tupla_odc == row.id) {
                                        row.seriesim = tupla.imeiSim;
                                        row.id_sim_serie = tupla.id;
                                        $("#datos_list_final").jsGrid("refresh");
                                      }
                                    })
                                  }
                                })

                            });
                          }}
                      ]
                  });
                });


                  $("#contenedor_sims").append($('#datos_simseries'));
              }
            });

            /*Start data for table*/
            $( function() {


            var result = json.rows;
            
            

      
            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                      
                        return (!filter.numeroFactura || tupla.numeroFactura === filter.numeroFactura)
                        && (!filter.articulo || tupla.articulo.indexOf(filter.articulo) > -1)
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
                  
                    return new Date(value).toLocaleDateString();
                }
            });

            function MoneyField(config) {
                jsGrid.NumberField.call(this, config);
            }

            MoneyField.prototype = new jsGrid.NumberField({

                itemTemplate: function(value) {
                  var string = numeral(value).format('$0,0');
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
            
            

            jsGrid.fields.myDateField = MyDateField;

              /* generate data table */
              $("#datos_list").jsGrid({
                width: "100%",
                height: "600px",

                confirmDeleting: false,
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
                    { name: "imeiCel", title: 'IMEI', type: "text", width: 100, editing: false, filtering: true},
                    { name: "articulo", title: 'Producto', type: "text", width: 150, editing: false, filtering: true},
                    { name: "remision", title: 'Remisión', type: "text", width: 100, editing: false, itemTemplate: function(_, item) {
                      return item.remision;
                    }},
                    { title: 'Info', width: 70, editing: false,  itemTemplate: function(_, item) {
                    return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' class='btn bttn-bordered bttn-success bttn-sm'>OK</button>")
                      .on("click", function(e) {

                          var target = $('#buttonTupla-'+item.id+'').data('idtupla');
                          var btn = $('#buttonTupla-'+item.id+'');
                          console.log(target);

                          $.each(db.tuplas, function(e, tupla) {
                            if (tupla.id == target) {
                              console.log(tupla);
                              obj_seleccionados.push({ 
                                id: tupla.id, 
                                article: tupla.articulo, 
                                preciounitario: tupla.precioUnitario,
                                preciopublico: tupla.precioPublico,
                                seriesim: tupla.imeiSim,
                                imei: tupla.imeiCel,
                                asignado: true
                              });
                              console.log(obj_seleccionados)
                              btn.attr('disabled', 'disabled');
                              $("#datos_list_final").jsGrid("refresh");
                            } 
                          });
                      });
                    }}
                ]

                
              });

              $("#datos_list_final").jsGrid({
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
                
                data: obj_seleccionados,
                //controller: db2,
         
                fields: [
                    { name: "id", title: 'Id Almacen', type: "text", width: 10, editing: false},
                    { name: "article", title: 'Equipo', type: "text", width: 100, editing: false},
                    { name: "imei", title: 'IMEI', type: "number", width: 100, editing: false},
                    { name: "seriesim", title: 'SIM/SERIE', type: "number", width: 100, editing: false},
                    { name: "telefono", title: 'Telefono', type: "number", width: 50, editing: false},
                    { name: "preciounitario", title: 'Precio', type: "money", width: 70, editing: false},
                    { name: "preciopublico", title: 'P/P', type: "money", width: 70, editing: false},
                    { title: 'Info', width: 120, editing: false,  itemTemplate: function(_, item) {
        
                    return item.imei === "0" ? "" : $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' class='btn bttn-bordered bttn-success bttn-sm btn-add-sim'>Agregar SIM</button>")
                      .on("click", function(e) {
                        
                            var target = $('#buttonTupla-'+item.id+'').data('idtupla');
                            
                            $.each(obj_seleccionados, function(e, tupla) {
                                console.log(obj_seleccionados);
                              if (target == tupla.id) {

                                  id_tupla_odc = target;
                                  id_sim_serie = tupla.id;

                                  $('#contenedor_sims').modal('show');
                                  $('#datos_simseries').jsGrid("refresh");
                                  //$("#datos_list_final").jsGrid("refresh");
                              }
                            })

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
<div class="container "> 
  <div class="row">
    <div class="header">SUMITEL S.A DE C.V</div>
  </div>
  <div class="row">
      <h1>NOTA COMPLETA</h1>
      <hr>
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
  <div class="row">
    &nbsp;
  </div>
  <div class="row">
      <div id="datos_list"></div>
      <div id="totals_simseries"></div>
      <div>&nbsp</div>
      <hr>
      <div id="datos_list_final"></div>
      <div id="datos_simseries">
      </div>

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