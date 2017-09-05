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
    return $this->db->query("SELECT a.id_aprendiz, a.nombre, a.apellido, a.documento, a.correo FROM tbl_aprendiz a
      join tbl_detallesaprendizgrupo dfg on dfg.id_aprendiz=a.id_aprendiz
      join tbl_fichagrupo fg on fg.id_fichaGrupo=dfg.id_fichaGrupo
       join tbl_fichaproyecto fp on fp.id_fichaGrupo=fg.id_fichaGrupo where fg.id_fichaGrupo='$asos' and a.estado= 1 ")->result_array();
  }



}

 ?>
