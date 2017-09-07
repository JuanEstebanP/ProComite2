<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Cliente <small>Best form elements.</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="<?php base_url() ?>Controllerhome">Home</a></li>
      <li><a href="#">Forms</a></li>
      <li class="active">Data</li>
    </ol>
  </div>




  <div id="page-inner">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading">
          Formaulario Clientes De Proyectos
        </div>

        <!-- <form class="form-horizontal"> -->
        <?php echo form_open('ControllerCliente/RegistrarCliente', array("class"=>"form-horizontal", "id"=>"formCliente", "role"=>"form", "method"=>"post")); ?>
        <fieldset>

          <!-- Form Name -->


          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Nombre: </label>
            <div class="col-md-4">
              <input id="textNombreCliente" name="textNombreCliente" type="text" placeholder="Juan, Alberto, Carlos" class="form-control input-md">
            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Apellido: </label>
            <div class="col-md-4">
              <input id="textApellidoCliente" name="textApellidoCliente" type="text" placeholder="Lopez, Zapata, Ciro" class="form-control input-md">
            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Teléfono: </label>
            <div class="col-md-4">
              <input id="textTelefonoCliente" name="textTelefonoCliente" type="text" placeholder="3139517896, 4226978" class="form-control input-md">
            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Correo: </label>
            <div class="col-md-4">
              <input id="textCorreoCliente" name="textCorreoCliente" type="text" placeholder="example@inix.com" class="form-control input-md">
            </div>
          </div>

          <!-- Button -->
          <div class="form-group">
            <label class="col-md-4 control-label" for="singlebutton"></label>
            <div class="col-md-8">
              <button id="RegistrarCliente" type="submit"  name="RegistrarCliente" class="btn btn-success">Registrar</button>
            </div>
          </div>

        </fieldset>
        <!-- </form> -->
        <?php echo form_close(); ?>
      </div>
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
                  <th>Nombre</th>
                  <th>Apellido</th>
                  <th>Telefono</th>
                  <th>Correo</th>
                  <th>Editar</th>
                </tr>
              </thead>
              <tbody id="tblInstructor">
                <?php foreach ($Cliente as $c) { ?>

                  <tr class="odd gradeX">
                  <td><?php echo $c['id_cliente']; ?></td>
                  <td><?php echo $c['nombre']; ?></td>
                  <td><?php echo $c['apellido']; ?></td>
                  <td><?php echo $c['telefono']; ?></td>
                  <td class="center"><?php echo $c['correo']; ?></td>

                  <td>
                    <button class="btn btn-primary" id="hoa" name="hoa" onclick="Editar(<?php echo $c['id_cliente']; ?>)"><i class="fa fa-pencil" aria-hidden="true"></i></button>
                  </td>
                </tr>
                <?php  } ?>

              </tbody>
            </table>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>

<div id="modalCliente" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Editar Cliente</h4>
      </div>
      <div class="modal-body">
        <!-- <form class="form-horizontal"> -->
        <?php echo form_open('ControllerCliente/ActualizarCliente', array("class"=>"form-horizontal", "id"=>"formActualizarCliente", "role"=>"form", 'method'=>'post')); ?>
        <fieldset>
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">ID: </label>
            <div class="col-md-4">
              <input id="txtIdCliente" name="txtIdCliente" type="text" class="form-control input-md" readonly="">
            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Nombre: </label>
            <div class="col-md-4">
              <input id="txtNombreCliente" name="txtNombreCliente" type="text" placeholder="placeholder" class="form-control input-md">
            </div>
          </div>


          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Apellido: </label>
            <div class="col-md-4">
              <input id="txtApellidoCliente" name="txtApellidoCliente" type="text" placeholder="placeholder" class="form-control input-md">
            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Teléfono: </label>
            <div class="col-md-4">
              <input id="txtTeleCliente" name="txtTeleCliente" type="text" placeholder="placeholder" class="form-control input-md">
            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Correo: </label>
            <div class="col-md-4">
              <input id="txtCorreoCliente" name="txtCorreoCliente" type="text" placeholder="placeholder" class="form-control input-md">
            </div>
          </div>
        </fieldset>
        <!-- </form> -->
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
        <button type="submit" id="btnActualizarCliente" name="btnActualizarCliente" class="btn btn-success">Enviar</button>
      </div>
    </div>
    <?php echo form_close(); ?>
  </div>
</div>
<!-- <script src="Plantilla/assets/js/Validaciones/ClientesValid.js"></script> -->
<script src="Plantilla/assets/js/Clientes.js"></script>
