<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <h1 class="page-header">
    Programar Comité
  </h1>
  <div class="header">
    <ol class="breadcrumb">
      <li><a href="<?php base_url() ?>Controllerhome">Pagina principal</a></li>
    </ol>
  </div>


<div class="col-lg-12">
        <div class="panel panel-default">
          <div class="panel-headig">
            Listado
          </div>
          <div class="panel-body">
            <div class="table-responsive">
              <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                <thead>
                  <th>#</th>
                  <th>Titulo</th>
                  <th>Objetivo general</th>
                  <th>Ficha carac.</th>
                  <th>Estado</th>
                  <th>Elegir</th>
                </thead>
                <tbody>
                  <?php foreach ($fichasXestado as $key) { ?>
                    <tr>
                      <td><?php echo $key['id_ficha'];  ?></td>
                      <td><?php echo $key['titulo']; ?></td>
                      <td><?php echo $key['obj_general']; ?></td>
                      <td><?php echo $key['numeroFicha']; ?></td>
                      <td><?php echo $key['nombreEstado'];?></td>
                      <td><input class="listaapren" type="checkbox" name="" value="<?php echo $key['id_ficha'];?>"></td>
                    </tr>
                  <?php    } ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>





        <div class="panel panel-default">
          <div class="panel-body">
            <form class="form-horizontal" role="form" id="formularioProgramacion" method="post"  >
              <fieldset>


                <div class="form-group">
                  <label class="col-md-4 control-label" for="textinput">Titulo Programación</label>
                  <div class="col-md-4">
                    <input id="titulo" name="titulo" type="text" placeholder="Prueba" class="form-control input-md" required="TRUE">

                  </div>
                </div>
                <!-- Text input-->
                <div class="form-group">
                  <label class="col-md-4 control-label" for="textinput">Fecha</label>
                  <div class="col-md-4">
                    <input id="fecha" name="fecha" type="date" placeholder="dia-mes-año" class="form-control input-md" required="TRUE">

                  </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                  <label class="col-md-4 control-label" for="textinput">Hora</label>
                  <div class="col-md-4">
                    <input id="hora" name="hora" type="time" placeholder="00:00" class="form-control input-md" required="TRUE">

                  </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                  <label class="col-md-4 control-label" for="textinput">Lugar</label>
                  <div class="col-md-4">
                    <input id="lugar" name="lugar" type="text" placeholder="torre norte" class="form-control input-md" required="TRUE">

                  </div>
                </div>

                <!-- Button -->

              </fieldset>
              <!-- <?php echo form_close(); ?> -->
            </form>

            <center><button type"button" class="btn btn-success" onclick="Regis()">REGISTRAR</button></center>
            <div class="form-group">
              <label class="col-md-4 control-label" for="singlebutton"></label>

            </div>
          </div>

        </div>
      </div>

</div>

    </div>

  </div>


  <!--MODAL MODIFICAR PROGRAMACION-->
  <div id="ModificarProgramacion" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modificar Programacion</h4>
        </div>
        <div class="modal-body">
          <!-- <form class="form-horizontal" role="form" id="formularioModicarProgramacion" method="post"> -->
          <fieldset>

            <input type="hidden" id="oculto" name="oculto">

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Titulo Programación</label>
              <div class="col-md-4">
                <input id="tituloModificar" name="tituloModificar" type="text" class="form-control input-md">

              </div>
            </div>
            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Fecha</label>
              <div class="col-md-4">
                <input id="fechaModificar" name="fechaModificar" type="date" placeholder="dia-mes-año" class="form-control input-md">
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Hora</label>
              <div class="col-md-4">
                <input id="horaModificar" name="horaModificar" type="time" placeholder="00:00" class="form-control input-md">
              </div>
            </div>
            <!-- Text input-->
            <div class="form-group">
              <label class="col-md-4 control-label" for="textinput">Lugar</label>
              <div class="col-md-4">
                <input id="lugarModificar" name="lugarModificar" type="text" placeholder="torre norte" class="form-control input-md">

              </div>
            </div>

            <!-- Button -->
            <div class="form-group">
              <label class="col-md-4 control-label" for="singlebutton"></label>
            </div>
          </fieldset>

          <!-- </form> -->
        </div>

        <div class="modal-footer">
          <button id="btnProgramacionModificar" type"submit" name="btnProgramacionModificar" class="btn btn-success" >Modificar</button>
          <button type="button" id="cerrar" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        </div>
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
                <th class="center">#</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Documento</th>
                <th>Correo</th>
              </tr>
            </thead>
            <tbody id="listainst">


            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal de fichas -->
  <div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <table>
            <thead>
              <th></th>
              <th></th>
              <th></th>
            </thead>
            <tbody >

            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
<!-- fin modal fichas -->

</div>
</div>


</fieldset>
</div>
</div>

<script src="Plantilla/assets/js/scriptProgramacion.js"></script>
