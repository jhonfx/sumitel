<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bttn.min.css')}"/>
    <g:set var="entityName" value="${message(code: 'articulo.label', default: 'Inventario')}" />
    <title>Alta articulo</title>
    <script>
        $(document).ready( function() {
            
            $('#costoSub').change( function() {
                var costo =  $('#costoSub').val();
                console.log(costo);
                var withformat = format("#,##0.####", costo);
                console.log(withformat)
                $('#costoSub').val(withformat)
            });

            $('#costoPublico').change( function() {
                var costo =  $('#costoPublico').val();
                console.log(costo);
                var withformat = format("#,##0.####", costo);
                console.log(withformat)
                $('#costoPublico').val(withformat)
            });

            $('#costoUnitario').change( function() {
                var costo =  $('#costoUnitario').val();
                console.log(costo);
                var withformat = format("#,##0.####", costo);
                console.log(withformat)
                $('#costoUnitario').val(withformat)
            });

           $('#on_save').on('click', function(e) {
            console.log($('#costoPublico').val());
            
            if ($('#articulo').val() !== "" && 
              $('#costoSub').val() !== "" && 
              $('#costoSub').val() !== "0.00" && 
              $('#costoPublico').val() !== "" &&
              $('#costoPublico').val() !== "0.00" &&
              $('#costoUnitario').val() !== "" &&
              $('#costoUnitario').val() !== "0.00" && 
              $('input:radio[name=tipo]:checked').length > 0) {
              $('#form_article').submit();
            } else {
              swal({
              title: "Error",
              type: "error",
              text: "Hay campos vacios",
              allowEscapeKey: true,
              imageSize: "20x20"
            });
              e.preventDefault();
              console.log("hay campos vacios");
            }

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
      <h1>ALTA PRODUCTO</h1>
      <hr>
    </div>
    <div class="row">
        <div class="col-sm-12">
        <g:form id="form_article" class="form-horizontal" controller="inventario" action="saveArticle">
          <div class="form-group">
            <label for="articulo" class="col-sm-2 control-label">Articulo</label>
            <div class="col-sm-6">
              <input type="text" class="form-control required" id="articulo" name="articulo" style="text-transform: uppercase">
            </div>
          </div>
          <div class="form-group">
            <label for="costoSub" class="col-sm-2 control-label">Costo Sub</label>
            <div class="col-sm-3">
              <input type="text" class="form-control text-right" id="costoSub" name="costoSub" placeholder="$0.00">
            </div>
          </div>
          <div class="form-group">
            <label for="costoPublico" class="col-sm-2 control-label">Costo Publico</label>
            <div class="col-sm-3">
              <input type="text" class="form-control text-right" id="costoPublico" name="costoPublico" placeholder="$0.00">
            </div>
          </div>
          <div class="form-group">
            <label for="costoUnitario" class="col-sm-2 control-label">Costo Unitario</label>
            <div class="col-sm-3">
              <input type="text" class="form-control text-right" placeholder="$0.00" id="costoUnitario" name="costoUnitario">
            </div>
          </div>
          <div class="form-group">
            <label for="tipoArticulo" class="col-sm-2 control-label">Tipo articulo</label>
            <div class="col-sm-8">
              <g:radio name="tipo" value="1"/>Equipo
              <g:radio name="tipo" value="2"/>Chip/Tarjeta Amigo
            </div>
          </div>

          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <button type="submit" id="on_save" class="btn  bttn-fill bttn-danger bttn-sm pull-right">Guardar</button>
            </div>
          </div>
        </g:form>
      </div>
  </div>
</div>
<script type="text/javascript" src="${resource(dir: 'javascripts', file: 'format_number.js')}"></script>
</body>
</html>