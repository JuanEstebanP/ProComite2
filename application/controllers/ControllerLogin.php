

<?php
class ControllerLogin extends CI_Controller
{

  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlLogin');
  }

  function index()
  {
    if ($this->session->userdata('usuario')) {
      redirect('Controllerhome');
    }

    if (isset($_POST['contrasena'])) {
    if ($this->MdlLogin->login($_POST['usuario'],$_POST['contrasena'])) {
      $this->session->set_userdata('usuario',$_POST['usuario']);
      redirect('Controllerhome');

    }else {

      $html = "";
      $html .= "<div style='position:fixed; margin-top:15%; z-index:3333; margin-left: 43% '><h3>Usuario o contraseña incorrecto</div>";
      echo $html;
      // redirect('ControllerLogin');

      }
    }
    $this->load->view('Login');
  }

public function logout()
{
$this->session->sess_destroy();
redirect('ControllerLogin');
}

}
?>
