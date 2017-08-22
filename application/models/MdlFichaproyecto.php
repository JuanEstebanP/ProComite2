<?php

class MdlFichaproyecto extends CI_Model
{
  public function conCliente()
  {
      $query  = $this->db->query("CALL sp_consultarClientes()");
      $res = $query->result_array();
      $query->next_result();
      $query->free_result();
      return $res;
  }
  function ConsultarFichasproyectos()
  {
    return $this->db->query("SELECT f.id_ficha,f.titulo,f.obj_general,f.version,c.nombre  id_cliente,fi.numeroFicha id_fichaGrupo,e.nombreEstado estado FROM tbl_fichaproyecto f
      JOIN tbl_estados e on e.id_estado=f.estado
      join tbl_cliente c on c.id_cliente=f.id_cliente
      join tbl_fichagrupo fi on fi.id_fichaGrupo=f.id_fichaGrupo")->result_array();
    }
    function ConsultarFichasGrupos()
    {
      return $this->db->query("SELECT * FROM tbl_fichagrupo")->result_array();
    }
    function consultaAprendices()
    {
      $query  = $this->db->query("CALL sp_consultarAprendices()");
      $res = $query->result_array();
      $query->next_result();
      $query->free_result();
      return $res;
    }

    function InsertarFichaproyecto($txtNombre,$txtObjetivo,$destino,$txtVersion,$txtCliente,$txtEstado,$txtFichagrupo)
    {
      $this->db->query("call sp_insertarFichaproyecto('$txtNombre','$txtObjetivo','$destino','$txtVersion','$txtCliente','$txtFichagrupo','$txtEstado')");
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
