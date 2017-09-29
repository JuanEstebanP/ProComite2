$(document).ready(function(){

  $('#formularioProgramacion').validate({
    rules:{


      titulo : {required:true, titulo:true}
      fecha : {required:true, fecha:true}
      hora: {required:true, hora:true}
      lugar: {required:true, lugar:true}
    },
    submitHandler:function(){
      Regis();
    },
    highlight:function(element){
      $(element).parent().removeClass('has-success').addClass('has-error');
    },

    success:function(element){
      $(element).parent().removeClass('has-error').addClass('has-success');
    },

    messages:{

      titulo :{ required: "Este campo es requerido", },
      fecha:{ required: "Este campo es requerido", },
      hora:{ required: "Este campo es requerido", },
      lugar:{ required: "Este campo es requerido", },

    }

  });
  jQuery.validator.addMethod("titulo", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);

  }, 'Ingrese un titulo correcto');

  jQuery.validator.addMethod("txtApellido", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);

  }, 'Ingrese un Apellido correcto');


});
