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
    $data['IdFichas'] = $this->MdlLlenarfichapro->IdFichasPro();
    $data['Aprendices'] = $this->MdlLlenarfichapro->Aprendices();
    $this->load->view('Llenarfichapro', $data);
  }

  function insertDetallefichapro()

  {

    $idaprendiz = $this->input->post('aprendiz');
    $idproyecto = $this->input->post('id');
    foreach ($idaprendiz as $key ) {

    $this->MdlLlenarfichapro->insertDetallefichapro($key,$idproyecto);
    }
    echo json_encode(array("status" => TRUE));
  }


}

 ?>
