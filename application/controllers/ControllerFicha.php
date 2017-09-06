<?php


class ControllerFicha extends CI_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlFicha');
  }

  function index()
  {
    $data['Ficha2'] = $this->MdlFicha->ConsultarFichas();
    $data['Ficha'] = $this->MdlFicha->conInstructor();
    $this->load->view('Ficha',$data);

    //$this->load->view('Ficha',$data);
  }

  function InsertarFicha()
  {
      $txtNumero = $this->input->post('txtNumero');
      $txtIniciolectiva = $this->input->post('txtIniciolectiva');
      $txtFinlectiva = $this->input->post('txtFinlectiva');
      $txtTitular = $this->input->post('txtTitular');
      $this->MdlFicha->InsertarFicha( $txtNumero,$txtIniciolectiva,$txtFinlectiva,$txtTitular);
      redirect('ControllerFicha?ok=1');
    }


    function Editar(){

      $dt = $this->input->post('id_fichaGrupo');
      $data = $this->MdlFicha->EditCodigo($dt);
      echo json_encode($data);


    }

    function EditarFicha(){
      $txtId = $this->input->post('txtIdModificar');
      $txtNumero = $this->input->post('txtNumeroModificar');
      $txtTitular = $this->input->post('txtTitularModificar');
      $txtIniciolectiva = $this->input->post('txtIniciolectivaModificar');
      $txtFinlectiva = $this->input->post('txtFinlectivaModificar');
      $this->MdlFicha->EditarFicha($txtId,$txtNumero, $txtTitular, $txtIniciolectiva, $txtFinlectiva);
      redirect('ControllerFicha?ok=1');

    }

    function consultaAprendices()
    {
      $dt = $this->input->post('id');
      $aprendiz = $this->MdlFicha->consultaAprendices($dt);
      echo json_encode($aprendiz);
    }

}



?>
