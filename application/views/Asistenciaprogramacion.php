<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Asistencia <small></small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="<?php base_url() ?>Controllerhome">Pagina principal</a></li>
    </ol>

  </div>

  <div id="page-inner">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="container-fluid">
          <div class="form-group">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <label class="control-label" for="textinput">programación</label>
            </div>
            <select class="form-control" data-live-search="true" id="txtpro"  name="txtpro">
              <option value=""></option>
              <?php foreach ($programacion as $f): ?>
                <option value="<?=  $f['id_programacion']; ?>">Titulo:
                  <?= $f['titulo']; ?>        Fecha:
                  <?= $f['fecha']; ?>
                </option>
              <?php endforeach ?>
            </select>
          </div>



    <!-- </div> -->

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height:40px;">
      <div class="form-group">
        <div>
          <center><button type="submit" class="btn btn-success" id="asistencia">Asistencia</button></center>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">
    Listado
  </div>
  <div class="panel-body">
    <div class="table-responsive" id="tab">
      <table class="table table-striped table-bordered table-hover" id="dataTables-example">
        <thead>
          <tr>
            <th class="center">#</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Documento</th>
            <th>Correo</th>
            <th>Asociar</th>
          </tr>
        </thead>
        <tbody id="tblasistencia">
          <?php   foreach ($instructores as $i) { ?>
            <tr class="odd gradeX">
              <td><?php echo $i['id_instructor']; ?></td>
              <td><?php echo $i['nombre']; ?></td>
              <td><?php echo $i['apellido']; ?></td>
              <td><?php echo $i['documento']; ?></td>
              <td><?php echo $i['correo']; ?></td>
              <td><input class="listainst" type="checkbox" value="<?php echo $i['id_instructor'];?>"></input></td>
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
</div>

<script src="Plantilla/assets/js/AsistenciaProgramacion.js"></script>
