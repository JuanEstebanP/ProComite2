
/*
registrar Instructores

*/

function regisInstructor() {

var txtNombre  =$('#txtNombre').val();
var txtApellido =$('#txtApellido').val();
var txtDocumento =$('#txtDocumento').val();
var txtCorreo =$('#txtCorreo').val();

  var letras = /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/;
  var numeros = /^[0-9]+$/;
  var email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;

  if (letras.test($('#txtNombre').val()) == false) {
    alertify.error("Campo nombre incorrecto o vacío");
    return false;
  }else if (letras.test($('#txtApellido').val()) == false) {
    alertify.error("Campo apellido incorrecto o vacío");
    return false;
  }else if (numeros.test($('#txtDocumento').val()) == false) {
    alertify.error("Campo documento incorrecto o vacío");
    return false;
  }else if (email.test($('#txtCorreo').val()) == false) {
    alertify.error("Campo correo incorrecto o vacío");
    return false;
  }else {
    $.ajax({
      url: 'ControllerInstructor/InsertarInstructor',
      type: 'POST',
      data: {txtNombre:txtNombre,
      txtApellido:txtApellido,
      txtDocumento:txtDocumento,
      txtCorreo:txtCorreo},
    }).done(function(data){
      swal(
        'Exitoso!',
        'El instructor fue agragado satisfactoriamente!',
        'success'
      );
      setTimeout(function(){location.reload()}, 1300);

      $('#txtNombre').value = "";
      $('#txtApellido').value = "";
      $('#txtDocumento').value = "";
      $('#txtCorreo').value = "";
    }).fail(function(data){

    });
  }
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
