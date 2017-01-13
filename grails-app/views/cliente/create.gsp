<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
    <title>Nuevo cliente</title>
    <script>
        $(document).ready( function() {
            
            console.log("jquery on");
            
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
      <h1>Nuevo Cliente</h1>
    </div>
    <div class="row">
        <g:form class="form-horizontal" controller="cliente" action="save">
          <div class="form-group">
            <label for="articulo" class="col-sm-2 control-label">Nombre completo</label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="nombre" name="nombre" style="text-transform: uppercase">
            </div>
          </div>
          <div class="form-group">
            <label for="costoSub" class="col-sm-2 control-label">Ciudad</label>
            <div class="col-sm-3">
              <input type="text" class="form-control" id="ciudad" name="ciudad" style="text-transform: uppercase">
            </div>
          </div>
          <div class="form-group">
            <label for="costoPublico" class="col-sm-2 control-label">Estado</label>
            <div class="col-sm-3">
              <input type="text" class="form-control" id="estado" name="estado" style="text-transform: uppercase">
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
</body>
</html>