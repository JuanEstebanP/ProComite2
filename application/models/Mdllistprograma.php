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
function consultarProgramacion($valor)
{
 return $this->db->query("SELECT * FROM tbl_programacioncomite where id_programacion='$valor'")->result_array();
}

function instructores($valor)
{
 return $this->db->query("SELECT * FROM tbl_comite c
join tbl_instructores i on i.id_instructor=c.fk_instructor
join tbl_programacioncomite pc on pc.id_programacion=c.fk_programacion
WHERE fk_programacion = '$valor'")->result_array();
}
function fichas($valor)
{
 return $this->db->query("SELECT * FROM tbl_dtllproyectoprogra dp
join tbl_programacioncomite p on p.id_programacion=dp.id_programacion
join tbl_fichaproyecto fp on fp.id_ficha= dp.id_ficha
join tbl_estados e on e.id_estado=fp.estado where dp.id_programacion = '$valor'")->result_array();
}

function fichasXprogramacion($data)
{
  return $this->db->query("CALL sp_fichasXprogramacion('$data')")->result_array();
}


}


?>
