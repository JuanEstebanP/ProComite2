<?php

/**
 *
 */
class MdlAsistenciaProgramacion extends CI_Model
{

  function consultarProgramaciones ()
  {
    return $this->db->query("SELECT * FROM tbl_programacioncomite")->result_array();
  }

  function instructores()
  {
    return $this->db->query("SELECT * FROM tbl_instructores")->result_array();
  }

  function registrarasistencia($id, $instructores)
  {
      $this->db->query("INSERT INTO tbl_comite VALUES (NULL,'$id','$instructores')");
  }
}

?>
