<?php

class MdlLlenarfichagrupo extends CI_Model
{
  public function conFicha()
  {
    $query = $this->db->query("CALL sp_conFicha()");
    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;
  }
  function consultaAprendices()
  {
    $query =  $this->db->query("CALL sp_aprendicesXestado()");
    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;

  }

  function insertarDetallefichagrupo($idficha,$idaprendiz)
  {
    return $this->db->query("CALL sp_regdetalleGrupo('$idaprendiz','$idficha')");
  }

}



?>
