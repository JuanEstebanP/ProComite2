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



//configuracion para gmail
$config = array(
     'protocol' => 'smtp',
     'smtp_host' => 'smtp.googlemail.com',
     'smtp_user' => '', //Su Correo de Gmail Aqui
     'smtp_pass' => '', // Su Password de Gmail aqui
     'smtp_port' => 465,
     'smtp_crypto' => 'ssl',
     'mailtype' => 'html',
     'wordwrap' => TRUE,
     'charset' => 'utf-8'
     );
     $this->email->initialize($config);
     $this->load->library('email', $config);
     $this->email->set_newline("\r\n");
     $this->email->from('');
     $this->email->subject('Asunto del correo');
     $this->email->message('Hola desde correo');
     $this->email->to('');
     if($this->email->send()){
         echo "enviado<br/>";
         echo $this->email->print_debugger();
     }else {
         echo "fallo <br/>";
         echo "error: ".$this->email->print_debugger();
     }
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
