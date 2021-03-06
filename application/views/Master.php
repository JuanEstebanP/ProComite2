<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE-edge">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Revisión y Gestión De Proyectos</title>
  <link rel="icon" type="image/png" href="http://localhost:81/ProComite2/Plantilla/assets/img/logo2.png" />

  <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css"> -->
  <!-- Bootstrap Styles-->
  <link href="Plantilla/assets/css/bootstrap.css" rel="stylesheet" />
  <!-- FontAwesome Styles-->
  <link href="Plantilla/assets/css/font-awesome.css" rel="stylesheet" />
  <!-- Custom Styles-->
  <link href="Plantilla/assets/css/custom-styles.css" rel="stylesheet" />
  <!-- Google Fonts-->
  <link href="Plantilla/assets/css/sweetalert.css" rel="stylesheet"/>

  <link href="Plantilla/assets/css/select2.css" rel="stylesheet"/>

  <link rel="stylesheet" href="Plantilla/assets/css/alertify.css">

  <link href="Plantilla/assets/css/select2.min.css" rel="stylesheet"/>

    <link href="Plantilla/assets/css/sweetalert.css" rel="stylesheet"/>
  <!-- <link rel="stylesheet" href="/vendor/bootstrap-multiselect/css/bootstrap-multiselect.css" /> -->

  <!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' /> -->
  <!-- Datatables bootstrap -->
  <link href="Plantilla/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />

  <!-- <link href="Plantilla/assets/css/alertify.css" rel="stylesheet" /> -->
</head>
<body>
  <div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="<?php base_url();?>Controllerhome"><img src="Plantilla/assets/img/logo.png" style="width:27%; margin-top:-2%;">
            <h4 style="margin-top:-23%; margin-left:33%; font-weight:600;">Comité de<br> proyectos</h4>
        </a>

      </div>

      <ul class="nav navbar-top-links navbar-right">

<li class="dropdown">
  <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
    <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
  </a>
  <ul class="dropdown-menu dropdown-alerts">
    <li>
      <a href="#">
        <div>
          <i class="fa fa-comment fa-fw"></i> New Comment
          <span class="pull-right text-muted small">4 min</span>
        </div>
      </a>
    </li>
    <li class="divider"></li>
    <li>
      <a href="#">
        <div>
          <i class="fa fa-twitter fa-fw"></i> 3 New Followers
          <span class="pull-right text-muted small">12 min</span>
        </div>
      </a>
    </li>
    <li class="divider"></li>
    <li>
      <a href="#">
        <div>
          <i class="fa fa-envelope fa-fw"></i> Message Sent
          <span class="pull-right text-muted small">4 min</span>
        </div>
      </a>
    </li>
    <li class="divider"></li>
    <li>
      <a href="#">
        <div>
          <i class="fa fa-tasks fa-fw"></i> New Task
          <span class="pull-right text-muted small">4 min</span>
        </div>
      </a>
    </li>
    <li class="divider"></li>
    <li>

      <a href="#">
        <div>
          <i class="fa fa-upload fa-fw"></i> Server Rebooted
          <span class="pull-right text-muted small">4 min</span>
        </div>
      </a>
    </li>
  </ul>
  <!-- /.dropdown-alerts -->
</li>
<!-- /.dropdown -->

<li class="dropdown">
  <a id="a" class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false" >

    <?php if ($this->session->userdata('usuario')) {
    $usuario = $this->session->userdata('usuario');
          echo $usuario;
        }
   ?> <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down">
    </i>
  </a>

  <ul class="dropdown-menu dropdown-user">
    <li><a href="#"><i class="fa fa-user fa-fw"></i>

<?php if ($this->session->userdata('usuario')) {
  $usuario = $this->session->userdata('usuario');
        echo $usuario;
      }
 ?>
</a>
    </li>
    <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
    </li>
    <li class="divider"></li>
    <li><a href="<?php base_url();?>ControllerLogin/logout"><i class="fa fa-sign-out fa-fw"></i> Cerrar Sesión</a>
    </li>
  </ul>
  <!-- /.dropdown-user -->
