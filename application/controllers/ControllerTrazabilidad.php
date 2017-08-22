<?php
/**
*
*/
class ControllerTrazabilidad extends CI_Controller

{

  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlTrazabilidad');
  }

  function index()
  {
  $dt = $this->input->post('txtidficha');
  $data['fichasB'] = $this->MdlTrazabilidad->fichasBf($dt);
    $this->load->view('trazabilidad',$data);
  }

// function Codtraz()
// {
//
//   $this->load->view('trazabilidad',$data);
// }

}

?>
