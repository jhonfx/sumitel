<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Inventario')}" />

    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'underscore.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'spin.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery.modal.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'numeral.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'accounting.min.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ring.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.modal.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bttn.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'iziModal.min.css')}"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <!--link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"-->

    <title>INVENTARIO</title>
    <script type="text/javascript">
      $(document).ready( function() {

        // if (sessionStorage.activo == "true") {
        //   $('#icon_menu').show();
        //   $('#logout').show();
        // } else {
        //   window.location.href = "/";
        // }
        console.log("inciando");
        $('#contenedor').hide();
        
        var response = [];
        $.ajax({
          url: "${createLink(controller: 'inventario', action:'obtenerListaArticulos')}",
          type: "GET",
          success: function(json) {

            var result = json.rows;
            var tamanio = result.length
            var customHeight = 36*30;

            /* load data using filter controller */
            (function() {
              
              var db = {

                loadData: function(filter) {
                    return $.grep(this.tuplas, function(tupla) {
                        return (!filter.articulo || tupla.articulo.indexOf(filter.articulo) > -1)
                        && (!filter.totalArticulos || tupla.totalArticulos == filter.totalArticulos)
                        && (!filter.precioPublico || tupla.precioPublico == filter.precioPublico)
                        && (!filter.precioUnitario || tupla.precioUnitario == filter.precioUnitario)
                        && (!filter.costoPublico || tupla.costoPublico == filter.costoPublico)
                        && (!filter.costoUnitario || tupla.costoUnitario == filter.costoUnitario)
                        // && (!filter.fechaCreacion.from || new Date(tupla.fechaCreacion) >= filter.fechaCreacion.from) 
                        // && (!filter.fechaCreacion.to || new Date(tupla.fechaCreacion) <= filter.fechaCreacion.to)
                    });
                },

              };

              window.db = db;
              db.tuplas = result;
              console.log(result)
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


            $( function() {

              /* generate data table */
              $("#datos_list").jsGrid({
                width: "100%",
                height: customHeight,

                confirmDeleting: false,
                deleteConfirm: "¿ Deseas borrar este artículo ?",

                filtering:true,
                editing: true,
                sorting: true,
                paging: true,
                autoload: true,

                pageSize: 30,
                pageButtonCount: 5,
                
                //data: json.rows,
                controller: db,
         
                fields: [
                    { name: "articulo", filtering: true, title:'Producto', type: "text", width: 80,  editing: false},
                    { name: "precioPublico", filtering: true, title:'Precio Publico', type: "money", width: 30,  editing: false },
                    { name: "precioUnitario", filtering: false,title: 'Precio Unitario', type: "money", width: 30,  editing: false},
                    { name: "precioSub", filtering: false,title: 'Precio Sub', type: "money", width: 30,  editing: false},
                    { name: "totalArticulos", filtering: true, title: 'Total', type: "number", width: 20,  editing: false},
                    { name: "costoPublico", filtering: true, title: 'Costo Publico',type: "money", width: 30,  editing: false},
                    { name: "costoUnitario", filtering: false, title: 'Costo Unitario', type: "money", width: 30,  editing: false},
                    { name: "costoSub", filtering: false, title: 'Costo Sub', type: "money", width: 30,  editing: false},
                    { title: '-', width: 10, editing: false, itemTemplate: function(_, item) {
                      
                        return item.totalArticulos == 0 ? $("<button type='button' id='buttonCancelar-"+item.id+"' data-articulo='"+item.articulo+"' data-idtupla='"+item.id+"' data-estatus='"+item.activo+"' class='btn bttn-bordered bttn-danger bttn-sm'><i class='fa fa-trash' aria-hidden='true'></i></button>").on('click', function(e) {
                            var target = $('#buttonCancelar-'+item.id+'').data('idtupla');
                            var estatus = $('#buttonCancelar-'+item.id+'').data('estatus');
                            var articulo = $('#buttonCancelar-'+item.id+'').data('articulo');
                            console.log(target);
                            console.log(estatus);
                            console.log(item.totalArticulos)

                            $.ajax({
                              url: "${createLink(controller: 'inventario', action:'borrarArticulo')}",
                              data: {id: target},
                              success: function(json) {
                                swal({
                                  title: "Borrar articulo",
                                  type: "warning",
                                  text: "El  " + articulo+"  ha sido borrado",
                                  allowEscapeKey: true,
                                });
                                setTimeout( function() {
                                  location.reload();
                                }, 3000);
                              }
                            });
                          }) : $("<button type='button' id='buttonCancelar-"+item.id+"' data-articulo='"+item.articulo+"' data-idtupla='"+item.id+"' data-estatus='"+item.activo+"' class='btn bttn-bordered bttn-success bttn-sm'><i class='fa fa-check' aria-hidden='true'></i></button>").on('click', function(e) {
                            var target = $('#buttonCancelar-'+item.id+'').data('idtupla');
                            var estatus = $('#buttonCancelar-'+item.id+'').data('estatus');
                            var articulo = $('#buttonCancelar-'+item.id+'').data('articulo');
                            console.log(target);
                            console.log(estatus);
                            console.log(item.totalArticulos)
                            if (item.totalArticulos !== 0) {
                              swal({
                                title: "Error",
                                type: "warning",
                                text: "El articulo aun cuenta con stock",
                                allowEscapeKey: true,
                              });
                              return;
                            } else {
                              $.ajax({
                                url: "${createLink(controller: 'inventario', action:'borrarArticulo')}",
                                data: {id: target},
                                success: function(json) {
                                  swal({
                                    title: "Borrar articulo",
                                    type: "warning",
                                    text: "El  " + articulo+"  ha sido borrado",
                                    allowEscapeKey: true,
                                  });
                                  setTimeout( function() {
                                    location.reload();
                                  }, 3000);
                                }
                              });
                            }

                      });
                    }},
                    { title: 'Info', width: 15, editing: false,  itemTemplate: function(_, item) {
                          return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' data-idserie='"+ item.imeiSim +"' class='btn bttn-bordered bttn-success bttn-sm pull-right'><i class='fa fa-edit' aria-hidden='true'></i></button>")
                            .on("click", function(e) {
                                var target = $('#buttonTupla-'+item.id+'').data('idtupla');

                                $.ajax({
                                  url: "${createLink(controller: 'inventario', action:'searchByArticle')}",
                                  data: {id: target},
                                  type: "POST",
                                  success: function(json) { 
                                    
                                    //console.log(json)
                                    var results = $.each(db.tuplas, function(e, tupla) {
                                      console.log(tupla.id);
                                      console.log(target)
                                      if (tupla.id == target) {
                                          $('#contenedor')
                                            .append('<form>')
                                            .append('<div class="form-group">')
                                            .append('<label for="articulo">Producto:</label>')
                                            .append('<input type="text" class="form-control" id="articulo" value="'+ tupla.articulo +'"/>')
                                            .append('<label for="costosub">Precio Publico:</label>')
                                            .append('<input  type="text" class="form-control" id="pp" value="'+ tupla.precioPublico +'"/> ')
                                            .append('<label for="costounitario">Precio Unitario:</label>')
                                            .append('<input  type="text" class="form-control" id="pu" value="'+ tupla.precioUnitario +'"/> ')
                                            .append('<label for="preciopublico">Precio Sub:</label>')
                                            .append('<input  type="text" class="form-control" id="ps" value="'+ tupla.precioSub +'"/> ')
                                            .append('<br>')
                                            .append('<button type="button" class="btn bttn-bordered bttn-primary bttn-sm pull-right" id="update_article">Actualizar</button>')
                                            .append('</div>')
                                            .append('</form>')
                                            $('#contenedor').modal('show');

                                            //Funcion para actualizar valores del articulo
                                            $('#update_article').click( function()  {
                                              console.log("click update")
                                              $.ajax({
                                                url: "${createLink(controller: 'inventario', action:'editArticle')}",
                                                data: {id: target, art: $('#articulo').val(), pp: $('#pp').val(), pu: $('#pu').val(), ps: $('#ps').val()},
                                                type: "POST",
                                                success: function(json) {
                                                  console.log(json);
                                                  //$('#contenedor').modal('hide')
                                                  var href2 = "${createLink(controller: 'inventario', action: 'listarArticulos')}"
                                                  location.href = href2;
                                                }
                                              });
                                            });


                                            var costouni = parseFloat($('#costounitario').val());
                                            console.log(costouni);
                                            var frm = accounting.formatMoney(costouni);
                                            console.log(frm);
                                      }
                                    })
                                  }
                                });
                                
                                $('#contenedor').on($.modal.BEFORE_CLOSE, function(event, modal) {
                                  $('#contenedor').html("");
                                  $('#datos_list').jsGrid("refresh");
                                  console.log("cerrando");
                                }); 
                                //searchByArticle

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
    <style type="text/css">
        @font-face {
          font-family: specialFont;
          src: url(${resource(dir: 'fonts', file: 'DK_High_Tea.otf')});
        }

        .icon-t {
          src: url(${resource(dir: 'png', file: 'error.png')});
        }

        .header {
         top: 0 !important;
         width: 100% !important;
         height: 100% !important;   /* Height of the footer */
         background: #9dc1e0 !important;
         float: right;
         font-size: 60px;
         font-weight: 400;
         color: white;
         text-align: center;
         padding: 30px;
         font-family: 'specialFont';
         margin-bottom: 20px;
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
          width: 100%;
          height: 10px;
          border: 1px;
          /*box-shadow: 0 10px 10px -10px #8c8b8b inset;*/
       }

       #logo_sumitel {
          width: 20%;
          height: 20%;
          margin-bottom: 20px;
       }
       #logo_telcel {
          width: 18%;
          height: 18%;
          float: right;  
          margin-bottom: 20px;
       }
    </style>
</head>
<body>
<div class="container">
  <div class="row">
    <div class="col-sm-12">
      <img id="logo_sumitel" src="${resource(dir: 'img', file:'sumitel.jpeg')}" />
      <img id="logo_telcel" src="${resource(dir: 'img', file:'telcel.png')}" />
    </div>
  </div>
  <div class="row">
     <div class="col-md-12">
       <div class="header">INVENTARIO</div>
       <div id="datos_list"></div>
       <div id="contenedor"></div>
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
