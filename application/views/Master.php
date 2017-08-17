<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE-edge">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Revisión y Gestión De Proyectos</title>
  <!-- Bootstrap Styles-->
  <link href="Plantilla/assets/css/bootstrap.css" rel="stylesheet" />
  <!-- FontAwesome Styles-->
  <link href="Plantilla/assets/css/font-awesome.css" rel="stylesheet" />
  <!-- Custom Styles-->
  <link href="Plantilla/assets/css/custom-styles.css" rel="stylesheet" />
  <!-- Google Fonts-->
  <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
  <!-- Datatables bootstrap -->
  <link href="Plantilla/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />

  <link href="Plantilla/assets/css/alertify.css" rel="stylesheet" />
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
        <a class="navbar-brand" href="<?php base_url();?>Controllerhome"><strong>ProComité</strong></a>
      </div>

      <ul class="nav navbar-top-links navbar-right">
        <!-- <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
        <i class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
      </a>
      <ul class="dropdown-menu dropdown-messages">
      <li>
      <a href="#">
      <div>
      <strong>John Doe</strong>
      <span class="pull-right text-muted">
      <em>Today</em>
    </span>
  </div>
  <div>Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...</div>
</a>
</li>
<li class="divider"></li>
<li>
<a href="#">
<div>
<strong>John Smith</strong>
<span class="pull-right text-muted">
<em>Yesterday</em>
</span>
</div>
<div>Lorem Ipsum has been the industry's standard dummy text ever since an kwilnw...</div>
</a>
</li>
<li class="divider"></li>
<li>
<a href="#">
<div>
<strong>John Smith</strong>
<span class="pull-right text-muted">
<em>Yesterday</em>
</span>
</div>
<div>Lorem Ipsum has been the industry's standard dummy text ever since the...</div>
</a>
</li>
<li class="divider"></li>
<li>
<a class="text-center" href="#">
<strong>Read All Messages</strong>
<i class="fa fa-angle-right"></i>
</a>
</li>
</ul>

</li> -->
<!-- /.dropdown-messages -->

<!-- /.dropdown -->
<!-- <li class="dropdown">
<a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
<i class="fa fa-tasks fa-fw"></i> <i class="fa fa-caret-down"></i>
</a>
<ul class="dropdown-menu dropdown-tasks">
<li>
<a href="#">
<div>
<p>
<strong>Task 1</strong>
<span class="pull-right text-muted">60% Complete</span>
</p>
<div class="progress progress-striped active">
<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
<span class="sr-only">60% Complete (success)</span>
</div>
</div>
</div>
</a>
</li>
<li class="divider"></li>
<li>
<a href="#">
<div>
<p>
<strong>Task 2</strong>
<span class="pull-right text-muted">28% Complete</span>
</p>
<div class="progress progress-striped active">
<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100" style="width: 28%">
<span class="sr-only">28% Complete</span>
</div>
</div>
</div>
</a>
</li>
<li class="divider"></li>
<li>
<a href="#">
<div>
<p>
<strong>Task 3</strong>
<span class="pull-right text-muted">60% Complete</span>
</p>
<div class="progress progress-striped active">
<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
<span class="sr-only">60% Complete (warning)</span>
</div>
</div>
</div>
</a>
</li>
<li class="divider"></li>
<li>
<a href="#">
<div>
<p>
<strong>Task 4</strong>
<span class="pull-right text-muted">85% Complete</span>
</p>
<div class="progress progress-striped active">
<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%">
<span class="sr-only">85% Complete (danger)</span>
</div>
</div>
</div>
</a>
</li>
<li class="divider"></li>
<li>
<a class="text-center" href="#">
<strong>See All Tasks</strong>
<i class="fa fa-angle-right"></i>
</a>
</li>
</ul>

</li> -->
<!-- /.dropdown-tasks -->

<!-- /.dropdown -->
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
    <li class="divider"></li>
    <li>
      <a class="text-center" href="#">
        <strong>See All Alerts</strong>
        <i class="fa fa-angle-right"></i>
      </a>
    </li>
  </ul>
  <!-- /.dropdown-alerts -->
</li>
<!-- /.dropdown -->
<li class="dropdown">
  <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
    <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
  </a>
  <ul class="dropdown-menu dropdown-user">
    <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
    </li>
    <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
    </li>
    <li class="divider"></li>
    <li><a href="#"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
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
        <a href="<?php base_url(); ?>Upload"><i class="fa fa-upload" aria-hidden="true"></i>Subir Ficha</a>
      </li>
      <li>
        <a href="<?php base_url();?>ControllerInstructor"><i class="fa fa-dashboard"></i> Instructores</a>
      </li>
      <li>
        <a href="<?php base_url();?>ControllerCliente" ><i class="fa fa-desktop"></i> Clientes</a>
      </li>
      <li>
        <a href="<?php base_url();?>ControllerProgramacion"><i class="fa fa-bar-chart-o"></i> Programación</a>
      </li>
      <li>
        <a href="<?php base_url();?>ControllerFicha"><i class="fa fa-qrcode"></i> Fichas de grupo</a>
      </li>

      <li>
        <a href="<?php base_url(); ?>ControllerAprendiz "><i class="fa fa-table"></i> Aprendices</a>
      </li>
      <li>
        <a href="<?php base_url(); ?>ControllerEvaluarFichas" ><i class="fa fa-edit"></i> Evaluar Ficha </a>
      </li>

      <li>
        <a href="<?php base_url(); ?>ControllerTrazabilidad"><i class=""></i> Trazabilidad</a>
      </li>

      <li>
        <a href="<?PHP base_url(); ?>ControllerFichaproyecto"><i class="fa fa-fw fa-file"></i> Ficha de Proyecto</a>
      </li>
    </ul>

  </div>

</nav>
<!-- /.NAVTOP -->
<!-- JS Scripts-->
<!-- jQuery Js -->
<!-- <script src="Plantilla/assets/js/jquery-1.10.2.js"></script> -->
<script src="Plantilla/assets/js/alertify.js"> </script>
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
<script>
$(document).ready(function () {
  $('#dataTables-example').dataTable();
});
</script>
