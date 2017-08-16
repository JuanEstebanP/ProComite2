<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Aprendices <small></small>
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
        <div class="panel-heading"><center>
          Registrar Aprendiz
        </div></center>

        <?php echo form_open('ControllerAprendiz/InsertarAprendiz', array("class"=>"form-horizontal", "id"=>"formAprendiz", "role"=>"form", 'method'=>'post')); ?>
        <!-- Text input-->
        <fieldset>
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Documento: </label>
            <div class="col-md-4">
              <input id="txtDocumento" name="txtDocumento" type="text" placeholder="1152487985" class="form-control input-md" required="true">

            </div>
          </div>



          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Nombre: </label>
            <div class="col-md-4">
              <input id="txtNombre"  value="<?php echo $this->input->post('txtNombre'); ?>"
              name="txtNombre" type="text" placeholder="Juan, Alberto, Carlos" class="form-control input-md" required="true">

            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Apellido: </label>
            <div class="col-md-4">
              <input id="txtApellido" name="txtApellido" type="text" placeholder="Lopez, Zapata, Ciro" class="form-control input-md" required="true">

            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Correo: </label>
            <div class="col-md-4">
              <input id="txtCorreo" name="txtCorreo" type="text" placeholder="ejemplo@inix.com" class="form-control input-md" required="true">

            </div>
          </div>



          <!-- Button (Double) -->
          <div class="form-group">
            <label class="col-md-4 control-label" for="button1id"></label>
            <div class="col-md-8">
              <button name="buttonRegistrar" type="submit" class="btn btn-success">Registrar</button>
            </div>
          </div>
          <?php echo form_close(); ?>
        </div>

        <div class="panel panel-default">
          <div class="panel-heading"><center>
            Importar Aprendices
          </div></center>
          <div class="form-group">
            <form action="<?php base_url();  ?>ControllerAprendiz/ImportarExcel" enctype="multipart/form-data" method="post" class="form-horizontal">

              <!-- File Button -->
              <div class="form-group">
                <label class="col-md-4 control-label" for="filebutton">Cargar archivo:</label>
                <div class="col-md-4">
                  <input id="file" name="file" class="input-file" type="file">
                </div>
              </div>

              <!-- Button -->
              <div class="form-group">
                <label class="col-md-4 control-label" for="singlebutton">Importar:</label>
                <div class="col-md-4">
                  <button name="file" id="file" type="submit" class="btn btn-primary"><i class="fa fa-upload" aria-hidden="true"></i></button>
                </div>
              </div>
            </form>
          </div>
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
                <tbody id="tblAprendiz">

                  <?php   foreach ($Aprendiz as $a) { ?>

                    <tr class="odd gradeX">
                      <td><?php echo $a['id_aprendiz']; ?></td>
                      <td><?php echo $a['nombre']; ?></td>
                      <td><?php echo $a['apellido']; ?></td>
                      <td><?php echo $a['documento']; ?></td>
                      <td class="center"><?php echo $a['correo']; ?></td>
                      <td>


                        <button class="btn btn-primary" id="hoa" name="hoa" onclick="Editar(<?php echo $a['id_aprendiz']; ?>)">
                          <i class="fa fa-pencil" aria-hidden="true"></i></button>
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
        <h4 class="modal-title">Editar Aprendiz</h4>
      </div>
      <div class="modal-body">
        <!-- <form class="form-horizontal"> -->
        <?php echo form_open('ControllerAprendiz/EditarAprendiz', array("class"=>"form-horizontal", "id"=>"formActualizar", "role"=>"form", 'method'=>'post')); ?>
        <fieldset>
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinputmodificar">ID: </label>
            <div class="col-md-4">
              <input id="textinputmodificar" name="txtIdModificar" type="text" class="form-control input-md" readonly="" required="true">
            </div>
          </div>


          <div class="form-group">
            <label class="col-md-4 control-label" for="textinputmodificar">Documento: </label>
            <div class="col-md-4">
              <input id="textinputmodificar" name="txtDocumentoModificar" type="text" placeholder="placeholder" class="form-control input-md" required="true">
            </div>
          </div>


          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinputmodificar">Nombre: </label>
            <div class="col-md-4">
              <input id="textinputmodificar" name="txtNombreModificar" type="text" placeholder="placeholder" class="form-control input-md" required="true">
            </div>
          </div>


          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinputmodificar">Apellido: </label>
            <div class="col-md-4">
              <input id="textinputmodificar" name="txtApellidoModificar" type="text" placeholder="placeholder" class="form-control input-md" required="true">
            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinputmodificar">Correo: </label>
            <div class="col-md-4">
              <input id="textinputmodificar" name="txtCorreoModificar" type="text" placeholder="placeholder" class="form-control input-md" required="true">
            </div>
          </div>


        </fieldset>
        <!-- </form> -->
      </div>
      <div class="modal-footer">
        <input type="submit" name="BotonEditar" class="btn btn-primary" value="Enviar">

      </div>
    </div>

  </div>
</div>
<script src="Plantilla/assets/js/Validaciones/AprendicesValid.js"></script>
<script src="Plantilla/assets/js/Aprendices.js"></script>
