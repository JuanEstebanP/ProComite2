
$(document).ready(function() { $("#txtFicha1").select2(); });

$('#hola').click(function () {
  var grup =$('#txtFicha1').val();
  var lista = [];
  $(".listaapren:checked").each(function() {
    lista.push(this.value);
  });
  if (lista.length > 0) {
        $.ajax({
          url: 'ControllerLlenarfichagrupo/insertarDetallefichagrupo',
          type:"POST",
          data:{id:grup,apren:lista},
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
          swal("Seleccione ficha de grupo");
          // alert("oh rayos!");
        });
  }
  else {
    swal("Seleccione un aprendiz");
  }
});
