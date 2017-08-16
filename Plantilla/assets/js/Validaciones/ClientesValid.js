var frmCliente= null;

$(document).ready(function (){

  frmCliente = $("#formCliente").validate({

    rules : {

      textNombreCliente : {required : true, textNombreCliente : true},
      textApellidoCliente: {required : true, textApellidoCliente : true},
      textTelefonoCliente: {required : true, textTelefonoCliente : true},
      textCorreoCliente: {required : true, textCorreoCliente : true}

    },

    submitHandler: function(formCliente){
      regisCliente();
    },
    highlight:function(element){
      $(element).parent().removeClass('has-success').addClass('has-error');
    },
    success:function(element){
      $(element).parent().removeClass('has-error').addClass('has-success');
    },

    messages:
    {

      textNombreCliente : {required : "Este campo es requerido",},
      textApellidoCliente : {required : "Este campo es requerido",},
      textTelefonoCliente : {required : "Este campo es requerido",},
      textCorreoCliente: {required : "Este campo es requerido",}
    }

  });
  jQuery.validator.addMethod("textNombreCliente", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un nombre correcto');

  jQuery.validator.addMethod("textApellidoCliente", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un Apellido correcto');

  jQuery.validator.addMethod("textCorreoCliente", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[_A-z0-9-]+(.[_A-z0-9-]+)@[A-z0-9-]+[.]{1}[A-z0-9-]{2,4}([.]{1}[A-z]{2,4})*$/.test(value);
  }, 'Ingrese un correo correcto');

  jQuery.validator.addMethod("textTelefonoCliente", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[0-9]{7,10}$/.test(value);
  }, 'Ingrese un teléfono válido');

  /*

  VALIDACION DEL FORMULARIO EN LA MODAL

  */
  $("#formActualizarCliente").validate({

    rules : {
      txtNombreCliente: {required : true, txtNombreCliente : true},
      txtApellidoCliente: {required : true, txtApellidoCliente : true},
      txtTeleCliente: {required : true, txtTeleCliente : true},
      txtCorreoCliente: {required : true, txtCorreoCliente : true}
    },

    submitHandler: function(formCliente){
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

      txtNombreCliente : {required : "Este campo es requerido",},
      txtApellidoCliente : {required : "Este campo es requerido",},
      txtTeleCliente : {required : "Este campo es requerido",},
      txtCorreoCliente: {required : "Este campo es requerido",}
    }

  });
  jQuery.validator.addMethod("txtNombreCliente", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un nombre correcto');

  jQuery.validator.addMethod("txtApellidoCliente", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) || /^[a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
  }, 'Ingrese un Apellido correcto');

  jQuery.validator.addMethod("txtCorreoCliente", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[_A-z0-9-]+(.[_A-z0-9-]+)@[A-z0-9-]+[.]{1}[A-z0-9-]{2,4}([.]{1}[A-z]{2,4})*$/.test(value);
  }, 'Ingrese un correo correcto');

  jQuery.validator.addMethod("txtTeleCliente", function (value, element) {
    // allow any non-whitespace characters as the host part
    return this.optional(element) ||  /^[0-9]{7,10}$/.test(value);
  }, 'Ingrese un teléfono válido');

});
