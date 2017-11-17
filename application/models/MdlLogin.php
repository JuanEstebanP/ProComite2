<?php
/**
*
*/
class MdlLogin extends CI_Model
{

public function login($usuario,$contrasena)
{
 $this->db->WHERE('usuario',$usuario);
 $this->db->WHERE('contrasena',$contrasena);
 $q = $this->db->get('tbl_usuarios');
 if ($q->num_rows()>0) {
   return true;
 }else {
   return false;
 }
}

  }


  ?>
