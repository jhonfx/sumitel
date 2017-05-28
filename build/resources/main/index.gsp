<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta name="layout" content="main"/>
    <meta charset="utf-8">
    <title>Sumitel S.A de C.V</title>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jsgrid-theme.min.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ring.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.modal.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bttn.min.css')}"/>
    <script type="text/javascript">
      $(document).ready( function() {
        $('#join').on('click', function() {
          console.log("asdasdasdsa")

          var frm = $('#login_form').serializeObject();
          console.log(frm);

          $.ajax({
            url: "${createLink(controller: 'usuario', action:'loginUser')}",
            data: {user: frm.user, passw: frm.passw},
            type: "GET",
            success: function(msg) {
              console.log(msg)
              if (msg.response.status == 409) {
                swal({
                  title: "Error",
                  type: "error",
                  text: "Usuario y/o Contraseña incorrectos",
                  allowEscapeKey: true,
                  imageSize: "20x20"
                });
              } else if (msg.response[0].session == true){
                console.log("si esta ok")
                sessionStorage.login = msg.response[0].login
                sessionStorage.activo = true

                var href = "${createLink(controller: 'inventario', action: 'listarArticulos')}";
                var specialurl = window.location.origin + href;
                window.location.href = specialurl;
              }

            },
            error: function(ss) {
              console.log(ss);
            },
            dataType:"json"
          })
        });
      });
    </script>
    <style type="text/css">

    .login {
      margin-top: 40px;
      float: left;
      margin-left: 14%;
      margin-right: 50%;
      width: 100%;
    }
    
    </style>
</head>
<body>
    
    <div class="container">
      <div class="row">
        <h1 style="text-align: center; font-size: 32px;">Sumitel Version 1.8</h1>
        <img class="img-responsive" style="align: center; margin: auto !important; margin-left: 50%; margin-right: 50%;" src="${resource(dir: 'images', file: 'sumitel.jpeg')}" />
        <div class="div_login">
          <form id="login_form" class="form-horizontal login">
            <div class="form-group">
              <label class="col-sm-2 control-label">USUARIO</label>
              <div class="col-sm-6">
                <input type="text" class="form-control" id="user" name="user" placeholder="Usuario">
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">CONTRASEÑA</label>
              <div class="col-sm-6">
                <input type="password" class="form-control" id="password" name="passw" placeholder="Contraseña">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-8">
                <button type="button" id="join" class="bttn-fill bttn-lg bttn-warning pull-right">Entrar</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
</body>
</html>
