
/*
registrar Instructores

*/

function regis() {
  var formulario =$("#formInstructor").serialize();

  $.ajax({
    url: 'ControllerInstructor/InsertarInstructor',
    type: 'POST',
    data: formulario,
  }).done(function(data){
    console.log(data);
  }).fail(function(data){
    console.log(data);
  });
}


/*
Actualizar Instructores

*/
function modi() {
  var formulario = $("#formActualizar").serialize();

  $.ajax({
    url: 'ControllerInstructor/ActualizarInstructor',
    type: 'POST',
    data: formulario,
  }).done(function(data){
    console.log(data);
  }).fail(function(data){
    console.log(data);
  });
}

/*
Cargar Datos en modal

*/

function Editar(data){
  $('#myModal').modal();
  console.log(data);
  // $("#txtId").val(data);
  $.ajax({

    url: 'ControllerInstructor/Editar',
    type: 'POST',
    dataType: 'JSON',
    data:{id_instructor:data}
  }).done(function(datos){
    console.log(datos);
    $('[name="txtIdModificar"]').val(datos.id_instructor);
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
