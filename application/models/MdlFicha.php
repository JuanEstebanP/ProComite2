<?php

class MdlFicha extends CI_Model
{


  function InsertarFicha($txtNumero, $txtIniciolectiva, $txtFinlectiva, $txtTitular)
  {
    $this->db->query("call sp_insertarFichaGrupo( '$txtFinlectiva', '$txtNumero', '$txtIniciolectiva', '$txtTitular')");
  }
  public function conInstructor()
  {
    $query = $this->db->query("CALL sp_Consultarinstructor");
    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;
  }
  function consultaAprendices($id)
  {
  return $this->db->query("CALL sp_ConsultaraprendicesXid('$id')")->result_array();
  }
  function ConsultarFichas()
  {
    $query =  $this->db->query("CALL sp_Consultarfichagrupo");
    $res = $query->result_array();
    $query->next_result();
    $query->free_result();
    return $res;
  }
  function EditCodigo($id_fichaGrupo)
  {

    return $this->db->query("call sp_idFicha('$id_fichaGrupo')")->row_array();

  }

  function EditarFicha($txtIdModificar,$txtNumeroModificar, $txtTitularModificar, $txtIniciolectivaModificar, $txtFinlectivaModificar)
  {
    $this->db->query("CALL sp_editarFicha('$txtIdModificar','$txtNumeroModificar','$txtTitularModificar',
    '$txtIniciolectivaModificar','$txtFinlectivaModificar')");

  }

}
?>
