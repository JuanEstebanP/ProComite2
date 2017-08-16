<?php


class ControllerInstructor extends CI_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlInstructor');
  }

  function index()
  {
    $data['Instructor'] = $this->MdlInstructor->ConsultarInstructores();
    $this->load->view('Instructores',$data);
    //  var_dump($dato);
    //    exit();
  }

  function InsertarInstructor(){

    $txtNombre = $this->input->post('txtNombre');
    $txtApellido = $this->input->post('txtApellido');
    $txtDocumento = $this->input->post('txtDocumento');
    $txtCorreo = $this->input->post('txtCorreo');

    $this->MdlInstructor->InsertarInstructor($txtNombre, $txtApellido, $txtDocumento, $txtCorreo);
    redirect('ControllerInstructor?ok=1');

  }

  function Editar(){

    $dt = $this->input->post('id_instructor');
    $data = $this->MdlInstructor->EditCodigo($dt);
    echo json_encode($data);


  }

  function ActualizarInstructor()
  {
    $txtId = $this->input->post('txtIdModificar');
    $txtNombre = $this->input->post('txtNombreModificar');
    $txtApellido = $this->input->post('txtApellidoModificar');
    $txtDocumento = $this->input->post('txtDocumentoModificar');
    $txtCorreo = $this->input->post('txtCorreoModificar');

    $this->MdlInstructor->ActualizarInstructor($txtId,$txtNombre,$txtApellido,$txtDocumento,$txtCorreo);
    redirect('ControllerInstructor?ok=1');
  }





}

?>
