/*
FUNCION DE ACTUALIZAR LOS DATOS DEL CLIENTE
*/
function actDatos() {
  var formulario =$("#formActualizarCliente").serialize();

  $.ajax({
    url: 'ControllerCliente/ActualizarCliente',
    type: 'POST',
    data: formulario,
  }).done(function(data){
    console.log(data);
  }).fail(function(data){
    console.log(data);
  });
}



// MODAL PARA RETORNA CLIENTES


function Editar(data){
  $('#modalCliente').modal();
  console.log(data);

  $.ajax({

    url: 'ControllerCliente/Editar',
    type: 'POST',
    dataType: 'JSON',
    data:{id_cliente:data}
  }).done(function(datos){
    console.log(datos);
    $('[name="txtIdCliente"]').val(datos.id_cliente);
    $('[name="txtNombreCliente"]').val(datos.nombre);
    $('[name="txtApellidoCliente"]').val(datos.apellido);
    $('[name="txtTeleCliente"]').val(datos.telefono);
    $('[name="txtCorreoCliente"]').val(datos.correo);
    $('#modalCliente').show();

  }).fail(function(datos){
    console.log(datos);
    alert("error");
  });
}
function ok()
{
  alertify.success("Registro Exitoso!");
}

function regisCliente()
{
  var textNombreCliente =$('#textNombreCliente').val();
  var textApellidoCliente=$('#textApellidoCliente').val();
  var textTelefonoCliente=$('#textTelefonoCliente').val();
  var textCorreoCliente=$('#textCorreoCliente').val();

  var letras = /^[0-9a-zA-ZáéíóúàèìòùÀÈÌÒÙÁÉÍÓÚñÑüÜ_\s]+$/;
  var numeros = /^[0-9]+$/;
  var email = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;

  if (letras.test($('#textNombreCliente').val())== false) {
    alertify.error("Campo nombre incorrecto o vacío");
    return false;
  } else if (letras.test($('#textApellidoCliente').val())== false) {
    alertify.error("Campo apellido incorrecto o vacío");
    return false;
  }else if (numeros.test($('#textTelefonoCliente').val()) == false) {
    alertify.error("Campo teléfono incorrecto o vacío");
    return false;
  }else if (email.test($('#textCorreoCliente').val() ) == false) {
    alertify.error("Campo correo incorrecto o vacío");
    return false;
  }
  else {
    $.ajax({
      url: 'ControllerCliente/RegistrarCliente',
      type: 'POST',
      data: {textNombreCliente:textNombreCliente, textApellidoCliente:textApellidoCliente, textTelefonoCliente:textTelefonoCliente, textCorreoCliente:textCorreoCliente},
      datatype: 'JSON'
    }).done(function (data){

      swal(
        'Exitoso!',
        'Cliente registrado satisfactoriamente!',
        'success'
      );
      setTimeout(function(){location.reload()}, 1300);
      $('#textNombreCliente').value = "";
      $('#textApellidoCliente').value = "";
      $('#textTelefonoCliente').value = "";
      $('#textCorreoCliente').value = "";

    });
  }
}
