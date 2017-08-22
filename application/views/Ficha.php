<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Fichas <small></small>
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
          Registrar Ficha De Grupo
        </div></center>

        <?php echo form_open('ControllerFicha/InsertarFicha', array("class"=>"form-horizontal", "id"=>"formFicha", "role"=>"form", 'method'=>'post')); ?>
        <!-- Text input-->

  <fieldset>


  <div class="form-group">
      <label class="col-md-4 control-label" for="textinput">Titular De la Ficha:</label>
      <div class="col-md-4">
          <select class="form-control"  title="Ficha" data-live-search="true" id="txtTitular"name="txtTitular" >
        <?php foreach ($Ficha as $key):?>
        <option value="<?= $key['id_instructor'] ?>">Documento:
        <?=$key['documento'];?> / Nombre completo:
        <?=$key['nombre'];?>
        </option>
        <?php endforeach ?>
    </select>
  </div>
</div>



          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Numero De Ficha: </label>
            <div class="col-md-4">
              <input id="txtNumero" name="txtNumero" type="text" placeholder="11524" class="form-control input-md" required="true">

            </div>
          </div>



          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Incio Etapa Lectiva:</label>
            <div class="col-md-4">
              <input id="txtIniciolectiva" name="txtIniciolectiva" type="date"  class="form-control input-md" required="true">

            </div>
          </div>

          <!-- Text input-->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Fin Etapa Lectiva: </label>
            <div class="col-md-4">
              <input id="txtFinlectiva" name="txtFinlectiva" type="date"  class="form-control input-md" required="true">

            </div>
          </div>
          <!--multiple select  -->
          <div class="form-group">
            <label class="col-md-4 control-label" for="textinput">Aprendices</label>
            <div class="col-md-4">

              <select class="selectpicker" multiple data-max-options="4" >
                <option value=""></option>
                <?php foreach ($Aprendiz as $key):?>
                  <option value="<?= $key['id_aprendiz'] ?>">Nombre:
                    <?=$key['nombre'];?>
                  </option>
                <?php endforeach ?>

              </select>

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
          <div class="panel-heading">
            Listado
          </div>
          <div class="panel-body">
            <div class="table-responsive">
              <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                <thead>
                  <tr>
                    <th class="center">#</th>
                    <th>Nombre Ficha</th>
                    <th>Titular Ficha</th>
                    <th>Inicio Lectiva</th>
                    <th>Fin Lectiva</th>
                    <th>Editar</th>
                  </tr>
                </thead>
                <tbody id="tblAprendiz">

                  <?php   foreach ($Ficha2 as $f) { ?>

                <tr class="odd gradeX">
                  <td><?php echo $f['id_fichaGrupo']; ?></td>
                  <td><?php echo $f['numeroFicha']; ?></td>
                  <td><?php echo $f['titularFicha']; ?></td>
                  <td><?php echo $f['iniciolectiva']; ?></td>
                  <td><?php echo $f['finlectiva']; ?></td>
                  <td>


          <button class="btn btn-primary" id="hoa" name="hoa" onclick="Editar(<?php echo $f['id_fichaGrupo']; ?>)">
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
        <h4 class="modal-title">Editar Ficha</h4>
      </div>
      <div class="modal-body">
        <!-- <form class="form-horizontal"> -->
      <?php echo form_open('ControllerFicha/EditarFicha', array("class"=>"form-horizontal", "id"=>"formActualizar", "role"=>"form", 'method'=>'post')); ?>
          <fieldset>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinputmodificar">ID: </label>
              <div class="col-md-4">
                <input id="textinputmodificar" name="txtIdModificar" type="text" class="form-control input-md" readonly="" required="true">
              </div>
            </div>


            <div class="form-group">
                <label class="col-md-4 control-label" for="textinput">Titular De Ficha:</label>
                <div class="col-md-4">
                    <select class="selectpicker" data-style="select-with-transition" title="Ficha" data-live-search="true" id="txtTitular"name="txtTitularModificar" required="true">
                      <option value=""></option>
                  <?php foreach ($Ficha as $key):?>
                  <option value="<?= $key['id_instructor'] ?>">Documento:
                  <?=$key['documento'];?>
                  </option>
                  <?php endforeach ?>
              </select>
            </div>
          </div>


            <div class="form-group">
              <label class="col-md-4 control-label" for="textinputmodificar">Numero De Ficha: </label>
              <div class="col-md-4">
                <input id="textinputmodificar" name="txtNumeroModificar" type="text" placeholder="placeholder" class="form-control input-md" required="true">
              </div>
            </div>


            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinputmodificar">Incio Etapa Lectiva: </label>
              <div class="col-md-4">
                <input id="textinputmodificar" name="txtIniciolectivaModificar" type="text" placeholder="placeholder" class="form-control input-md" required="true">
              </div>
            </div>


            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinputmodificar">Fin Etapa Lectiva: </label>
              <div class="col-md-4">
                <input id="textinputmodificar" name="txtFinlectivaModificar" type="text" placeholder="placeholder" class="form-control input-md" required="true">
              </div>
            </div>

            <!-- Text input-->



          </fieldset>
        <!-- </form> -->
      </div>
      <div class="modal-footer">
        <button type="submit" name="BotonEditar" class="btn btn-primary">Enviar</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
    </div>

  </div>
</div>
<script src="Plantilla/assets/js/Fichas.js"></script>
