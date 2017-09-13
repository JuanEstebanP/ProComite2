$(document).ready(function(){

  $("#formFichaproyecto").validate({
    rules:{

      txtCliente : {required:true, txtDocumento:true},
      txtNombre : {required:true, txtNombre:true},
      txtObjetivo: {required:true, txtObjetivo:true},
      txtVersion: {required:true, txtVersion:true},
      txtEstado: {required:true, txtEstado:true}
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

      txtCliente :{ required: "Este campo es requerido", },
      txtNombre:{ required: "Este campo es requerido", },
      txtObjetivo:{ required: "Este campo es requerido", },
      txtVersion:{ required: "Este campo es requerido", },
      txtEstado:{required: "Este campo es requerido"}
    }

  });

  jQuery.validator.addMethod("txtNombre", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);

  }, 'Ingrese un nombre correcto');

  jQuery.validator.addMethod("txtObjetivo", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un objetivo válido');

  jQuery.validator.addMethod("txtCorreo", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[_A-z0-9-]+(.[_A-z0-9-]+)@[A-z0-9-]+[.]{1}[A-z0-9-]{2,4}([.]{1}[A-z]{2,4})*$/.test(value);
  }, 'Ingrese un correo correcto');

  jQuery.validator.addMethod("txtVersion", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[0-9]{1,3}$/.test(value);
  }, 'Ingrese un documento válido');

  //Validar Modal
  $("#Actualizarproyecto").validate({
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
