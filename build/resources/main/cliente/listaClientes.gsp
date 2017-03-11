<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bttn.min.css')}"/>
    <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
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

    <title>Lista Clientes</title>
    <script>
        $(document).ready( function() {
            $('#contenedor').hide();
            $("#modal").iziModal();


            $(document).on('click', '.trigger', function (event) {
                event.preventDefault();
                $('#modal').iziModal('open');
            });


            console.log("jquery on");

            // $.ajax({
            //   url: "${createLink(controller: 'cliente', action: 'clientList')}",
            //   type: 'GET',
            //   error: function(e) {
            //     console.log(e)
            //   },
            //   success: function(json) {
            //     console.log(json)
            //   }
            // });

            $.getJSON("${createLink(controller: 'cliente', action: 'clientList')}", {
              ajax: 'true'
            }, function(callback) {
                console.log(callback)
                var tuplas = callback;
                var saldoTotal = 0;


                $.ajax({
                  url:"${createLink(controller:'cliente', action:'datosCliente')}",
                  data: {},
                  type: "GET",
                  success: function(callback) {
                    console.log(callback);
                  },
                  error: function(error){
                    console.log(error)
                  },
                  dataType:"json"
                });

                $("#listaClientes").jsGrid({
                      width: "100%",
                      height: "600px",
                      filtering: true,
                      editing: false,
                      inserting: false,
                      sorting: true,
                      paging: true,
                      autoload: true,
                      pageSize: 80,
                      pageButtonCount: 5,
                      
                      data: tuplas,
                      //controller: db2,
               
                      fields: [
                          { name: "id", title: 'ID', type: "number", width: 30, editing: false},
                          { name: "nombre", title: 'Nombre', type: "text", width: 30, editing: false},
                          { name: "ciudad", title: 'Ciudad', type: "text", width: 40, editing: false, filtering: true},
                          { name: "estado", title: 'Estado', type: "text", width: 40, editing: false, filtering: true},
                          { name: "saldoTotal", title: 'Salto Total', type: "text", width: 40, editing: false, filtering: true},
                          { name: "abonoSaldo", title: 'Saldo Pendiente', type: "text", width: 40, editing: false, filtering: false},
                          { title: 'Abono', type: "text", width: 20, editing: false, filtering: false, itemTemplate: function(_, item){
                            return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' class='btn bttn-bordered bttn-success bttn-sm btn-abono'><i class='glyphicon glyphicon-plus'></i></button>").on('click', function(e) {
                                
                                $('#modal').iziModal('open', {
                                  iframeHeight: 300,
                                  width: 200,
                                  transitionIn: 'bounceInDown'
                                });


                                var target = $('#buttonTupla-'+item.id+'').data('idtupla');
                                console.log(target);
                                

                                $.each(tuplas, function(e, tupla) {
                                  if(tupla.id === target) {
                                    $('#aplicar_pago').on('click', function(e) {
                                      e.preventDefault();
                                      e.stopPropagation();
                                      var pago = $('#pago').val();
                                      if (pago > tupla.saldoTotal) {
                                        swal({
                                          title: "Error",
                                          type: "error",
                                          text: "Pago no debe ser mayor a saldo total",
                                          allowEscapeKey: true,
                                          imageSize: "20x20"
                                        });
                                        $('#modal').iziModal('close');
                                        return;
                                      } else {
                                        $('#modal').iziModal('close');
                                        $.ajax({
                                          url: "${createLink(controller: 'cliente', action: 'abonoCliente')}",
                                          data: {id: tupla.id , pago: pago},
                                          type: "POST",
                                          success: function(callback) {
                                            console.log(callback);
                                            $('#listaClientes').jsGrid("refresh");

                                          },
                                          error: function(error) {
                                            console.log(error)
                                            $('#listaClientes').jsGrid("refresh");
                                            var href = "${createLink(controller: 'cliente', action: 'listaClientes')}";
                                            var specialurl = window.location.origin + window.location.pathname;
                                            console.log(specialurl)
                                            location.reload(specialurl)
                                          },
                                          dataType: "json"
                                        });
                                      }
                                    })
                                  }
                                })

                                

                            });
                          }},
                          { title: 'Historico', width: 20, editing: false,  itemTemplate: function(_, item) {
                            console.log(item)
                            return $("<button type='button' id='buttonTupla-"+item.id+"' data-idtupla='"+ item.id +"' class='btn bttn-bordered bttn-success bttn-sm btn-add-sim'><i class='glyphicon glyphicon-list-alt'></i></button>").on('click', function(e) {
                                  

                                  $('#contenedor')
                                  .append('<form>')
                                  .append('<div class="form-group">')
                                  .append('<label for="articulo">Producto:</label>')
                                  .append('<input readonly type="text" class="form-control" id="articulo" value="1"/>')
                                  .append('</div>')
                                  .append('</form>')
                                  $('#contenedor').modal('hide');
                            });

                            $('#contenedor').on($.modal.BEFORE_CLOSE, function(event, modal) {
                            $('#contenedor').html("");
                              console.log("cerrando");
                            });  

                            $('#contenedor_abono').on($.modal.BEFORE_CLOSE, function(event, modal) {
                            $('#contenedor_abono').html("");
                              console.log("cerrando");
                            });  

                          }}
                      ]
                  });
             
            });
            
        })
    </script>
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
</head>
<body>
<div class="container">
    <div class="row">
      <div class="header" >SUMITEL S.A DE C.V</div>
    </div>
    <div class="row">
      <h1>Lista Clientes</h1>
      <hr>
    </div>
    <div class="row">
        <div id="listaClientes"></div>
        <div id="contenedor"></div>
        <div id="contenedor_abono"></div>
        <div id="modals">
            <div id="modal" class="iziModal" data-izimodal-title="Pago de cliente">
              <form class="form-inline">
                <div class="form-group">
                  <label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
                  <div class="input-group">
                    <div class="input-group-addon">$</div>
                    <input type="text" class="form-control" id="pago" placeholder="$0">
                  </div>
                </div>
                <button type="submit" id="aplicar_pago" class="btn btn-primary">Aplicar</button>
              </form>
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
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'iziModal.js')}"></script>
</body>
</html>