<!DOCTYPE html>
<html>
<head>
  <title></title>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'printer.css')}"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}"/>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery-3.1.1.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'moment.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'moment-with-locales.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'accounting.min.js')}"></script>

  
  <script type="text/javascript">
    $(document).ready( function() {

      var fact = window.location.href.split("=")[1];
      var totalCoste = 0;
      var suma = 0;


      console.log(fact);
      $.ajax({
          url: "${createLink(controller: 'ordenCompra', action:'datosPrintOrdenCompleta')}?remision=" + fact,
          type: "GET",
          success: function(json) {
            console.log(json);
            console.log(json.length)
            moment.locale("es");
            $('.date').append(moment(new Date()).format("LL"));
            $('.cliente').append(json[0].nombreCliente);
            $('.numOrden').append(fact);
            var position = json.length-1;
            var totalTexto = json[position].totalTexto;
            var totalCoste = 0;
            console.log(totalTexto)



            var content = "<table id='table_articles' class='table table-bordered table-striped'>";
                content += '<thead>'
                  content += '<th>Equipo</th>';
                  content += '<th>IMEI</th>';
                  content += '<th>SIM</th>';
                  content += '<th>Precio</th>';
                  content += '<th>P/P</th>';
                content += '</thead>';
              for(i=0; i<json.length; i++){
                  totalCoste = parseFloat(json[i].precio) + totalCoste;
                  content += '<tr>';
                    content += '<td>' +  json[i].nombreEquipo + '</td>';
                    content += '<td>' +   json[i].imei + '</td>';
                    content += '<td>' +  json[i].simSerie + '</td>';
                    content += '<td style="text-align: right;">' +  accounting.formatMoney(json[i].precio) +'</td>';
                    content += '<td style="text-align: right;">' +  accounting.formatMoney(json[i].precioPublico) +'</td>';
                  content += '</tr>';
              }
              content += "</table>"

              console.log(totalCoste);
              console.log(json[0].precio)
            $('#coste').append(totalTexto);
            $('#total_num').append(accounting.formatMoney(totalCoste));
            $('#tableContainer').append(content);
          }
      });

      $('.printer').on('click', function() {
        window.print();
        console.log("listo para imprimir")
      });

        

    });
  </script>
</head>
<body>

<div class="container">
    <button class="printer btn" style="float: right">Imprimir</button> 
    <br />  
    <div class="row">
        <div id="section-to-print">
        <div class="same">
          <div class="col-sm-3">
            
            <g:img dir="img" file="sumitel.jpeg" class="img-responsive sumitel" />
          </div>
          <div class="col-sm-6 title">
            <p class="text_header">CONSTRUCTORA, COMERCIALIZADORA Y ADMINISTRADORA LOGISTICA</p>
          </div>
          <div class="col-sm-3">
            <g:img dir="img" file="telcel.png" class="img-responsive telcel"/>
          </div>
        
          <div class="col-sm-12">
            <p>GRUPO SUMITEL S.A DE C.V 23 SEPTIEMBRE 514 COL.MORELOS CP 50120 TOLUCA, MÉX, RFCGSA070416-4I5 TEL(01722) 277 85 49 E-mail: sumittelcel@</p>
          </div>
          </div>
        </div>
        <div class="more_body" id="nombre_cliente">
          <div class="col-sm-9">
            <div class="panel panel-default">
              <div class="panel-heading" >Toluca, Méx a <label class="date"></label></div>
              <div class="panel-body">
                <label class="cliente"></label>
              </div>
            </div>
          </div>
          <div class="col-sm-3">
            
            <div style="float: right;">ORDEN DE COMPRA</div><br>
            <div class="numOrden" style="float: right; font-size: 48px;"></div>
          </div>
        
          <div class="col-sm-12" id="tableContainer"></div>
    

        
          <div class="col-sm-12">
            <span class="pull-right" id="total_num" style="font-size: 22px;"></span>
          </div>
          <div class="col-sm-12" id="foot_ter">
            <div class="text-uppercase panel panel-default">
              <div class="panel-body">
                debe(mos) y pagaré(mos) a la orden de grupo sumitel asociados, s.a. de c.v. en esta plaza la cantidad de <span id="coste"></span>  cantidad que ampara las mercancias expresadas en esta orden de compra recibidas a mi (nuestra) entera satisfacción de no pagarse el día de su vencimiento, causará un interes moratorio a razón (10 %) mensual de su valor total, este pagaré se rige por la ley general de titulos y operaciones de crédito, la firma puesta en cualquier lugar de este documento implica su aceptación.
              </div>
            </div>
          </div>
          <div class="col-sm-12 firma">
            <div class="col-sm-7"></div>
            <div class="col-sm-5">
              <br /><br /><br />
              <span class="line">____________________________________________________________</span>
              <p class="text-uppercase textFirma">firma de conformidad</p>
            </div>
          </div>
          <div class="col-sm-12 text-uppercase opciones">
            <div class="col-sm-3 panel panel-default">
              <div class="panel-body ajustPanel">
                <span>dirección</span>
              </div>
            </div>
            <div class="col-sm-3 panel panel-default">
              <div class="panel-body ajustPanel">
                <span>almacén</span>
              </div>
            </div>
            <div class="col-sm-3 panel panel-default">
              <div class="panel-body ajustPanel">
                <span>contabilidad</span>
              </div>
            </div>
            <div class="col-sm-3 panel panel-default">
              <div class="panel-body ajustPanel">
                <span>recibio</span>
              </div>
            </div>
          </div>
        </div>
    </div>
  </div>
</body>

  
</html>