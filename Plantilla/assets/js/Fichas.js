$("#buttonRegistrar").on("click",function() {
  var formulario =$("#formFicha").serialize();

  $.ajax({
    url: 'ControllerFicha/InsertarFicha',
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

    url: 'ControllerFicha/Editar',
    type: 'POST',
    dataType: 'JSON',
    data:{id_fichaGrupo:data}
  }).done(function(datos){
    console.log(datos);
      $('[name="txtIdModificar"]').val(datos.id_fichaGrupo);
      $('[name="txtNumeroModificar"]').val(datos.numeroFicha);
      $('[name="txtTitularModificar"]').val(datos.titularFicha);
      $('[name="txtIniciolectivaModificar"]').val(datos.iniciolectiva);
      $('[name="txtFinlectivaModificar"]').val(datos.finlectiva);
      $('#myModal').modal('show');
    }).fail(function(datos){
      console.log(datos);
      alert("error");
    });
}


function consultaAprendices(data) {
  var valor = data;
  $.ajax({
    url:'ControllerFicha/consultaAprendices',
    type: "POST",
    data: {id:valor},
    dataType: "JSON"
  }).done(function(data){
    $("#tblaprendices").html("");
    $.each(data, function(i, v) {
      $("#tblaprendices").append("<tr><td>"+v.id_aprendiz+"</td><td>"+v.nombre+"</td><td>"+v.apellido+"</td><td>"+v.documento+"</td><td>"+v.correo+"</td></tr>");
console.log(data);
    });

  }).fail(function(data){
    alert("fail");
  });
}
