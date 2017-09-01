<?php

class MdlFicha extends CI_Model
{


  function InsertarFicha($txtNumero, $txtIniciolectiva, $txtFinlectiva, $txtTitular)
  {
    $this->db->query("call sp_insertarFichaGrupo( '$txtFinlectiva', '$txtNumero', '$txtIniciolectiva', '$txtTitular')");
  }
  public function conInstructor()
  {
    return $this->db->query("SELECT id_instructor,documento,nombre from tbl_instructores")->result_array();
  }
  function consultaAprendices($id)
  {
  return $this->db->query("SELECT * FROM tbl_aprendiz a join tbl_detallesaprendizgrupo d on d.id_aprendiz=a.id_aprendiz where d.id_fichaGrupo = '$id'")->result_array();
  }
  function ConsultarFichas()
  {
    return $this->db->query("SELECT * FROM tbl_fichagrupo")->result_array();
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
