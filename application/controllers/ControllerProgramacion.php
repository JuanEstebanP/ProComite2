<?php

class ControllerProgramacion extends CI_Controller
{

  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->model('MdlProgamacion');

  }

  public function index()
  {

    $data['fichasXestado'] = $this->MdlProgamacion->fichasXestado();
    //  $data['Programacion'] = $this->MdlProgamacion->consultarProgramacion();
    $this->load->view('RegistrarProgramacion',$data);

  }



  function registrarProgramacion(){

    $txttitulo = $this->input->post('titulo');
    $txtfecha = $this->input->post('fecha');
    $txthora = $this->input->post('hora');
    $txtlugar = $this->input->post('lugar');
    $this->MdlProgamacion->registrarProgramacion($txttitulo,$txtfecha, $txthora, $txtlugar);
    $id = $this->input->post('id');
    foreach ($id as $i) {

      $this->MdlProgamacion->dtllcomitefichas($i);
    }
    echo json_encode(array("status" => TRUE));
    $this->load->library('My_PHPMailer');


  }



  public function mostrarProgramacion(){
    $txtidprogramacion = $this->input->post('id_programacion');
    $data = $this->MdlProgamacion->mostrarProgramacion($txtidprogramacion);
    echo json_encode($data);
  }

  public function editarProgramacion(){
    $txtidprogramacionModificar = $this->input->post('oculto');
    $txttituloModificar = $this->input->post('tituloModificar');
    $txtfechaModificar = $this->input->post('fechaModificar');
    $txthoraModificar = $this->input->post('horaModificar');
    $txtlugarModificar = $this->input->post('lugarModificar');

    $this->MdlProgamacion->editarProgramacion($txtidprogramacionModificar, $txttituloModificar,$txtfechaModificar, $txthoraModificar, $txtlugarModificar);
    redirect('ControllerProgramacion?ok=1');

  }

  function consultarInstructores()
  {
    $txtidprogramacion = $this->input->post('id');
    $data = $this->MdlProgamacion->consultarInstructores($txtidprogramacion);
    echo json_encode($data);
  }



}

?>
