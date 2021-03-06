<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Fichas De Proyectos <small></small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="<?php base_url() ?>Controllerhome">Pagina principal</a></li>
    </ol>

  </div>

  <div id="page-inner">
    <div class="col-lg-12">
      <div class="panel panel-default" style="height:400px;">
        <div class="panel-heading"><center>
          Registrar Ficha De Proyecto
        </div></center>

        <form  id="formFichaproyecto" class="form-horizontal" action="" method="post" enctype="multipart/form-data">

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Cliente Del Proyecto:</label>
              <div class="col-md-4">
                <select class="form-control"  id="txtCliente" name="txtCliente" required="true" >
                  <option value=""></option>
                  <?php foreach ($Fichaproyectos as $key):?>
                    <option value="<?= $key['id_cliente'] ?>">Nombre:
                      <?=$key['nombre'];?>
                    </option>
                  <?php endforeach ?>
                </select>
              </div>
            </div>



            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Nombre Del Poyecto: </label>
              <div class="col-md-4">
                <input id="txtNombre" name="txtNombre" type="text" placeholder="SAM" class="form-control input-md" >
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Objetivo General:</label>
              <div class="col-md-4">
                <input id="txtObjetivo" name="txtObjetivo" type="text" placeholder="Falta alcance."  class="form-control input-md" >
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Ficha:</label>
              <div class="col-md-4">
                <input type="file" name="file_pr" id="file_pr">
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Versión Del Poyecto: </label>
              <div class="col-md-4">
                <input id="txtVersion" name="txtVersion" type="text" placeholder="1,1..."  class="form-control input-md" >
              </div>
            </div>



            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Ficha De Grupo:</label>
              <div class="col-md-4">
                <select class="form-control"  id="txtFichagrupo" name="txtFichagrupo"  >
                  <option value=""></option>
                  <?php foreach ($ficha as $key):?>
                    <option value="<?= $key['id_fichaGrupo'] ?>">Numero:
                      <?=$key['numeroFicha'];?>
                    </option>
                  <?php endforeach ?>
                </select>
              </div>
            </div>


            <!-- Button (Double) -->
            <div class="form-group">
              <label class="col-md-4 control-label" for="button1id"></label>

            </div>

            <div class="col-lg-12" >
              <center><button  type="button" onclick="regisProyecto()" class="btn btn-success" >Registrar</button></center>
            </div>
        </form>

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
                  <th>Titulo proyecto</th>
                  <th>Objetivo General</th>
                  <th>Versión</th>
                  <th>Cliente</th>
                  <th>Ficha a la que pertenece</th>
                  <th>Estado</th>
                  <th>Editar</th>
                  <th>Consultar aprendices</th>
                  <!-- <th>detalle</th> -->
                </tr>
              </thead>
              <tbody id="tbl_fichaproyecto">

                <?php   foreach ($Ficha2 as $f) { ?>

                  <tr class="odd gradeX">
                    <td><?php echo $f['id_ficha']; ?></td>
                    <td><?php echo $f['titulo']; ?></td>
                    <td><?php echo $f['obj_general']; ?></td>
                    <td><?php echo $f['version']; ?></td>
                    <td><?php echo $f['id_cliente']; ?></td>
                    <td><?php echo $f['id_fichaGrupo']; ?></td>
                    <td><?php echo $f['estado']; ?></td>

                    <td>


                      <button class="btn btn-primary" id="hoa" name="hoa" onclick="Editar(<?php echo $f['id_ficha'];?>)">
                        <i class="fa fa-pencil" aria-hidden="true"></i></button>
                      </td>

                      <td>

                        <button data-toggle="modal" data-target="#myModaluno" name="button" class="btn btn-primary" onclick="consultarAprendiz(<?php echo $f['id_ficha'];?>)">
                          <i class="fa fa-search" arial-hidden="true"></i>
                        </button>
                      </td>

                    </tr>
                  <?php } ?>
                </tbody>
              </table>
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
                    <tbody id="tblaprendices">

                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </fieldset>
  </div>
</div>




<!---
MODAL PARA EDITAR -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Editar Ficha De Proyecto</h4>
      </div>
      <div class="modal-body">
        <!-- <form class="form-horizontal"> -->
        <!-- <?php echo form_open('ControllerFichaproyecto/EditarFichaproyecto', array("class"=>"form-horizontal", "id"=>"formActualizar", "role"=>"form", 'method'=>'post')); ?> -->
        <form  id="Actualizarproyecto" class="form-horizontal" action="<?php base_url(); ?>ControllerFichaproyecto/EditarFichaproyecto" method="post" enctype="multipart/form-data">
          <fieldset>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinputmodificar">ID: </label>
              <div class="col-md-4">
                <input id="textinputmodificar" name="txtIdModificar" type="text" class="form-control input-md" readonly="" >
              </div>
            </div>


            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Cliente Del Proyecto:</label>
              <div class="col-md-4">
                <select class="form-control" id="txtClienteModificar"name="txtClienteModificar">
                  <option value=""></option>
                  <?php foreach ($Fichaproyectos as $key):?>
                    <option value="<?= $key['id_cliente'] ?>">Nombre:
                      <?=$key['nombre'];?>
                    </option>
                  <?php endforeach ?>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Nombre Del Poyecto: </label>
              <div class="col-md-4">
                <input id="txtNombreModificar" name="txtNombreModificar" type="text" placeholder="11524" class="form-control input-md" required="true">
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Objetivo General:</label>
              <div class="col-md-4">
                <input id="txtObjetivoModificar" name="txtObjetivoModificar" type="text" placeholder="Falta alcance."  class="form-control input-md" required="true">
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Archivo ficha:</label>
              <div class="col-md-4">
                <input  name="fileC" type="file" class="form-control input-md"   >
              </div>
            </div>
<div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Versión Del Poyecto: </label>
              <div class="col-md-4">
                <input id="txtVersionModificar" name="txtVersionModificar" type="text" placeholder="1.1..."  class="form-control input-md" required="true">
              </div>
            </div>


            <input type="hidden" name="txtFichagrupoM" value="">
            <input id="txtEstadoModificar" name="txtEstadoModificar" type="hidden"   class="form-control input-md" required="true">

            <!-- Text input-->
          </fieldset>
          <!-- </form> -->
        </div>
        <div class="modal-footer">
          <button type="submit" name="fileC" class="btn btn-primary">Enviar</button>

        </div>
        <!-- <?php echo form_close(); ?> -->
      </form>
    </div>

  </div>
</div>
<!-- Modal consultar fichas -->
<div id="myModalC" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Editar Ficha De Proyecto</h4>
      </div>
      <div class="modal-body">

        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover"  >
            <thead>
              <tr>
                <th>Fichas: </th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($fichasB as $f ){ ?>
              <tr class="odd gradeX">
              <td name="Url"><?php echo '<a href="'.$f['Url'].'"> '.substr($f['Url'],10).' </a>' ?></td>
            </tr>

          <?php } ?>
        </tbody>
      </table>



    </div>
  </div>



</div>
      <button type="submit" name="fileC" class="btn btn-primary">Enviar</button>
</div>
</div>
<!-- <script src="Plantilla/assets/js/Validaciones/ProyectoValid.js"></script> -->
<script src="Plantilla/assets/js/FichasProyectos.js"></script>
