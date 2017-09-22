<?php
include 'Master.php';
?>


<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Gestión y Evaluación <small>Best form elements.</small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="<?php base_url() ?>Controllerhome">Home</a></li>
      <li><a href="#">Forms</a></li>
      <li class="active">Data</li>
    </ol>
  </div>


  <div id="page-inner">
    <div class="row">
      <div class="col-lg-12">
        <div class="panel panel-default">
          <div class="panel-heading">
            <div class="panel-body">
              <div class="row">

                <div class="col-lg-12">

                  <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                      <thead>
                        <tr>
                          <th class="center">ID Ficha</th>
                          <th>Titulo</th>
                          <th>Ficha pdf</th>
                          <th>Cliente</th>
                          <th>Objetivo general</th>
                          <th>Observación</th>
                          <th>Estado</th>
                          <th>Evaluar</th>
                          <th>Consultar fichas</th>

                        </tr>
                      </thead>
                      <tbody id="tbl_fichaproyecto">
                        <?php foreach ($fichasArh as $f ) { ?>

                          <tr class="odd gradeX">
                            <td><?php echo $f['id_ficha']; ?></td>
                            <td><?php echo $f['titulo']; ?></td>
                            <td><?php echo '<a href="'.$f['Url'].'"> '.substr($f['Url'],10).' </a>' ?></td>
                            <td><?php echo $f['nombre']; ?></td>
                            <td><?php echo $f['obj_general']; ?></td>
                            <td><?php echo $f['observacion']; ?></td>
                            <td><?php echo $f['nombreEstado']; ?></td>
                            <td>
                              <button class="btn btn-primary" type="button" name="btnEvaluar" id="btnEvaluar" onclick="DatosF(<?PHP echo $f['id_ficha']; ?>);"><i class="fa fa-pencil" aria-hidden="true"></i></button>
                            </td>
                            <td>
                              <button data-toggle="modal" data-target="#myModaluno" type="button" name="button" class="btn btn-primary"  onclick="trazabi(<?PHP echo $f['id_ficha']; ?>)"><i class="fa fa-search"></i></button>
                            </td>


                          </tr>

                        <?php  }  ?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--
MODAL PARA CAMBIAR ESTADO Y AGREGAR OBSERVACIONES
-->
<div id="ModalEvaluar" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Evaluar</h4>
      </div>
      <div class="modal-body">
        <!-- <form class="form-horizontal"> -->
        <?php echo form_open('ControllerEvaluarFichas/InsertardtllComite', array("class"=>"form-horizontal", "role"=>"form", "method"=>"post")); ?>
        <fieldset>

          <div class="form-group">
            <label class="col-md-4 control-label" for="textarea">ID: </label>
            <div class="col-md-4">
              <input type="text" name="idF"  class="form-control input-md" readonly>
            </div>
          </div>

          <!-- Select Basic -->
          <div class="form-group">
            <label class="col-md-4 control-label" for="selectbasic">Estado: </label>
            <div class="col-md-4">
              <select  name="EstadosF" class="form-control" id="txtEstado">
                <option value=""></option>
                <?php foreach($EstadosF as $fi): ?>
                  <option value="<?= $fi['id_estado']; ?>">
                    <?=$fi['nombreEstado'];?>
                  </option>
                <?php endforeach ?>
              </select>
            </div>
          </div>



          <!-- Textarea -->

          <div class="form-group">
            <label class="col-md-4 control-label" for="textarea">Observaciones: </label>
            <div class="col-md-4">
              <textarea class="form-control"  name="textarea" ></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit"   class="btn btn-success ">Enviar</button>

          </div>
        </fieldset>
        <!-- </form> -->
        <?php echo form_close(); ?>
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
            <th class="center">Fichas</th>



          </tr>
        </thead>
        <tbody id="tblTrazabilidad">

          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</div>


<script src="Plantilla/assets/js/EvaluarFicha.js"></script>
