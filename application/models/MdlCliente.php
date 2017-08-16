<?php

/**
*
*/
class MdlCliente extends CI_Model
{


  function RegistrarCliente($Nombre, $Apellido, $tele, $correo){

    $this->db->query("call sp_insertarCliente('$Nombre', '$Apellido', '$tele', '$correo')");
  }

  function ConsultarClientes()
  {
    return $this->db->query("call sp_consultarClientes")->result_array();
  }

  function EditCliente($data)
  {
    return  $this->db->query("call sp_idClientes('$data')")->row_array();
  }

  function ActualizarCliente($txtIdCliente,$txtNombreCliente,$txtApellidoCliente,$txtTeleCliente,$txtCorreoCliente)
  {
    return $this->db->query("call sp_actualizarCliente('$txtIdCliente','$txtNombreCliente','$txtApellidoCliente','$txtTeleCliente','$txtCorreoCliente')");
  }

}


?>
