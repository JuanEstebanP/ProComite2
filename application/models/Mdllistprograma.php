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

function fichas($data)
{
 return  $this->db->query("CALL sp_fichasXprogramacion('$data')")->result_array();
}

}


?>
