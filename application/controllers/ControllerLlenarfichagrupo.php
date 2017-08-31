<?php


class ControllerLlenarfichagrupo extends CI_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlLlenarfichagrupo');
  }

  function index()
  {
    $data['Ficha'] = $this->MdlLlenarfichagrupo->conFicha();
    $data['Aprendiz'] = $this->MdlLlenarfichagrupo->consultaAprendices();
    $this->load->view('Llenarfichagrupo',$data);

  }
  function insertarDetallefichagrupo()
  {

  $idficha=$this->input->post('id');
  $idaprendiz=$this->input->post('apren');

  foreach ($idaprendiz as $ida) {

  $this->MdlLlenarfichagrupo->insertarDetallefichagrupo($idficha, $ida);

  }

  echo json_encode(array("status" => TRUE));
  }

}




?>
