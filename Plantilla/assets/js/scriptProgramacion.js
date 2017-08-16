
$("#btnProgramacionModificar").click(function() {

    var formularioModificar = $("#formularioModicarProgramacion").serialize();
  $.ajax({
    url: 'ControllerProgramacion/editarProgramacion',
    type: 'POST',
    data: formularioModificar,
  }).done(function(data){
    console.log(data);

  }).fail(function(data){
    console.log(data);
  });
});

$("#btnProgramacion").on("click",function() {
  $("#myModal").modal();
  var formulario =$("#formularioProgramacion").serialize();

  $.ajax({
    url: 'ControllerProgramacion/registrarProgramacion',
    type: 'POST',
    data: formulario,
  }).done(function(data){
  //  $("#myModal").show();
    console.log(data);
  }).fail(function(data){
    console.log(data);
  });
});


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

function abrirModal(){
  $("#myModal").modal();
}
