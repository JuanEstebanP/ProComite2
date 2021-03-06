<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Asociar <small></small>
    </h1>
    <ol class="breadcrumb">
      <li><a href="<?php base_url() ?>Controllerhome">Pagina principal</a></li>
    </ol>

  </div>

  <div id="page-inner">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <!-- <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="height:60px;"> -->
        <!-- Fichas de proyecto -->
        <div class="container-fluid">

          <div class="form-group">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <label class="control-label" for="textinput">Fichas grupo:</label>
            </div>
            <select class="form-control" data-live-search="true" id="txtGrupo"  name="txtGrupo">
              <option value=""></option>
              <?php foreach ($fichasGrupo as $f): ?>
                <option value="<?=  $f['id_fichaGrupo']; ?>">Ficha:
                  <?= $f['numeroFicha']; ?>
                </option>
              <?php endforeach ?>
            </select>
          </div>


          <div class="form-group">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
              <label class="control-label" for="textinput" >Fichas proyectos:</label>
            </div>
            <div id="Seleccionar">

            </div>
    </div>
    <!-- </div> -->

    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height:40px;">
      <div class="form-group">
        <div>
          <center><button type="submit" class="btn btn-success" id="asos">Asociar</button></center>
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
        <tbody id="tblasociados">

        </tbody>
      </table>
    </div>
  </div>
</div>
</div>
</div>
</div>
</div>

<script src="Plantilla/assets/js/Llenarfichaproyecto.js"></script>
