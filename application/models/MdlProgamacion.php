<?php

class MdlProgamacion extends CI_Model
{


  function registrarProgramacion($txtfecha, $txthora, $txtlugar)
  {
    $this->db->query("call sp_RegistrarProgramacion('$txtfecha', '$txthora', '$txtlugar')");
  }

  function consultarProgramacion()
  {
    return $this->db->query("call sp_ConsultarProgramacion()")->result_array();
  }

  function mostrarProgramacion($txtidprogramacion)
  {
    return $this->db->query("call sp_MostrarProgramacion('$txtidprogramacion')")->result_array();
  }

  function editarProgramacion($txtidprogramacionModificar, $txtfechaModificar, $txthoraModificar, $txtlugarModificar)
  {
    return $this->db->query("call sp_EditarProgramacion('$txtidprogramacionModificar', '$txtfechaModificar', '$txthoraModificar', '$txtlugarModificar')");
  }

function consultarInstructores($id)
{
  return $this->db->query("SELECT * FROM tbl_instructores i join tbl_comite c on c.fk_instructor=i.id_instructor where c.fk_programacion = '$id'")->result_array();
}


}

?>
