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
            //reload_table();
            alertify.success("Exitoso");
          }
          else {
            alert("Error");
          }
        }).fail(function(jqXHR, textStatus, errorThrown){
          alert("oh rayos!");
        });
  }
});
