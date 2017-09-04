$('#asos').click(function () {
  var grup =$('#txtIdFicha').val();
  var lista = [];
  $(".listaapren:checked").each(function() {
    lista.push(this.value);
  });
  if (lista.length > 0) {
    $.ajax({
      url: 'ControllerLlenarfichapro/insertDetallefichapro',
      type:"POST",
      data:{id:grup,aprendiz:lista},
      dataType:"JSON",
    }).done(function(data){
      if(data.status){
        swal(
          'Exitoso!',
          'Los aprendices seleccionados se asociaron a la ficha seleccionada!',
          'success'
        )
        setTimeout(function(){location.reload()}, 1300);

      }
      else {
        alert("Error");
      }
    }).fail(function(jqXHR, textStatus, errorThrown){
      swal("Seleccione ficha de proyecto");
      // alert("oh rayos!");
    });
  }
  else {
    swal("Seleccione un aprendiz");
  }
});



$("#txtGrupo").change(function(){
  var valor = $("#txtGrupo").val();
   console.log(valor);
   $('#Seleccionar').html('');
  $.ajax({
    url: 'ControllerLlenarfichapro/obtenerProyectos',
    type:"POST",
    data:{id:valor},
    dataType:"JSON",
  }).done(function(data){
    var html = '';
    html += '<select class="form-control" data-live-search="true" id="txtIdFicha"  ><option value="">Seleccione ficha del proyecto</option>'
    html += '';
    for(var i = 0; i < data.length; i++){
        html += '<option value="'+ data[i].id_ficha +'">Ficha: ' + data[i].titulo + '</option>';
      }
        html += '</select>';
        $('#Seleccionar').append(html);
  });
});
