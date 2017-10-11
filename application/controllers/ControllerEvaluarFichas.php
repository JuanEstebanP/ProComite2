<?php
class ControllerEvaluarFichas extends CI_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlEvaluarFicha');
  }

  function index()
  {

    $data['EstadosF'] = $this->MdlEvaluarFicha->EstadosFicha();
    $data['fichasArh'] = $this->MdlEvaluarFicha->CosultarFichas();
    $this->load->view('Evaluar',$data);

  }

  function DatosF()
  {
    $dt = $this->input->post('id_ficha');
    $data = $this->MdlEvaluarFicha->CodFichaE($dt);
    echo json_encode($data);
  }

  function InsertardtllComite()
  {
    $estado = $this->input->post('txtEstado');
    $idficha = $this->input->post('idF');
    $observ = $this->input->post('txtobserva');

    $regis = $this->MdlEvaluarFicha->InsertarEstadoObser($idficha,$observ,$estado);
    echo json_encode($regis);

  }

  function fichasBf()
  {
    $dt = $this->input->post('id');
    $traza = $this->MdlEvaluarFicha->fichasBf($dt);
    echo json_encode($traza);
  }




}
?>
