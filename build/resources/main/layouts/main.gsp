<!doctype html>
<!DOCTYPE html>
<%
response.setHeader("Cache-Control","no-cache"); // Fuerza al cache a obtener una nueva copia de la pagina desde el servidor de origen
response.setHeader("Cache-Control","no-store"); // Indica al cache no guardar la pagina, bajo ninguna circunstancia
response.setDateHeader("Expires", 0);           // Causes the proxy cache to see the page as "stale"
response.setDateHeader('max-age', 0)
response.setIntHeader('Expires', -1)            //prevents caching at the proxy server
response.setHeader("Pragma", "no-cache");       // HTTP 1.0 compatibilidad
%>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery-3.1.1.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery-ui.js')}"></script>
    
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'stylesheets', file: 'style_buttons.css')}"/>

    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'format_number.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'sidebar.js')}"></script>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'push_nav.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ring.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'sweetalert.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.flexdatalist.css')}"/>

    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'sumitel_utils.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'moment.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'sweetalert.min.js')}"></script>
    

    <script>
      function openNav() {
          document.getElementById("mySidenav").style.width = "250px";
          document.getElementById("main").style.marginLeft = "250px";
      }

      function closeNav() {
          document.getElementById("mySidenav").style.width = "0";
          document.getElementById("main").style.marginLeft= "0";
      }
    </script>
    <asset:stylesheet src="application.css"/>
    <g:layoutHead/>
</head>
<body>


    <div id="mySidenav" class="sidenav">
      <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
      <a href="${createLink(controller: 'almacen', action: 'obtenerAlmacen')}">Almacen</a>
      <a href="${createLink(controller: 'inventario', action: 'listarArticulos')}">Inventario</a>
      <a href="${createLink(controller: 'almacen', action: 'altamasiva')}">Alta masiva</a>
      <a href="${createLink(controller: 'almacen', action: 'altaporpistola')}">Alta dispositivo</a>
      <a href="${createLink(controller: 'inventario', action: 'create')}">Nuevo Producto</a>
      <a href="${createLink(controller: 'cliente', action: 'create')}">Nuevo Cliente</a>
      <a href="${createLink(controller: 'almacen', action: 'listaparaorden')}">Orden Compra</a>
      <a href="${createLink(controller: 'ordenCompra', action: 'reimprimirOrden')}">Reimprimir Orden</a>
    </div>

    <div id="main">
      <span style="font-size:30px;cursor:pointer" onclick="openNav()">☰</span>
      <g:layoutBody/>
      
    </div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
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

    <script type="text/javascript" src="${resource(dir: 'javascripts', file: 'jquery.flexdatalist.js')}"></script>
 
    <!-- <div class="footer">SUMITEL S.A de C.V</div> -->
</body>
</html>
