<?php
include 'Master.php';
?>

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


          <center><h4 class="modal-title">Registrar</h4></center>

        <div class="modal-body">
          <?php echo form_open('ControllerProgramacion/registrarProgramacion', array("class"=>"form-horizontal", "id"=>"formularioProgramacion", "role"=>"form", 'method'=>'post')); ?>
          <!-- <form class="form-horizontal" role="form" id="formularioProgramacion" method="post" action="" > -->
          <fieldset>
            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Fecha</label>
              <div class="col-md-4">
                <input id="fecha" name="fecha" type="date" placeholder="dia-mes-año" class="form-control input-md">

              </div>
            </div>

            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Hora</label>
              <div class="col-md-4">
                <input id="hora" name="hora" type="time" placeholder="00:00" class="form-control input-md">

              </div>
            </div>

            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Lugar</label>
              <div class="col-md-4">
                <input id="lugar" name="lugar" type="text" placeholder="torre norte" class="form-control input-md">

              </div>
            </div>

            <!-- Button -->
            <div class="form-group">
              <label class="col-md-4 control-label" for="singlebutton"></label>
              <div class="col-md-4">
                <button type"button" name="btnProgramacion" class="btn btn-success" >REGISTRAR</button>

              </div>
            </div>
          </fieldset>
          <?php echo form_close(); ?>
          <!-- </form> -->
      </div>
</div>


  <!-- listado de programacion de comite  -->
    <div class="panel panel-default">
      <div class="panel-heading">
        Tabla Programación
      </div>
      <div class="panel-body">
        <div class="table-responsive">
          <div id="">
            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
              <thead>
                <tr>
                  <th class="text-center">
                    N°
                  </th>
                  <th class="text-center">
                    Fecha
                  </th>

                  <th class="text-center">
                    Hora
                  </th>

                  <th class="text-center">
                    Lugar
                  </th>

                  <th class="text-center">
                    Opciones
                  </th>
                  <th>
                    Asistencia
                  </th>
                </tr>
              </thead>
              <tbody id="TablaConsultarProgramacion">
                <?php   foreach ($Programacion as $i) { ?>
                  <tr class="odd gradeX">
                    <td><?php echo $i['id_programacion']; ?></td>
                    <td><?php echo $i['fecha']; ?></td>
                    <td><?php echo $i['hora']; ?></td>
                    <td><?php echo $i['lugar']; ?></td>
                    <td><button class="btn btn-default" id="txtPrograma" name="button" onClick="mostrarProgramacion(<?php echo $i['id_programacion']; ?>)"><i class="fa fa-pencil" aria-hidden="true"></i></td>
                    <td>
                      <button class="btn btn-default" onClick="consultarInstructores(<?php echo $i['id_programacion'];?>)" data-toggle="modal" data-target="#myModaluno">
                      <i class="fa fa-search"></i>
                      </button>
                    </td>
                    </tr>


                    <?php } ?>

                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>

    </div>

      </div>


      <!--MODAL MODIFICAR PROGRAMACION-->
      <div id="ModificarProgramacion" class="modal fade" role="dialog">
        <div class="modal-dialog">

          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title">Modificar Programacion</h4>
            </div>
            <div class="modal-body">
              <?php echo form_open('ControllerProgramacion/editarProgramacion', array("class"=>"form-horizontal", "id"=>"formularioModicarProgramacion", "role"=>"form", 'method'=>'post')); ?>
              <!-- <form class="form-horizontal" role="form" id="formularioModicarProgramacion" method="post"> -->
                <fieldset>

                  <input type="hidden" id="oculto" name="oculto">
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
                    <div class="col-md-4">
                      <button id="btnProgramacionModificar" type"submit" name="btnProgramacionModificar" class="btn btn-success" >Modificar</button>

                    </div>
                  </div>
                </fieldset>
                <?php echo form_close(); ?>
              <!-- </form> -->
            </div>

            <div class="modal-footer">
              <button type="button" id="cerrar" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
          </div>

        </div>
      </div>

    </div>


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
  </div>


  </fieldset>
</div>
</div>

    <script src="Plantilla/assets/js/scriptProgramacion.js"></script>
