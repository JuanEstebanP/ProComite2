<?php
/**
 *
 */
class MdlTrazabilidad extends CI_Model
{

  function __construct(argument)
  {
    # code...
  }

  function fichasBf($id)
  {
    $this->db->query("SELECT Url FROM tbl_dtllproyecto WHERE id_ficha = '$id' ");
  }
}

 ?>
