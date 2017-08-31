<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Asociar <small></small>
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
        <!-- <div class="panel-heading"><center>
        Asociar Aprendices A Ficha de Grupo
      </div></center> -->


      <fieldset>

        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="height:60px;">
          <label class="control-label" for="textinput" style="float:right; margin-top:3%;">Fichas proyectos:</label>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="height:60px;">
          <div class="form-group">
            <select class="form-control" data-live-search="true" id="txtIdFicha" required="true" style="width:30%; margin-top:2%;" >
              <option value="">---Buscar---</option>
              <?php foreach ($IdFichas as $Id) { ?>
                <option value="<?=  $Id['id_ficha']; ?>">Ficha:
                  <?= $Id['id_ficha']; ?>
                </option>
              <?php } ?>
            </select>
          </div>
        </div>


        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height:40px;">
          <div class="form-group">
            <div>
              <center><button name="buttonRegistrar" type="submit" class="btn btn-success" id="asos">Asociar</button></center>
            </div>
          </div>
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
                  <!-- <th>dghj</th> -->
                  <th>Asociar</th>
                </tr>
              </thead>
              <tbody id="tblAprendiz">
                <?php foreach ($Aprendices as $key ) { ?>
                  <tr class="odd gradeX">
                    <td><?php echo $key['id_aprendiz']; ?></td>
                    <td><?php echo $key['nombre'];?></td>
                    <td><?php echo $key['apellido'];?></td>
                    <td><?php echo $key['documento'];?></td>
                    <td><?php echo $key['correo']; ?></td>
                    <!-- <td><?php echo $key['estado']; ?></td> -->
                    <td>
                      <input class="listaapren" type="checkbox" value="<?php echo $key['id_aprendiz'];?>"></input>
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

<script src="Plantilla/assets/js/Llenarfichaproyecto.js"></script>
