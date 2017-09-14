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
    // $this->load->view('/Master.php');
    $data['Programacion'] = $this->MdlProgamacion->consultarProgramacion();
    $this->load->view('RegistrarProgramacion.php',$data);

  }

function registrarProgramacion(){
  $txtfecha = $this->input->post('fecha');
  $txthora = $this->input->post('hora');
  $txtlugar = $this->input->post('lugar');

  $this->MdlProgamacion->registrarProgramacion($txtfecha, $txthora, $txtlugar);
  redirect('ControllerProgramacion?ok=1');
}

public function mostrarProgramacion(){
  $txtidprogramacion = $this->input->post('id_programacion');
  $data = $this->MdlProgamacion->mostrarProgramacion($txtidprogramacion);
   echo json_encode($data);
}

public function editarProgramacion(){
  $txtidprogramacionModificar = $this->input->post('oculto');
  $txtfechaModificar = $this->input->post('fechaModificar');
  $txthoraModificar = $this->input->post('horaModificar');
  $txtlugarModificar = $this->input->post('lugarModificar');

  $this->MdlProgamacion->editarProgramacion($txtidprogramacionModificar, $txtfechaModificar, $txthoraModificar, $txtlugarModificar);
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
