

function mostrarProgramacion(id_programacion){

  $("#ModificarProgramacion").modal();

  $.ajax({
    url: 'ControllerProgramacion/mostrarProgramacion',
    type: 'POST',
    dataType: 'json',
    data:{id_programacion: id_programacion}

  }).done(function (data) {

    $("#oculto").val(data[0].id_programacion);
    $("#fechaModificar").val(data[0].fecha);
    $("#horaModificar").val(data[0].hora);
    $("#lugarModificar").val(data[0].lugar);
    $("#ModificarProgramacion").show();

  }).fail(function (data) {
    alert("error");
    console.log(data);
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
console.log(data);
});
});
}
