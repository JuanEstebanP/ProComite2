<?php
/**
*
*/
class Controllerhome extends CI_Controller
{

public function index(){

  if ($this->session->userdata('usuario')) {
    $this->load->view('Home');
  }else {
    redirect('ControllerLogin');
  }


  }

}




?>
