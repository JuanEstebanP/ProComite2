<?php


class Mdllistprograma extends CI_Model {


function programaciones()
{
   $query =  $this->db->query("CALL sp_ConsultarProgramacion");
   $res= $query->result_array();
   $query->next_result();
   $query->free_result();
   return $res;
}

function fichasGrupo()
{
  $query =$this->db->query("CALL sp_Consultarfichagrupo");
  $res = $query->result_array();
  $query->next_result();
  $query->free_result();
  return $res;
}
function editarProgramacion($txtidprogramacionModificar,$txttituloModificar,$txtfechaModificar, $txthoraModificar, $txtlugarModificar)
{
  return $this->db->query("call sp_EditarProgramacion('$txtidprogramacionModificar','$txttituloModificar', '$txtfechaModificar', '$txthoraModificar', '$txtlugarModificar')");
}
function consultarProgramación()
{
  return $this->db->query("SELECT * FROM tbl_programacioncomite")->result_array();
}

function instructores()
{
  return $this->db->query("SELECT * FROM tbl_instructores")->result_array();
}
function fichas()
{
  return $this->db->query("SELECT * FROM tbl_fichaproyecto")->result_array();
}

function fichasXprogramacion($data)
{
  return $this->db->query("CALL sp_fichasXprogramacion('$data')")->result_array();
}


}


?>
