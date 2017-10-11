
function Regis(){

  var titulo =$ ('#titulo').val();
  var fecha =$ ('#fecha').val();
  var hora =$ ('#hora').val();
  var lugar =$ ('#lugar').val();
  var lista = [];

  var letras = /^[a-zA-Z]+$/;

  $(".listaapren:checked").each(function() {
    lista.push(this.value);
  });
  if (letras.test($('#titulo').val()) == false) {
    alertify.error("Campo titulo incorrecto o vacío");
    return false;
  }else   if (fecha == "") {
        alertify.error("Campo fecha obligatorio");
        return false;
  }else   if (hora == "" ) {
        alertify.error("Campo hora obligatorio");
        return false;
  }else   if (letras.test($('#lugar').val()) == false) {
        alertify.error("Campo lugar incorrecto o vacío");
        return false;
  }else   if (lista.length <= 0) {
    alertify.error("Seleccione una ficha");
    return false;
  } else {
        $.ajax({
        url: 'ControllerProgramacion/registrarProgramacion',
        type: 'POST',
        data: {titulo:titulo,fecha:fecha,hora:hora,lugar:lugar,id:lista},
        dataType: 'JSON'
      }).done(function (data){
        swal(
          'Exitoso!',
          'Los aprendices seleccionados se asociaron a la ficha seleccionada!',
          'success'
        )
        setTimeout(function(){location.reload()}, 1300);

      });
  }


}

function mostrarProgramacion(id_programacion){

  $("#ModificarProgramacion").modal();

  $.ajax({
    url: 'ControllerProgramacion/mostrarProgramacion',
    type: 'POST',
    dataType: 'json',
    data:{id_programacion: id_programacion}

  }).done(function (data) {

    $("#oculto").val(data[0].id_programacion);
    $("#tituloModificar").val(data[0].titulo);
    $("#fechaModificar").val(data[0].fecha);
    $("#horaModificar").val(data[0].hora);
    $("#lugarModificar").val(data[0].lugar);
    $("#ModificarProgramacion").show();

  }).fail(function (data) {
    alert("error");

  });
}


function consultarInstructores(data) {

  var valor = data;

  $.ajax({
    url: 'ControllerProgramacion/consultarInstructores',
    type: "POST",
    data: {id:valor},
    dataType: "JSON"
  }).done(function (data){
    $("#listainst").html("");
    $.each(data, function(i, v) {
      $("#listainst").append("<tr><td>"+v.id_instructor+"</td><td>"+v.nombre+"</td><td>"+v.apellido+"</td><td>"+v.documento+"</td><td>"+v.correo+"</td></tr>");

    });
  });
}

function fichasXprogramacion(data) {
 $("#myModaldos").modal();
  var valor = data;
  $.ajax({
    url: 'Controllerlistprograma/Fichas',
    type: "POST",
    data: {id:valor},
    dataType: "JSON"
  }).done(function (data){
      $("#proyectosXcomite").html("");
      $.each(data, function(i, v){
        $("#proyectosXcomite").append("<tr><td>"+v.id_ficha+"</td><td>"+v.titulo+"</td><td>"+v.obj_general+"</td></tr>");
      });
  }).fail(function(data){
    alert("error");
  });
}

function pdf(id){
var valor = id;
console.log(valor);
location.href = 'http://localhost/ProComite2/index.php/Controllerlistprograma/generarPDFtodo/' + valor;

}
