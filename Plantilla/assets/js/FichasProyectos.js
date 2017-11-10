function regisProyecto() {
	var  cliente =$('#txtCliente').val();
	var  nombre =$('#txtNombre').val();
	var  objetivo=$('#txtObjetivo').val();
	var  version=$('#txtVersion').val();
	var  ficha=$('#txtFichagrupo').val();
	var  archivo=$('#file_pr').val();

	if ( cliente == "" ) {
    alertify.error("Campo cliente incorrecto o vacío");
    return false;
  }else if (nombre == "") {
    alertify.error("Campo nombre proyecto incorrecto o vacío");
    return false;
  }else if (objetivo == "") {
    alertify.error("Campo objetivo incorrecto o vacío");
    return false;
}else if (archivo == "") {
	alertify.error("Campo archivo incorrecto o vacío");
	return false;
}else if (version == "") {
    alertify.error("Campo version incorrecto o vacío");
    return false;
  }else if (ficha == ""){
		alertify.error("Campo ficha grupo incorrecto o vacío");
		return false;
	}
	else {


		var formData = new FormData($("#formFichaproyecto")[0]);

    // var file_data = $('#file_pr').prop('files')[0];

    // formData.append('file', file_data);
    // alert(formData);
		$.ajax({
			url:'ControllerFichaproyecto/InsertarFichaproyecto',
          type: 'post',
          data: formData,
          dataType: 'text',  // what to expect back from the PHP script, if anything
                cache: false,
                contentType: false,
                processData: false,
			success:function(){
				swal(
					'Exitoso!',
					'Ficha de proyecto registrada exitosamente!',
					'success'
				)
				setTimeout(function(){location.reload()}, 1300);


				/*if (resp==="Exito") {
					alert(resp);
					$("#msg-error").hide();
					$("#form-create-usuario")[0].reset();
				}else if(resp==="Error"){
					alert(resp);
				}
				else{
					$(".list-errors").html(resp);
					$("#msg-error").show();
				}*/
			}

		});

}
}


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
