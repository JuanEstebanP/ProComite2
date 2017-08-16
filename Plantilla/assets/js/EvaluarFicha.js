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
