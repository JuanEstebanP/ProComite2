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

    $query = $this->db->query("CALL sp_Fichasproyectos()");
    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;

  }
  function ConsultarFichasGrupos()
  {
    $query = $this->db->query("CALL sp_Fichasgrupos()");

    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;
  }
  function consultaAprendices($id)
  {
    return $this->db->query("CALL sp_consultaAprendices('$id')")->result_array();
    }

    function InsertarFichaproyecto($txtNombre,$txtObjetivo,$destino,$txtVersion,$txtCliente,$txtEstado,$txtFichagrupo)
    {
      $this->db->query("call sp_insertarFichaproyecto('$txtNombre','$txtObjetivo','$destino','$txtVersion','$txtCliente','$txtFichagrupo','$txtEstado')");
    }
    function EditCodigo($id_ficha)
    {
      return $this->db->query("call sp_idFichaProyecto('$id_ficha')")->row_array();
    }

    function EditarFichaproyecto($txtIdModificar,$txtNombreModificar,$txtObjetivoModificar,$txtVersionModificar,$destino,$txtClienteModificar,$txtFichagrupoM,$txtEstadoModificar)
    {
      $this->db->query("call sp_editarFichaproyecto('$txtIdModificar','$txtNombreModificar','$txtObjetivoModificar','$txtVersionModificar','$destino','$txtClienteModificar','$txtFichagrupoM','$txtEstadoModificar')");
    }
    function FichasBG($id)
    {
      $query = $this->db->query("CALL sp_fichasBG('$id')");
      $res = $query->result_array();
      $query->next_result();
      $query->free_result();
      return $res;
    }



  }
  ?>
