<?php


class ControllerLlenarfichagrupo extends CI_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlLlenarfichagrupo');
    $this->load->helper('array');
  }

  function index()
  {
    $data['Ficha'] = $this->MdlLlenarfichagrupo->conFicha();
    $data['Aprendiz'] = $this->MdlLlenarfichagrupo->consultaAprendices();
    $this->load->view('Llenarfichagrupo',$data);

  }

  function insertChecks()
  {
    $ficha = $this->input->post('id_ficha');
    $aprendices = $this->input->post('aprendiz');

    var_dump($aprendices, $ficha);
    exit();
  }

}




?>
