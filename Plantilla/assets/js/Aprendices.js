/*
REGISTRAR APRENDICES
*/

function regisAprendi() {
  var formulario =$("#formAprendiz").serialize();

  $.ajax({
    url: 'ControllerAprendiz/InsertarAprendiz',
    type: 'POST',
    data: formulario,
  }).done(function(data){
    console.log(data);
  }).fail(function(data){
    console.log(data);
  });
}
/*
ACTUALIZAR APRENDICES
*/
function actDatos() {
  var formulario = $("#formActualizar").serialize();

  $.ajax({
    url: 'ControllerAprendiz/EditarAprendiz',
    type: 'POST',
    data: formulario,
  }).done(function(data){
    console.log(data);
  }).fail(function(data){
    console.log(data);
  });
}
/*
CARGAR DATOS EN VENTANA MODAL
*/
function Editar(data){
  $('#myModal').show();
  $.ajax({

    url: 'ControllerAprendiz/Editar',
    type: 'POST',
    dataType: 'JSON',
    data:{id_aprendiz:data}
  }).done(function(datos){
    console.log(datos);
      $('[name="txtIdModificar"]').val(datos.id_aprendiz);
      $('[name="txtNombreModificar"]').val(datos.nombre);
      $('[name="txtApellidoModificar"]').val(datos.apellido);
      $('[name="txtDocumentoModificar"]').val(datos.documento);
      $('[name="txtCorreoModificar"]').val(datos.correo);
      $('#myModal').modal('show');
    }).fail(function(datos){
      console.log(datos);
      alert("error");
    });
}