</li>
<!-- /.dropdown -->
</ul>
</nav>
<!--/. NAV TOP  -->
<nav class="navbar-default navbar-side" role="navigation">
  <div class="sidebar-collapse">
    <ul class="nav" id="main-menu">

      <li>
        <a href="<?php base_url();?>ControllerInstructor"><i class="fa fa-male"></i> Instructores</a>
      </li>


      <li>
        <a href="<?php base_url(); ?>ControllerAprendiz "><i class="fa fa-user"></i> Aprendices</a>
      </li>

    <!-- Fichas grupo -->
    <li>
      <a href=""><i class="fa fa-users"></i> Fichas de grupo <span class="fa arrow"></span></a>
      <ul class="nav nav-second-level">
        <li>
          <a href="<?php base_url();?>ControllerFicha" data-toggle="tooltip" title="Registrar, Consultar, Modificar" data-placement="right"><i class="fa fa-file" aria-hidden="true"></i>Gestionar fichas grupo</a>
        </li>
        <li>
          <a href="<?php base_url(); ?>ControllerLlenarfichagrupo"><i class="fa fa-refresh" aria-hidden="true"></i>Asociar aprendices</a>
        </li>
      </ul>
    </li>
    <!-- Fichas Proyecto -->
    <li>
      <a href="#"><i class="fa fa-fw fa-file"></i>Fichas de Proyecto <span class="fa arrow"></span></a>
      <ul class="nav nav-second-level">
        <li>
          <a href="<?php base_url();?>ControllerCliente" ><i class="fa fa-briefcase"></i> Clientes</a>
        </li>
        <li>
          <a href="<?PHP base_url(); ?>ControllerFichaproyecto" data-toggle="tooltip" title="Registrar, Consultar, Modificar"  data-placement="right"><i class="fa fa-exchange" aria-hidden="true"></i>Gestionar fichas proyecto</a>
        </li>
        <li>
          <a href="<?php base_url(); ?>ControllerLlenarfichapro"><i class="fa fa-plus" aria-hidden="true"></i>Asociar aprendices</a>
        </li>
      </ul>
    </li>

    <li>
    <a href="#"><i class="fa fa-qrcode"></i> Comité <span class="fa arrow"></span></a>
    <ul class="nav nav-second-level">
      <li>
        <a href="<?php base_url();?>ControllerProgramacion"><i class="fa fa-calendar"></i> Registrar Programación</a>
      </li>
      <li>
        <a href="<?php base_url(); ?>Controllerlistprograma"><i class="fa fa-file-text-o" aria-hidden="true"></i>Listar programación</a>
      </li>
      <li>
        <a href="<?php base_url();?>ControllerAsistenciaprogramacion"><i class="fa fa-check-square-o"></i> Asistencia</a>
      </li>
      <li>
        <a href="<?php base_url(); ?>ControllerEvaluarFichas"><i class="fa fa-edit"></i> Evaluar Ficha</a>
      </li>
    </ul>
    </li>

  </ul>

</div>

</nav>
<!-- /.NAVTOP -->
<!-- JS Scripts-->
<!-- jQuery Js -->
<!-- <script src="Plantilla/assets/js/jquery-1.10.2.js"></script> -->
<!-- <script src="Plantilla/assets/js/alertify.js"> </script> -->

<!-- <script src="/vendor/bootstrap-multiselect/js/bootstrap-multiselect.js"></script> -->
<!-- Compiled and minified CSS -->


<!-- Compiled and minified JavaScript -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script> -->
<script src="Plantilla/assets/js/jquery-3.2.1.min.js"></script>
<!-- JQuery Validate -->
<script src="Plantilla/assets/js/jquery.validate.min.js"></script>
<script src="Plantilla/assets/js/additional-methods.min.js"></script>
<!-- Bootstrap Js -->
<script src="Plantilla/assets/js/bootstrap.min.js"></script>
<!-- Metis Menu Js -->
<script src="Plantilla/assets/js/jquery.metisMenu.js"></script>
<!-- Custom Js -->
<script src="Plantilla/assets/js/custom-scripts.js"></script>
<!-- Datatables scripts -->
<script src="Plantilla/assets/js/dataTables/jquery.dataTables.js"></script>
<!-- Datatables Styles -->
<script src="Plantilla/assets/js/dataTables/dataTables.bootstrap.js"></script>

<script src="Plantilla/assets/js/sweetalert.min.js"></script>

<script src="Plantilla/assets/js/select2.full.js"></script>

<script src="Plantilla/assets/js/select2.js"></script>

<script src="Plantilla/assets/js/alertify.js"></script>


<script>
$(document).ready(function () {
  $('#dataTables-example').dataTable();
});
</script>

<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});
</script>
