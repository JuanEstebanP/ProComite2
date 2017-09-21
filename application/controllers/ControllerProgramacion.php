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
    $this->load->view('RegistrarProgramacion',$data);

  }

  function registrarProgramacion(){
    $txttitulo = $this->input->post('titulo');
    $txtfecha = $this->input->post('fecha');
    $txthora = $this->input->post('hora');
    $txtlugar = $this->input->post('lugar');

    $this->MdlProgamacion->registrarProgramacion($txttitulo,$txtfecha, $txthora, $txtlugar);

    //   $config =array(
    //  'protocol'=> 'smtp',
    //  'smtp_host'=> "smtp.gmail.com",
    //  'smtp_port'=> 465,
    //  'smtp_user'=> "procomiteevaluacion@gmail.com",
    //  'smtp_pass'=> "evaluacion2017",
    //  'smtp_crypto'=> 'ssl',
    //  'mailtype'=> 'html'
    //  );
    $config['protocol']    = 'smtp';
    $config['smtp_host']    = 'ssl://smtp.gmail.com';
    $config['smtp_port']    = '465';
    $config['smtp_timeout'] = '7';
    $config['smtp_user']    = 'procomiteevaluacion@gmail.com';
    $config['smtp_pass']    = 'evaluacion2017';
    $congig['smtp_crypto'] = 'ssl';
    $config['charset']    = 'utf-8';
    $config['newline']    = "\r\n";
    $config['mailtype'] = 'text'; // or html
    $config['validation'] = TRUE; // bool whether to validate email or not

    //  $this->email->initialize($config);
    $this->load->library('email',$config);
    $this->email->initialize($config);

    $this->email->from('procomiteevaluacion@gmail.com', 'Comité');
    $this->email->to('romerohm1996@gmail.com');

    $this->email->subject('Email de prueba');
    $this->email->message('Hola desde ProComite');

    if (  $this->email->send()) {
      redirect('ControllerProgramacion?ok=1');
    }else {
      echo $this->email->print_debugger();
    }






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
