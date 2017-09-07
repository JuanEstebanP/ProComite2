<?php

/**
*
*/
class MdlEvaluarFicha extends CI_Model
{


  function CosultarFichas()
  {
    return  $this->db->query("call sp_consultarFichasArh")->result_array();
  }

  function EstadosFicha()
  {
    return $this->db->query("SELECT id_estado, nombreEstado FROM tbl_estados")->result_array();
  }

  function CodFichaE($id_ficha)
  {
    return $this->db->query("call sp_idEvaluar('$id_ficha')")->row_array();
  }

  function InsertarEstadoObser($idficha, $observ, $estado)
  {
    return $this->db->query("call sp_EvaluarFicha('$idficha', '$observ','$estado')");
  }

  function fichasBf($id)
  {
    return  $this->db->query("SELECT Url FROM tbl_dtllproyecto WHERE id_ficha = '$id' ")->result_array();
  }

}

?>
