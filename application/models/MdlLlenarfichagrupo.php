<?php

class MdlLlenarfichagrupo extends CI_Model
{
  public function conFicha()
  {
    return $this->db->query("SELECT * from tbl_fichagrupo")->result_array();
  }
  function consultaAprendices()
  {
    return $this->db->query("SELECT * FROM tbl_aprendiz WHERE estado =!1 OR estado = !2")->result_array();

  }

  function insertarDetallefichagrupo($idficha,$idaprendiz)
  {
    return $this->db->query("CALL sp_regdetalleGrupo('$idaprendiz','$idficha')");
  }

}



?>
