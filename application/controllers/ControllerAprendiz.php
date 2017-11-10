<?php


class ControllerAprendiz extends CI_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->load->database();
    $this->load->helper('form');
    $this->load->model('MdlAprendiz');
  }

  function index()
  {

    $data['Aprendiz'] = $this->MdlAprendiz->ConsultarAprendices();
    $this->load->view('Aprendices',$data);
  }
  function InsertarAprendiz(){


    $txtNombre = $this->input->post('txtNombre');
    $txtApellido = $this->input->post('txtApellido');
    $txtDocumento = $this->input->post('txtDocumento');
    $txtCorreo = $this->input->post('txtCorreo');
    $this->MdlAprendiz->InsertarAprendiz($txtNombre, $txtApellido, $txtDocumento, $txtCorreo);
    redirect('ControllerAprendiz?ok=1');

  }

  function Editar(){

    $dt = $this->input->post('id_aprendiz');
    $data = $this->MdlAprendiz->EditCodigo($dt);
    echo json_encode($data);


  }

  function EditarAprendiz(){
    $txtId = $this->input->post('txtIdModificar');
    $txtNombre = $this->input->post('txtNombreModificar');
    $txtApellido = $this->input->post('txtApellidoModificar');
    $txtDocumento = $this->input->post('txtDocumentoModificar');
    $txtCorreo = $this->input->post('txtCorreoModificar');
    $this->MdlAprendiz->EditarAprendiz($txtId,$txtNombre, $txtApellido, $txtDocumento, $txtCorreo);
    redirect('ControllerAprendiz?ok=1');

  }

  function ImportarExcel(){
    require_once 'PHPExcel/Classes/PHPExcel.php';
    $archivo = $_FILES['file']['name']; //captura el nombre del archivo
    $tipo = $_FILES['file']['type'];
    $carpeta = "./";
    opendir($carpeta);
    $destino =  $carpeta.$_FILES['file']['name'];
    copy($_FILES['file']['tmp_name'],$destino);

    $objPHPExcel = PHPExcel_IOFactory::load($archivo);

    $dataArr = array();

    foreach ($objPHPExcel->getWorksheetIterator() as $archivo) {
        $archivoTitle     = $archivo->getTitle();
        $highestRow         = $archivo->getHighestRow();
        $highestColumn      = $archivo->getHighestColumn();
        $highestColumnIndex = PHPExcel_Cell::columnIndexFromString($highestColumn);

        for ($row = 1; $row <= $highestRow; ++ $row) {
            for ($col = 0; $col < $highestColumnIndex; ++ $col) {
                $cell = $archivo->getCellByColumnAndRow($col, $row);
                $val = $cell->getValue();
                $dataArr[$row][$col] = $val;
            }
        }
    }
    
    foreach($dataArr as $val){
    $this->MdlAprendiz->Importar($val['0'],$val['1'],$val['2'],$val['3'],$val['4']);
    }
    redirect('ControllerAprendiz');

    }



}
?>
