<?php
/**
 *
 */
class ControllerAsistenciaprogramacion extends CI_Controller
{

  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlAsistenciaProgramacion');
  }


function index()
{
  if ($this->session->userdata('usuario')) {
    $data['programacion'] = $this->MdlAsistenciaProgramacion->consultarProgramaciones();
    $data["instructores"] = $this->MdlAsistenciaProgramacion->instructores();
    $this->load->view('AsistenciaProgramacion',$data);
  }else {
    redirect('ControllerLogin');
  }


}

function insertDetalleAsistencia()
{
  $programacion = $this->input->post('programacion');
  $instructores = $this->input->post('instruc');

  foreach ($instructores as $key) {

    $this->MdlAsistenciaProgramacion->registrarasistencia($programacion,$key);

  }
  echo json_encode(array("funciono" => true));
}








}?>
