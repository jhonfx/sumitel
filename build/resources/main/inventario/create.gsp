<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
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
            
        })
    </script>
    <style type="text/css">
      .header {
         top: 0 !important;
         width: 100% !important;
         height: 60px !important;   /* Height of the footer */
         background: #9dc1e0 !important;
         float: right;
         font-size: 30px;
         color: white;
         text-align: center;
         padding: 15px;
      }
    </style>
</head>
<body>
<div class="container"> 
  <div class="col-md-12">
    <div class="row">
      <div class="header col-sm-12" >SUMITEL S.A DE C.V</div>
    </div>
    <div class="row">
      <h1>Nuevo articulo</h1>
    </div>
    <div class="row">
        <g:form class="form-horizontal" controller="inventario" action="saveArticle">
          <div class="form-group">
            <label for="articulo" class="col-sm-2 control-label">Articulo</label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="articulo" name="articulo" style="text-transform: uppercase">
            </div>
          </div>
          <div class="form-group">
            <label for="costoSub" class="col-sm-2 control-label">Costo Sub</label>
            <div class="col-sm-3">
              <input type="text" class="form-control text-right" id="costoSub" name="costoSub" value="0.00">
            </div>
          </div>
          <div class="form-group">
            <label for="costoPublico" class="col-sm-2 control-label">Costo Publico</label>
            <div class="col-sm-3">
              <input type="text" class="form-control text-right" id="costoPublico" name="costoPublico" value="0.00">
            </div>
          </div>
          <div class="form-group">
            <label for="costoUnitario" class="col-sm-2 control-label">Costo Unitario</label>
            <div class="col-sm-3">
              <input type="text" class="form-control text-right" id="costoUnitario" name="costoUnitario" value="0.00">
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
            <div class="col-sm-offset-2 col-sm-7">
              <button type="submit" class="btn btn-default">Guardar</button>
            </div>
          </div>
        </g:form>
    </div>
  </div>
</div>
<script type="text/javascript" src="${resource(dir: 'javascripts', file: 'format_number.js')}"></script>
</body>
</html>