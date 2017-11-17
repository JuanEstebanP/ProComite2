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
    if ($this->session->userdata('usuario')) {
      $data['fichasXestado'] = $this->MdlProgamacion->fichasXestado();
      //  $data['Programacion'] = $this->MdlProgamacion->consultarProgramacion();
      $this->load->view('RegistrarProgramacion',$data);

    }else {
      redirect('ControllerLogin');
    }



  }



  function registrarProgramacion(){

    $txttitulo = $this->input->post('titulo');
    $txtfecha = $this->input->post('fecha');
    $txthora = $this->input->post('hora');
    $txtlugar = $this->input->post('lugar');
    $this->MdlProgamacion->registrarProgramacion($txttitulo,$txtfecha, $txthora, $txtlugar);

    require_once('PHPMailer/class.phpmailer.php');
$inst = $this->MdlProgamacion->consultarcorreintruc();
    // instancio un objeto de la clase PHPMailer
//     $mail = new PHPMailer;
//
// $mail->IsMAIL();                                      // Set mailer to use SMTP
// $mail->Host = 'localhost';                 // Specify main and backup server
// $mail->Port = 25;                                    // Set the SMTP port
// $mail->SMTPAuth = true;                               // Enable SMTP authentication
// $mail->Username = 'juanestebanpulgarin.a@gmail.com';                // SMTP username
// $mail->Password = 'juanesteban2';                  // SMTP password
// $mail->SMTPSecure = 'ssl';                            // Enable encryption, 'ssl' also accepted
//
// $mail->From = 'juanestebanpulgarin.a@gmail.com';
// $mail->FromName = 'Your From name';
// foreach ($inst as $key ) {
//   # code...
//
// $mail->AddAddress($key);  // Add a recipient
//
//
// $mail->IsHTML(true);                                  // Set email format to HTML
//
// $mail->Subject = 'Here is the subject';
// $mail->Body    = 'This is the HTML message body <strong>in bold!</strong>';
// $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
//
// if(!$mail->Send()) {
//    echo 'Message could not be sent.';
//    echo 'Mailer Error: ' . $mail->ErrorInfo;
//    exit;
// }
// echo 'Message has been sent';
// }


    $this->load->library("email");

     //configuracion para gmail
     $configGmail = array(
    'protocol' => 'SMTP',
   'smtp_host' => 'localhost',
   'smtp_port' => 25,
       'smtp_crypto' => 'ssl',
   'smtp_user' => 'jepulgarin16@misena.edu.co',
   'smtp_pass' => 'juanesteban1',
   'mailtype' => 'html',
   'charset' => 'utf-8',
   'newline' => "\r\n"
     );

$txtmensaje = "<h2>El día ";
$txtmensaje .= $txtfecha;
$txtmensaje .= " se tiene programado un comité en ";
$txtmensaje .= $txtlugar;
$txtmensaje .= " a las ";
$txtmensaje .= $txthora;

    $instructores = $this->MdlProgamacion->consultarcorreintruc();
    foreach ($instructores as $key) {


     $this->email->initialize($configGmail);

     $this->email->from('jepulgarin16@misena.edu.co');
     $this->email->to($key);
     $this->email->subject('Comité De Evaluación');
     $this->email->message($txtmensaje);
     $this->email->send();
}
    $id = $this->input->post('id');
    foreach ($id as $i) {

      $this->MdlProgamacion->dtllcomitefichas($i);
    }
    echo json_encode(array("status" => TRUE));


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
