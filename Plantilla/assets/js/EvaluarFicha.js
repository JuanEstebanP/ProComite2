function DatosF(data){
  $('#ModalEvaluar').modal();

  $.ajax({

    url: 'ControllerEvaluarFichas/DatosF',
    type: 'POST',
    dataType: 'JSON',
    data:{id_ficha:data}
  }).done(function(datos){
    console.log(datos);
    $('[name="idF"]').val(datos.id_ficha);
    $('[name="EstadosF"]').val(datos.estado);
    $('#ModalEvaluar').modal('show');
  });
}


function trazabi (data) {
  var valor = data;
  $.ajax({
    url:'ControllerEvaluarFichas/fichasBf',
    type: "POST",
    data: {id:valor},
    dataType: "JSON"
  }).done(function(data){

    $("#tblTrazabilidad").html("");
    $.each(data, function(i, v) {
      $("#tblTrazabilidad").append("<tr><td><a href="+v.Url+">"+v.Url.substring(10)+"</a></td></tr>");
      console.log(data);
    });

  }).fail(function(data){
    alert("fail");
  });
}
