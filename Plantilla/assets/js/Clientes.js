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

/*
FUNCION DE REGISTRAR CLIENTES
*/
// function regisCliente() {
//
//   var formulario = $("#formCliente").serialize();
//
//   $.ajax({
//     url: 'ControllerCliente/RegistrarCliente',
//     type: 'POST',
//     data: formulario,
//   }).done(function(data){
//     console.log(data);
//   }).fail(function(data){
//     console.log(data);
//   });
// }
/*

MODAL PARA RETORNA CLIENTES

*/
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
