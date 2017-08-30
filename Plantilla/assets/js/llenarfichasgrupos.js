$('#hola').click(function () {
  var grup =$('#txtFicha').val();
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
            alertify.success("Exitoso");
            setTimeout(function(){location.reload()}, 1000);
          }
          else {
            alert("Error");
          }
        }).fail(function(jqXHR, textStatus, errorThrown){
          alertify.error("Seleccione ficha de grupo.");
          // alert("oh rayos!");
        });
  }
  else {
    alertify.error("Seleccione aprendiz.");
  }
});
