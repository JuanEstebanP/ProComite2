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
            swal({
    title: "¿Esta seguro de asociar los aprendices seleccionados?",
    type: "warning",
    showCancelButton: true,
    confirmButtonColor: "#5cb85c",
    confirmButtonText: "Asociarlos!",
    closeOnConfirm: false
  },
function(){
  swal("Asociados", "Los aprendices fueron asociados.", "success");

  setTimeout(function(){location.reload()}, 2000);
});

}
          else {
            alert("Error");
          }
        }).fail(function(jqXHR, textStatus, errorThrown){
          swal("Seleccione ficha de grupo");
          // alert("oh rayos!");
        });
  }
  else {
    swal("Seleccione un aprendiz");
  }
});
