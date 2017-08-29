<?php

class MdlLlenarfichagrupo extends CI_Model
{
  public function conFicha()
  {
    return $this->db->query("SELECT * from tbl_fichagrupo")->result_array();
  }
  function consultaAprendices()
  {
    $query  = $this->db->query("CALL sp_consultarAprendices()");
    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;
  }

  function insertarDetallefichagrupo($idficha,$idaprendiz)
  {
    $this->db->query("INSERT INTO `tbl_detallesaprendizgrupo` (`id_detalle`, `id_aprendiz`, `id_fichaGrupo`) VALUES (null,'$idaprendiz','$idficha')");
  }

}
