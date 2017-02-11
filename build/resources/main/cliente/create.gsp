<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main" />
    <asset:stylesheet src="application.css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bttn.min.css')}"/>
    <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
    <title>Nuevo cliente</title>
    <script>
        $(document).ready( function() {
            
            console.log("jquery on");
            
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
      <h1>NUEVO CLIENTE</h1>
      <hr>
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
              <button type="submit" id="on_save" class="btn">Guardar</button>
            </div>
          </div>
        </g:form>
    </div>
</div>
</body>
</html>