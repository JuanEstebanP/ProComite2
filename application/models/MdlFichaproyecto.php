<?php

class MdlFichaproyecto extends CI_Model
{
  public function conCliente()
  {
    return $this->db->query("Call sp_consultarClientes")->result_array();
  }
  function ConsultarFichasproyectos()
  {
    return $this->db->query("SELECT f.id_ficha,f.titulo,f.obj_general,f.version,c.nombre id_cliente,e.nombreEstado estado FROM tbl_fichaproyecto f
      JOIN tbl_estados e on e.id_estado=f.estado
      join tbl_cliente c on c.id_cliente=f.id_cliente")->result_array();
    }
    function InsertarFichaproyecto($txtNombre,$txtObjetivo,$destino,$txtVersion,$txtCliente,$txtEstado)
    {
      $this->db->query("call sp_insertarFichaproyecto('$txtNombre','$txtObjetivo','$destino','$txtVersion','$txtCliente','$txtEstado')");
    }
    function EditCodigo($id_ficha)
    {
      return $this->db->query("call sp_idFichaProyecto('$id_ficha')")->row_array();
    }

    function EditarFichaproyecto($txtIdModificar,$txtNombreModificar,$txtObjetivoModificar,$txtVersionModificar,$destino,$txtClienteModificar,$txtEstadoModificar)
    {
      $this->db->query("call sp_editarFichaproyecto('$txtIdModificar','$txtNombreModificar','$txtObjetivoModificar','$txtVersionModificar','$destino','$txtClienteModificar','$txtEstadoModificar')");
    }

  }
  ?>
