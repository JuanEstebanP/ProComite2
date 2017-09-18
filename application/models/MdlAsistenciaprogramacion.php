<?php

/**
 *
 */
class MdlAsistenciaProgramacion extends CI_Model
{

  function consultarProgramaciones ()
  {
    return $this->db->query("SELECT * FROM tbl_programacioncomite where estado= 0 ")->result_array();
  }

  function instructores()
  {
    return $this->db->query("SELECT * FROM tbl_instructores")->result_array();
  }

  function registrarasistencia($id, $instructores)
  {
    return $this->db->query("call sp_asistencia('$id','$instructores')");
  }
}

?>
