<?php
include 'Master.php';
?>

<div id="page-wrapper" >
  <div class="header">
    <h1 class="page-header">
      Trazabilidad <small>repositorio</small>
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
          </div>
          <div class="panel-body">
            <div class="row">

              <div class="col-lg-12">

                <div class="form-group">
                  <form class="form-horizontal" action="<?php base_url(); ?>ControllerTrazabilidad" method="post">
                    <div class="col-md-4">
                      <input type="number" name="txtidficha" value="" class="form-control">
                    </div>
                    <div class="col-md-4">
                      <button type="submit" name="button" class="btn btn-primary">Consultar</button>
                    </div>

                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">
        Listado de Fichas
      </div>
      <div class="-panel-body">
        <div class="row">
          <div class="col-md-12">
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
                    <td><?php echo '<a href="'.$f['Url'].'"> '.substr($f['Url'],10).' </a>' ?></td>
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
