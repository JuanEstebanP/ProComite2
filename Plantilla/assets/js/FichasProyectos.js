// function regisProyecto() {
//
//   var txtCliente =$('#txtCliente').val();
//   var txtNombre =$('#txtNombre').val();
//   var txtObjetivo =$('#txtObjetivo').val();
//   var file_pr =$('#file_pr').val();
//   var txtVersion =$('#txtVersion').val();
//   var txtFichagrupo =$('#txtFichagrupo').val();
//   var letras = /^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/;
//   var numeros = /^[0-9]+$/;
//   var ext = (file_pr.substring(file_pr.lastIndexOf("."))).toLowerCase();
//
// //   if (ext == '.pdf') {
// // alertify.error("Extensión no permitida");
// //   }else if (txtCliente == "") {
// //     alertify.error("weqeq");
// //     return;
// //   }
//
//
//   $.ajax({
//     url: 'ControllerFichaproyecto/InsertarFichaproyecto',
//     type: 'POST',
//     dataType: 'JSON',
//     data: {txtCliente:txtCliente,
//        txtNombre:txtNombre,
//        txtObjetivo:txtObjetivo,
//        file_pr:file_pr,
//        txtVersion:txtVersion,
//        txtFichagrupo:txtFichagrupo}
//     }).done(function(data){
//       console.log(data);
//     }).fail(function(data){
//
//     });
//
//
// }
$("#buttonRegistrar").on("click",function() {
 nom =  $("#txtNombre").val();
 if (nom == "hola"  ) {
   alert("llene el campo ");
 }
 else {
   var formulario =$("#formFichaproyecto").serialize();

   $.ajax({
     url: 'ControllerFichaproyecto/InsertarFichaproyecto',
     type: 'POST',
     data: formulario,
   }).done(function(data){
     console.log(data);
   }).fail(function(data){
     console.log(data);
   });
 }
});


  function Editar(data){
    $('#myModal').show();
    $.ajax({

      url: 'ControllerFichaproyecto/Editar',
      type: 'POST',
      dataType: 'JSON',
      data:{id_ficha:data}
    }).done(function(datos){
      console.log(datos);
    //  var selet = $('[name="txtClienteModificar"]').select2();
      $('[name="txtIdModificar"]').val(datos.id_ficha);
    $('[name="txtClienteModificar"]').val(datos.id_cliente).trigger('change');
      $('[name="txtNombreModificar"]').val(datos.titulo);
      $('[name="txtObjetivoModificar"]').val(datos.obj_general);
      $('[name="txtVersionModificar"]').val(datos.version);
      $('[name="txtFichagrupoM"]').val(datos.id_fichaGrupo)
      $('[name="txtEstadoModificar"]').val(datos.estado);
      $('#myModal').modal('show');
    }).fail(function(datos){
      console.log(datos);
      alert("error");
    });
  }

  function consultarAprendiz(data) {
    var valor= data;
    $.ajax({
      url: 'ControllerFichaproyecto/consultarAprendiz',
      type: "POST",
      data:{id:valor},
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


  $(document).ready(function() { $("#txtCliente").select2(); });
  $(document).ready(function() { $("#txtFichagrupo").select2(); });
  $(document).ready(function() { $("#txtClienteModificar").select2(); });
