<?php
/**
*
*/
class ControllerLlenarfichapro extends CI_Controller
{

  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->helper('array');
    $this->load->model('MdlLlenarfichapro');
  }

  function index()
  {
    $data['fichasGrupo'] = $this->MdlLlenarfichapro->Fichasgruo();
    $data['IdFichas'] = $this->MdlLlenarfichapro->IdFichasPro();
    $data['Aprendices'] = $this->MdlLlenarfichapro->Aprendices();
    $this->load->view('Llenarfichapro', $data);
  }

  function insertDetallefichapro()

  {
    $idproyecto = $this->input->post('id');
    $idaprendiz = $this->input->post('aprendiz');

    foreach ($idaprendiz as $key ) {

      $this->MdlLlenarfichapro->insertDetallefichapro($idproyecto,$key);
    }
    echo json_encode(array("status" => TRUE));
  }


}

?>
