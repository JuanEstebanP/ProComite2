var frmm = null;

$(document).ready(function ( ) {
    frmm = $("#form").validate({

            rules: {

                txtGrupoM:
                { required: true, txtGrupoM: true },

                txtGrupoModificar:
                { required: true, txtGrupoModificar: true },
            },
            submitHandler: function (form) {

                insertar();

            },

            highlight:function(element){
                $(element).parent().removeClass('has-success').addClass('has-error');
            },

            success:function(element){
                $(element).parent().removeClass('has-error').addClass('has-success');
            },
            //// Mensaje
            messages:
            {
                txtGrupoM: { required: "Este campo es requerido", },
                txtGrupoModificar: { required: "Este campo es requerido", },
            }
      });

    ///// Validacion con expresiones regulares

    jQuery.validator.addMethod("txtGrupoM", function (value, element) {
        // allow any non-whitespace characters as the host part
        return this.optional(element) || /^[0-9-a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
    }, 'Ingrese un nombre correcto');

    ////// Desavilita el boton de registrar los cambios de nombre de la enfermedad si el campo no esta correcto

    $('#form').on('keyup blur', function () {
        if ($("#form").valid()) {

            $('#registrar').show();

        } else {

            $('#registrar').hide();

        }
    });

    ///// form para modificar

    $("#formModificar").validate({

        rules: {

            txtGrupoModificar:
            { required: true, txtGrupoModificar: true },
        },
        submitHandler: function (formModificar) {
            modificraEnfermedad();
        },

        highlight: function (element) {
            $(element).parent().removeClass('has-success').addClass('has-error');
        },

        success: function (element) {
            $(element).parent().removeClass('has-error').addClass('has-success');
        },

        //// Mensaje
        messages:
        {
            txtGrupoModificar: { required: "Este campo es requerido", },
        }
    });

    ///// Validacion con expresiones regulares

    jQuery.validator.addMethod("txtGrupoModificar", function (value, element) {
        // allow any non-whitespace characters as the host part
        return this.optional(element) || /^[0-9-a-zA-ZñÑáéíóúÁÉÍÓÚ/\s/a-zA-ZñÑáéíóúÁÉÍÓÚ]+$/.test(value);
    }, 'Ingrese un nombre correcto');

    ////// Desavilita el boton de guardar los cambios de nombre de la enfermedad si el campo no esta correcto
    //$('#formModificar').on('keyup blur', function () {
    //    if ($("#formModificar").valid()) {

    //        $('#guardar').show();

    //    } else {

    //        $('#guardar').disabled();

    //    }
    //});

});
