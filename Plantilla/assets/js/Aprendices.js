/*
REGISTRAR APRENDICES
*/

function regisAprendi() {
  var  txtDocumento =$('#txtDocumento').val();
  var  txtNombre =$('#txtNombre').val();
  var  txtApellido=$('#txtApellido').val();
  var  txtCorreo=$('#txtCorreo').val();

  var letras = /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/;
  var numeros = /^[0-9]+$/;
  var email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;

  if (numeros.test($('#txtDocumento').val()) == false ) {
    alertify.error("Campo documento incorrecto o vacío");
    return false;
  }else if (letras.test($('#txtNombre').val()) == false) {
    alertify.error("Campo nombre incorrecto o vacío");
    return false;
  }else if (letras.test($('#txtApellido').val()) == false) {
    alertify.error("Campo apellido incorrecto o vacío");
    return false;
  }else if (email.test($('#txtCorreo').val()) == false) {
    alertify.error("Campo correo incorrecto o vacío");
    return false;
  }else {
    $.ajax({
      url: 'ControllerAprendiz/InsertarAprendiz',
      type: 'POST',
      data: {txtDocumento:txtDocumento,
        txtNombre:txtNombre,
        txtApellido:txtApellido,
        txtCorreo:txtCorreo},
      }).done(function(data){
        swal(
          'Exitoso!',
          'Aprendiz seleccionado exitosamente!',
          'success'
        )
        setTimeout(function(){location.reload()}, 1300);
      }).fail(function(data){
        alert("wqwqw");
      });
    }
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
