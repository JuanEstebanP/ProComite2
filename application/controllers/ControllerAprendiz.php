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

    //obtenemos el archivo .csv

    $tipo = $_FILES['file']['type'];
    $tamanio = $_FILES['file']['size'];
    $archivotmp = $_FILES['file']['tmp_name'];
    //cargamos el archivo
    $lineas = file($archivotmp);
    //inicializamos variable a 0, esto nos ayudará a indicarle que no lea la primera línea
    $i=0;
    //Recorremos el bucle para leer línea por línea
    foreach ($lineas as $linea_num => $linea)
    {
      //abrimos bucle
      /*si es diferente a 0 significa que no se encuentra en la primera línea
      (con los títulos de las columnas) y por lo tanto puede leerla*/
      if($i != 0)
      {
        //abrimos condición, solo entrará en la condición a partir de la segunda pasada del bucle.
        /* La funcion explode nos ayuda a delimitar los campos, por lo tanto irá
        leyendo hasta que encuentre un ; */
        $datos = explode(";",$linea);
        //$arr = array();
        //Almacenamos los datos que vamos leyendo en una variable
        $nombre = trim($datos[0]);
        $apellido = trim($datos[1]);
        $documento = trim($datos[2]);
        $correo = trim($datos[3]);

        //guardamos en base de datos la línea leida
        $this->MdlAprendiz->Importar($nombre,$apellido,$documento,$correo);

        //cerramos condición
      }

      /*Cuando pase la primera pasada se incrementará nuestro valor y a la siguiente pasada ya
      entraremos en la condición, de esta manera conseguimos que no lea la primera línea.*/
      $i++;
      //cerramos bucle
    }
    redirect('ControllerAprendiz?ok=1');
  }
}
?>
