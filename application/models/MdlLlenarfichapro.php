<?php
/**
 *
 */
class MdlLlenarfichapro extends CI_Model
{
  function IdFichasPro()
  {
    return $this->db->query("SELECT id_ficha FROM tbl_fichaproyecto")->result_array();
  }

  function Aprendices()
  {
    return $this->db->query("SELECT * FROM tbl_aprendiz")->result_array();
  }

  function insertDetallefichapro($idproyecto,$key)
  {
  return $this->db->query("CALL sp_regdetalleProyecto('$key','$idproyecto')");
  }
}

 ?>
