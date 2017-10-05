<?php include 'Master.php' ?>


<div id="page-wrapper" >
  <h1 class="page-header">
    Programar Comité
  </h1>
  <div class="header">
    <ol class="breadcrumb">
      <li><a href="<?php base_url();?>Controllerhome">Home</a></li>
      <li><a href="#">Forms</a></li>
      <li class="active">Data</li>
    </ol>
  </div>


  <div id="page-inner">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-body">

          <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
              <thead>
                <th>#</th>
                <th>Titulo</th>
                <th>fecha</th>
                <th>Hora</th>
                <th>Lugar</th>
                <th>Modificar</th>
                <th>Ver</th>
                <th>qwerty</th>
              </thead>
              <tbody>
                <?php foreach ($programaciones as $k): ?>
                  <tr>
                    <td><?php echo $k['id_programacion'];?></td>
                    <td><?php echo $k['titulo']; ?></td>
                    <td><?php echo $k['fecha']; ?></td>
                    <td><?php echo $k['hora']; ?></td>
                    <td><?php echo $k['lugar']; ?></td>
                    <td><button class="btn btn-primary" type="button" name="button" onclick="mostrarProgramacion(<?php echo $k['id_programacion']; ?>)"><i class="fa fa-search" aria-hidden="true"></i></button></td>
                    <td><button class="btn btn-primary" type="button" name="button" onclick="consultarInstructores(<?php echo $k['id_programacion']; ?>)" data-toggle="modal" data-target="#myModaluno"><i class="fa fa-search" aria-hidden="true"></i></button></td>
                    <td><button class="btn btn-primary" type="button" name="button" onclick="fichasXprogramacion(<?php echo  $k['id_programacion']; ?>)"><i class="fa fa-paperclip" aria-hidden="true"></i></button></td>
                  </tr>
                <?php endforeach; ?>
              </tbody>
            </table>
          </div>

        </div>
      </div>

    </div>
  </div>


  <div id="ModificarProgramacion" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modificar Programacion</h4>
        </div>
        <div class="modal-body">
          <form class="form-horizontal" role="form" id="formularioModicarProgramacion" method="post">
          <fieldset>

            <input type="hidden" id="oculto" name="oculto">

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Titulo Programación</label>
              <div class="col-md-4">
                <input id="tituloModificar" name="tituloModificar" type="text" class="form-control input-md">

              </div>
            </div>
            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Fecha</label>
              <div class="col-md-4">
                <input id="fechaModificar" name="fechaModificar" type="date" placeholder="dia-mes-año" class="form-control input-md">
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Hora</label>
              <div class="col-md-4">
                <input id="horaModificar" name="horaModificar" type="time" placeholder="00:00" class="form-control input-md">
              </div>
            </div>
            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Lugar</label>
              <div class="col-md-4">
                <input id="lugarModificar" name="lugarModificar" type="text" placeholder="torre norte" class="form-control input-md">

              </div>
            </div>

            <!-- Button -->
            <div class="form-group">
              <label class="col-md-4 control-label" for="singlebutton"></label>
            </div>
          </fieldset>

          </form>
        </div>

        <div class="modal-footer">
          <button id="btnProgramacionModificar" type"submit" name="btnProgramacionModificar" class="btn btn-success" >Modificar</button>
          <button type="button" id="cerrar" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        </div>
      </div>
    </div>
  </div>

</div>
<!-- Modal de fichas -->
<div id="myModaldos" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
      </div>
      <div class="modal-body">
        <table  class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <th>#</th>
              <th>titulo</th>
              <th>Objetivo</th>
            </tr>
          </thead>
          <tbody id="proyectosXcomite">
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<!-- fin modal fichas -->

<div id="myModaluno" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="panel panel-default">
      <div class="panel-heading">
        Listado
      </div>
      <div class="panel-body">
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover" id="dataTables-example">
            <thead>
              <tr>
                <th class="center">#</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Documento</th>
                <th>Correo</th>
              </tr>
            </thead>
            <tbody id="listainst">


            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="Plantilla/assets/js/scriptProgramacion.js"></script>
