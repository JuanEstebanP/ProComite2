$('#asistencia').click(function () {
var pro = $('#txtpro').val();
var lista = [];
$('.listainst:checked').each(function () {
  lista.push(this.value);
});
if (lista.length > 0) {
  $.ajax({
    url: 'ControllerAsistenciaprogramacion/insertDetalleAsistencia',
    type: "POST",
    data:{programacion:pro,instruc:lista},
    dataType:"JSON",
  }).done(function(data) {
    if (data.funciono) {
      swal(
        'Exitoso!',
        'Los instructores seleccionados asistieron a la programacion! '+ "  " + pro,
        'success'
      )
      setTimeout(function(){location.reload()}, 1300);
  }
}).fail(function (jqXHR, textStatus, errorThrown) {
        swal("Seleccione Programación");
});
}
else {
  swal("seleccione instructor");
}
});
