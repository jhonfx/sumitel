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
        width: 700px;
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

        $('#aplicar_orden').on('click', function() {
          console.log(obj_seleccionados);
          $.each(obj_seleccionados, function(e, tpla) {
              ids.push({'id': tpla.id})
            if (tpla.id_sim_serie !== undefined) {
              ids.push({'id': tpla.id_sim_serie});
            }
          });
          console.log(ids);
          console.log(obj_seleccionados);

          $.ajax({
            url: "${createLink(controller: 'ordenCompra', action:'generarOrdenCompleta')}",
            // data: {imeis: imeis, seriesim: series, name: "Karen Medina", ciudad: "Toluca", estado: "Mexico"},
            data: {obj: JSON.stringify(obj_seleccionados), name: $('#name').val(), ciudad: $('#ciudad').val(), estado: $('#estado').val(), ids: JSON.stringify(ids)},
            type: "POST",
            success: function(json) { 
              console.log(json)
              ids =[]; 
              //var href = "${createLink(controller: 'ordenCompra', action: 'printOrden')}" +"?factura=" + json.factura;
              //location.href = href;
              //window.open(href, '_blank');

              console.log(json)
                var href = "${createLink(controller: 'ordenCompra', action: 'printOrdenCompleta')}" +"?remision=" + json.remision;
                //location.href = href;
                window.open(href, '_blank');
            }
          });
        });


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


        $.ajax({
          url: "${createLink(controller: 'almacen', action:'obtenerAlmacen2')}",
          type: "GET",
          error: function() {
            console.log("tuvimos un error al cargar los datos")
          },
          success: function(json) {
            
            $('.div_cargando').hide();
            $("#contenedor_sims").hide();

            $.ajax({
              url: "${createLink(controller: 'almacen', action:'obtenerArticulosDos')}",
              type: "GET",
              error: function() {
                console.log("hay error?")
              },
              success: function(json) {
                
                imeiSimCel = json;

                $("#datos_simseries").jsGrid({
                      width: "650px",
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
                      
                      data: imeiSimCel.rows,
                      //controller: db,
               
                      fields: [
                          { name: "factura", title: 'Factura', type: "number", width: 30, editing: false},
                          { name: "articulo", title: 'Articulo', type: "text", width: 30, editing: false},
                          { name: "imeiSim", title: 'SIM / SERIE', type: "number", width: 30, editing: false, filtering: true},
                          { title: 'Info', width: 20, editing: false,  itemTemplate: function(_, item) {

                          return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' data-idserie='"+ item.imeiSim +"' class='btn bttn-bordered bttn-success bttn-sm'>OK</button>")
                            .on("click", function(e) {

                                var target = $('#buttonTupla-'+item.id+'').data('idtupla');
                                $.each(imeiSimCel.rows, function(e, tupla) {
                                  if (target == tupla.id) {
                                    console.log(tupla);
                                    console.log(id_tupla_odc)
                                    console.log(id_sim_serie)
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

                //Tabla dinamica
                // var table = $("<table class='row col-md-6'></table>").attr("id", "simSerie_table").attr("name", "simSerie");
                //   $.each(imeiSimCel.rows, function (i, el) {
                //       table.append("<tr>");
                //         table.append("<td>" + el.articulo + "</td>");
                //         table.append("<td>" + el.imeiSim + "</td>");
                //         table.append("<td><button type='button' class='btn' id='"+el.id+"'>Aplicar</button></td>");
                //       table.append("</tr>");
                //   });
                  $("#contenedor_sims").append($('#datos_simseries'));
              }
            });

            $('#button_tupla').on('click', function(e, target) {
              // console.log("dando click")
              var id = target.val();
              // console.log(id);
            })
            var tuplas = json.rows

            /*Start data for table*/
            $( function() {


            var result = json.rows;
            
            

      
            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                      // console.log(tupla)
                        return (!filter.numeroFactura || tupla.numeroFactura === filter.numeroFactura)
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
                    { name: "imeiSim", title: 'SIM / SERIE', type: "text", width: 100, editing: false, filtering: true},
                    { name: "imeiCel", title: 'IMEI', type: "text", width: 100, editing: false, filtering: true},
                    { name: "articulo", title: 'Producto', type: "text", width: 150, editing: false, filtering: false},
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
                                imei: tupla.imeiCel
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
                //controller: db_final,
         
                fields: [
                    { name: "id", title: 'Id Almacen', type: "text", width: 10, editing: false},
                    { name: "article", title: 'Equipo', type: "text", width: 100, editing: false},
                    { name: "imei", title: 'IMEI', type: "number", width: 100, editing: false},
                    { name: "seriesim", title: 'SIM/SERIE', type: "number", width: 100, editing: false},
                    { name: "telefono", title: 'Telefono', type: "number", width: 50, editing: false},
                    { name: "preciounitario", title: 'Precio', type: "number", width: 70, editing: false},
                    { name: "preciopublico", title: 'P/P', type: "number", width: 70, editing: false},
                    { title: 'Info', width: 120, editing: false,  itemTemplate: function(_, item) {
                    return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' class='btn bttn-bordered bttn-success bttn-sm'>Agregar SIM</button>")
                      .on("click", function(e) {
                        console.log(imeiSimCel);
                            var target = $('#buttonTupla-'+item.id+'').data('idtupla');
                            

                            console.log(target)
                            $.each(obj_seleccionados, function(e, tupla) {
                                console.log(tupla.id)
                              if (target == tupla.id) {
                                console.log("son los mismos");
                                console.log(tupla)
                                //tupla.seriesim = '8952020216690926011'
                                  id_tupla_odc = target;
                                  id_sim_serie = tupla.id;

                                  $('#contenedor_sims').modal('show');

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
      <div id="datos_list_final"></div>
      <div id="datos_simseries"></div>
      <div id="contenedor_sims"></div>
      <button type="button" id="aplicar_orden" class="btn pull-right">Aplicar</button>
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