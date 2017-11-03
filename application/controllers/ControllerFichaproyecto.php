<?php


class ControllerFichaproyecto extends CI_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlFichaproyecto');
  }
  function index()
  {
    $dt = $this->input->post('txtidfichaG');
    $data['fichasG'] = $this->MdlFichaproyecto->FichasBG($dt);

    $data['Ficha2'] = $this->MdlFichaproyecto->ConsultarFichasproyectos();
    $data['Fichaproyectos'] = $this->MdlFichaproyecto->conCliente();
    $data['ficha'] = $this->MdlFichaproyecto->ConsultarFichasGrupos();
    $this->load->view('FichasProyecto',$data);

    //$this->load->view('Ficha',$data);

  }


  public function InsertarFichaproyecto(){



  $carpeta = "./uploads/";
  opendir($carpeta);
  $destino =  $carpeta.$_FILES['file_pr']['name'];
  copy($_FILES['file_pr']['tmp_name'],$destino);

  $txtNombre = $this->input->post('txtNombre');
  $txtObjetivo = $this->input->post('txtObjetivo');
  $txtVersion = $this->input->post('txtVersion');
  $txtCliente = $this->input->post('txtCliente');
  $txtFichagrupo = $this->input->post('txtFichagrupo');
  $this->MdlFichaproyecto->InsertarFichaproyecto($txtNombre,$txtObjetivo,$destino,$txtVersion,$txtCliente,$txtFichagrupo);

  // if ($this->input->is_ajax_request()) {
  //   //$file = $_FILES['photo_user']['name'];
  //   //echo json_encode($file);
  //
  //   /*$config['upload_path'] = "./assets/images/uploads/";
  //   $config['allowed_types'] = "jpg";
  //
  //   $this->load->library("upload", $config);
  //
  //   if (!$this->upload->do_upload('photo_user')) {
  //     echo json_encode($this->upload->display_errors());
  //   }
  //   else
  //   {
  //     $data = array('upload_data' => $this->upload->data());
  //     echo $data['upload_data']['file_name'];
  //   }*/
  //   //----- comienza el ingreso
  //   $txtNombre = $this->input->post('txtNombre');
  //   $txtObjetivo = $this->input->post('txtObjetivo');
  //   $txtVersion = $this->input->post('txtVersion');
  //   $txtCliente = $this->input->post('txtCliente');
  //   $txtFichagrupo = $this->input->post('txtFichagrupo');
  //
  //
  //       $config['upload_path'] = "./uploads/";
  //       $config['allowed_types'] = "pdf";
  //
  //       $this->load->library("upload", $config);
  //
  //       if (!$this->upload->do_upload('file_pr')) {
  //         //echo $this->upload->display_errors();
  //         if (!empty($_FILES['file_pr']['name'])) {
  //               // Name isn't empty so a file must have been selected
  //               //$error = array('error' => $this->upload->display_errors());
  //               //$this->load->view('upload_success', $error);
  //               echo $this->upload->display_errors();
  //           } else {
  //               // No file selected - set default image
  //               $data = [
  //             "titulo" => $txtNombre,
  //             "obj_general" => $txtObjetivo,
  //             "url" => "default.jpg",
  //             "version" => $txtVersion,
  //             "id_cliente" => $txtCliente,
  //             "id_fichaGrupo" =>$txtFichagrupo
  //           ];
  //
  //           if ($this->MdlFichaproyecto->InsertarFichaproyecto($data) == true) {
  //             echo "Exito";
  //           }
  //           else{
  //             echo "Error";
  //           }
  //           }
  //       }
  //       else
  //       {
  //         $data = array('upload_data' => $this->upload->data());
  //
  //         $datos = [
  //           "nombres" => $nombres,
  //           "apellidos" => $apellidos,
  //           "email" => $email,
  //           "password" => sha1($password),
  //           "photo" => $data['upload_data']['file_name'],
  //         ];
  //
  //         if ($this->Usuarios_model->guardar($datos) == true) {
  //           echo "Exito";
  //         }
  //         else{
  //           echo "Error";
  //         }
  //       }
  //
  //
  //
  //
  //
  //
  //
  //
  // }
  // else{
  //   show_404();
  // }


}

  function Editar(){

    $dt = $this->input->post('id_ficha');
    $data = $this->MdlFichaproyecto->EditCodigo($dt);
    echo json_encode($data);
  }

  function EditarFichaproyecto(){
    $txtId = $this->input->post('txtIdModificar');
    $txtNombre = $this->input->post('txtNombreModificar');
    $txtObjetivo = $this->input->post('txtObjetivoModificar');
    $txtVersion = $this->input->post('txtVersionModificar');
    $carpeta = "./uploads/";
    opendir($carpeta);
    $destino =  $carpeta.$_FILES['fileC']['name'];
    copy($_FILES['fileC']['tmp_name'],$destino);
    $txtCliente = $this->input->post('txtClienteModificar');
      $txtFichagrupoM = $this->input->post('txtFichagrupoM');
    $txtEstado = $this->input->post('txtEstadoModificar');
    $this->MdlFichaproyecto->EditarFichaproyecto($txtId, $txtNombre,$txtObjetivo,$txtVersion,$destino,$txtCliente, $txtFichagrupoM ,$txtEstado);
    redirect('ControllerFichaproyecto');
  }

  function consultarAprendiz()
  {
    $dt = $this->input->post('id');
    $apren = $this->MdlFichaproyecto->consultaAprendices($dt);
    echo json_encode($apren);
  }

}






?>
