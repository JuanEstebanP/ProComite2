$("#login-button").click(function(event){
  var usuario = $('#usuario').val();
  var contrasena = $('#contrasena').val();


  $.ajax({
  url: 'ControllerLogin/index',
  type: 'POST',
  data: {usuario:usuario, contrasena:contrasena},
  dataType: 'JSON'
}).done(function (data){
    event.preventDefault();
  $('form').fadeOut(500);
  $('.wrapper').addClass('form-success');

})
});
