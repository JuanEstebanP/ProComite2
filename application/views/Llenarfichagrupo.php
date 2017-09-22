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
  <label class="control-label" for="textinput" style="float:right; margin-top:3%;">Fichas Grupos:</label>
</div>

<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="height:60px;">
<div class="form-group">
  <select class="form-control" data-live-search="true" id="txtFicha1" name="txtFicha" style="width:30%; margin-top:2%;" >
    <option value=""></option>
    <?php foreach ($Ficha as $key):?>
      <option value="<?= $key['id_fichaGrupo'] ?>">Nombre:
        <?=$key['numeroFicha'];?>
      </option>
    <?php endforeach ?>
  </select>
</div>
</div>


<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height:40px;">
  <div class="form-group">
    <div>
      <center><button name="buttonRegistrar" type="submit" class="btn btn-success" id="hola" >Asociar</button></center>
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
                      <table class="table table-striped table-bordered table-hover" id="dataTables-example"  >
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
                        <tbody id="tblAprendiz">

                          <?php   foreach ($Aprendiz as $a) { ?>

                            <tr class="odd gradeX">
                              <td><?php echo $a['id_aprendiz']; ?></td>
                              <td><?php echo $a['nombre']; ?></td>
                              <td><?php echo $a['apellido']; ?></td>
                              <td><?php echo $a['documento']; ?></td>
                              <td class="center"><?php echo $a['correo']; ?></td>
                              <td>
                                <input class="listaapren" type="checkbox" value="<?php echo $a['id_aprendiz'];?>"></input>
                              </td>
                              </tr>
                            <?php
                           } ?>
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


<script src="Plantilla/assets/js/llenarfichasgrupos.js"></script>
