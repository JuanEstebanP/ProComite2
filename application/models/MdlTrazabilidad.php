<?php
/**
 *
 */
class MdlTrazabilidad extends CI_Model
{


  function fichasBf($id)
  {
    return  $this->db->query("SELECT Url FROM tbl_dtllproyecto WHERE id_ficha = '$id' ")->result_array();
  }

}

 ?>
