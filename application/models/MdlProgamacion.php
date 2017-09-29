<?php

class MdlProgamacion extends CI_Model
{


  function registrarProgramacion($titulo,$txtfecha, $txthora, $txtlugar)
  {
    $this->db->query("call sp_RegistrarProgramacion('$titulo','$txtfecha', '$txthora', '$txtlugar')");
  }

  function consultarProgramacion()
  {
   $query = $this->db->query("call sp_ConsultarProgramacion()");
   $res = $query->result_array();
   $query->next_result();
   $query->free_result();
   return $res;
  }

  function mostrarProgramacion($txtidprogramacion)
  {
    return $this->db->query("call sp_MostrarProgramacion('$txtidprogramacion')")->result_array();
  }

  function editarProgramacion($txtidprogramacionModificar,$txttituloModificar,$txtfechaModificar, $txthoraModificar, $txtlugarModificar)
  {
    return $this->db->query("call sp_EditarProgramacion('$txtidprogramacionModificar','$txttituloModificar', '$txtfechaModificar', '$txthoraModificar', '$txtlugarModificar')");
  }

function consultarInstructores($id)
{
  return $this->db->query("SELECT * FROM tbl_instructores i join tbl_comite c on c.fk_instructor=i.id_instructor where c.fk_programacion = '$id'")->result_array();
}
function consultarcorreintruc()
{
  return $this->db->query("SELECT correo FROM tbl_instructores")->result_array();
}

function fichasXestado()
{
  return $this->db->query("CALL sp_fichasXestado")->result_array();
}
function dtllcomitefichas($id)
{
  $this->db->query("CALL sp_dtllProyectoprogra('$id')");
}

}

?>
