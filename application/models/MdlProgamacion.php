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



}

?>
