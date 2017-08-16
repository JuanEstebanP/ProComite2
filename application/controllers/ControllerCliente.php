<?php

/**
*
*/
class ControllerCliente extends CI_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlCliente');
  }

  function index()
  {
    $data['Cliente'] = $this->MdlCliente->ConsultarClientes();
    $this->load->view('Cliente',$data);
  }

  function RegistrarCliente()
  {
    $Nombre = $this->input->post('textNombreCliente');
    $Apellido = $this->input->post('textApellidoCliente');
    $tele = $this->input->post('textTelefonoCliente');
    $correo  = $this->input->post('textCorreoCliente');

    $this->MdlCliente->RegistrarCliente($Nombre, $Apellido, $tele, $correo);
    redirect('ControllerCliente?ok=1');
  }

  function Editar()
  {
    $dt = $this->input->post('id_cliente');
    $data = $this->MdlCliente->EditCliente($dt);
    echo json_encode($data);
  }

  function ActualizarCliente()
  {
    $txtIdCliente = $this->input->post('txtIdCliente');
    $txtNombreCliente = $this->input->post('txtNombreCliente');
    $txtApellidoCliente = $this->input->post('txtApellidoCliente');
    $txtTeleCliente = $this->input->post('txtTeleCliente');
    $txtCorreoCliente = $this->input->post('txtCorreoCliente');

    $this->MdlCliente->ActualizarCliente($txtIdCliente,$txtNombreCliente,$txtApellidoCliente,$txtTeleCliente,$txtCorreoCliente);
    redirect('ControllerCliente?ok=1');
  }
}
?>
