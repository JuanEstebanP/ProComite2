<?php
/**
 *
 */
class MdlLlenarfichapro extends CI_Model
{
  function IdFichasPro()
  {
    return $this->db->query("SELECT id_ficha, titulo FROM tbl_fichaproyecto")->result_array();
  }

  function Fichasgruo()
  {
    return $this->db->query("SELECT id_fichaGrupo, numeroFicha FROM tbl_fichagrupo")->result_array();
  }

  function Aprendices()
  {
    return $this->db->query("SELECT * FROM tbl_aprendiz WHERE estado =1 ")->result_array();
  }

  function insertDetallefichapro($idproyecto,$key)
  {
  return $this->db->query("CALL sp_regdetalleProyecto('$key','$idproyecto')");
  }

  function obtenerProyectos($id)
  {
    return $this->db->query("SELECT * FROM tbl_fichaproyecto WHERE id_fichaGrupo = '$id'")->result_array();
  }



}

 ?>