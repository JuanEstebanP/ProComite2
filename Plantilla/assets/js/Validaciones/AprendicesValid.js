$(document).ready(function(){

  $("#formAprendiz").validate({
    rules:{

      txtDocumento : {required:true, txtDocumento:true},
      txtNombre : {required:true, txtNombre:true},
      txtApellido: {required:true, txtApellido:true},
      txtCorreo: {required:true, txtCorreo:true},
    },
    submitHandler:function(){
      regisAprendiz();
    },
    highlight:function(element){
      $(element).parent().removeClass('has-success').addClass('has-error');
    },

    success:function(element){
      $(element).parent().removeClass('has-error').addClass('has-success');
    },

    messages: {

      txtDocumento :{ required: "Este campo es requerido", },
      txtNombre:{ required: "Este campo es requerido", },
      txtApellido:{ required: "Este campo es requerido", },
      txtCorreo:{ required: "Este campo es requerido", },
    }

  });

  jQuery.validator.addMethod("txtNombre", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un nombre correcto');

  jQuery.validator.addMethod("txtApellido", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un Apellido correcto');

  jQuery.validator.addMethod("txtCorreo", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[_A-z0-9-]+(.[_A-z0-9-]+)@[A-z0-9-]+[.]{1}[A-z0-9-]{2,4}([.]{1}[A-z]{2,4})*$/.test(value);
  }, 'Ingrese un correo correcto');

  jQuery.validator.addMethod("txtDocumento", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[0-9]{7,10}$/.test(value);
  }, 'Ingrese un documento válido');

  $("#formActualizar").validate({
    rules:{

      txtDocumentoModificar : {required:true, txtDocumentoModificar:true},
      txtNombreModificar : {required:true, txtNombreModificar:true},
      txtApellidoModificar : {required:true, txtApellidoModificar:true},
      txtCorreoModificar : {required:true, txtCorreoModificar:true},
    },
    submitHandler:function(){
      actDatos();
    },
    highlight:function(element){
      $(element).parent().removeClass('has-success').addClass('has-error');
    },

    success:function(element){
      $(element).parent().removeClass('has-error').addClass('has-success');
    },

    messages:
    {
      txtDocumentoModificar:{ required: "Este campo es requerido", },
      txtNombreModificar:{ required: "Este campo es requerido", },
      txtApellidoModificar:{ required: "Este campo es requerido", },
      txtCorreoModificar:{ required: "Este campo es requerido", }


    }

  });
  jQuery.validator.addMethod("txtNombreModificar", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un nombre correcto');

  jQuery.validator.addMethod("txtApellidoModificar", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un Apellido correcto');

  jQuery.validator.addMethod("txtCorreoModificar", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[_A-z0-9-]+(.[_A-z0-9-]+)@[A-z0-9-]+[.]{1}[A-z0-9-]{2,4}([.]{1}[A-z]{2,4})*$/.test(value);
  }, 'Ingrese un correo correcto');

  jQuery.validator.addMethod("txtDocumentoModificar", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[0-9]{7,10}$/.test(value);
  }, 'Ingrese un documento válido');


});
