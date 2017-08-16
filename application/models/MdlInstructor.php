<?php

class MdlInstructor extends CI_Model
{


  function InsertarInstructor($txtNombre, $txtApellido, $txtDocumento, $txtCorreo)
  {
    $this->db->query("call sp_insertarInstructor('$txtNombre', '$txtApellido', '$txtDocumento', '$txtCorreo')");
  }

  function ConsultarInstructores()
  {
    return $this->db->query("call sp_consultarInstructores")->result_array();
  }

  function EditCodigo($data)
  {

    return $this->db->query("call sp_idInstructores('$data')")->row_array();

  }

  function ActualizarInstructor($txtId,$txtNombre,$txtApellido,$txtDocumento,$txtCorreo)
  {
    return $this->db->query("call sp_actualizarInstructor('$txtId', '$txtNombre', '$txtApellido', '$txtDocumento', '$txtCorreo')");
  }

}
?>
