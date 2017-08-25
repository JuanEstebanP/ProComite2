$("#buttonRegistrar").on("click",function() {
  var formulario =$("#formFichaproyecto").serialize();

  $.ajax({
    url: 'ControllerFichaproyecto/InsertarFichaproyecto',
    type: 'POST',
    data: formulario,
  }).done(function(data){
    console.log(data);
  }).fail(function(data){
    console.log(data);
  });
});


function Editar(data){
  $('#myModal').show();
  $.ajax({

    url: 'ControllerFichaproyecto/Editar',
    type: 'POST',
    dataType: 'JSON',
    data:{id_ficha:data}
  }).done(function(datos){
    console.log(datos);
      $('[name="txtIdModificar"]').val(datos.id_ficha);
      $('[name="txtClienteModificar"]').val(datos.id_cliente);
      $('[name="txtNombreModificar"]').val(datos.titulo);
      $('[name="txtObjetivoModificar"]').val(datos.obj_general);
      $('[name="txtVersionModificar"]').val(datos.version);
      $('[name="txtFichagrupoM"]').val(datos.id_fichaGrupo)
      $('[name="txtEstadoModificar"]').val(datos.estado);
      $('#myModal').modal('show');
    }).fail(function(datos){
      console.log(datos);
      alert("error");
    });
}

function abrirM(data)
{


  $('#myModalC').show();
  $.ajax({
    url: 'ControllerFichaproyecto/abrirM',
    trype: 'POST',
    dataType: 'JSON',
    data:{id_ficha:data}
  }).done(function (data) {
    contenido+='<td class="text-center"><a data-toggle="tooltip" data-container="body" title="Consultar detalle"><span class="fa fa-eye Picon" aria-hidden="true" onclick="abrirM('+data.id_ficha+')"></span></td>';
    console.log(data);
    $('#myModalC').modal('show');
//    alert("entro",data);
  }).fail(function(data) {
    console.log(data);
  //  alert("Fallo esta cosa");

});
}
