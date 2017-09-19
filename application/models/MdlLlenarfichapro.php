<?php
/**
*
*/
class MdlLlenarfichapro extends CI_Model
{
  function IdFichasPro()
  {

    $query = $this->db->query("CALL sp_IdFichasPro");
    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;
  }

  function Fichasgru()
  {
    $query = $this->db->query("CALL sp_Fichasgru");
    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;
  }

  function insertDetallefichapro($idproyecto,$key)
  {
    return $this->db->query("CALL sp_regdetalleProyecto('$key','$idproyecto')");
  }

  function obtenerProyectos($id)
  {
    return $this->db->query("CALL sp_Consultarproyectos('$id')")->result_array();
  }

  function obtenerAprendices($asos)
  {
    return $this->db->query("CALL sp_obtenerAprendices('$asos')")->result_array();
    }



  }

  ?>
