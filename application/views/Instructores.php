<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Instructores
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
          Registro individual
        </div>

        <?php echo form_open('ControllerInstructor/InsertarInstructor', array("class"=>"form-horizontal", "id"=>"formInstructor", "role"=>"form", 'method'=>'post')); ?>
        <!-- Text input-->
        <fieldset>
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Nombre: </label>
            <div class="col-md-4">
              <input id="txtNombre"  value="<?php echo $this->input->post('txtNombre'); ?>"  name="txtNombre" type="text" placeholder="Juan, Alberto, Carlos" class="form-control input-md">

            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Apellido: </label>
            <div class="col-md-4">
              <input id="txtApellido" name="txtApellido" type="text" placeholder="Lopez, Zapata, Ciro" class="form-control input-md">

            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Documento: </label>
            <div class="col-md-4">
              <input id="txtDocumento" name="txtDocumento" type="text" placeholder="1152487985" class="form-control input-md" >

            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Correo: </label>
            <div class="col-md-4">
              <input id="txtCorreo" name="txtCorreo" type="text" placeholder="ejemplo@inix.com" class="form-control input-md">

            </div>
          </div>

          <!-- Button (Double) -->
          <div class="form-group">
            <label class="col-md-4 control-label" for="button1id"></label>
            <div class="col-md-8">
              <button  name="buttonRegistrar" type="submit" class="btn btn-success">Registrar</button>
            </div>
          </div>
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
                    <th>Documento</th>
                    <th>Correo</th>
                    <th>Editar</th>
                  </tr>
                </thead>
                <tbody id="tblInstructor">
                  <?php foreach ($Instructor as $i) { ?>

                    <tr class="odd gradeX">
                      <td><?php echo $i['id_instructor']; ?></td>
                      <td><?php echo $i['nombre']; ?></td>
                      <td><?php echo $i['apellido']; ?></td>
                      <td><?php echo $i['documento']; ?></td>
                      <td class="center"><?php echo $i['correo']; ?></td>

                      <td>
                        <button class="btn btn-primary" id="hoa" name="hoa" onclick="Editar(<?php echo $i['id_instructor']; ?>)"><i class="fa fa-pencil" aria-hidden="true"></i></button>
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
    </fieldset>
  </div>



  ---------------------------------------------------
  MODAL PARA EDITAR
  ---------------------------------------------------
  <div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Editar Instructores</h4>
        </div>
        <div class="modal-body">
          <!-- <form class="form-horizontal"> -->
          <?php echo form_open('ControllerInstructor/ActualizarInstructor', array("class"=>"form-horizontal", "id"=>"formActualizar", "role"=>"form", 'method'=>'post','name'=>'formActualizar')); ?>
          <fieldset>
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">ID: </label>
              <div class="col-md-4">
                <input id="txtIdModificar" name="txtIdModificar" type="text" class="form-control input-md" readonly="">
              </div>
            </div>

            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Nombre: </label>
              <div class="col-md-4">
                <input id="txtNombreModificar" name="txtNombreModificar" type="text" placeholder="placeholder" class="form-control input-md">
              </div>
            </div>


            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Apellido: </label>
              <div class="col-md-4">
                <input id="txtApellidoModificar" name="txtApellidoModificar" type="text" placeholder="placeholder" class="form-control input-md">
              </div>
            </div>

            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Documento: </label>
              <div class="col-md-4">
                <input id="txtDocumentoModificar" name="txtDocumentoModificar" type="text" placeholder="placeholder" class="form-control input-md">
              </div>
            </div>

            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Correo: </label>
              <div class="col-md-4">
                <input id="txtCorreoModificar" name="txtCorreoModificar" type="text" placeholder="placeholder" class="form-control input-md">
              </div>
            </div>
          </fieldset>
          <!-- </form> -->
        </div>
        <div class="modal-footer">
          <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
          <button type="submit" id="btnActualizar" name="btnActualizar" class="btn btn-success">Enviar</button>
        </div>
      </div>
      <?php echo form_close(); ?>
    </div>
  </div>
  <script src="Plantilla/assets/js/Validaciones/InstructoresValid.js"></script>
  <script src="Plantilla/assets/js/Instructores.js"></script>
