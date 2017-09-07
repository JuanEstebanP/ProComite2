-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-08-2017 a las 20:37:12
-- Versión del servidor: 5.6.24
-- Versión de PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sam`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `aaaaa`(IN `sp_idCategoria` INT, IN `sp_fechaInicio` VARCHAR(100), IN `sp_fechaFinal` VARCHAR(100))
    NO SQL
BEGIN
if sp_idCategoria = '6' THEN
SELECT cate.idCategoria, mant.idMantenimiento,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientos as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE mant.fecha BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY)
UNION
SELECT cate.idCategoria, mant.idMantenimientod,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientosotros as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE mant.fecha BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarCantidadInsumoDevolucion`(IN `sp_Cantidad` INT, IN `sp_IdInsumo` INT)
BEGIN
DECLARE cantidadActual INT;
SET cantidadActual= (SELECT tblinsumos.cantidad FROM tblinsumos WHERE tblinsumos.idInsumo=sp_IdInsumo);
UPDATE tblinsumos SET tblinsumos.cantidad=(cantidadActual-sp_Cantidad) WHERE tblinsumos.idInsumo=sp_IdInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarCantidadInsumoEntrada`(IN `sp_NuevaCantidad` INT, IN `sp_IdInsumo` INT)
BEGIN
DECLARE cantidadActual INT;
SET cantidadActual= (SELECT tblinsumos.cantidad FROM tblinsumos WHERE tblinsumos.idInsumo=sp_IdInsumo);
UPDATE tblinsumos SET tblinsumos.cantidad=(cantidadActual+sp_NuevaCantidad) WHERE tblinsumos.idInsumo=sp_IdInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarEstadoSolicitud`(IN `sp_Solicitud` INT, IN `sp_idEstado` INT)
BEGIN
UPDATE tblsolicitud SET tblsolicitud.idestado=sp_idEstado WHERE tblsolicitud.idsolicitud=sp_Solicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarFechaInicioSesion`(IN `sp_UltimoIngreso` VARCHAR(45), IN `sp_NumeroIdentificacion` INT)
BEGIN
UPDATE tblcuentausuario SET tblcuentausuario.ultimoIngreso=sp_UltimoIngreso WHERE tblcuentausuario.numeroIdentificacion=sp_NumeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarFechaSolicitud`(IN `sp_fechaInicial` VARCHAR(45), IN `sp_fechaFinal` VARCHAR(45), IN `sp_idSolicitud` INT)
BEGIN
UPDATE tblsolicitud SET tblsolicitud.fechaInicio=sp_fechaInicial, tblsolicitud.fechaFinal=sp_fechaFinal WHERE tblsolicitud.idsolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AgregarPermisoCuentaUsuario`(IN `sp_idCuentaUsuario` INT, IN `sp_idPermiso` INT)
BEGIN
INSERT INTO tblpermisosusuario (idCuentaUsuario, idPermiso) VALUES (sp_idCuentaUsuario, sp_idPermiso);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AsignarTecnico`(IN `sp_numeroIdentificacion` VARCHAR(45), IN `sp_idSolicitud` INT, IN `sp_idCuentaUsuario` INT)
BEGIN

INSERT INTO tbltecnicosolicitudes (tbltecnicosolicitudes.idSolicitud, tbltecnicosolicitudes.numeroIdentificacion,tbltecnicosolicitudes.idCuentaUsuario) VALUES (sp_idSolicitud,sp_numeroIdentificacion,sp_idCuentaUsuario);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AutocompletarEquipo`()
BEGIN
SELECT CONCAT(tblequipos.Codigo, ' - ', tblcategoriasequipos.Nombre) as Equipo FROM tblequipos JOIN tblcategoriasequipos ON (tblequipos.idCategoria = tblcategoriasequipos.idCategoria);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AutocompletarInsumo`()
BEGIN
SELECT CONCAT(tblinsumos.nombre,' - ',tblinsumos.codigo) AS Insumo FROM tblinsumos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AutocompletarSolicitud`()
BEGIN
SELECT CONCAT('N° ', tblsolicitud.idsolicitud, ' - ', tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as Solicitud FROM tblsolicitud WHERE tblsolicitud.idestado = 4 OR tblsolicitud.idestado = 6;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AutocompletarUsuario`()
BEGIN
SELECT tblusuarios.numeroIdentificacion,CONCAT(tblusuarios.primerNombre,'',tblusuarios.segundoNombre,' ',tblusuarios.primerApellido,' ',tblusuarios.segundoApellido,' - ',tblusuarios.numeroIdentificacion) AS nombreCompleto FROM tblusuarios;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CambiarEstadoNotificaciones`(IN `sp_idCuentaUsuario` INT)
BEGIN
UPDATE tblusuarionotificaciones SET tblusuarionotificaciones.Estado=0 WHERE tblusuarionotificaciones.idCuentaUsuario=sp_idCuentaUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConfirmarCuentaUsuario`(IN `sp_nombreUsuario` VARCHAR(45))
BEGIN
SELECT tblcuentausuario.nombreUsuario, tblcuentausuario.idCuentaUsuario, tblcuentausuario.contrasenia,tblcuentausuario.numeroIdentificacion,tblcuentausuario.estado, tblcuentausuario.ultimoIngreso,tblusuarios.idRol,tblroles.nombre as nombreRol FROM tblcuentausuario JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) JOIN tblroles ON(tblusuarios.idRol=tblroles.idRol) WHERE tblcuentausuario.nombreUsuario=sp_nombreUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarAmbientes`(IN `sp_IdPiso` INT)
BEGIN
SELECT tblambientes.idAmbiente, tblambientes.Nombre from tblambientes WHERE idPiso = sp_IdPiso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarAmbientesPisoPlanos`(IN `sp_idPiso` INT)
    NO SQL
BEGIN

IF sp_idPiso != 4 AND sp_idPiso != 3 THEN
SELECT tblambientes.idAmbiente, tblambientes.Nombre FROM tblambientes WHERE tblambientes.idPiso = sp_idPiso OR tblambientes.idAmbiente = 1 OR tblambientes.idAmbiente = 2 OR tblambientes.idAmbiente = 4;
END IF;
IF sp_idPiso = 4 THEN
SELECT tblambientes.idAmbiente, tblambientes.Nombre FROM tblambientes WHERE tblambientes.idPiso = sp_idPiso OR tblambientes.idAmbiente = 1 OR tblambientes.idAmbiente = 2 OR tblambientes.idAmbiente = 4 OR tblambientes.idAmbiente = 5 or tblambientes.idAmbiente = 17 OR tblambientes.idAmbiente = 25;
END IF;
IF sp_idPiso = 3 THEN
SELECT tblambientes.idAmbiente, tblambientes.Nombre FROM tblambientes WHERE tblambientes.idPiso = sp_idPiso OR tblambientes.idAmbiente = 1 OR tblambientes.idAmbiente = 2 OR tblambientes.idAmbiente = 4 OR tblambientes.idAmbiente = 5;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCambiosPorCategoria`(IN `sp_idCategoria` INT, IN `sp_idItem` INT)
BEGIN
SELECT tblitems.Nombre, COUNT(tblitemsmantenimientos.idItemMantenimiento) as Cambios FROM tblitemsmantenimientos JOIN tblitems ON (tblitemsmantenimientos.idItem = tblitems.idItem) JOIN tblcomponentesitems ON (tblitems.idComponente = tblcomponentesitems.idComponente) JOIN tblcategoriasequipos ON (tblcomponentesitems.idCategoria = tblcategoriasequipos.idCategoria) WHERE tblitemsmantenimientos.Accion = "C" AND tblcategoriasequipos.idCategoria = sp_idCategoria AND tblitemsmantenimientos.idItem = sp_idItem;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCambiosPorEquipo`(IN `sp_CodigoEquipo` VARCHAR(45), IN `sp_idItem` INT)
BEGIN
SELECT tblitems.Nombre, COUNT(tblitemsmantenimientos.idItemMantenimiento) as Cambios FROM tblitemsmantenimientos JOIN tblmantenimientos ON (tblitemsmantenimientos.idMantenimiento = tblmantenimientos.idMantenimiento) JOIN tblitems ON (tblitemsmantenimientos.idItem = tblitems.idItem) JOIN tblequipos ON (tblmantenimientos.idEquipo = tblequipos.idEquipo) WHERE tblitemsmantenimientos.Accion = "C" AND tblequipos.Codigo = sp_CodigoEquipo AND tblitemsmantenimientos.idItem = sp_idItem;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCantidadActualInsumo`(IN `sp_IdInsumo` INT)
BEGIN
SELECT CONCAT(tblunidadesmedida.nombre,' - ', tblunidadesmedida.abreviacion) AS nombre, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.nombre) AS cantidadActual FROM tblinsumos JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) WHERE tblinsumos.idInsumo=sp_IdInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCategoriasEquipos`()
    NO SQL
SELECT tblcategoriasequipos.idCategoria, tblcategoriasequipos.Nombre FROM tblcategoriasequipos
WHERE idCategoria != '6'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCategoriasEquiposPlanos`(IN `sp_idAmbiente` INT)
BEGIN

SELECT DISTINCT(tblcategoriasequipos.idCategoria) as idCategoria,tblcategoriasequipos.Nombre FROM tblcategoriasequipos 
JOIN tbltiposequipos ON(tblcategoriasequipos.idCategoria = tbltiposequipos.idCategoria) JOIN tblequipos ON(tblequipos.idTipoEquipo=tbltiposequipos.idTipoEquipo) WHERE tblequipos.idAmbiente=sp_idAmbiente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCategoriasInformesFecha`()
    NO SQL
SELECT tblcategoriasequipos.idCategoria, tblcategoriasequipos.Nombre FROM tblcategoriasequipos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCategoriaSolicitud`(IN `sp_idSolicitud` INT)
BEGIN
SELECT (tblcategoriasequipos.Nombre) AS nombre, tblcategoriasequipos.idCategoria FROM tblcategoriasequipos JOIN tblsolicitud ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) WHERE tblsolicitud.idsolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCategoriaSolicitudd`(IN `sp_idSolicitud` INT)
    NO SQL
BEGIN
SELECT (tblcategoriasequipos.Nombre) AS nombre, tblcategoriasequipos.idCategoria FROM tblcategoriasequipos JOIN tblsolicitud ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) WHERE tblsolicitud.idsolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarComplejos`()
    NO SQL
BEGIN
SELECT tblcomplejos.idComplejos, tblcomplejos.nombreComplejos from tblcomplejos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarComponentes`(IN `sp_idCategoria` INT)
BEGIN
SELECT tblcomponentesitems.idComponente, tblcomponentesitems.Nombre FROM tblcomponentesitems WHERE tblcomponentesitems.idCategoria=sp_idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCorreoEnviarEncuesta`(IN `sp_idSolicitud` INT)
BEGIN
SELECT tblsolicitud.correo FROM tblsolicitud WHERE tblsolicitud.idsolicitud = sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCorreoModificarAsignacion`(IN `sp_identificacion` INT)
BEGIN
SELECT DISTINCT(tblusuarios.correoElectronico) FROM tblusuarios 
LEFT JOIN
tblmodificacionessolicitud ON (tblmodificacionessolicitud.idTecnico = tblusuarios.numeroIdentificacion) WHERE tblusuarios.numeroIdentificacion = sp_identificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCorreoRechazarSolicitud`(IN `sp_IdSolicitud` INT)
BEGIN
SELECT tblsolicitud.correo,TRIM(CONCAT(tblsolicitud.primerNombre,' ', tblsolicitud.segundoNombre,' ', tblsolicitud.primerApellido,' ', tblsolicitud.segundoApellido)) as Nombre FROM tblsolicitud WHERE tblsolicitud.idsolicitud = sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCorreoRegistrarMantenimiento`(IN `sp_IdSolicitud` INT)
BEGIN
SELECT DISTINCT tblusuarios.correoElectronico, TRIM(CONCAT(tblusuarios.primerNombre,' ', tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ', tblusuarios.segundoApellido)) as Nombre FROM tblusuarios JOIN tblcuentausuario ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) JOIN tblmodificacionessolicitud ON(tblcuentausuario.idCuentaUsuario=tblmodificacionessolicitud.idCuentaUsuario) WHERE tblmodificacionessolicitud.idSolicitud=sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCuentaUsuario`(IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
SET lc_time_names = 'es_CO';
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ',tblusuarios.primerApellido,' ', tblusuarios.segundoApellido) AS nombresCompletos, tblusuarios.numeroIdentificacion AS numeroIdentificacion,  CONCAT(tbltipoidentificacion.abreviacion,' ',  tblusuarios.numeroIdentificacion) AS identificacion, tblusuarios.telefono, tblusuarios.celular, CONCAT(tblmunicipios.nombre,', ',tbldepartamentos.nombre) AS municipio, tblusuarios.direccion, tblusuarios.correoElectronico, tblgeneros.nombre AS nombreGenero, tblgeneros.idGenero, DATE_FORMAT(tblcuentausuario.ultimoIngreso, '%W %d de %M de %Y a las %h:%i %p') as ultimoIngreso, tblroles.nombre as nombreRol FROM tblcuentausuario JOIN tblusuarios ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion)JOIN tblmunicipios ON(tblusuarios.idMunicipio=tblmunicipios.idMunicipio) JOIN tbldepartamentos ON(tblmunicipios.idDepartamento=tbldepartamentos.idDepartamento) JOIN tblgeneros ON(tblusuarios.idGenero=tblgeneros.idGenero)  JOIN tbltipoidentificacion ON(tblusuarios.idTipoIdentificacion=tbltipoidentificacion.idTipoIdentificacion) JOIN tblroles ON(tblroles.idRol=tblusuarios.idRol) WHERE tblcuentausuario.numeroIdentificacion=sp_numeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDatosTecnicos`(IN `sp_IdSolicitud` INT)
BEGIN
SELECT DISTINCT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ',tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombres, tblusuarios.numeroIdentificacion, tblusuarios.correoElectronico FROM tblusuarios JOIN tbltecnicosolicitudes ON(tblusuarios.numeroIdentificacion=tbltecnicosolicitudes.numeroIdentificacion) WHERE tbltecnicosolicitudes.idSolicitud=sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDepartamentos`()
BEGIN
SELECT tbldepartamentos.idDepartamento,tbldepartamentos.nombre FROM tbldepartamentos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDetalleEquipoFicha`(IN `sp_idEquipo` INT)
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblequipos.idEquipo, tblequipos.Codigo, tblmarcasequipos.Nombre as NombreMarca, tblequipos.Modelo as NombreModelo, tbltiposequipos.Nombre as NombreTipo, tblequipos.Serie as NombreSerie, CONCAT(tbltorres.Nombre, ' - Piso ', tblpisos.Nombre, ' - ', tblambientes.Nombre) AS Ubicacion, DATE_FORMAT(tblequipos.FechaFabricacion,'%d de %M de %Y') AS FechaFabricacion, DATE_FORMAT(tblequipos.FechaInstalacion,'%d de %M de %Y') AS FechaInstalacion, tblequipos.cuentadante,tblequipos.dependencia,tblequipos.placaInventario, DATE_FORMAT(CURDATE(),'%d de %M de %Y') AS fechaActual, tbltiposequipos.idCategoria,(SELECT COUNT(tblmantenimientos.idMantenimiento)+1 FROM tblmantenimientos WHERE tblmantenimientos.idEquipo=sp_idEquipo) AS numeroRevision FROM tblequipos JOIN tblmarcasequipos ON (tblmarcasequipos.idMarca = tblequipos.idMarca) JOIN tbltiposequipos ON (tblequipos.idTipoEquipo = tbltiposequipos.idTipoEquipo) JOIN tblambientes ON(tblequipos.idAmbiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblpisos.idPiso=tblambientes.idPiso) JOIN tbltorres ON (tbltorres.idTorre=tblpisos.idTorre) WHERE tblequipos.idEquipo=sp_idEquipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDetallesEmpresa`(IN `sp_idEmpresa` INT)
BEGIN
SELECT tblempresas.idEmpresa, tblempresas.nombre AS nombreEmpresa, tblempresas.NIT,CONCAT(tblmunicipios.nombre,', ',tbldepartamentos.nombre) AS municipio, tblempresas.direccion,tblempresas.correo,tblempresas.telefono, CASE tblempresas.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado, tbltipoempresa.nombre as tipoEmpresa FROM tblempresas JOIN tblmunicipios ON(tblempresas.idMunicipio=tblmunicipios.idMunicipio) JOIN tbldepartamentos ON(tblmunicipios.idDepartamento=tbldepartamentos.idDepartamento) JOIN tbltipoempresa ON(tblempresas.idTipoEmpresa=tbltipoempresa.idTipoEmpresa)  WHERE tblempresas.idEmpresa=sp_idEmpresa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDetallesEquipo`(IN `sp_IdEquipo` INT)
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblequipos.idEquipo, tblequipos.Codigo, tblmarcasequipos.Nombre as NombreMarca, tblequipos.Modelo as NombreModelo, tblcategoriasequipos.Nombre as NombreCategoria, tblequipos.Serie as NombreSerie, CONCAT(tbltorres.Nombre, ' - Piso ', tblpisos.Nombre, ' - ', tblambientes.Nombre) AS Ubicacion, DATE_FORMAT(tblequipos.FechaFabricacion,'%d de %M de %Y') AS FechaFabricacion, DATE_FORMAT(tblequipos.FechaInstalacion,'%d de %M de %Y') AS FechaInstalacion, tblequipos.cuentadante, tblequipos.dependencia, tblequipos.placaInventario, tbltiposequipos.Nombre as TipoEquipo, CASE tblequipos.Psv WHEN '1' THEN 'Si' WHEN '0' THEN 'No' END AS psv FROM tblequipos JOIN tblmarcasequipos ON (tblmarcasequipos.idMarca = tblequipos.idMarca) JOIN tbltiposequipos ON(tbltiposequipos.idTipoEquipo=tblequipos.idTipoEquipo) JOIN tblcategoriasequipos ON (tbltiposequipos.idCategoria = tblcategoriasequipos.idCategoria) JOIN tblambientes ON(tblequipos.idAmbiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblpisos.idPiso=tblambientes.idPiso) JOIN tbltorres ON (tbltorres.idTorre=tblpisos.idTorre) WHERE tblequipos.idEquipo=sp_IdEquipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDetallesEquiposPlanos`(IN `sp_idEquipo` INT)
BEGIN
SELECT tblequipos.idEquipo,tblequipos.Codigo,tblequipos.Modelo,tblequipos.Serie,tblequipos.FechaFabricacion,tblequipos.FechaInstalacion,tblequipos.cuentadante,tblequipos.dependencia,tblequipos.placaInventario,tblmantenimientos.fecha,tblmantenimientos.observaciones,CONCAT( tblmantenimientos.predictivo + tblmantenimientos.preventivo + tblmantenimientos.correctivo)As mantenimiento,CONCAT(tbltorres.Nombre, ' - Piso ', tblpisos.Nombre, ' - ', tblambientes.Nombre) AS Ubicacion,tbltiposequipos.Nombre As nombreTipoEquipo, tbltiposequipos.idTipoEquipo ,tblcategoriasequipos.idCategoria,tblcategoriasequipos.Nombre AS nombreCategoria,tblmarcasequipos.idMarca,tblmarcasequipos.nombre AS nombreMarcas FROM tblequipos LEFT JOIN tblmantenimientos ON (tblequipos.idEquipo=tblmantenimientos.idEquipo) LEFT JOIN tblambientes ON(tblequipos.idAmbiente=tblambientes.idAmbiente)LEFT JOIN tblpisos ON (tblpisos.idPiso=tblambientes.idPiso) LEFT JOIN tbltorres ON(tbltorres.idTorre=tblpisos.idTorre)LEFT JOIN tbltiposequipos ON (tbltiposequipos.idTipoEquipo=tblequipos.idTipoEquipo)LEFT JOIN tblcategoriasequipos ON (tblcategoriasequipos.idCategoria=tbltiposequipos.idCategoria)LEFT JOIN tblmarcasequipos ON (tblmarcasequipos.idMarca=tblequipos.idMarca) WHERE tblequipos.idEquipo=sp_idEquipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDetalleSinEquipoFicha`(IN `sp_idEquipo` INT)
    NO SQL
BEGIN
SELECT tblsinequipo.idEquipo FROM tblsinequipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDetallesInsumo`(IN `sp_IdInsumo` INT)
BEGIN
SELECT tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS marca, CONCAT(tblinsumos.cantidad,' ', tblunidadesmedida.nombre) AS cantidad, tblinsumos.estado, tblpresentacion.nombre as presentacion, CASE tblinsumos.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado FROM tblinsumos JOIN tblmarcas ON(tblinsumos.idMarca=tblmarcas.idMarca) JOIN tblpresentacion ON(tblinsumos.idPresentacion=tblpresentacion.idPresentacion)JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) WHERE tblinsumos.idInsumo=sp_IdInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDetalleSolicitud`(IN `sp_idSolicitud` INT)
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres, tblcategoriasequipos.Nombre as categoria, tblestadosolicitud.Nombre as estado,  DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, CONCAT(tblcomplejos.nombreComplejos,' - ', tbltorres.Nombre,' - Piso ',tblpisos.Nombre,' - ',tblambientes.Nombre) AS Ubicacion, tblsolicitud.descripcion, tblsolicitud.img, tblsolicitud.correo, tblsolicitud.idestado, DATE_FORMAT(tblsolicitud.fechaInicio,'%d de %M de %Y') AS fechaInicio, DATE_FORMAT(tblsolicitud.fechaFinal,'%d de %M de %Y') AS fechaFinal, tblsolicitud.motivoRechazo ,tblsolicitud.img FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tblambientes ON(tblambientes.idAmbiente=tblsolicitud.idambiente) JOIN tblpisos ON(tblambientes.idPiso=tblpisos.idPiso) JOIN tbltorres ON(tblpisos.idTorre=tbltorres.idTorre) JOIN tblcomplejos ON(tbltorres.idComplejos=tblcomplejos.idComplejos) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria)  WHERE sp_idSolicitud = tblsolicitud.idsolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDetallesUsuario`(IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
SELECT CONCAT(tblusuarios.primerNombre,' ', tblusuarios.segundoNombre) AS nombresCompletos, CONCAT(tblusuarios.primerApellido,' ', tblusuarios.segundoApellido) AS apellidosCompletos,CONCAT(tbltipoidentificacion.nombre,' - ',tbltipoidentificacion.abreviacion) AS tipoIdentificacion, tblusuarios.numeroIdentificacion AS numeroIdentificacion,
tblusuarios.perfil,
tblusuarios.telefono, tblusuarios.celular,tblusuarios.direccion AS direccion, tblusuarios.correoElectronico, tblgeneros.nombre AS nombreGenero, CONCAT(tblmunicipios.nombre,', ',tbldepartamentos.nombre) AS municipio, tblroles.nombre AS nombreRol FROM tblusuarios JOIN tbltipoidentificacion ON(tblusuarios.idTipoIdentificacion=tbltipoidentificacion.idTipoIdentificacion) JOIN tblmunicipios ON(tblusuarios.idMunicipio=tblmunicipios.idMunicipio) JOIN tbldepartamentos ON(tblmunicipios.idDepartamento=tbldepartamentos.idDepartamento) JOIN tblgeneros ON(tblgeneros.idGenero=tblusuarios.idGenero) JOIN tblroles ON(tblusuarios.idRol=tblroles.idRol) WHERE tblusuarios.numeroIdentificacion=sp_numeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarDevoluciones`(IN `sp_IdInsumo` INT)
BEGIN

SELECT DATE_FORMAT(tbldevoluciones.fechaDevolucion, '%d/%m/%Y a las %h:%i %p') as fechaDevolucion, CONCAT(tbldevoluciones.cantidad,' ',tblunidadesmedida.nombre) AS cantidad, LEFT(tbldevoluciones.descripcion,28) AS descripcion, tbltiposdevolucion.nombre AS tipoDevolucion,  LENGTH(tbldevoluciones.descripcion) AS longitud, tbldevoluciones.descripcion as descripcionCompleta FROM tbldevoluciones JOIN tblinsumos ON(tbldevoluciones.idInsumo=tblinsumos.idInsumo) JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) JOIN tbltiposdevolucion ON(tbldevoluciones.idTipoDevolucion=tbltiposdevolucion.idTipoDevolucion) WHERE tbldevoluciones.idInsumo=sp_IdInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarEmpresas`()
BEGIN
SELECT tblempresas.idEmpresa, tblempresas.nombre AS nombreEmpresa, tblempresas.NIT, tblempresas.direccion,tblempresas.correo,tblempresas.telefono,tbltipoempresa.nombre AS tipoEmpresa FROM tblempresas JOIN tbltipoempresa ON(tblempresas.idTipoEmpresa=tbltipoempresa.idTipoEmpresa);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarEntradas`(IN `sp_IdInsumo` INT)
BEGIN
SELECT DATE_FORMAT(tblentradas.fechaEntrada, '%d/%m/%Y a las %h:%i %p') as fechaEntrada, CONCAT(tblentradas.cantidad,' ',tblunidadesmedida.nombre) AS cantidad FROM tblentradas JOIN tblinsumos ON(tblentradas.idInsumo=tblinsumos.idInsumo) JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) WHERE tblentradas.idInsumo=sp_IdInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarEquipos`()
    NO SQL
SELECT tblequipos.idEquipo, tblequipos.Codigo, tblmarcasequipos.Nombre as NombreMarca, tblequipos.Modelo as NombreModelo, tblcategoriasequipos.Nombre as NombreCategoria, tblequipos.Serie as NombreSerie, CONCAT(tbltorres.Nombre, ' - Piso ', tblpisos.Nombre, ' - ', tblambientes.Nombre) AS Ubicacion FROM tblequipos JOIN tblmarcasequipos ON (tblmarcasequipos.idMarca = tblequipos.idMarca) JOIN tbltiposequipos ON(tblequipos.idTipoEquipo=tbltiposequipos.idTipoEquipo) JOIN tblcategoriasequipos ON (tbltiposequipos.idCategoria = tblcategoriasequipos.idCategoria) JOIN tblambientes ON(tblequipos.idAmbiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblpisos.idPiso=tblambientes.idPiso) JOIN tbltorres ON (tbltorres.idTorre=tblpisos.idTorre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarEquiposPlanos`(IN `sp_idAmbiente` INT, IN `sp_idCategoria` INT)
BEGIN
SELECT tblequipos.idEquipo,tblequipos.Codigo FROM tblequipos LEFT JOIN tblambientes ON(tblequipos.idAmbiente=tblambientes.idAmbiente)LEFT JOIN tblpisos ON (tblpisos.idPiso=tblambientes.idPiso) LEFT JOIN tbltorres ON(tbltorres.idTorre=tblpisos.idTorre)LEFT JOIN tbltiposequipos ON(tblequipos.idTipoEquipo=tbltiposequipos.idTipoEquipo) LEFT JOIN tblcategoriasequipos ON(tbltiposequipos.idCategoria=tblcategoriasequipos.idCategoria) WHERE tblambientes.idAmbiente=sp_idAmbiente AND tblcategoriasequipos.idCategoria=sp_idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarEquiposSolicitud`(IN `sp_idSolicitud` INT)
BEGIN
DECLARE categoriaEquipo INT;
DECLARE ambiente INT;
SET categoriaEquipo= (SELECT tblsolicitud.idCategoria FROM tblsolicitud WHERE tblsolicitud.idsolicitud=sp_idSolicitud);
SET ambiente= (SELECT tblsolicitud.idambiente FROM tblsolicitud WHERE tblsolicitud.idsolicitud=sp_idSolicitud);
SELECT tblequipos.idEquipo,tblequipos.Codigo,null FROM tblequipos JOIN tbltiposequipos ON(tblequipos.idTipoEquipo=tbltiposequipos.idTipoEquipo) WHERE tbltiposequipos.idCategoria=categoriaEquipo AND tblequipos.idAmbiente=ambiente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarEstadoCuentaUsuario`(IN `sp_numeroIdentificacion` INT)
BEGIN

SET lc_time_names = 'es_CO';
SELECT tblcuentausuario.estado, DATE_FORMAT(tblcuentausuario.ultimoIngreso, '%d de %M de %Y a las %h:%i %p') AS ultimoIngreso, (tblcuentausuario.nombreUsuario) as nombreUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion=sp_numeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarEstadosSolicitud`()
BEGIN
SELECT tblestadosolicitud.idEstado,tblestadosolicitud.Nombre FROM tblestadosolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarGeneros`()
BEGIN
SELECT tblgeneros.idGenero,tblgeneros.nombre FROM tblgeneros;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarHistorialNotificaciones`(IN `sp_idCuentaUsuario` INT)
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblnotificaciones.idSolicitud, DATE_FORMAT(tblsolicitud.fechaRegistro, '%d de %M de %Y a las %h:%i %p')AS fechaRegistro, CONCAT(tblsolicitud.primerNombre, ' ', tblsolicitud.primerApellido) as Nombres, tblnotificaciones.Descripcion, tblusuarionotificaciones.Estado, tblsolicitud.idCategoria FROM tblnotificaciones JOIN tblsolicitud ON tblsolicitud.idsolicitud = tblnotificaciones.idSolicitud JOIN tblusuarionotificaciones ON(tblnotificaciones.idNotificaciones=tblusuarionotificaciones.idNotificaciones)  WHERE tblusuarionotificaciones.idCuentaUsuario=sp_idCuentaUsuario
ORDER BY tblnotificaciones.idNotificaciones DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarInsumos`()
BEGIN
SELECT tblinsumos.idInsumo, tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS marca, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad, tblinsumos.estado, tblpresentacion.nombre as presentacion FROM tblinsumos JOIN tblmarcas ON(tblinsumos.idMarca=tblmarcas.idMarca) JOIN tblpresentacion ON(tblinsumos.idPresentacion=tblpresentacion.idPresentacion) JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarItems`(IN `sp_idComponente` INT)
BEGIN

SELECT tblitems.idItem, tblitems.Nombre FROM tblitems WHERE tblitems.idComponente=sp_idComponente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarItemsInformeCambiosC`(IN `sp_idCategoria` INT)
BEGIN
SELECT tblitems.idItem, tblitems.Nombre FROM tblitems JOIN tblcomponentesitems ON (tblitems.idComponente = tblcomponentesitems.idComponente) JOIN tblcategoriasequipos ON (tblcomponentesitems.idCategoria = tblcategoriasequipos.idCategoria) WHERE tblcategoriasequipos.idCategoria = sp_idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarItemsInformeCambiosE`(IN `sp_CodigoEquipo` VARCHAR(45))
BEGIN
SELECT DISTINCT(tblitems.idItem) AS idItem, tblitems.Nombre FROM tblitems JOIN tblcomponentesitems ON (tblitems.idComponente = tblcomponentesitems.idComponente) JOIN tblcategoriasequipos ON (tblcomponentesitems.idCategoria = tblcategoriasequipos.idCategoria) JOIN tblequipos ON (tblequipos.idCategoria = tblcategoriasequipos.idCategoria) WHERE tblequipos.Codigo = sp_CodigoEquipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMarcas`()
BEGIN
SELECT tblmarcas.idMarca, tblmarcas.nombre FROM tblmarcas WHERE tblmarcas.estado=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMarcasEquipoRegistradas`()
    NO SQL
BEGIN
SELECT tblmarcasequipos.Nombre, tblmarcasequipos.idMarca FROM tblmarcasequipos;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMarcasEquipos`()
    NO SQL
SELECT tblmarcasequipos.idMarca, tblmarcasequipos.Nombre FROM tblmarcasequipos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMarcasModificarInsumo`(IN `sp_idInsumo` INT)
BEGIN
SELECT DISTINCT tblmarcas.idMarca, tblmarcas.nombre FROM tblmarcas LEFT JOIN tblinsumos ON(tblinsumos.idMarca=tblmarcas.idMarca) WHERE tblmarcas.estado=1 OR tblmarcas.estado=0 AND tblinsumos.idInsumo=sp_idInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMarcasRegistradas`()
BEGIN
SELECT tblmarcas.nombre, tblmarcas.idMarca FROM tblmarcas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarModificacionesSolicitud`(IN `sp_idSolicitud` INT)
BEGIN
SELECT DATE_FORMAT(tblmodificacionessolicitud.fecha, '%d/%m/%Y a las %h:%i %p') as fechaModificacion, 
tblmodificacionessolicitud.Motivo as motivoCompleto, 
CASE tblmodificacionessolicitud.tipoModificacion WHEN '1' THEN 'Agregado' WHEN '2' THEN 'Eliminado' WHEN '3' THEN 'Plazo extendido' WHEN '4' THEN 'Finalizado' WHEN '5' THEN 'Ficha técnica' END as tipoModificacion,
IFNULL(CONCAT(tblusuarios.primerNombre, ' ', tblusuarios.segundoNombre, ' ', tblusuarios.primerApellido, ' ', tblusuarios.segundoApellido), ' - ') AS usuarioModificado,
tblcuentausuario.nombreUsuario,
LENGTH(tblmodificacionessolicitud.Motivo) AS longitud, 
LEFT(tblmodificacionessolicitud.Motivo,28) AS Motivo
FROM tblmodificacionessolicitud JOIN tblcuentausuario ON(tblmodificacionessolicitud.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) LEFT JOIN tblusuarios ON (tblusuarios.numeroIdentificacion = tblmodificacionessolicitud.idTecnico) WHERE tblmodificacionessolicitud.idSolicitud=sp_idSolicitud

UNION

SELECT DATE_FORMAT(tblplazosolicitud.fecha, '%d/%m/%Y a las %h:%i %p') as fechaModificacion, 
tblplazosolicitud.Motivo as motivoCompleto, 
'Plazo extendido', 
' - ',tblcuentausuario.nombreUsuario,
LENGTH(tblplazosolicitud.Motivo) AS longitud,
LEFT(tblplazosolicitud.Motivo,28) AS Motivo FROM tblplazosolicitud JOIN tblcuentausuario ON(tblcuentausuario.idCuentaUsuario=tblplazosolicitud.idCuentaUsuario) WHERE tblplazosolicitud.idSolicitud=sp_idSolicitud;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarModulos`(IN `sp_idRol` INT)
BEGIN
SELECT DISTINCT tblmodulos.idModulo,tblmodulos.nombre AS nombreModulo FROM tblmodulos JOIN tblpermisos ON(tblpermisos.idModulo=tblmodulos.idModulo) WHERE tblpermisos.idRol=sp_idRol or tblpermisos.idRol=3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarModulosUsuario`(IN `sp_idCuentaUsuario` INT)
BEGIN
SELECT DISTINCT tblpermisos.idModulo, tblpermisos.verModulo, tblmodulos.nombre AS nombreModulo FROM tblpermisos JOIN tblmodulos ON(tblpermisos.idModulo=tblmodulos.idModulo) JOIN tblpermisosusuario ON(tblpermisos.idPermiso=tblpermisosusuario.idPermiso) WHERE tblpermisosusuario.idCuentaUsuario=sp_idCuentaUsuario AND verModulo=1 ORDER BY tblpermisos.idModulo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMotivoRechazoSolicitud`(IN `sp_IdSolicitud` INT)
BEGIN
SELECT tblsolicitud.motivoRechazo FROM tblsolicitud WHERE tblsolicitud.idsolicitud=sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarMunicipios`(IN `sp_idDepartamento` INT)
BEGIN
SELECT idMunicipio,nombre FROM tblmunicipios where idDepartamento=sp_idDepartamento;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarNombreAmbientePlanos`(IN `sp_idAmbiente` INT)
BEGIN
SELECT tblambientes.Nombre AS nombre FROM tblambientes  WHERE tblambientes.idAmbiente=sp_idAmbiente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarNotificacion`(IN `sp_idCuentaUsuario` INT, IN `sp_tipoNotificacion` INT)
    NO SQL
IF sp_tipoNotificacion = 0 THEN

SELECT tblnotificaciones.idSolicitud, DATE_FORMAT(tblnotificaciones.Fecha, '%d/%m/%Y a las %h:%i %p')AS fecha, DATE_FORMAT(tblnotificaciones.Fecha, '%d/%m/%Y') as ordenar, CONCAT('Realizada por ', tblsolicitud.primerNombre, ' ', tblsolicitud.primerApellido) as Nombres, tblnotificaciones.Descripcion, tblusuarionotificaciones.Estado, tblsolicitud.idCategoria FROM tblnotificaciones JOIN tblsolicitud ON tblsolicitud.idsolicitud = tblnotificaciones.idSolicitud JOIN tblusuarionotificaciones ON(tblnotificaciones.idNotificaciones=tblusuarionotificaciones.idNotificaciones)  WHERE tblusuarionotificaciones.idCuentaUsuario=sp_idCuentaUsuario AND tblnotificaciones.tipoNotificacion = sp_tipoNotificacion
ORDER BY tblnotificaciones.idNotificaciones DESC LIMIT 1;

ELSE

SELECT 	DISTINCT tblnotificaciones.idNotificaciones, DATE_FORMAT(tblnotificaciones.Fecha , '%d/%m/%Y a las %h:%i %p')AS fecha,tblnotificaciones.Fecha as ordenar, CONCAT('Realizado por ', tblusuarios.primerNombre, ' ', tblusuarios.primerApellido) as Nombres, tblnotificaciones.Descripcion FROM tblnotificaciones JOIN tblmodificacionessolicitud ON (tblnotificaciones.idNotificaciones = tblmodificacionessolicitud.idNotificaciones) JOIN tblusuarionotificaciones ON (tblnotificaciones.idNotificaciones=tblusuarionotificaciones.idNotificaciones) JOIN tblcuentausuario ON (tblmodificacionessolicitud.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON (tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) WHERE tblnotificaciones.tipoNotificacion = sp_tipoNotificacion AND tblusuarionotificaciones.idCuentaUsuario=sp_idCuentaUsuario ORDER BY tblnotificaciones.idNotificaciones DESC LIMIT 1;

END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarNumeroPreguntasEncuesta`()
BEGIN
SELECT COUNT(tblpreguntasencuesta.idPregunta) as numeroPreguntas FROM tblpreguntasencuesta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarPermisosModulo`(IN `sp_idModulo` INT, IN `sp_idCuentaUsuario` VARCHAR(45), IN `sp_idRol` INT)
BEGIN
SELECT DISTINCT (tblpermisos.idPermiso) AS idPermiso, tblpermisos.nombre, tblpermisosusuario.idPermiso AS permisoUsuario FROM tblpermisos LEFT JOIN tblpermisosusuario ON(tblpermisos.idPermiso=tblpermisosusuario.idPermiso)  WHERE tblpermisosusuario.idCuentaUsuario=sp_idCuentaUsuario AND tblpermisos.idModulo=sp_idModulo AND tblpermisos.idRol=sp_idRol OR tblpermisos.idRol=3 AND tblpermisosusuario.idCuentaUsuario=sp_idCuentaUsuario AND tblpermisos.idModulo=sp_idModulo
UNION 

SELECT tblpermisos.idPermiso, tblpermisos.nombre, NULL FROM tblpermisos WHERE tblpermisos.idPermiso NOT IN (SELECT tblpermisosusuario.idPermiso FROM tblpermisosusuario WHERE tblpermisosusuario.idCuentaUsuario=sp_idCuentaUsuario AND tblpermisos.idModulo=sp_idModulo) AND tblpermisos.idModulo=sp_idModulo AND tblpermisos.idRol=sp_idRol OR tblpermisos.idRol=3 AND tblpermisos.idModulo=sp_idModulo AND tblpermisos.idPermiso NOT IN (SELECT tblpermisosusuario.idPermiso FROM tblpermisosusuario WHERE tblpermisosusuario.idCuentaUsuario=sp_idCuentaUsuario AND tblpermisos.idModulo=sp_idModulo)
ORDER BY idPermiso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarPermisosUsuario`(IN `sp_idCuentaUsuario` INT)
BEGIN
SELECT tblpermisos.idModulo,tblpermisosusuario.idPermiso FROM tblpermisos JOIN tblmodulos ON(tblpermisos.idModulo=tblmodulos.idModulo) JOIN tblpermisosusuario ON(tblpermisos.idPermiso=tblpermisosusuario.idPermiso) WHERE tblpermisosusuario.idCuentaUsuario=sp_idCuentaUsuario ORDER BY tblpermisos.idPermiso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarPisos`(IN `sp_IdTorre` INT)
BEGIN
SELECT idPiso, Nombre from tblpisos WHERE idTorre = sp_IdTorre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarPreguntasEncuesta`()
BEGIN
SELECT tblpreguntasencuesta.idPregunta, tblpreguntasencuesta.Descripcion, tblpreguntasencuesta.tipoPregunta FROM tblpreguntasencuesta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarPresentaciones`()
BEGIN
SELECT tblpresentacion.idPresentacion, tblpresentacion.nombre FROM tblpresentacion WHERE tblpresentacion.estado=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarPresentacionesModificarInsumo`(IN `sp_idInsumo` INT)
BEGIN
SELECT DISTINCT tblpresentacion.idPresentacion, tblpresentacion.nombre FROM tblpresentacion LEFT JOIN tblinsumos ON(tblinsumos.idPresentacion=tblpresentacion.idPresentacion) WHERE tblpresentacion.estado=1 OR tblpresentacion.estado=0 AND tblinsumos.idInsumo=sp_idInsumo;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarPresentacionesRegistradas`()
BEGIN
SELECT tblpresentacion.idPresentacion,tblpresentacion.nombre FROM tblpresentacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarRiesgos`(IN `sp_idTipoRiesgo` INT)
BEGIN
SELECT tblriesgos.idRiesgo,tblriesgos.descripcion FROM tblriesgos WHERE tblriesgos.idTipoRiesgo=sp_idTipoRiesgo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarRiesgosd`(IN `sp_idTipoRiesgo2` INT)
    NO SQL
BEGIN
SELECT tblriesgos.idRiesgo,tblriesgos.descripcion FROM tblriesgos WHERE tblriesgos.idTipoRiesgo=sp_idTipoRiesgo2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarSolicitudes`(IN `sp_IdRol` INT, IN `sp_numeroIdentificacion` VARCHAR(45), IN `sp_estadoSolicitud` INT, IN `sp_idPrioridad` INT, IN `sp_idCategoria` INT, IN `sp_idTorre` INT)
BEGIN

IF sp_IdRol=1 THEN
IF sp_estadoSolicitud=0 THEN
IF sp_idPrioridad=0 THEN
IF sp_idTorre=0 THEN
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres, tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado, DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado, tblsolicitud.prioridad,  tblambientes.idAmbiente, tblpisos.idPiso, tbltorres.idTorre, tbltorres.Nombre AS torre FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) JOIN tblambientes ON(tblsolicitud.idambiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblambientes.idPiso=tblpisos.idPiso) JOIN tbltorres ON(tblpisos.idTorre=tbltorres.idTorre)WHERE tblsolicitud.idCategoria=sp_idCategoria AND tbltorres.idTorre=1 AND tblsolicitud.fechaRegistro < CURRENT_DATE AND tblsolicitud.fechaRegistro > date_add(CURRENT_DATE, INTERVAL - 90 DAY) AND tblsolicitud.idestado !=6
ORDER BY tblsolicitud.fechaRegistro DESC;

ELSE
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres, tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado, DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado, tblsolicitud.prioridad, tblambientes.idAmbiente, tblpisos.idPiso, tbltorres.idTorre, tbltorres.Nombre AS torre FROM 
tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria)  JOIN tblambientes ON(tblsolicitud.idambiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblambientes.idPiso=tblpisos.idPiso) JOIN tbltorres ON(tblpisos.idTorre=tbltorres.idTorre) WHERE tbltorres.idTorre=sp_idTorre AND tblcategoriasequipos.idCategoria=sp_idCategoria ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;
END IF;

ELSE
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres, tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado, DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado, tblsolicitud.prioridad, tblambientes.idAmbiente, tblpisos.idPiso, tbltorres.idTorre, tbltorres.Nombre AS torre FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) JOIN tblambientes ON(tblsolicitud.idambiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblambientes.idPiso=tblpisos.idPiso) JOIN tbltorres ON(tblpisos.idTorre=tbltorres.idTorre) WHERE tblsolicitud.prioridad=sp_idPrioridad AND tbltorres.idTorre=sp_idTorre AND tblsolicitud.idCategoria=sp_idCategoria  ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;
END IF;


ELSE	
IF sp_idPrioridad=0 THEN
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres, tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado, DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado, tblsolicitud.prioridad, tblambientes.idAmbiente, tblpisos.idPiso, tbltorres.idTorre, tbltorres.Nombre AS torre FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) JOIN tblambientes ON(tblsolicitud.idambiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblambientes.idPiso=tblpisos.idPiso) JOIN tbltorres ON(tblpisos.idTorre=tbltorres.idTorre) WHERE tblsolicitud.idestado=sp_estadoSolicitud AND tbltorres.idTorre=sp_idTorre AND tblsolicitud.idCategoria=sp_idCategoria ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;
ELSE
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres, tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado, DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado, tblsolicitud.prioridad, tblambientes.idAmbiente, tblpisos.idPiso, tbltorres.idTorre, tbltorres.Nombre AS torre FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) JOIN tblambientes ON(tblsolicitud.idambiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblambientes.idPiso=tblpisos.idPiso) JOIN tbltorres ON(tblpisos.idTorre=tbltorres.idTorre) WHERE tblsolicitud.idestado=sp_estadoSolicitud AND tblsolicitud.prioridad=sp_idPrioridad AND tbltorres.idTorre=sp_idTorre AND tblsolicitud.idCategoria=sp_idCategoria ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;
END IF;
END IF;



ELSEIF sp_IdRol=2 THEN

IF sp_estadoSolicitud=0 THEN
IF sp_idPrioridad=0 THEN
IF sp_idCategoria = 0 THEN
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres,tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado,  DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado,tblsolicitud.prioridad FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tbltecnicosolicitudes ON(tbltecnicosolicitudes.idSolicitud=tblsolicitud.idsolicitud) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) WHERE tbltecnicosolicitudes.numeroIdentificacion=sp_numeroIdentificacion ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;

ELSE

SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres,tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado,  DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado,tblsolicitud.prioridad FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tbltecnicosolicitudes ON(tbltecnicosolicitudes.idSolicitud=tblsolicitud.idsolicitud) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) WHERE tbltecnicosolicitudes.numeroIdentificacion=sp_numeroIdentificacion AND tblsolicitud.idCategoria=sp_idCategoria ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;

END IF;
ELSE 

SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres,tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado,  DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado,tblsolicitud.prioridad FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tbltecnicosolicitudes ON(tbltecnicosolicitudes.idSolicitud=tblsolicitud.idsolicitud) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) WHERE tbltecnicosolicitudes.numeroIdentificacion=sp_numeroIdentificacion AND tblsolicitud.prioridad=sp_idPrioridad AND tblsolicitud.idCategoria=sp_idCategoria ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;
END IF;
ELSE
IF sp_idPrioridad=0 THEN 
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres,tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado,  DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado,tblsolicitud.prioridad FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tbltecnicosolicitudes ON(tbltecnicosolicitudes.idSolicitud=tblsolicitud.idsolicitud) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) WHERE tbltecnicosolicitudes.numeroIdentificacion=sp_numeroIdentificacion AND tblsolicitud.idestado=sp_estadoSolicitud AND tblsolicitud.idCategoria=sp_idCategoria ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;
ELSE 
SELECT tblsolicitud.idsolicitud, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres,tblcategoriasequipos.Nombre AS categoria, tblestadosolicitud.Nombre as estado,  DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblsolicitud.idestado,tblsolicitud.prioridad FROM tblsolicitud JOIN tblestadosolicitud ON(tblsolicitud.idestado=tblestadosolicitud.idEstado) JOIN tbltecnicosolicitudes ON(tbltecnicosolicitudes.idSolicitud=tblsolicitud.idsolicitud) JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) WHERE tbltecnicosolicitudes.numeroIdentificacion=sp_numeroIdentificacion AND tblsolicitud.idestado=sp_estadoSolicitud AND tblsolicitud.prioridad=sp_idPrioridad AND tblsolicitud.idCategoria=sp_idCategoria ORDER BY tblsolicitud.prioridad, tblsolicitud.fechaRegistro DESC;
END IF;
END IF;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarSolicitudesAtendidas`()
    NO SQL
BEGIN
SELECT CONCAT('Hasta la fecha, se han atendido <strong>', COUNT(tblsolicitud.idsolicitud),'</strong> solicitudes utilizando el sistema Soluciones Ágiles en Mantenimiento "SAM" ') AS Total FROM tblsolicitud WHERE  tblsolicitud.idestado=6 LIMIT 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarSolicitudesAtrasadas`()
BEGIN
SELECT tblsolicitud.idsolicitud,DATE_FORMAT(tblsolicitud.fechaInicio, '%d/%m/%Y') as fechaInicio, DATE_FORMAT(tblsolicitud.fechaFinal, '%d/%m/%Y') as fechaFinal FROM tblsolicitud WHERE tblsolicitud.fechaFinal<CURDATE() AND tblsolicitud.idestado=3 ORDER BY  tblsolicitud.fechaFinal ASC LIMIT 3 ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarSolicitudesCalendario`(IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
SELECT tblsolicitud.idestado, tblsolicitud.fechaInicio, DATE_ADD(tblsolicitud.fechaFinal,INTERVAL 1 DAY) AS fechaFinal, CASE tblsolicitud.prioridad WHEN 1 THEN '#EF5350' WHEN 2 THEN '#FDD835' ELSE '#4CAF50' END AS Color, CONCAT('  Solicitud Nº ',tblsolicitud.idsolicitud) AS titulo FROM tblsolicitud JOIN tblambientes ON(tblambientes.idAmbiente=tblsolicitud.idambiente) JOIN tblpisos ON(tblambientes.idPiso=tblpisos.idPiso) JOIN tbltorres ON(tblpisos.idTorre=tbltorres.idTorre) JOIN tbltecnicosolicitudes ON(tbltecnicosolicitudes.idSolicitud=tblsolicitud.idsolicitud) WHERE tbltecnicosolicitudes.numeroIdentificacion=sp_numeroIdentificacion AND tblsolicitud.idestado != 6;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarSolicitudesParaHoy`()
    NO SQL
BEGIN
SELECT tblsolicitud.idsolicitud,DATE_FORMAT(tblsolicitud.fechaInicio, '%d/%m/%Y') as fechaInicio, DATE_FORMAT(tblsolicitud.fechaFinal, '%d/%m/%Y') as fechaFinal FROM tblsolicitud WHERE  tblsolicitud.fechaInicio=CURDATE() AND tblsolicitud.idestado=3 ORDER BY tblsolicitud.fechaInicio ASC LIMIT 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarSolicitudesRecientes`()
BEGIN
SELECT tblsolicitud.idsolicitud,concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres, DATE_FORMAT(tblsolicitud.fechaRegistro, '%d/%m/%Y a las %h:%i %p') as fechaRegistro, tblcategoriasequipos.Nombre as equipoAfectado FROM tblsolicitud JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria=tblcategoriasequipos.idCategoria) ORDER BY tblsolicitud.fechaRegistro DESC LIMIT 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarSolicitudesSinAsignar`()
BEGIN
SELECT tblsolicitud.idsolicitud, DATE_FORMAT(tblsolicitud.fechaRegistro,'%d/%m/%Y') as fechaRegistro, concat(tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido) as nombres FROM tblsolicitud WHERE tblsolicitud.idestado=2 ORDER BY  tblsolicitud.fechaFinal ASC LIMIT 3;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTecnicos`()
BEGIN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ',tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombres, tblusuarios.numeroIdentificacion FROM tblusuarios WHERE tblusuarios.idRol=2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTecnicosDisponibles`()
BEGIN
SELECT concat(tblusuarios.primerNombre, ' ', tblusuarios.segundoNombre, ' ', tblusuarios.primerApellido, ' ', tblusuarios.segundoApellido) as nombres, tblusuarios.numeroIdentificacion FROM tblusuarios WHERE tblusuarios.numeroIdentificacion NOT IN (SELECT DISTINCT tbltecnicosolicitudes.numeroIdentificacion FROM tbltecnicosolicitudes LEFT JOIN tblsolicitud ON(tbltecnicosolicitudes.idSolicitud=tblsolicitud.idsolicitud) WHERE CURDATE() BETWEEN tblsolicitud.fechaInicio AND tblsolicitud.fechaFinal) AND tblusuarios.idRol=2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTecnicosSolicitud`(IN `sp_IdSolicitud` INT)
BEGIN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ',tblusuarios.primerApellido,' ',tblusuarios.segundoApellido,' - ', tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as NombreCompleto, TRIM(CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ',tblusuarios.primerApellido,' ',tblusuarios.segundoApellido)) as Nombre FROM tblusuarios JOIN tbltecnicosolicitudes ON(tblusuarios.numeroIdentificacion=tbltecnicosolicitudes.numeroIdentificacion) JOIN tblsolicitud ON(tblsolicitud.idsolicitud=tbltecnicosolicitudes.idSolicitud) JOIN tbltipoidentificacion ON(tblusuarios.idTipoIdentificacion=tbltipoidentificacion.idTipoIdentificacion) WHERE tblsolicitud.idsolicitud=sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTiposDevolucion`()
BEGIN
SELECT tbltiposdevolucion.idTipoDevolucion, tbltiposdevolucion.nombre FROM tbltiposdevolucion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTiposEquipos`(IN `sp_idCategoria` INT)
BEGIN
SELECT DISTINCT tbltiposequipos.idTipoEquipo,tbltiposequipos.Nombre FROM tbltiposequipos WHERE tbltiposequipos.idCategoria=sp_idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTiposIdentificacion`()
BEGIN
SELECT tbltipoidentificacion.idTipoIdentificacion,CONCAT(tbltipoidentificacion.nombre,' - ',tbltipoidentificacion.abreviacion) AS nombre FROM tbltipoidentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTiposRiesgos`()
BEGIN
SELECT tbltiposriesgos.idTipoRiesgo,(tbltiposriesgos.Nombre) as Nombre FROM tbltiposriesgos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTiposRiesgosd`()
    NO SQL
BEGIN
SELECT tbltiposriesgos.idTipoRiesgo,(tbltiposriesgos.Nombre) as Nombre FROM tbltiposriesgos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTorres`(IN `sp_IdComplejo` INT)
BEGIN
SELECT idTorre, Nombre from tbltorres WHERE tbltorres.idComplejos=sp_IdComplejo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTorresEquipos`()
    NO SQL
BEGIN
SELECT tbltorres.idTorre, tbltorres.Nombre from tbltorres;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarTorreSolicitud`()
    NO SQL
BEGIN
SELECT tbltorres.idTorre, tbltorres.Nombre FROM tbltorres
WHERE tbltorres.idTorre != 7;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUltimoIdEncuesta`()
BEGIN
SELECT MAX(tblencuestas.idEncuesta) AS idEncuesta FROM tblencuestas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUltimoIdMantenimiento`()
BEGIN
SELECT MAX(tblmantenimientos.idMantenimiento) AS idMantenimiento FROM tblmantenimientos;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUltimoIdMantenimientod`()
    NO SQL
BEGIN
SELECT MAX(tblmantenimientosotros.idMantenimientod) AS idMantenimientod FROM tblmantenimientosotros;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUltimoIdNotificacion`()
    NO SQL
SELECT MAX(idNotificaciones) As idNotificaciones FROM tblnotificaciones$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUltimoIdSolicitud`()
BEGIN
SELECT MAX(idSolicitud) As idSolicitud FROM tblsolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUnidadesMedida`()
BEGIN
SELECT tblunidadesmedida.idUnidadMedida, CONCAT(tblunidadesmedida.nombre,' - ' ,tblunidadesmedida.abreviacion) as nombre FROM tblunidadesmedida;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUsuarioModificado`(IN `sp_idCuentaUsuario` INT)
    NO SQL
SELECT CONCAT(tblusuarios.primerNombre, ' ', tblusuarios.primerApellido) as Nombres FROM tblusuarios WHERE tblusuarios.numeroIdentificacion = sp_idCuentaUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUsuarioRetirarTecnico`(IN `sp_identificacion` INT)
BEGIN
SELECT CONCAT(tblusuarios.primerNombre, ' ', tblusuarios.segundoNombre, ' ', tblusuarios.primerApellido, ' ', tblusuarios.segundoApellido) as NombreCompleto FROM tblusuarios WHERE tblusuarios.numeroIdentificacion = sp_identificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUsuarios`(IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
SELECT CONCAT(tblusuarios.primerNombre,' ', tblusuarios.segundoNombre) AS nombresCompletos, CONCAT(tblusuarios.primerApellido,' ', tblusuarios.segundoApellido) AS apellidosCompletos, CONCAT(tbltipoidentificacion.abreviacion,' ', tblusuarios.numeroIdentificacion) AS identificacion, tblusuarios.numeroIdentificacion AS numeroIdentificacion,
tblusuarios.perfil,
tblusuarios.telefono, tblusuarios.direccion AS direccion, tblgeneros.nombre AS nombreGenero, tblcuentausuario.idCuentaUsuario, tblusuarios.idRol, tblroles.nombre AS nombreRol FROM tblusuarios JOIN tblgeneros ON(tblgeneros.idGenero=tblusuarios.idGenero) JOIN tbltipoidentificacion ON(tblusuarios.idTipoIdentificacion=tbltipoidentificacion.idTipoIdentificacion) JOIN tblroles ON(tblusuarios.idRol=tblroles.idRol) LEFT JOIN tblcuentausuario ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) WHERE tblusuarios.numeroIdentificacion not like sp_numeroIdentificacion ORDER BY tblusuarios.fechaRegistro DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUsuariosNotificacion`(IN `sp_Tipo` INT, IN `sp_idCategoria` INT, IN `sp_idCuentaUsuario` INT, IN `sp_idSolicitud` INT)
BEGIN
IF sp_Tipo = 0 THEN

IF sp_idCategoria = 1 THEN
SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=44 AND tblusuarios.idRol=1;
END IF;

IF sp_idCategoria = 2 THEN
SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=45 AND tblusuarios.idRol=1;
END IF;

IF sp_idCategoria = 3 THEN
SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=52 AND tblusuarios.idRol=1;
END IF;

IF sp_idCategoria = 4 THEN
SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=49 AND tblusuarios.idRol=1;
END IF;

IF sp_idCategoria = 5 THEN
SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=56 AND tblusuarios.idRol=1;
END IF;
END IF;

IF sp_Tipo = 1 THEN

IF sp_idCategoria = 1 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=44

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;


IF sp_idCategoria = 2 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=45

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 3 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=52

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 4 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=49

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 5 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=56

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;
END IF;

IF sp_Tipo = 2 THEN

IF sp_idCategoria = 1 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=44

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;

END IF;

IF sp_idCategoria = 2 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=45

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 3 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=52

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 4 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=49

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 5 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=56

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;
END IF;

IF sp_Tipo = 3 THEN

IF sp_idCategoria = 1 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=44

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;

END IF;

IF sp_idCategoria = 2 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=45

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 3 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=52

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;

END IF;


IF sp_idCategoria = 4 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=49

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 5 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=56

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;
END IF;

IF sp_Tipo = 4 THEN

IF sp_idCategoria = 1 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=44

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN tblusuarios ON (tblcuentausuario.numeroIdentificacion = tblusuarios.numeroIdentificacion) JOIN tbltecnicosolicitudes ON (tblusuarios.numeroIdentificacion = tbltecnicosolicitudes.numeroIdentificacion) JOIN tblsolicitud ON (tbltecnicosolicitudes.idSolicitud = tblsolicitud.idsolicitud) WHERE tblsolicitud.idsolicitud = sp_idSolicitud;


END IF;

IF sp_idCategoria = 2 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=45

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN tblusuarios ON (tblcuentausuario.numeroIdentificacion = tblusuarios.numeroIdentificacion) JOIN tbltecnicosolicitudes ON (tblusuarios.numeroIdentificacion = tbltecnicosolicitudes.numeroIdentificacion) JOIN tblsolicitud ON (tbltecnicosolicitudes.idSolicitud = tblsolicitud.idsolicitud) WHERE tblsolicitud.idsolicitud = sp_idSolicitud;
END IF;

IF sp_idCategoria = 3 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=52

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN tblusuarios ON (tblcuentausuario.numeroIdentificacion = tblusuarios.numeroIdentificacion) JOIN tbltecnicosolicitudes ON (tblusuarios.numeroIdentificacion = tbltecnicosolicitudes.numeroIdentificacion) JOIN tblsolicitud ON (tbltecnicosolicitudes.idSolicitud = tblsolicitud.idsolicitud) WHERE tblsolicitud.idsolicitud = sp_idSolicitud;

END IF;

IF sp_idCategoria = 4 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=49

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN tblusuarios ON (tblcuentausuario.numeroIdentificacion = tblusuarios.numeroIdentificacion) JOIN tbltecnicosolicitudes ON (tblusuarios.numeroIdentificacion = tbltecnicosolicitudes.numeroIdentificacion) JOIN tblsolicitud ON (tbltecnicosolicitudes.idSolicitud = tblsolicitud.idsolicitud) WHERE tblsolicitud.idsolicitud = sp_idSolicitud;
END IF;

IF sp_idCategoria = 5 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=56

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN tblusuarios ON (tblcuentausuario.numeroIdentificacion = tblusuarios.numeroIdentificacion) JOIN tbltecnicosolicitudes ON (tblusuarios.numeroIdentificacion = tbltecnicosolicitudes.numeroIdentificacion) JOIN tblsolicitud ON (tbltecnicosolicitudes.idSolicitud = tblsolicitud.idsolicitud) WHERE tblsolicitud.idsolicitud = sp_idSolicitud;
END IF;
END IF;

IF sp_Tipo = 5 THEN

IF sp_idCategoria = 1 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=44;

END IF;

IF sp_idCategoria = 2 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=45;
END IF;

IF sp_idCategoria = 3 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=52;

END IF;

IF sp_idCategoria = 4 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=49;
END IF;

IF sp_idCategoria = 5 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=56;
END IF;
END IF;

IF sp_Tipo = 6 THEN

IF sp_idCategoria = 1 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=44

UNION


SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 2 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=45

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 3 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=52

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 4 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=49

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;

IF sp_idCategoria = 5 THEN

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN 	tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) WHERE tblpermisosusuario.idPermiso=56

UNION

SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario WHERE tblcuentausuario.numeroIdentificacion = sp_idCuentaUsuario;
END IF;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CrearCuentaUsuario`(IN `sp_nombreUsuario` VARCHAR(45), IN `sp_contrasenia` VARCHAR(45), IN `sp_numeroIdentificacion` VARCHAR(45), IN `sp_estado` INT)
BEGIN

INSERT INTO tblcuentausuario (nombreUsuario,contrasenia,numeroIdentificacion,estado) VALUES (sp_nombreUsuario,sp_contrasenia,sp_numeroIdentificacion, sp_estado) ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarPermisoCuentaUsuario`(IN `sp_idCuentaUsuario` INT, IN `sp_idPermiso` INT)
BEGIN

DELETE FROM tblpermisosusuario WHERE tblpermisosusuario.idCuentaUsuario=sp_idCuentaUsuario AND tblpermisosusuario.idPermiso=sp_idPermiso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarTecnicosSolicitud`(IN `sp_idSolicitud` INT)
BEGIN
DELETE FROM tbltecnicosolicitudes WHERE tbltecnicosolicitudes.idSolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ExtenderFechaSolicitud`(IN `sp_idSolicitud` INT)
BEGIN
SELECT DATE_FORMAT(tblsolicitud.fechaInicio,'%d-%m-%Y') as fechaInicio, DATE_FORMAT(tblsolicitud.fechaFinal,'%d-%m-%Y') as fechaFinal FROM tblsolicitud WHERE tblsolicitud.idsolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeBajas`(IN `sp_fechaInicio` VARCHAR(10), IN `sp_fechaFinal` VARCHAR(10))
BEGIN
SET lc_time_names = 'es_CO';
IF sp_fechaInicio=0 AND sp_fechaFinal=0 THEN
SELECT tblinsumos.codigo, tblinsumos.nombre, DATE_FORMAT(tblbajas.fechaBaja, '%d de %M de %Y a las %h:%i %p') as fechaBaja, CONCAT(tblbajas.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad FROM tblinsumos JOIN tblbajas ON(tblinsumos.idInsumo=tblbajas.idInsumo) JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) ORDER BY tblbajas.fechaBaja;
ELSE
SELECT tblinsumos.codigo, tblinsumos.nombre, DATE_FORMAT(tblbajas.fechaBaja, '%d de %M de %Y a las %h:%i %p') as fechaBaja, CONCAT(tblbajas.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad FROM tblinsumos JOIN tblbajas ON(tblinsumos.idInsumo=tblbajas.idInsumo) JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) WHERE tblbajas.fechaBaja BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY) ORDER BY tblbajas.fechaBaja;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeCategoriaPorFecha`(IN `sp_fechaInicio` VARCHAR(100), IN `sp_fechaFinal` VARCHAR(100), IN `sp_idCategoria` INT)
    NO SQL
BEGIN

IF sp_fechaInicio = 0 and sp_fechaFinal = 0 THEN
IF sp_idCategoria = '1' THEN
SELECT cate.idCategoria, mant.idMantenimiento,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, complejo.nombreComplejos, cate.Nombre FROM tblmantenimientos as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre INNER JOIN tblcomplejos as complejo ON complejo.idComplejos = torre.idComplejos WHERE cate.idCategoria = sp_idCategoria;
END IF;
END IF;

IF sp_fechaInicio = 0 and sp_fechaFinal = 0 THEN
IF sp_idCategoria != '1' AND sp_idCategoria != '6' THEN 
SELECT cate.idCategoria, mant.idMantenimientod,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientosotros as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE cate.idCategoria = sp_idCategoria;
END IF;
END IF;

IF sp_fechaInicio = 0 and sp_fechaFinal = 0 THEN
if sp_idCategoria = '6' THEN
SELECT cate.idCategoria, mant.idMantenimiento,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientos as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre
UNION
SELECT cate.idCategoria, mant.idMantenimientod,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientosotros as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre;
END IF;
END IF;


IF sp_idCategoria = '1' THEN

SELECT cate.idCategoria, mant.idMantenimiento,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientos as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE mant.fecha BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY) and cate.idCategoria = sp_idCategoria;
END IF;

IF sp_idCategoria = '2' THEN
SELECT cate.idCategoria, mant.idMantenimientod,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientosotros as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE mant.fecha BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY) and cate.idCategoria = sp_idCategoria;
END IF;

IF sp_idCategoria = '3' THEN
SELECT cate.idCategoria, mant.idMantenimientod,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientosotros as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE mant.fecha BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY) and cate.idCategoria = sp_idCategoria;
END IF;

IF sp_idCategoria = '4' THEN
SELECT cate.idCategoria, mant.idMantenimientod,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientosotros as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE mant.fecha BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY) and cate.idCategoria = sp_idCategoria;
END IF;

if sp_idCategoria = '6' THEN
SELECT cate.idCategoria, mant.idMantenimiento,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientos as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE mant.fecha BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY)
UNION
SELECT cate.idCategoria, mant.idMantenimientod,mant.fecha,mant.observaciones,soli.descripcion,
soli.primerNombre,soli.primerApellido,soli.idsolicitud, tecni.numeroIdentificacion,usuario.primerNombre as nombreTecnico,usuario.primerApellido as apellidoTecnico,ambiente.Nombre as nombreAmbiente, piso.Nombre as nombrePiso,torre.Nombre as nombreTorre, cate.Nombre FROM tblmantenimientosotros as mant INNER JOIN tblsolicitud as soli ON mant.idSolicitud = soli.idsolicitud INNER JOIN tblcategoriasequipos as cate ON cate.idCategoria = soli.idCategoria INNER JOIN tbltecnicosolicitudes as tecni ON tecni.idSolicitud = soli.idsolicitud INNER JOIN tblusuarios as usuario ON usuario.numeroIdentificacion = tecni.numeroIdentificacion INNER join tblambientes as ambiente ON ambiente.idAmbiente = soli.idambiente INNER JOIN tblpisos as piso ON piso.idPiso = ambiente.idPiso INNER JOIN tbltorres as torre ON torre.idTorre = piso.idTorre WHERE mant.fecha BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeCuentasUsuario`(IN `sp_fechaInicio` VARCHAR(10), IN `sp_fechaFinal` VARCHAR(10), IN `sp_estadoCuenta` INT)
BEGIN
SET lc_time_names = 'es_CO';

IF sp_fechaInicio=0 AND sp_fechaFinal=0 THEN
IF sp_estadoCuenta='1' THEN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombreCompleto, CONCAT(tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as identificacion, tblcuentausuario.nombreUsuario, DATE_FORMAT(tblcuentausuario.ultimoIngreso, '%d de %M de %Y') AS ultimoIngreso, DATE_FORMAT(tblcuentausuario.fechaRegistro, '%d de %M de %Y') AS fechaRegistro,CASE tblcuentausuario.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado  FROM tblcuentausuario JOIN tblusuarios ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) JOIN tbltipoidentificacion ON(tbltipoidentificacion.idTipoIdentificacion=tblusuarios.idTipoIdentificacion) WHERE tblcuentausuario.estado=1;
ELSEIF sp_estadoCuenta='2' THEN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombreCompleto, CONCAT(tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as identificacion, tblcuentausuario.nombreUsuario, DATE_FORMAT(tblcuentausuario.ultimoIngreso, '%d de %M de %Y') AS ultimoIngreso, DATE_FORMAT(tblcuentausuario.fechaRegistro, '%d de %M de %Y') AS fechaRegistro, CASE tblcuentausuario.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado FROM tblcuentausuario JOIN tblusuarios ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) JOIN tbltipoidentificacion ON(tbltipoidentificacion.idTipoIdentificacion=tblusuarios.idTipoIdentificacion) WHERE tblcuentausuario.estado=0;
ELSEIF sp_estadoCuenta='3' THEN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombreCompleto, CONCAT(tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as identificacion, tblcuentausuario.nombreUsuario,DATE_FORMAT(tblcuentausuario.ultimoIngreso, '%d de %M de %Y') AS ultimoIngreso, DATE_FORMAT(tblcuentausuario.fechaRegistro,'%d de %M de %Y') AS fechaRegistro,CASE tblcuentausuario.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado FROM tblcuentausuario JOIN tblusuarios ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) JOIN tbltipoidentificacion ON(tbltipoidentificacion.idTipoIdentificacion=tblusuarios.idTipoIdentificacion);
END IF;
ELSE
IF sp_estadoCuenta='1' THEN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombreCompleto, CONCAT(tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as identificacion, tblcuentausuario.nombreUsuario, DATE_FORMAT(tblcuentausuario.ultimoIngreso, '%d de %M de %Y') AS ultimoIngreso, DATE_FORMAT(tblcuentausuario.fechaRegistro, '%d de %M de %Y') AS fechaRegistro,CASE tblcuentausuario.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado  FROM tblcuentausuario JOIN tblusuarios ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) JOIN tbltipoidentificacion ON(tbltipoidentificacion.idTipoIdentificacion=tblusuarios.idTipoIdentificacion) WHERE tblcuentausuario.estado=1 AND tblcuentausuario.fechaRegistro BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY);
ELSEIF sp_estadoCuenta='2' THEN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombreCompleto, CONCAT(tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as identificacion, tblcuentausuario.nombreUsuario, DATE_FORMAT(tblcuentausuario.ultimoIngreso, '%d de %M de %Y') AS ultimoIngreso, DATE_FORMAT(tblcuentausuario.fechaRegistro, '%d de %M de %Y') AS fechaRegistro, CASE tblcuentausuario.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado FROM tblcuentausuario JOIN tblusuarios ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) JOIN tbltipoidentificacion ON(tbltipoidentificacion.idTipoIdentificacion=tblusuarios.idTipoIdentificacion) WHERE tblcuentausuario.estado=0 AND tblcuentausuario.fechaRegistro BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY);
ELSEIF sp_estadoCuenta='3' THEN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombreCompleto, CONCAT(tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as identificacion, tblcuentausuario.nombreUsuario,DATE_FORMAT(tblcuentausuario.ultimoIngreso, '%d de %M de %Y') AS ultimoIngreso, DATE_FORMAT(tblcuentausuario.fechaRegistro,'%d de %M de %Y') AS fechaRegistro,CASE tblcuentausuario.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado FROM tblcuentausuario JOIN tblusuarios ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) JOIN tbltipoidentificacion ON(tbltipoidentificacion.idTipoIdentificacion=tblusuarios.idTipoIdentificacion) WHERE tblcuentausuario.fechaRegistro BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY);
END IF;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeDetalladoInsumoConsultarBajas`(IN `sp_CodigoInsumo` VARCHAR(45))
BEGIN
SET lc_time_names = 'es_CO';
SELECT DATE_FORMAT(tblbajas.fechaBaja,'%d de %M de %Y a las %h:%i %p') AS fechaBaja, CONCAT(tblbajas.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad FROM tblbajas JOIN tblinsumos ON(tblinsumos.idInsumo=tblbajas.idInsumo) JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) WHERE tblinsumos.codigo=sp_CodigoInsumo ORDER BY tblbajas.fechaBaja;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeDetalladoInsumoConsultarEntradas`(IN `sp_CodigoInsumo` VARCHAR(45))
BEGIN
SET lc_time_names = 'es_CO';
SELECT DATE_FORMAT(tblentradas.fechaEntrada,'%d de %M de %Y a las %h:%i %p') AS fechaEntrada, CONCAT(tblentradas.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad FROM tblentradas JOIN tblinsumos ON(tblinsumos.idInsumo=tblentradas.idInsumo) JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) WHERE tblinsumos.codigo=sp_CodigoInsumo ORDER BY tblentradas.fechaEntrada;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeDetalladoInsumoConsultarInsumo`(IN `sp_CodigoInsumo` VARCHAR(45))
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS nombreMarca, tblpresentacion.nombre AS nombrePresentacion, tblunidadesmedida.nombre AS nombreUnidadMedida, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad, CASE tblinsumos.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado, DATE_FORMAT(tblinsumos.fechaRegistro,'%d de %M de %Y') AS fechaRegistro FROM tblinsumos JOIN tblmarcas ON(tblmarcas.idMarca=tblinsumos.idMarca) JOIN tblpresentacion ON(tblpresentacion.idPresentacion=tblinsumos.idPresentacion) JOIN tblunidadesmedida ON(tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida) WHERE tblinsumos.codigo=sp_CodigoInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeDetalladoUsuario`(IN `sp_NumeroIdentificacion` VARCHAR(45))
BEGIN
SET lc_time_names = 'es_CO';
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre) AS nombres, CONCAT(tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS apellidos, tblusuarios.numeroIdentificacion as identificacion, tbltipoidentificacion.abreviacion as tipoIdentificacon, tblusuarios.direccion, tblusuarios.telefono, tblusuarios.celular, tblusuarios.correoElectronico, CONCAT(tblmunicipios.nombre,', ',tbldepartamentos.nombre) AS municipio, tblgeneros.nombre AS nombreGenero, DATE_FORMAT(tblusuarios.fechaRegistro, '%d de %M de %Y')AS fechaRegistro, UPPER(tblcuentausuario.nombreUsuario) AS nombreUsuario, CASE tblcuentausuario.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado, DATE_FORMAT(tblcuentausuario.fechaRegistro, '%d de %M de %Y')AS fechaCreacionCuenta, DATE_FORMAT(tblcuentausuario.ultimoIngreso , '%d de %M de %Y')AS ultimoIngreso FROM tblusuarios JOIN tbltipoidentificacion ON(tblusuarios.idTipoIdentificacion=tbltipoidentificacion.idTipoIdentificacion) JOIN tblmunicipios ON(tblmunicipios.idMunicipio=tblusuarios.idMunicipio) JOIN tbldepartamentos ON(tbldepartamentos.idDepartamento=tblmunicipios.idDepartamento) JOIN tblgeneros ON(tblgeneros.idGenero=tblusuarios.idGenero) LEFT JOIN tblcuentausuario ON(tblcuentausuario.numeroIdentificacion=tblusuarios.numeroIdentificacion) WHERE tblusuarios.numeroIdentificacion=sp_NumeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeEntradas`(IN `sp_fechaInicio` VARCHAR(10), IN `sp_fechaFinal` VARCHAR(10))
BEGIN
SET lc_time_names = 'es_CO';
IF sp_fechaInicio=0 AND sp_fechaFinal=0 THEN
SELECT tblinsumos.codigo, tblinsumos.nombre, DATE_FORMAT(tblentradas.fechaEntrada, '%d de %M de %Y a las %h:%i %p') as fechaEntrada, CONCAT(tblentradas.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad FROM tblinsumos JOIN tblentradas ON(tblinsumos.idInsumo=tblentradas.idInsumo) JOIN tblunidadesmedida ON (tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida) ORDER BY tblentradas.fechaEntrada;

ELSE
SELECT tblinsumos.codigo, tblinsumos.nombre, DATE_FORMAT(tblentradas.fechaEntrada, '%d de %M de %Y a las %h:%i %p') as fechaEntrada, CONCAT(tblentradas.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad FROM tblinsumos JOIN tblentradas ON(tblinsumos.idInsumo=tblentradas.idInsumo) JOIN tblunidadesmedida ON (tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida) WHERE tblentradas.fechaEntrada BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY) ORDER BY tblentradas.fechaEntrada;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeFichaConsultarEquipo`(IN `sp_idSolicitud` INT)
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblequipos.idEquipo, tblequipos.Codigo, tblmarcasequipos.Nombre as NombreMarca, tblequipos.Modelo as NombreModelo, tbltiposequipos.Nombre as NombreTipo, tblequipos.Serie as NombreSerie, CONCAT(tbltorres.Nombre, ' - Piso ', tblpisos.Nombre, ' - ', tblambientes.Nombre) AS Ubicacion, DATE_FORMAT(tblmantenimientos.fecha, '%d de %M de %Y a las %h:%i %p') as fecha, DATE_FORMAT(tblequipos.FechaFabricacion,'%d de %M de %Y') AS FechaFabricacion, DATE_FORMAT(tblequipos.FechaInstalacion,'%d de %M de %Y') AS FechaInstalacion, tblequipos.cuentadante,tblequipos.dependencia,tblequipos.placaInventario, DATE_FORMAT(CURDATE(),'%d de %M de %Y') AS fechaActual, tbltiposequipos.idCategoria,(SELECT COUNT(tblmantenimientos.idMantenimiento)+1 FROM tblmantenimientos WHERE tblmantenimientos.idSolicitud=sp_idSolicitud) AS numeroRevision,  CASE tblmantenimientos.predictivo WHEN 1 THEN 'X' WHEN 0 THEN ' ' END AS predictivo, CASE tblmantenimientos.preventivo WHEN 1 THEN 'X' WHEN 0 THEN ' ' END AS preventivo, CASE tblmantenimientos.correctivo WHEN 1 THEN 'X' WHEN 0 THEN ' ' END AS correctivo, tblmantenimientos.observaciones FROM tblequipos JOIN tblmarcasequipos ON (tblmarcasequipos.idMarca = tblequipos.idMarca) JOIN tbltiposequipos ON (tblequipos.idTipoEquipo = tbltiposequipos.idTipoEquipo) JOIN tblambientes ON(tblequipos.idAmbiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblpisos.idPiso=tblambientes.idPiso) JOIN tbltorres ON (tbltorres.idTorre=tblpisos.idTorre) JOIN tblmantenimientos ON (tblmantenimientos.idEquipo = tblequipos.idEquipo) WHERE tblmantenimientos.idSolicitud = sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeFichaConsultarFormulario`(IN `sp_idSolicitud` INT)
    NO SQL
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblmantenimientosotros.motivo, tblmantenimientosotros.motivo1, tblmantenimientosotros.motivo2, tblmantenimientosotros.descripcion,(SELECT COUNT(tblmantenimientosotros.idSolicitud=sp_idSolicitud)+1 FROM tblmantenimientosotros) AS numeroRevision, DATE_FORMAT(tblmantenimientosotros.fecha, '%d de %M de %Y a las %h:%i %p') as fecha, CASE tblmantenimientosotros.predictivo WHEN 1 THEN 'X' WHEN 0 THEN ' ' END AS predictivo, CASE tblmantenimientosotros.preventivo WHEN 1 THEN 'X' WHEN 0 THEN ' ' END AS preventivo, CASE tblmantenimientosotros.correctivo WHEN 1 THEN 'X' WHEN 0 THEN ' ' END AS correctivo, tblmantenimientosotros.observaciones, tblmantenimientosotros.idMantenimientod FROM tblmantenimientosotros WHERE tblmantenimientosotros.idSolicitud = sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeFichaConsultarItems`(IN `sp_idSolicitud` INT, IN `sp_idComponente` INT)
BEGIN
SELECT tblitems.idItem AS idItemOrder, tblitems.Nombre, CASE tblitemsmantenimientos.Accion WHEN 'C' THEN 'X' ELSE ' ' END AS Cambio,CASE tblitemsmantenimientos.Accion WHEN 'M' THEN 'X' ELSE ' ' END AS Mantenimiento  FROM tblitems JOIN tblitemsmantenimientos ON (tblitemsmantenimientos.idItem=tblitems.idItem) JOIN tblcomponentesitems ON(tblitems.idComponente=tblcomponentesitems.idComponente) JOIN tblmantenimientos ON(tblmantenimientos.idMantenimiento=tblitemsmantenimientos.idMantenimiento) WHERE tblmantenimientos.idSolicitud=sp_idSolicitud AND tblcomponentesitems.idComponente=sp_idComponente
UNION
SELECT tblitems.idItem AS idItemOrder,tblitems.Nombre,' ' AS Cambio, ' ' AS Mantenimiento FROM tblitems LEFT JOIN tblcomponentesitems ON(tblitems.idComponente=tblcomponentesitems.idComponente) WHERE tblcomponentesitems.idComponente=sp_idComponente AND tblitems.idItem NOT IN(SELECT tblitemsmantenimientos.idItem FROM tblitemsmantenimientos LEFT JOIN tblmantenimientos ON (tblmantenimientos.idMantenimiento=tblitemsmantenimientos.idMantenimiento) WHERE tblmantenimientos.idSolicitud=sp_idSolicitud) ORDER BY idItemOrder;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeFichaConsultarRiesgos`(IN `sp_IdSolicitud` INT, IN `sp_idTipoRiesgo` INT)
BEGIN
SELECT tblriesgos.idRiesgo AS idRiesgoOrder, tblriesgos.descripcion, ' ' AS fuente, ' ' AS controlesExistentes FROM tblriesgos LEFT JOIN tblriesgosmantenimiento ON(tblriesgos.idRiesgo=tblriesgosmantenimiento.idRiesgo) WHERE tblriesgos.idTipoRiesgo=sp_idTipoRiesgo AND tblriesgos.idRiesgo NOT IN (SELECT tblriesgosmantenimiento.idRiesgo FROM tblriesgosmantenimiento JOIN tblmantenimientos ON(tblriesgosmantenimiento.idMantenimiento=tblmantenimientos.idMantenimiento) WHERE tblmantenimientos.idSolicitud=sp_IdSolicitud)
UNION
SELECT tblriesgos.idRiesgo AS idRiesgoOrder, tblriesgos.descripcion, tblriesgosmantenimiento.fuente, tblriesgosmantenimiento.controlesExistentes FROM tblriesgosmantenimiento JOIN tblriesgos ON(tblriesgos.idRiesgo=tblriesgosmantenimiento.idRiesgo) JOIN tblmantenimientos ON(tblmantenimientos.idMantenimiento=tblriesgosmantenimiento.idMantenimiento) WHERE tblmantenimientos.idSolicitud=sp_IdSolicitud AND tblriesgos.idTipoRiesgo=sp_idTipoRiesgo ORDER BY idRiesgoOrder;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeFichaConsultarRiesgosd`(IN `sp_IdSolicitud` INT, IN `sp_idTipoRiesgo` INT)
    NO SQL
BEGIN
SELECT tblriesgos.idRiesgo AS idRiesgoOrder, tblriesgos.descripcion, ' ' AS fuente, ' ' AS controlesExistentes FROM tblriesgos LEFT JOIN tblriesgosmantenimiento ON(tblriesgos.idRiesgo=tblriesgosmantenimiento.idRiesgo) WHERE tblriesgos.idTipoRiesgo=sp_idTipoRiesgo AND tblriesgos.idRiesgo NOT IN (SELECT tblriesgosmantenimiento.idRiesgo FROM tblriesgosmantenimiento JOIN tblmantenimientosotros ON(tblriesgosmantenimiento.idMantenimientod=tblmantenimientosotros.idMantenimientod) WHERE tblmantenimientosotros.idSolicitud=sp_IdSolicitud)
UNION
SELECT tblriesgos.idRiesgo AS idRiesgoOrder, tblriesgos.descripcion, tblriesgosmantenimiento.fuente, tblriesgosmantenimiento.controlesExistentes FROM tblriesgosmantenimiento JOIN tblriesgos ON(tblriesgos.idRiesgo=tblriesgosmantenimiento.idRiesgo) JOIN tblmantenimientosotros ON(tblmantenimientosotros.idMantenimientod=tblriesgosmantenimiento.idMantenimientod) WHERE tblmantenimientosotros.idSolicitud=sp_IdSolicitud AND tblriesgos.idTipoRiesgo=sp_idTipoRiesgo ORDER BY idRiesgoOrder;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeFichaImagenes`(IN `sp_IdSolicitud` INT)
BEGIN

SELECT tbldiagnosticositems.idItem, tblitems.Nombre, tbldiagnosticositems.Imagen FROM tbldiagnosticositems LEFT JOIN  tblitems ON (tbldiagnosticositems.idItem = tblitems.idItem) LEFT JOIN tblmantenimientos ON (tbldiagnosticositems.idMantenimiento = tblmantenimientos.idMantenimiento) LEFT JOIN tblsolicitud ON (tblmantenimientos.idSolicitud = tblsolicitud.idsolicitud)  LEFT JOIN tblitemsmantenimientos ON (tbldiagnosticositems.idMantenimiento = tblitemsmantenimientos.idMantenimiento) WHERE tblsolicitud.idsolicitud = sp_IdSolicitud AND tblitemsmantenimientos.Accion = 'C' GROUP BY tbldiagnosticositems.idDiagnostico;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeInsumos`(IN `sp_fechaInicio` VARCHAR(10), IN `sp_fechaFinal` VARCHAR(10), IN `sp_estadoInsumo` INT)
BEGIN
SET lc_time_names = 'es_CO';

IF sp_fechaInicio=0 AND sp_fechaFinal=0 THEN
IF sp_estadoInsumo='1' THEN
SELECT tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS nombreMarca, tblpresentacion.nombre AS nombrePresentacion, tblunidadesmedida.nombre AS nombreUnidadMedia, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad, CASE tblinsumos.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado, DATE_FORMAT(tblinsumos.fechaRegistro, '%d de %M de %Y') AS fechaRegistro FROM tblinsumos JOIN tblmarcas ON(tblmarcas.idMarca=tblinsumos.idMarca) JOIN tblpresentacion ON(tblpresentacion.idPresentacion=tblinsumos.idPresentacion) JOIN tblunidadesmedida ON(tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida) WHERE tblinsumos.estado=1;
ELSEIF sp_estadoInsumo='2' THEN
SELECT tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS nombreMarca, tblpresentacion.nombre AS nombrePresentacion, tblunidadesmedida.nombre AS nombreUnidadMedia, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad, CASE tblinsumos.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado, DATE_FORMAT(tblinsumos.fechaRegistro, '%d de %M de %Y') AS fechaRegistro FROM tblinsumos JOIN tblmarcas ON(tblmarcas.idMarca=tblinsumos.idMarca) JOIN tblpresentacion ON(tblpresentacion.idPresentacion=tblinsumos.idPresentacion) JOIN tblunidadesmedida ON(tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida) WHERE tblinsumos.estado=0;
ELSEIF sp_estadoInsumo='3' THEN
SELECT tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS nombreMarca, tblpresentacion.nombre AS nombrePresentacion, tblunidadesmedida.nombre AS nombreUnidadMedia, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad, CASE tblinsumos.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado,DATE_FORMAT(tblinsumos.fechaRegistro, '%d de %M de %Y') AS fechaRegistro FROM tblinsumos JOIN tblmarcas ON(tblmarcas.idMarca=tblinsumos.idMarca) JOIN tblpresentacion ON(tblpresentacion.idPresentacion=tblinsumos.idPresentacion) JOIN tblunidadesmedida ON(tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida);
END IF;
ELSE
IF sp_estadoInsumo='1' THEN
SELECT tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS nombreMarca, tblpresentacion.nombre AS nombrePresentacion, tblunidadesmedida.nombre AS nombreUnidadMedia, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad, CASE tblinsumos.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado,DATE_FORMAT(tblinsumos.fechaRegistro, '%d de %M de %Y') AS fechaRegistro  FROM tblinsumos JOIN tblmarcas ON(tblmarcas.idMarca=tblinsumos.idMarca) JOIN tblpresentacion ON(tblpresentacion.idPresentacion=tblinsumos.idPresentacion) JOIN tblunidadesmedida ON(tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida) WHERE tblinsumos.fechaRegistro BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY) AND tblinsumos.estado=1;
ELSEIF sp_estadoInsumo='2' THEN
SELECT tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS nombreMarca, tblpresentacion.nombre AS nombrePresentacion, tblunidadesmedida.nombre AS nombreUnidadMedia, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad, CASE tblinsumos.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado,DATE_FORMAT(tblinsumos.fechaRegistro, '%d de %M de %Y') AS fechaRegistro FROM tblinsumos JOIN tblmarcas ON(tblmarcas.idMarca=tblinsumos.idMarca) JOIN tblpresentacion ON(tblpresentacion.idPresentacion=tblinsumos.idPresentacion) JOIN tblunidadesmedida ON(tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida) WHERE tblinsumos.fechaRegistro BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY) AND tblinsumos.estado=0;
ELSEIF sp_estadoInsumo='3' THEN
SELECT tblinsumos.codigo, tblinsumos.nombre, tblmarcas.nombre AS nombreMarca, tblpresentacion.nombre AS nombrePresentacion, tblunidadesmedida.nombre AS nombreUnidadMedia, CONCAT(tblinsumos.cantidad,' ',tblunidadesmedida.abreviacion) AS cantidad, CASE tblinsumos.estado WHEN 1 THEN 'Activo' WHEN 0 THEN 'Inactivo' END AS estado,DATE_FORMAT(tblinsumos.fechaRegistro, '%d de %M de %Y') AS fechaRegistro FROM tblinsumos JOIN tblmarcas ON(tblmarcas.idMarca=tblinsumos.idMarca) JOIN tblpresentacion ON(tblpresentacion.idPresentacion=tblinsumos.idPresentacion) JOIN tblunidadesmedida ON(tblunidadesmedida.idUnidadMedida=tblinsumos.idUnidadMedida) WHERE tblinsumos.fechaRegistro BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY);
END IF;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GenerarInformeUsuariosRegistrados`(IN `sp_fechaInicio` VARCHAR(10), IN `sp_fechaFinal` VARCHAR(10))
BEGIN
SET lc_time_names = 'es_CO';
IF sp_fechaInicio=0 AND sp_fechaFinal=0 THEN
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombreCompleto, CONCAT(tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as identificacion, tblusuarios.telefono, tblusuarios.celular, tblusuarios.direccion,CONCAT(tblmunicipios.nombre,', ',tbldepartamentos.nombre) AS municipio, tblusuarios.correoElectronico, tblgeneros.nombre AS nombreGenero, DATE_FORMAT(tblusuarios.fechaRegistro, '%d de %M de %Y') AS fechaRegistro FROM tblusuarios JOIN tbltipoidentificacion ON(tbltipoidentificacion.idTipoIdentificacion=tblusuarios.idTipoIdentificacion) JOIN tblmunicipios ON(tblusuarios.idMunicipio=tblmunicipios.idMunicipio) JOIN tbldepartamentos ON(tbldepartamentos.idDepartamento=tblmunicipios.idDepartamento) JOIN tblgeneros ON(tblusuarios.idGenero=tblgeneros.idGenero);
ELSE
SELECT CONCAT(tblusuarios.primerNombre,' ',tblusuarios.segundoNombre,' ', tblusuarios.primerApellido,' ',tblusuarios.segundoApellido) AS nombreCompleto, CONCAT(tbltipoidentificacion.abreviacion,' ',tblusuarios.numeroIdentificacion) as identificacion, tblusuarios.telefono, tblusuarios.celular, tblusuarios.direccion,CONCAT(tblmunicipios.nombre,', ',tbldepartamentos.nombre) AS municipio, tblusuarios.correoElectronico, tblgeneros.nombre AS nombreGenero, DATE_FORMAT(tblusuarios.fechaRegistro, '%d de %M de %Y') AS fechaRegistro FROM tblusuarios JOIN tbltipoidentificacion ON(tbltipoidentificacion.idTipoIdentificacion=tblusuarios.idTipoIdentificacion) JOIN tblmunicipios ON(tblusuarios.idMunicipio=tblmunicipios.idMunicipio) JOIN tbldepartamentos ON(tbldepartamentos.idDepartamento=tblmunicipios.idDepartamento) JOIN tblgeneros ON(tblusuarios.idGenero=tblgeneros.idGenero) WHERE tblusuarios.fechaRegistro BETWEEN sp_fechaInicio AND DATE_ADD(sp_fechaFinal,INTERVAL 1 DAY);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosContraseña`(IN `sp_contrasenia` VARCHAR(45), IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
UPDATE tblcuentausuario SET contrasenia=sp_contrasenia WHERE tblcuentausuario.numeroIdentificacion=sp_numeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosEmpresa`(IN `sp_nombre` VARCHAR(45), IN `sp_NIT` VARCHAR(45), IN `sp_idMunicipio` INT, IN `sp_direccion` VARCHAR(45), IN `sp_correo` VARCHAR(45), IN `sp_telefono` VARCHAR(45), IN `sp_idEmpresa` INT)
BEGIN
UPDATE tblempresas SET tblempresas.nombre=sp_nombre, tblempresas.NIT=sp_nit,tblempresas.idMunicipio=sp_idMunicipio, tblempresas.direccion=sp_direccion, tblempresas.correo=sp_correo, tblempresas.telefono=sp_telefono WHERE tblempresas.idEmpresa=sp_idEmpresa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosEquipo`(IN `sp_Codigo` VARCHAR(45), IN `sp_Marca` INT, IN `sp_Modelo` VARCHAR(45), IN `sp_TipoEquipo` INT, IN `sp_Serie` VARCHAR(45), IN `sp_FechaFabricacion` VARCHAR(45), IN `sp_FechaInstalacion` VARCHAR(45), IN `sp_Ambiente` INT, IN `sp_Cuentadante` VARCHAR(45), IN `sp_Dependencia` VARCHAR(45), IN `sp_PlacaInventario` VARCHAR(45), IN `sp_IdEquipo` INT, IN `sp_Psv` INT)
    NO SQL
BEGIN
UPDATE tblequipos SET tblequipos.Codigo=sp_Codigo, tblequipos.idMarca = sp_Marca, tblequipos.Modelo = sp_Modelo, tblequipos.idTipoEquipo = sp_TipoEquipo, tblequipos.Serie = sp_Serie, tblequipos.FechaFabricacion = sp_FechaFabricacion, tblequipos.FechaInstalacion = sp_FechaInstalacion, tblequipos.idAmbiente = sp_Ambiente, tblequipos.cuentadante = sp_Cuentadante, tblequipos.dependencia = sp_Dependencia, tblequipos.placaInventario = sp_PlacaInventario, tblequipos.Psv = sp_Psv WHERE tblequipos.idEquipo=sp_idEquipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosExtenderFechaSolicitud`(IN `sp_IdSolicitud` INT, IN `sp_FechaInicial` VARCHAR(45), IN `sp_FechaFinal` VARCHAR(45))
BEGIN
UPDATE tblsolicitud SET tblsolicitud.fechaInicio=sp_FechaInicial, tblsolicitud.fechaFinal=sp_FechaFinal WHERE tblsolicitud.idsolicitud=sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosFechaSolicitud`(IN `sp_IdSolicitud` INT, IN `sp_FechaInicial` VARCHAR(45), IN `sp_FechaFinal` VARCHAR(45))
BEGIN
UPDATE tblsolicitud SET tblsolicitud.fechaInicio=sp_FechaInicial, tblsolicitud.fechaFinal=sp_FechaFinal WHERE tblsolicitud.idsolicitud=sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosInfoPersonal`(IN `sp_primerNombre` VARCHAR(45), IN `sp_segundoNombre` VARCHAR(45), IN `sp_primerApellido` VARCHAR(45), IN `sp_segundoApellido` VARCHAR(45), IN `sp_idTipoIdentificacion` INT, IN `sp_numeroIdentificacion` VARCHAR(45), IN `sp_telefono` VARCHAR(45), IN `sp_celular` VARCHAR(45), IN `sp_idMunicipio` INT, IN `sp_direccion` VARCHAR(45), IN `sp_correoElectronico` VARCHAR(45), IN `sp_idGenero` INT)
BEGIN
UPDATE tblusuarios SET tblusuarios.primerNombre=sp_primerNombre, tblusuarios.segundoNombre=sp_segundoNombre, tblusuarios.primerApellido=sp_primerApellido, tblusuarios.segundoApellido=sp_segundoApellido, tblusuarios.idTipoIdentificacion=sp_idTipoIdentificacion, tblusuarios.telefono=sp_telefono, tblusuarios.celular=sp_celular, tblusuarios.idMunicipio=sp_idMunicipio, tblusuarios.direccion=sp_direccion, tblusuarios.correoElectronico=sp_correoElectronico, tblusuarios.idGenero=sp_idGenero WHERE tblusuarios.numeroIdentificacion=sp_numeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosInsumo`(IN `sp_idInsumo` INT, IN `sp_codigo` VARCHAR(45), IN `sp_nombre` VARCHAR(45), IN `sp_idMarca` INT, IN `sp_estado` INT, IN `sp_idPresentacion` INT)
BEGIN
UPDATE tblinsumos SET tblinsumos.codigo=sp_codigo, tblinsumos.nombre=sp_nombre, tblinsumos.idMarca=sp_idMarca, tblinsumos.idPresentacion=sp_idPresentacion, tblinsumos.estado=sp_estado WHERE tblinsumos.idInsumo=sp_idInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosMarca`(IN `sp_idMarca` INT, IN `sp_nombreMarca` VARCHAR(45))
BEGIN
UPDATE tblmarcas SET tblmarcas.nombre=sp_nombreMarca WHERE tblmarcas.idMarca=sp_idMarca;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosMarcaEquipo`(IN `sp_idMarca` INT, IN `sp_nombreMarca` VARCHAR(45))
    NO SQL
BEGIN
UPDATE tblmarcasequipos SET tblmarcasequipos.Nombre=sp_nombreMarca WHERE tblmarcasequipos.idMarca=sp_idMarca;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosNombreAmbiente`(IN `sp_idAmbiente` INT, IN `sp_Nombre` VARCHAR(45))
    NO SQL
UPDATE tblambientes SET tblambientes.Nombre = sp_Nombre WHERE tblambientes.idAmbiente = sp_idAmbiente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosNombreUsuario`(IN `sp_NombreUsuario` VARCHAR(45), IN `sp_NumeroIdentificacion` VARCHAR(45))
BEGIN
UPDATE tblcuentausuario SET tblcuentausuario.nombreUsuario=sp_NombreUsuario WHERE tblcuentausuario.numeroIdentificacion=sp_NumeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosPresentacion`(IN `sp_idPresentacion` INT, IN `sp_nombrePresentacion` VARCHAR(45))
BEGIN
UPDATE tblpresentacion SET tblpresentacion.nombre=sp_nombrePresentacion WHERE tblpresentacion.idPresentacion=sp_idPresentacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosTecnicoSolicitud`(IN `sp_idSolicitud` INT, IN `sp_NumeroIdentificacion` INT, IN `sp_idCuentaUsuario` INT)
BEGIN
INSERT INTO tbltecnicosolicitudes (tbltecnicosolicitudes.idSolicitud, tbltecnicosolicitudes.numeroIdentificacion,tbltecnicosolicitudes.idCuentaUsuario) VALUES (sp_idSolicitud,sp_numeroIdentificacion,sp_idCuentaUsuario);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GuardarCambiosUsuario`(IN `sp_primerNombre` VARCHAR(45), IN `sp_segundoNombre` VARCHAR(45), IN `sp_primerApellido` VARCHAR(45), IN `sp_segundoApellido` VARCHAR(45), IN `sp_idTipoIdentificacion` INT, IN `sp_numeroIdentificacion` VARCHAR(45), IN `sp_telefono` VARCHAR(45), IN `sp_celular` VARCHAR(45), IN `sp_idMunicipio` INT, IN `sp_direccion` VARCHAR(45), IN `sp_correoElectronico` VARCHAR(45), IN `sp_idGenero` INT, IN `sp_perfil` VARCHAR(45))
BEGIN
UPDATE tblusuarios SET tblusuarios.perfil=sp_perfil,  tblusuarios.primerNombre=sp_primerNombre, tblusuarios.segundoNombre=sp_segundoNombre, tblusuarios.primerApellido=sp_primerApellido, tblusuarios.segundoApellido=sp_segundoApellido, tblusuarios.idTipoIdentificacion=sp_idTipoIdentificacion, tblusuarios.telefono=sp_telefono, tblusuarios.celular=sp_celular, tblusuarios.idMunicipio=sp_idMunicipio, tblusuarios.direccion=sp_direccion, tblusuarios.correoElectronico=sp_correoElectronico, tblusuarios.idGenero=sp_idGenero WHERE tblusuarios.numeroIdentificacion=sp_numeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarEmpresa`(IN `sp_idEmpresa` INT)
BEGIN
SELECT tblempresas.idEmpresa AS idEmpresa, tblempresas.nombre AS nombreEmpresa, tblempresas.NIT, tblmunicipios.idDepartamento, tblempresas.idMunicipio, tblempresas.direccion,tblempresas.correo,tblempresas.telefono,tblempresas.estado FROM tblempresas JOIN tblmunicipios ON(tblempresas.idMunicipio=tblmunicipios.idMunicipio) WHERE tblempresas.idEmpresa=sp_idEmpresa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarEquipo`(IN `sp_idEquipo` INT)
BEGIN

SELECT tblequipos.idEquipo, tblequipos.Codigo, tblequipos.idMarca, tblequipos.Modelo as NombreModelo, tblequipos.Serie as NombreSerie, tblequipos.idAmbiente, tblambientes.idPiso, tblpisos.idTorre, DATE_FORMAT(tblequipos.FechaInstalacion,'%d-%m-%Y') AS FechaInstalacion,  DATE_FORMAT(tblequipos.FechaFabricacion,'%d-%m-%Y') AS FechaFabricacion, tbltiposequipos.idCategoria, tblcategoriasequipos.Nombre as nombreCategoria, tblequipos.idTipoEquipo, tblequipos.cuentadante, tblequipos.placaInventario, tblequipos.dependencia, CASE tblequipos.Psv WHEN '1' THEN 'Si' WHEN '0' THEN 'No' END AS psv FROM tblequipos JOIN tblambientes ON(tblequipos.idAmbiente=tblambientes.idAmbiente) JOIN tblpisos ON(tblpisos.idPiso=tblambientes.idPiso) JOIN tbltorres ON (tbltorres.idTorre=tblpisos.idTorre) JOIN tbltiposequipos ON(tbltiposequipos.idTipoEquipo=tblequipos.idTipoEquipo) JOIN tblcategoriasequipos ON(tbltiposequipos.idCategoria=tblcategoriasequipos.idCategoria) WHERE tblequipos.idEquipo=sp_idEquipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarEstadoCuentaUsuario`(IN `sp_NumeroIdentificacion` VARCHAR(45), IN `sp_Estado` INT)
BEGIN
UPDATE tblcuentausuario SET tblcuentausuario.estado=sp_Estado WHERE tblcuentausuario.numeroIdentificacion=sp_NumeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarEstadoEmpresa`(IN `sp_idEmpresa` INT, IN `sp_Estado` INT)
BEGIN

UPDATE tblempresas set tblempresas.estado=sp_Estado WHERE tblempresas.idEmpresa=sp_idEmpresa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarEstadoInsumo`(IN `sp_IdInsumo` INT, IN `sp_Estado` INT)
BEGIN
UPDATE tblinsumos SET tblinsumos.estado=sp_Estado WHERE tblinsumos.idInsumo=sp_IdInsumo;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarEstadoMarca`(IN `sp_idMarca` INT, IN `sp_Estado` INT)
BEGIN
UPDATE tblmarcas SET tblmarcas.estado=sp_Estado WHERE tblmarcas.idMarca=sp_idMarca;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarEstadoPresentacion`(IN `sp_idPresentacion` INT, IN `sp_Estado` INT)
BEGIN
UPDATE tblpresentacion SET tblpresentacion.estado=sp_Estado WHERE tblpresentacion.idPresentacion=sp_idPresentacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarFechaSolicitud`(IN `sp_idSolicitud` INT)
BEGIN
SELECT DATE_FORMAT(tblsolicitud.fechaInicio,'%d-%m-%Y') as fechaInicio, DATE_FORMAT(tblsolicitud.fechaFinal,'%d-%m-%Y') as fechaFinal FROM tblsolicitud WHERE tblsolicitud.idsolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarInformacionPersonal`(IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
SELECT tblusuarios.primerNombre, tblusuarios.segundoNombre, tblusuarios.primerApellido, tblusuarios.segundoApellido, tblusuarios.idTipoIdentificacion, tblusuarios.numeroIdentificacion, tblusuarios.telefono, tblusuarios.celular, tblmunicipios.idDepartamento, tblusuarios.idMunicipio, tblusuarios.direccion, tblusuarios.correoElectronico, tblusuarios.idGenero FROM tblusuarios JOIN tblmunicipios ON(tblmunicipios.idMunicipio=tblusuarios.idMunicipio) WHERE tblusuarios.numeroIdentificacion=sp_numeroIdentificacion;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarInsumo`(IN `sp_idInsumo` INT)
BEGIN
SELECT tblinsumos.idInsumo, tblinsumos.codigo, tblinsumos.nombre, tblinsumos.idMarca AS marca, tblinsumos.cantidad, tblinsumos.estado, tblinsumos.idPresentacion as presentacion, tblunidadesmedida.nombre AS unidadMedida FROM tblinsumos JOIN tblunidadesmedida ON(tblinsumos.idUnidadMedida=tblunidadesmedida.idUnidadMedida) WHERE tblinsumos.idInsumo=sp_IdInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarMarca`(IN `sp_IdMarca` INT)
BEGIN
SELECT tblmarcas.idMarca, tblmarcas.nombre, tblmarcas.estado FROM tblmarcas WHERE tblmarcas.idMarca=sp_IdMarca;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarMarcaEquipo`(IN `sp_IdMarca` INT)
    NO SQL
BEGIN
SELECT tblmarcasequipos.idMarca, tblmarcasequipos.Nombre FROM tblmarcasequipos WHERE tblmarcasequipos.idMarca=sp_IdMarca;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarPresentacion`(IN `sp_idPresentacion` INT)
BEGIN
SELECT tblpresentacion.idPresentacion, tblpresentacion.nombre, tblpresentacion.estado FROM tblpresentacion WHERE tblpresentacion.idPresentacion=sp_idPresentacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarPrioridadSolicitud`(IN `sp_idSolicitud` INT, IN `sp_idPrioridad` INT)
BEGIN
UPDATE tblsolicitud SET tblsolicitud.prioridad=sp_idPrioridad WHERE tblsolicitud.idsolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarTecnicoSolicitud`(IN `sp_idSolicitud` INT)
BEGIN
SELECT tblusuarios.numeroIdentificacion FROM tblsolicitud JOIN tbltecnicosolicitudes ON(tblsolicitud.idsolicitud=tbltecnicosolicitudes.idSolicitud) JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tbltecnicosolicitudes.numeroIdentificacion) WHERE tblsolicitud.idsolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarUsuario`(IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
SELECT tblusuarios.perfil, tblusuarios.primerNombre, tblusuarios.segundoNombre,tblusuarios.primerApellido, tblusuarios.segundoApellido, tblusuarios.idTipoIdentificacion, tblusuarios.numeroIdentificacion, tblusuarios.telefono, tblusuarios.celular, tblmunicipios.idDepartamento AS idDepartamento, tblusuarios.idMunicipio AS idMunicipio, tblusuarios.direccion, tblusuarios.correoElectronico, tblusuarios.idGenero AS idGenero FROM tblusuarios JOIN tblmunicipios ON(tblusuarios.idMunicipio=tblmunicipios.idMunicipio) WHERE tblusuarios.numeroIdentificacion=sp_numeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RechazarSolicitud`(IN `sp_MotivoRechazo` TEXT, IN `sp_idSolicitud` INT)
BEGIN
UPDATE tblsolicitud SET tblsolicitud.motivoRechazo=sp_MotivoRechazo WHERE tblsolicitud.idsolicitud=sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarDescripcionFallo`(IN `sp_idSolicitud` INT, IN `sp_idCuentaUsuario` INT, IN `sp_motivoModificacion` TEXT)
BEGIN 
INSERT INTO tblplazosolicitud (idSolicitud,idCuentaUsuario,Motivo) VALUES (sp_idSolicitud,sp_idCuentaUsuario,sp_motivoModificacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarDetalleEncuesta`(IN `sp_idEncuesta` INT, IN `sp_idPregunta` INT, IN `sp_Respuesta` VARCHAR(45))
BEGIN
INSERT INTO tbldetallesencuestas (idEncuesta, idPregunta, Respuesta) VALUES(sp_idEncuesta, sp_idPregunta, sp_Respuesta);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarDevolucion`(IN `sp_IdInsumo` INT, IN `sp_cantidad` INT, IN `sp_idTipoDevolucion` INT, IN `sp_descripcion` TEXT)
BEGIN
INSERT INTO tbldevoluciones (idInsumo,cantidad,idTipoDevolucion,descripcion) VALUES (sp_IdInsumo,sp_cantidad,sp_idTipoDevolucion,sp_descripcion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarDiagnosticoMantenimiento`(IN `sp_IdMantenimiento` INT, IN `sp_IdItem` INT, IN `sp_Imagen` VARCHAR(100), IN `sp_Descripcion` TEXT)
BEGIN
INSERT INTO tbldiagnosticositems (idMantenimiento, idItem, Imagen, Descripcion) VALUES (sp_IdMantenimiento, sp_IdItem, sp_Imagen, sp_Descripcion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarEmpresa`(IN `sp_nombre` VARCHAR(45), IN `sp_NIT` VARCHAR(45), IN `sp_idMunicipio` INT, IN `sp_direccion` VARCHAR(45), IN `sp_correo` VARCHAR(45), IN `sp_telefono` VARCHAR(45), IN `sp_estado` INT, IN `sp_idTipoEmpresa` INT)
BEGIN

INSERT INTO tblEmpresas  (nombre,NIT,idMunicipio,direccion,correo,telefono,estado,idTipoEmpresa) VALUES (sp_nombre, sp_NIT, sp_idMunicipio, sp_direccion, sp_correo, sp_telefono, sp_estado, sp_idTipoEmpresa);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarEncuesta`(IN `sp_idSolicitud` INT)
BEGIN
INSERT INTO tblencuestas (idSolicitud) VALUES(sp_idSolicitud);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarEntrada`(IN `sp_IdInsumo` INT, IN `sp_cantidad` INT)
BEGIN
INSERT INTO tblentradas (idInsumo, cantidad) VALUES (sp_IdInsumo, sp_cantidad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarEquipo`(IN `sp_Codigo` VARCHAR(45), IN `sp_idMarca` INT, IN `sp_Modelo` VARCHAR(45), IN `sp_idTipo` INT, IN `sp_idCategoria` INT, IN `sp_Serie` VARCHAR(45), IN `sp_Psv` INT, IN `sp_FechaFabricacion` VARCHAR(45), IN `sp_FechaInstalacion` VARCHAR(45), IN `sp_Cuentadante` VARCHAR(45), IN `sp_Dependencia` VARCHAR(45), IN `sp_PlacaInventario` VARCHAR(45), IN `sp_idAmbiente` INT)
    NO SQL
BEGIN
INSERT INTO tblequipos (Codigo, idMarca, Modelo, idTipoEquipo,idCategoria, Serie, Psv, FechaFabricacion, FechaInstalacion, cuentadante, dependencia,placaInventario,  idAmbiente) VALUES (sp_Codigo, sp_idMarca, sp_Modelo, sp_idTipo, sp_idCategoria,  sp_Serie,sp_Psv,sp_FechaFabricacion, sp_FechaInstalacion,sp_Cuentadante, sp_Dependencia, sp_PlacaInventario, sp_idAmbiente);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarInsumo`(IN `sp_codigo` VARCHAR(45), IN `sp_nombre` VARCHAR(45), IN `sp_idMarca` INT, IN `sp_estado` INT, IN `sp_idPresentacion` INT, IN `sp_idUnidadMedida` INT)
BEGIN
INSERT INTO tblinsumos (codigo, nombre, idMarca, estado, idPresentacion, idUnidadMedida) VALUES (sp_codigo, sp_nombre,sp_idMarca, sp_estado, sp_idPresentacion, sp_idUnidadMedida);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarItemMantenimiento`(IN `sp_idMantenimiento` INT, IN `sp_idItem` INT, IN `sp_accion` VARCHAR(45))
BEGIN
INSERT INTO tblitemsmantenimientos(idMantenimiento,idItem,Accion) VALUES (sp_idMantenimiento,sp_idItem,sp_accion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarMantenimiento`(IN `sp_idEquipo` INT, IN `sp_predictivo` INT, IN `sp_preventivo` INT, IN `sp_correctivo` INT, IN `sp_observaciones` TEXT, IN `sp_idSolicitud` INT)
BEGIN

INSERT INTO tblmantenimientos (idEquipo,predictivo,preventivo,correctivo,observaciones,idSolicitud) VALUES (sp_idEquipo,sp_predictivo,sp_preventivo,sp_correctivo,sp_observaciones,sp_idSolicitud);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarMantenimientod`(IN `sp_motivo` VARCHAR(100), IN `sp_motivo1` VARCHAR(100), IN `sp_motivo2` VARCHAR(100), IN `sp_descripcion` VARCHAR(100), IN `sp_predictivo` INT, IN `sp_preventivo` INT, IN `sp_correctivo` INT, IN `sp_observaciones` VARCHAR(100), IN `sp_idSolicitud` INT)
    NO SQL
BEGIN

INSERT INTO tblmantenimientosotros (motivo,motivo1,motivo2,descripcion,predictivo,preventivo,correctivo,observaciones,idSolicitud) VALUES (sp_motivo,sp_motivo1,sp_motivo2,sp_descripcion,sp_predictivo,sp_preventivo,sp_correctivo,sp_observaciones,sp_idSolicitud);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarMarca`(IN `sp_nombreMarca` VARCHAR(45), IN `sp_Estado` INT)
BEGIN
INSERT INTO tblmarcas (tblmarcas.nombre, tblmarcas.estado) VALUES (sp_nombreMarca, sp_Estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarMarcaEquipo`(IN `sp_Nombre` VARCHAR(45))
    NO SQL
INSERT INTO tblmarcasequipos (Nombre) VALUES (sp_Nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarMotivoModificacion`(IN `sp_idSolicitud` INT, IN `sp_idCuentaUsuario` INT, IN `sp_motivoModificacion` TEXT, IN `sp_tipoModificacion` INT, IN `sp_idTecnico` VARCHAR(45), IN `sp_idNotificaciones` INT)
BEGIN 
INSERT INTO tblmodificacionessolicitud (idSolicitud,idCuentaUsuario,idTecnico, tipoModificacion, Motivo, idNotificaciones) VALUES (sp_idSolicitud,sp_idCuentaUsuario,sp_idTecnico, sp_tipoModificacion, sp_motivoModificacion, sp_idNotificaciones);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarNotificacionUsuario`(IN `sp_idnotificacion` INT, IN `sp_idcuentausuario` INT)
BEGIN
INSERT INTO tblusuarionotificaciones (Estado, idNotificaciones,idCuentaUsuario) VALUES (1, sp_idnotificacion,sp_idcuentausuario);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarNuevaNotificacion`(IN `sp_descripcion` TEXT, IN `sp_tipo` INT, IN `sp_idSolicitud` INT)
BEGIN
INSERT INTO tblnotificaciones (Descripcion,tipoNotificacion,idSolicitud) VALUES (sp_descripcion,sp_tipo,sp_idSolicitud);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarPresentacion`(IN `sp_Nombre` VARCHAR(45), IN `sp_Estado` INT)
BEGIN
INSERT INTO tblpresentacion (tblpresentacion.nombre, tblpresentacion.estado) VALUES (sp_Nombre, sp_Estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarRiesgosMantenimiento`(IN `sp_idRiesgo` INT, IN `sp_fuente` TEXT, IN `sp_controlesExistentes` TEXT, IN `sp_idMantenimiento` INT)
BEGIN
INSERT INTO tblriesgosmantenimiento (idRiesgo,idMantenimiento,fuente,controlesExistentes) VALUES (sp_idRiesgo,sp_idMantenimiento,sp_fuente,sp_controlesExistentes);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarRiesgosMantenimientod`(IN `sp_idRiesgo` INT, IN `sp_fuente2` TEXT, IN `sp_controlesExistente2` TEXT, IN `sp_idMantenimiento2` INT)
    NO SQL
BEGIN
INSERT INTO tblriesgosmantenimiento (idRiesgo,idMantenimientod,fuente,controlesExistentes) VALUES (sp_idRiesgo,sp_idMantenimiento2,sp_fuente2,sp_controlesExistente2);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarSolicitud`(IN `sp_idCategoria` VARCHAR(45), IN `sp_Ambiente` INT, IN `sp_Nombre1` VARCHAR(45), IN `sp_Nombre2` VARCHAR(45), IN `sp_Apellido1` VARCHAR(45), IN `sp_Apellido2` VARCHAR(45), IN `sp_Correo` VARCHAR(45), IN `sp_Descripcion` TEXT, IN `sp_Img` VARCHAR(100))
BEGIN
INSERT INTO tblsolicitud (idCategoria, idambiente, primerNombre, segundoNombre, primerApellido, segundoApellido, correo, descripcion, prioridad, img) VALUES(sp_idCategoria, sp_Ambiente, sp_Nombre1, sp_Nombre2, sp_Apellido1, sp_Apellido2, sp_Correo, sp_Descripcion, 1,sp_Img);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarUsuario`(IN `sp_primerNombre` VARCHAR(45), IN `sp_segundoNombre` VARCHAR(45), IN `sp_primerApellido` VARCHAR(45), IN `sp_segundoApellido` VARCHAR(45), IN `sp_idTipoIdentificacion` INT, IN `sp_numeroIdentificacion` VARCHAR(45), IN `sp_telefono` VARCHAR(45), IN `sp_celular` VARCHAR(45), IN `sp_idMunicipio` INT, IN `sp_direccion` VARCHAR(45), IN `sp_correoElectronico` VARCHAR(45), IN `sp_idGenero` INT, IN `sp_idRol` INT, IN `sp_perfil` VARCHAR(100))
BEGIN
INSERT INTO tblusuarios (perfil,primerNombre,segundoNombre,primerApellido,segundoApellido,idTipoIdentificacion,numeroIdentificacion,telefono,celular,idMunicipio,direccion,correoElectronico,idGenero,idRol) VALUES (sp_perfil, sp_primerNombre, sp_segundoNombre, sp_primerApellido, sp_segundoApellido, sp_idTipoIdentificacion, sp_numeroIdentificacion,sp_telefono, sp_celular, sp_idMunicipio, sp_direccion, sp_correoElectronico, sp_idGenero, sp_idRol) ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TareaCategoriaSolicitudesPendientes`()
SELECT DISTINCT tblsolicitud.idCategoria FROM tblsolicitud WHERE (tblsolicitud.idestado = 1 OR tblsolicitud.idestado = 2) AND DATEDIFF(CURDATE(),tblsolicitud.fechaRegistro)>=2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TareaCategoriaSolicitudesSinEjecutar`()
    NO SQL
SELECT DISTINCT tblsolicitud.idCategoria FROM tblsolicitud WHERE tblsolicitud.idestado = 3 AND DATEDIFF(CURDATE(),tblsolicitud.fechaFinal) >= 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TareaSolicitudesPendientes`(IN `sp_idCategoria` INT)
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblsolicitud.idsolicitud, tblsolicitud.idCategoria, TRIM(CONCAT(	tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido)) as NombreCompleto, tblcategoriasequipos.Nombre, DATE_FORMAT(tblsolicitud.fechaRegistro, '%d de %M de %Y') as fechaRegistro FROM tblsolicitud JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria = tblcategoriasequipos.idCategoria) WHERE (tblsolicitud.idestado = 1 OR tblsolicitud.idestado = 2) AND DATEDIFF(CURDATE(), tblsolicitud.fechaRegistro) >= 2 AND tblsolicitud.idCategoria=sp_idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TareaSolicitudesSinEjecutar`(IN `sp_idCategoria` INT)
    NO SQL
BEGIN
SET lc_time_names = 'es_CO';
SELECT tblsolicitud.idsolicitud, tblsolicitud.idCategoria, TRIM(CONCAT(	tblsolicitud.primerNombre, ' ', tblsolicitud.segundoNombre, ' ', tblsolicitud.primerApellido, ' ', tblsolicitud.segundoApellido)) as NombreCompleto, tblcategoriasequipos.Nombre, DATE_FORMAT(tblsolicitud.fechaFinal, '%d de %M de %Y') as fechaFinal FROM tblsolicitud JOIN tblcategoriasequipos ON(tblsolicitud.idCategoria = tblcategoriasequipos.idCategoria) WHERE tblsolicitud.idestado = 3 AND DATEDIFF(CURDATE(), tblsolicitud.fechaFinal) >= 1 AND tblsolicitud.idCategoria=sp_idCategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TareaUsuariosRecibenCorreo`(IN `sp_idCategoria` INT)
BEGIN
IF sp_idCategoria = 1 THEN
SELECT tblusuarios.numeroIdentificacion, TRIM(CONCAT(tblusuarios.primerNombre, ' ', tblusuarios.segundoNombre, ' ', tblusuarios.primerApellido, ' ', tblusuarios.segundoApellido)) as NombreCompleto, tblusuarios.correoElectronico, tblusuarios.idRol FROM tblusuarios JOIN tblcuentausuario ON(tblusuarios.numeroIdentificacion = tblcuentausuario.numeroIdentificacion) JOIN tblpermisosusuario ON(tblcuentausuario.idCuentaUsuario = tblpermisosusuario.idCuentaUsuario) WHERE tblusuarios.idRol=1 AND tblpermisosusuario.idPermiso = 44;
END IF;
IF sp_idCategoria = 2 THEN
SELECT tblusuarios.numeroIdentificacion, TRIM(CONCAT(tblusuarios.primerNombre, ' ', tblusuarios.segundoNombre, ' ', tblusuarios.primerApellido, ' ', tblusuarios.segundoApellido)) as NombreCompleto, tblusuarios.correoElectronico, tblusuarios.idRol FROM tblusuarios JOIN tblcuentausuario ON(tblusuarios.numeroIdentificacion = tblcuentausuario.numeroIdentificacion) JOIN tblpermisosusuario ON(tblcuentausuario.idCuentaUsuario = tblpermisosusuario.idCuentaUsuario) WHERE tblusuarios.idRol=1 AND tblpermisosusuario.idPermiso = 45;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TareaUsuariosRecibenCorreoSinEjecutar`(IN `sp_idCategoria` INT)
    NO SQL
IF sp_idCategoria = 1 THEN

SELECT DISTINCT tblmodificacionessolicitud.idCuentaUsuario, tblusuarios.correoElectronico, tblusuarios.numeroIdentificacion FROM tblmodificacionessolicitud LEFT JOIN tblsolicitud ON (tblsolicitud.idsolicitud=tblmodificacionessolicitud.idSolicitud) LEFT JOIN tblcuentausuario ON (tblcuentausuario.idCuentaUsuario=tblmodificacionessolicitud.idCuentaUsuario) LEFT JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) LEFT JOIN tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) WHERE tblsolicitud.idestado=3 AND DATEDIFF(CURDATE(),tblsolicitud.fechaFinal)>=1 AND tblpermisosusuario.idPermiso=44;

ELSEIF sp_idCategoria = 2 THEN

SELECT DISTINCT tblmodificacionessolicitud.idCuentaUsuario, tblusuarios.correoElectronico, tblusuarios.numeroIdentificacion FROM tblmodificacionessolicitud LEFT JOIN tblsolicitud ON (tblsolicitud.idsolicitud=tblmodificacionessolicitud.idSolicitud) LEFT JOIN tblcuentausuario ON (tblcuentausuario.idCuentaUsuario=tblmodificacionessolicitud.idCuentaUsuario) LEFT JOIN tblusuarios ON(tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) LEFT JOIN tblpermisosusuario ON(tblpermisosusuario.idCuentaUsuario=tblcuentausuario.idCuentaUsuario) WHERE tblsolicitud.idestado=3 AND DATEDIFF(CURDATE(),tblsolicitud.fechaFinal)>=1 AND tblpermisosusuario.idPermiso=45;

END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TareaValidarUsuarioAsociadoSolicitud`(IN `sp_IdSolicitud` INT, IN `sp_NumeroIdentificacion` INT)
BEGIN
DECLARE idCuentaUsuario INT;
SET idCuentaUsuario = (SELECT tblcuentausuario.idCuentaUsuario FROM tblcuentausuario JOIN tblusuarios ON (tblcuentausuario.numeroIdentificacion = tblusuarios.numeroIdentificacion) WHERE tblusuarios.numeroIdentificacion = sp_NumeroIdentificacion);

SELECT tblusuarios.correoElectronico FROM tblusuarios LEFT JOIN tblcuentausuario ON (tblusuarios.numeroIdentificacion=tblcuentausuario.numeroIdentificacion) LEFT JOIN tblmodificacionessolicitud ON (tblcuentausuario.idCuentaUsuario = tblmodificacionessolicitud.idCuentaUsuario) LEFT JOIN tblsolicitud ON (tblmodificacionessolicitud.idSolicitud=tblsolicitud.idsolicitud) WHERE tblmodificacionessolicitud.idsolicitud=sp_IdSolicitud AND tblsolicitud.idestado = 3 AND tblmodificacionessolicitud.idCuentaUsuario = idCuentaUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarCantidadRegistrarDevolucionInsumo`(IN `sp_idInsumo` INT, IN `sp_cantidad` INT)
BEGIN
SELECT tblinsumos.idInsumo,tblinsumos.cantidad FROM tblinsumos WHERE sp_cantidad>tblinsumos.cantidad AND tblinsumos.idInsumo=sp_idInsumo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarCodigoEquipo`(IN `sp_codigo` VARCHAR(45), IN `sp_idEquipo` INT, IN `sp_funcion` VARCHAR(45))
    NO SQL
BEGIN
IF sp_funcion='R' THEN
SELECT tblequipos.codigo FROM tblequipos WHERE tblequipos.codigo=sp_codigo;
ELSEIF sp_funcion='M' THEN
SELECT tblequipos.codigo FROM tblequipos WHERE tblequipos.codigo=sp_codigo AND tblequipos.idEquipo !=sp_idEquipo;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarCodigoInsumo`(IN `sp_codigo` VARCHAR(45))
BEGIN
SELECT tblinsumos.codigo FROM tblinsumos WHERE tblinsumos.codigo=sp_codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarCorreo`(IN `sp_funcion` VARCHAR(5), IN `sp_correo` VARCHAR(45), IN `sp_numeroIdentificacion` INT)
BEGIN
IF sp_funcion='R' THEN
SELECT  tblusuarios.correoElectronico FROM tblusuarios WHERE tblusuarios.correoElectronico=sp_correo;
ELSEIF sp_funcion='M' THEN
SELECT  tblusuarios.correoElectronico FROM tblusuarios WHERE tblusuarios.correoElectronico=sp_correo AND tblusuarios.numeroIdentificacion !=sp_numeroIdentificacion;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarCorreoEmpresa`(IN `sp_funcion` VARCHAR(5), IN `sp_correo` VARCHAR(45), IN `sp_idEmpresa` INT)
BEGIN
IF sp_funcion='R' THEN
SELECT tblempresas.correo FROM tblempresas WHERE tblempresas.correo=sp_correo;
ELSEIF sp_funcion='M' THEN
SELECT tblempresas.correo FROM tblempresas WHERE tblempresas.correo=sp_correo AND tblempresas.idEmpresa != sp_idEmpresa;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarEncuestaRealizada`(IN `sp_idSolicitud` INT)
BEGIN
SELECT tblencuestas.idEncuesta FROM tblencuestas WHERE tblencuestas.idSolicitud = sp_idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarFichaRegistrada`(IN `sp_IdSolicitud` INT)
BEGIN
SELECT tblmantenimientos.idSolicitud,tblsolicitud.idestado FROM tblmantenimientos JOIN tblsolicitud ON(tblsolicitud.idsolicitud=tblmantenimientos.idSolicitud) WHERE tblmantenimientos.idSolicitud=sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarFichaRegistradad`(IN `sp_IdSolicitud` INT)
    NO SQL
BEGIN
SELECT tblmantenimientosotros.idSolicitud,tblsolicitud.idestado FROM tblmantenimientosotros JOIN tblsolicitud ON(tblsolicitud.idsolicitud=tblmantenimientosotros.idSolicitud) WHERE tblmantenimientosotros.idSolicitud=sp_IdSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarNIT`(IN `sp_NIT` INT)
BEGIN
SELECT tblempresas.NIT FROM tblempresas WHERE tblempresas.NIT=sp_NIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarNombreEmpresa`(IN `sp_funcion` VARCHAR(5), IN `sp_nombre` VARCHAR(45), IN `sp_idEmpresa` INT)
BEGIN
IF sp_funcion='R' THEN
SELECT tblempresas.nombre FROM tblempresas WHERE tblempresas.nombre=sp_nombre;
ELSEIF sp_funcion='M' THEN
SELECT tblempresas.nombre FROM tblempresas WHERE tblempresas.nombre=sp_nombre AND tblempresas.idEmpresa != sp_idEmpresa;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarNombreInsumo`(IN `sp_funcion` VARCHAR(5), IN `sp_nombreInsumo` VARCHAR(45), IN `sp_idInsumo` INT)
BEGIN
IF sp_funcion='R' THEN
SELECT tblinsumos.nombre FROM tblinsumos WHERE tblinsumos.nombre=sp_nombreInsumo;

ELSEIF sp_funcion='M' THEN
SELECT tblinsumos.nombre FROM tblinsumos WHERE tblinsumos.nombre=sp_nombreInsumo AND tblinsumos.idInsumo !=sp_idInsumo;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarNombreMarca`(IN `sp_funcion` VARCHAR(5), IN `sp_nombreMarca` VARCHAR(45), IN `sp_idMarca` INT)
BEGIN
IF sp_funcion='R' THEN
SELECT tblmarcas.nombre FROM tblmarcas WHERE tblmarcas.nombre=sp_nombreMarca;
ELSEIF sp_funcion='M' THEN
SELECT tblmarcas.nombre FROM tblmarcas WHERE tblmarcas.nombre=sp_nombreMarca AND tblmarcas.idMarca !=sp_idMarca;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarNombreMarcaEquipo`(IN `sp_funcion` VARCHAR(5), IN `sp_nombreMarca` VARCHAR(45), IN `sp_idMarca` INT)
    NO SQL
BEGIN
IF sp_funcion='R' THEN
SELECT tblmarcasequipos.Nombre FROM tblmarcasequipos WHERE tblmarcasequipos.Nombre=sp_nombreMarca;
ELSEIF sp_funcion='M' THEN

SELECT tblmarcasequipos.Nombre FROM tblmarcasequipos WHERE tblmarcasequipos.Nombre=sp_nombreMarca AND tblmarcasequipos.idMarca !=sp_idMarca;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarNombrePresentacion`(IN `sp_funcion` VARCHAR(5), IN `sp_nombrePresentacion` VARCHAR(45), IN `sp_idPresentacion` INT)
BEGIN

IF sp_funcion='R' THEN
SELECT tblpresentacion.nombre FROM tblpresentacion WHERE tblpresentacion.nombre=sp_nombrePresentacion;
ELSEIF sp_funcion='M' THEN
SELECT tblpresentacion.nombre FROM tblpresentacion WHERE tblpresentacion.nombre=sp_nombrePresentacion AND tblpresentacion.idPresentacion !=sp_idPresentacion;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarNombreUsuario`(IN `sp_funcion` VARCHAR(5), IN `sp_nombreUsuario` VARCHAR(45), IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
IF sp_funcion='R' THEN
SELECT tblcuentausuario.nombreUsuario FROM tblcuentausuario WHERE tblcuentausuario.nombreUsuario=sp_nombreUsuario;
ELSEIF sp_funcion='M' THEN
SELECT tblcuentausuario.nombreUsuario FROM tblcuentausuario WHERE tblcuentausuario.nombreUsuario=sp_nombreUsuario AND tblcuentausuario.numeroIdentificacion !=sp_numeroIdentificacion;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarNumeroIdentificacion`(IN `sp_numeroIdentificacion` VARCHAR(45))
BEGIN
SELECT tblusuarios.numeroIdentificacion FROM tblusuarios WHERE tblusuarios.numeroIdentificacion=sp_numeroIdentificacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarSolicitudExistente`(IN `sp_IdCategoria` INT, IN `sp_IdAmbiente` INT)
BEGIN

SELECT tblsolicitud.idsolicitud FROM tblsolicitud WHERE tblsolicitud.idCategoria = sp_IdCategoria AND tblsolicitud.idambiente = sp_IdAmbiente AND (tblsolicitud.idestado = 1 OR tblsolicitud.idestado = 2 OR tblsolicitud.idestado = 3 OR tblsolicitud.idestado = 4);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblambientes`
--

CREATE TABLE IF NOT EXISTS `tblambientes` (
  `idAmbiente` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `idPiso` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=533 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblambientes`
--

INSERT INTO `tblambientes` (`idAmbiente`, `Nombre`, `idPiso`) VALUES
(1, 'Escalas principales', 1),
(2, 'Ascensor izquierdo', 1),
(3, 'Cuarto2', 3),
(4, 'Ascensor derecho', 1),
(5, 'Escalas secundarias', 2),
(6, 'Bodega de artes gráficas', 3),
(7, 'Baño mujeres', 3),
(8, 'Baño hombres', 3),
(9, 'Cuarto técnico', 3),
(10, 'Ambiente 2-4', 3),
(11, 'Ambiente 2-3', 3),
(12, 'Bienestar al aprendiz', 3),
(13, 'Ambiente 2-2', 3),
(14, 'Ambiente 2-2 transporte', 3),
(15, 'Ambiente 2-1', 3),
(16, 'Ambiente 2-1 transporte', 3),
(17, 'Cuarto técnico', 3),
(18, 'Baño hombres auditorio', 3),
(19, 'Cuarto', 3),
(20, 'Bodega', 3),
(21, 'Pasillo cocina', 3),
(22, 'Cocina', 3),
(23, 'Baño mujeres cocina', 3),
(24, 'Escalas auditorio', 4),
(25, 'Auditorio', 3),
(26, 'Pasillo', 3),
(27, 'Cocina', 2),
(28, 'Escalas cocina', 2),
(29, 'Cuarto almacenamiento cocina', 2),
(30, 'Pasillo auditorio', 4),
(31, 'Pasillo cocina', 4),
(32, 'Cocineta', 6),
(33, 'Baño de mujeres cocina', 2),
(34, 'Baño de hombres cocina', 2),
(35, 'Path', 2),
(36, 'Cuarto útil', 2),
(37, 'Baño auditorio', 2),
(38, 'Camerino auditorio', 2),
(39, 'Auditorio', 2),
(40, 'Cuarto técnico', 6),
(41, 'Oficina sindesena', 2),
(42, 'Oficina sindesena', 2),
(43, 'Baño mujeres', 2),
(44, 'Baño hombres', 2),
(45, 'Cuarto útil', 2),
(47, 'Bienestar al aprendiz', 2),
(48, 'Biblioteca', 2),
(49, 'Pasillo', 2),
(50, 'Administración educativa', 4),
(51, 'Cuarto rack', 6),
(52, 'Cuarto útil', 4),
(53, 'Baño de hombres', 4),
(54, 'Baño de mujeres', 4),
(55, 'Ambiente 3-1', 4),
(56, 'Fábrica de Software', 4),
(57, 'Cuarto técnico', 4),
(58, 'Cuarto técnico', 4),
(59, 'Oficina contratación', 4),
(60, 'Contratación', 4),
(61, 'Archivo', 4),
(62, 'Oficina auditorio', 4),
(63, 'Cocineta salón de música', 4),
(64, 'Cocineta', 4),
(65, 'Cuarto', 4),
(66, 'Oficina salón de música', 4),
(67, 'Almacenamiento salón de música', 4),
(68, 'Baño de hombres salón de música\n', 4),
(69, 'Baño de mujeres salón de música', 4),
(70, 'Ambiente 4-1', 5),
(71, 'Pasillo', 4),
(72, 'Pasillo de salón de música', 4),
(73, ' salón de música', 4),
(74, 'Ambiente 4-', 5),
(75, 'Ambiente 4-', 5),
(76, 'Bodega', 5),
(77, 'Cuarto técnico', 5),
(78, 'Baño de hombres', 5),
(79, 'Cuarto', 5),
(80, '', 5),
(81, 'Contrato de aprendizaje', 5),
(82, 'Ambiente 4-', 5),
(83, 'Archivo documental', 5),
(84, 'Cuarto técnico', 5),
(85, 'Baño de mujeres', 5),
(86, 'Bodega', 5),
(87, 'Bodega', 5),
(88, 'Baño de mujeres', 5),
(89, 'Cocineta', 5),
(90, 'Ambiente 4-', 5),
(91, 'Ambiente 4-', 5),
(92, 'Ambiente 4-', 5),
(93, 'Ambiente 4-', 5),
(94, 'Ambiente 4-', 5),
(95, 'Pasillo', 5),
(96, 'Terraza derecha', 5),
(97, 'Terraza izquierda', 5),
(98, 'Baño de mujeres', 6),
(99, 'Ambiente 5-', 6),
(100, 'Baño de hombres', 6),
(101, 'Ambiente 5-', 6),
(102, 'Ambiente 5-', 6),
(103, 'Ambiente 5-', 6),
(104, 'Ambiente 5-', 6),
(105, 'Ambiente 5-', 6),
(106, 'Baño de mujeres', 6),
(107, 'Baño de hombres', 6),
(108, 'Cuarto', 6),
(109, 'Ambiente 5-', 6),
(110, 'Ambiente 5-', 6),
(111, 'Ambiente 5-', 6),
(112, 'Ambiente 6-2', 7),
(113, 'Ambiente 6-1', 7),
(114, 'Baño de hombres', 7),
(115, 'Oficina de etapa práctica', 7),
(116, 'Baño de mujeres', 7),
(117, 'Cocineta', 7),
(118, 'Ambiente 6-', 7),
(119, 'Oficina de sistemas', 7),
(120, 'Ambiente 6-', 7),
(121, 'Baño de mujeres', 7),
(122, 'Ambiente 6-', 7),
(123, 'Ambiente 6-', 7),
(124, 'Mantenimiento de cómputo', 7),
(125, 'Baño de hombres', 7),
(126, 'Cuarto', 7),
(127, 'Ambiente 6-', 7),
(128, 'Pasillo', 7),
(129, 'Ambiente 7-', 8),
(130, 'Ambiente 7-', 8),
(131, 'Bodega', 8),
(132, 'Bodega', 8),
(133, 'Baño de mujeres', 8),
(134, 'Cocineta', 8),
(135, 'Cuarto técnico', 8),
(136, 'Ambiente 7-', 8),
(137, 'Sala de instructores', 8),
(138, 'Ambiente 7-', 8),
(139, 'Ambiente 7-', 8),
(140, 'Ambiente 7-', 8),
(141, 'Bodega', 8),
(142, 'Almacen', 8),
(143, 'Baño de hombres', 8),
(144, 'Terraza derecha', 8),
(145, 'Terraza izquierda', 8),
(146, 'Pasillo', 8),
(147, 'Ambiente 8-', 9),
(148, 'Sala instructores', 9),
(149, 'Cuarto técnico', 9),
(150, 'Ambiente 8-', 9),
(151, 'Bodega', 9),
(152, 'Bodega', 9),
(153, 'Ambiente 8-', 9),
(154, 'Baño de mujeres', 9),
(155, 'Baño de hombres', 9),
(156, 'Cocineta', 9),
(157, 'Bodega', 9),
(158, 'Bodega', 9),
(159, 'Ambiente 8-', 9),
(160, 'Ambiente 8-', 9),
(161, 'Ambiente 8-', 9),
(162, 'Pasillo', 9),
(163, 'Cuarto técnico', 10),
(164, 'Cuarto técnico', 10),
(165, 'Baño de mujeres', 10),
(166, 'Cuarto técnico', 10),
(167, 'Cuarto técnico', 10),
(168, 'Subdirección', 10),
(169, 'Sala de juntas', 10),
(170, 'Coordinación misional', 10),
(171, 'Oficina de contratación', 10),
(172, 'Oficina', 10),
(173, 'Cuarto técnico', 10),
(174, 'Cuarto técnico', 10),
(175, 'Baño de hombres', 10),
(176, 'Cocineta', 10),
(177, 'Pasillo', 10),
(178, 'Oficina', 10),
(179, 'Ambiente 10-', 11),
(180, 'Ambiente 10-', 11),
(181, 'Deposito', 11),
(182, 'Cuarto electrico', 11),
(183, 'Cuarto técnico', 11),
(184, 'Ambiente 10-', 11),
(185, 'Ambiente 10-', 11),
(186, 'Ambiente 10-', 11),
(187, 'Baño de mujeres', 11),
(188, 'Cuarto de aire acondicionado', 11),
(189, 'Cuarto electrico', 11),
(190, 'Ambiente 10-', 11),
(191, 'Ambiente 10-', 11),
(192, 'Cocineta', 11),
(193, 'Baño de hombres', 11),
(194, 'Bodega', 11),
(195, 'Pasillo', 11),
(196, 'Pasillo', 6),
(197, 'Escenario auditorio', 3),
(198, 'Segundo piso', 13),
(199, 'Camerinos de hombres', 12),
(200, 'Baños de hombres', 12),
(201, 'Camerinos aprendices hombres', 12),
(202, 'Baños aprendices hombres', 12),
(203, 'Camerinos mujeres', 12),
(204, 'Baños empleados hombres', 12),
(205, 'Baños', 12),
(206, 'Baños', 12),
(207, 'Camerinos mujeres', 12),
(208, 'Baños mujeres', 12),
(209, 'Sauna', 12),
(210, 'Turco', 12),
(211, 'Pasillo', 12),
(212, 'Estacionamiento', 14),
(213, 'Cuarto oscuro', 14),
(214, 'Bodega papel', 14),
(215, 'Equipos publicaciones', 14),
(216, 'Auxiliar ', 14),
(217, 'Fotocopiadora', 14),
(218, 'Monitoreo', 14),
(219, 'Mantenimientos aires', 14),
(220, 'Oficina vigilancia', 14),
(221, 'Impresion de medios', 14),
(222, 'Vestier mujeres', 14),
(223, 'Vestier hombres', 14),
(224, 'Bodega aseo', 14),
(225, 'Bodega comercializadora', 14),
(226, 'Bodega de investigación y desarrollo', 14),
(227, 'Bodega mantenimiento edificios', 14),
(228, 'Bodega servicios ', 14),
(229, 'Aula taller artes gráficas', 14),
(230, 'Vigilancia', 14),
(231, 'Bodega de subdirección agropecuaria', 14),
(232, 'Archivo central', 14),
(233, 'Archivo central', 14),
(234, 'Archivo central', 14),
(235, 'Zona de descarga', 14),
(236, 'Bodega almacen central', 14),
(237, 'Tanque de agua', 14),
(238, 'Shut basuras', 14),
(239, 'Cuarto bombas', 14),
(240, 'Subestación electrica', 14),
(241, 'Bodega de mantenimiento de edificios', 14),
(242, 'Ascensor de carga', 14),
(243, 'Buitron', 14),
(244, 'Bodega almacén general', 14),
(245, 'Bodega comunicaciones', 14),
(246, 'Baño de hombres', 14),
(247, 'Baño de mujeres', 14),
(248, 'Baño de hombres', 14),
(249, 'Baño de mujeres', 14),
(250, 'Vestier de hombres', 14),
(251, 'Vestier de mujeres', 14),
(252, 'Zona de descarga', 14),
(253, 'Almacén general ', 14),
(254, 'Deposito varios', 14),
(255, 'Cuarto de aire acondicionado', 14),
(256, 'Cuarto de aseo ', 14),
(257, 'Foro de orquesta', 14),
(258, 'Salón de espejos', 14),
(259, 'Deposito de deportes', 14),
(260, 'Instructor de deportes', 14),
(261, 'Ambiente Comercio 101', 15),
(262, 'Unidad emprendimiento', 15),
(263, 'Conectividad', 15),
(264, 'Aula de Bilinguismo 1', 15),
(265, 'Aula de Bilinguismo 2', 15),
(266, 'Aula de Bilinguismo 3', 15),
(267, 'Grupo mixto', 15),
(268, 'Servicio medico', 15),
(269, 'Unidad correspondencia', 15),
(270, 'Archivo central', 15),
(271, 'Baño de hombres', 15),
(272, 'Cuarto de aseo', 15),
(273, 'Salón de anexo2', 15),
(274, 'Salón de anexo1', 15),
(275, 'Cuarto de aire acondicionado', 15),
(276, 'Escenario', 15),
(277, 'Deposito del teatro', 15),
(278, 'Archivo de servicios', 15),
(279, 'Archivo de comercio', 15),
(280, 'Cuarto', 15),
(281, 'Cuarto', 15),
(282, 'Foro de orquesta', 15),
(283, 'Servicios', 15),
(284, 'Gestión de centros', 15),
(285, 'Comercio', 15),
(286, 'Archivo de salud', 15),
(287, 'Cuarto', 15),
(288, 'Cuarto', 15),
(289, 'Cuarto', 15),
(290, 'Salud', 15),
(291, 'Archivo rodante', 15),
(292, 'Microfilmación', 15),
(293, 'Archivo auxiliar', 15),
(294, 'Archivo quejas y reclamos', 15),
(295, 'Administración de documentos', 15),
(296, 'Baño', 15),
(297, 'Cuarto de archivo', 15),
(298, 'Archivo de contratación', 15),
(299, 'Recursos humanos', 15),
(300, 'Oficina', 15),
(301, 'Oficina', 15),
(302, 'Oficina', 15),
(303, 'Oficina', 15),
(304, 'Oficina', 15),
(305, 'Archivo beneficiario', 15),
(306, 'Oficina', 15),
(307, 'Oficina', 15),
(308, 'Secretaria', 15),
(309, 'Oficina', 15),
(310, 'Sala de espera', 15),
(311, 'Atención beneficiarios', 15),
(312, 'Baño', 15),
(313, 'Cocineta', 15),
(314, 'Medica pediatra', 15),
(315, 'Medico general', 15),
(316, 'Odontologia', 15),
(317, 'Cirugias', 15),
(318, 'RX', 15),
(319, 'Odontologia', 15),
(320, 'Enfermeria', 15),
(321, 'Ambiente almacena', 17),
(322, 'Ambiente Comercio 301', 17),
(323, 'Ambiente Comercio 302', 17),
(324, 'Ambiente Comercio 303', 17),
(325, 'Ambiente Comercio 304', 17),
(326, 'Ambiente Comercio 305', 17),
(327, 'Ambiente Comercio 306', 17),
(328, 'Ambiente Comercio 310', 17),
(329, 'Ambiente Comercio 311', 17),
(330, 'Ambiente Comercio 312', 17),
(331, 'Ambiente Comercio 313', 17),
(332, 'Ambiente Comercio 314', 17),
(333, 'Ambiente Comercio 315', 17),
(334, 'Ambiente Comercio 316', 17),
(335, 'Ambiente Comercio 317', 17),
(336, 'Ambiente Comercio 318', 17),
(337, 'Laboratorio financiero 1', 17),
(338, 'Laboratorio contable 2', 17),
(339, 'Oficina sistemas', 17),
(340, 'Camara Gessell', 17),
(341, 'Hall piso 3° Ala Norte', 17),
(342, 'Hall piso 3° Ala Sur', 17),
(343, 'Gestion documental comercio', 17),
(344, 'Sala de reuniones', 17),
(345, 'Sala de computo', 17),
(346, 'Cuarto de aire acondicionado', 17),
(347, 'Oficina coordinador', 17),
(348, 'Oficina coordinador', 17),
(349, 'Oficina coordinador', 17),
(350, 'Oficina coordinador', 17),
(351, 'Baño de hombres', 17),
(352, 'Baño de mujeres', 17),
(353, 'Cocineta', 17),
(354, 'Ascensor de carga', 17),
(355, 'Shut de basuras', 17),
(356, 'Pasillo', 17),
(357, 'Oficina', 17),
(358, 'Oficina', 17),
(359, 'Oficina', 17),
(360, 'Escaleras', 17),
(361, 'Cuarto', 17),
(362, 'Cuarto de aseo', 17),
(363, 'Escaleras', 17),
(364, 'Pasillo', 17),
(365, 'Pasillo2', 17),
(366, 'Ambiente Comercio 401', 18),
(367, 'Ambiente Comercio 402', 18),
(368, 'Ambiente Comercio 403', 18),
(369, 'Ambiente Comercio 404', 18),
(370, 'Ambiente Comercio 405', 18),
(371, 'Ambiente Comercio 406', 18),
(372, 'Pasillo 1', 18),
(373, 'Ambiente Comercio 407', 18),
(374, 'Ambiente Comercio 408', 18),
(375, 'Ambiente Comercio 409', 18),
(376, 'Ambiente Comercio 410', 18),
(377, 'Escaleras 1', 18),
(378, 'Escaleras 2', 18),
(379, 'Baño de mujeres 1', 18),
(380, 'Pasillo gestión documental', 18),
(381, 'Baño de hombres 1', 18),
(382, 'Baño de hombres 2', 18),
(383, 'Baño de mujeres 2', 18),
(384, 'Baño de mujeres 3', 18),
(385, 'Bienestar al aprendiz comercio', 18),
(386, 'Apoyo logistico comercio', 18),
(387, 'Carnetizacion comercio', 18),
(388, 'Cuarto tecnico IDFS. comercio', 18),
(389, 'Ambiente Comercio 411', 18),
(390, 'Ambiente Comercio 412', 18),
(391, 'Ambiente Comercio 413', 18),
(392, 'Ambiente Comercio 414', 18),
(393, 'Ambiente Comercio 415', 18),
(394, 'Ambiente Comercio 416', 18),
(395, 'Ambiente Comercio 417', 18),
(396, 'Ambiente Comercio 418', 18),
(397, 'Pasillo 2', 18),
(398, 'Tesorería', 15),
(399, 'Oficina', 15),
(400, 'Oficina', 15),
(401, 'Oficina', 15),
(402, 'Archivo de presupuesto', 15),
(403, 'Contabilidad', 15),
(404, 'Archivo de contabilidad', 15),
(405, 'Baño', 15),
(406, 'Baño de mujeres', 15),
(407, 'Baño de mujeres', 15),
(408, 'Baño de hombres', 15),
(409, 'Baño de hombres', 15),
(410, 'Archivo financiero', 15),
(411, 'cocineta', 15),
(412, 'Promoción y mercadeo', 15),
(413, 'Planta telefonica', 15),
(414, 'Escaleras', 15),
(415, 'Escaleras', 15),
(416, 'Oficina', 15),
(417, 'Pasillo', 15),
(418, 'Nose', 15),
(419, 'Nose', 15),
(420, 'Escalas', 15),
(421, 'Escalas', 15),
(422, 'Escalas', 15),
(423, 'Ascensor izquierdo', 14),
(424, 'Ascensor derecho', 14),
(425, 'Cocineta', 15),
(426, 'Baño de mujeres', 17),
(427, 'Baño de hombres', 17),
(428, 'Cocineta', 17),
(430, 'Aula', 17),
(431, 'Aula', 17),
(432, 'Baño de hombres 3', 18),
(433, 'Cuarto de aseo', 18),
(434, 'Cocineta 1', 18),
(436, 'Hall piso 4° Ala Norte', 18),
(437, 'Hall piso 4° Ala Sur', 18),
(438, 'Adm educativa comercio', 18),
(439, 'Contratacion comercio', 18),
(440, 'Cocineta 2', 18),
(441, 'Subdireccion centro comercio', 19),
(442, 'Sala instructores comercio', 19),
(443, 'Relaciones exteriores comercio', 19),
(444, 'Ambiente comercio 501', 19),
(445, 'Ambiente comercio 502', 19),
(446, 'Ambiente comercio 503', 19),
(447, 'Ambiente comercio 504', 19),
(448, 'Ambiente comercio 505', 19),
(449, 'Ambiente comercio 506', 19),
(450, 'Ambiente comercio 507', 19),
(451, 'Ambiente comercio 508', 19),
(452, 'Etapa productiva comercio', 19),
(453, 'Hall piso 5° Ala Norte', 19),
(454, 'Baño mujeres', 19),
(455, 'cocina', 19),
(456, 'Ambiente 601', 20),
(457, 'Ambiente 602', 20),
(458, 'Ambiente 603', 20),
(459, 'Ambiente 604', 20),
(460, 'Ambiente 605', 20),
(461, 'Microbiologia', 20),
(462, 'Laboratorio ciencias basicas', 20),
(463, 'Cocina', 20),
(464, 'Baño mujeres', 20),
(465, 'Ambiente 701', 21),
(466, 'Ambiente 702', 21),
(467, 'Ambiente 703', 21),
(468, 'Ambiente 704', 21),
(469, 'Ambiente 705', 21),
(470, 'Ambiente 706', 21),
(471, 'Ambiente 707', 21),
(472, 'Ambiente 708A', 21),
(473, 'Ambiente 708B', 21),
(474, 'Senova', 21),
(475, 'Cocina', 21),
(476, 'Baño de hombres', 21),
(477, 'Ambiente 801', 22),
(478, 'Ambiente 802', 22),
(479, 'Ambiente 803', 22),
(480, 'Ambiente 804', 22),
(481, 'Ambiente 805', 22),
(482, 'Ambiente 806', 22),
(483, 'Ambiente 807', 22),
(484, 'Ambiente 808', 22),
(485, 'Ambiente 809', 22),
(486, 'Laboratorio Seguridad y Salud en el Trabajo', 22),
(487, 'Bodega 1-2', 22),
(488, 'Cocina', 22),
(489, 'Baño de mujeres', 22),
(490, 'Sala de instructores de salud', 23),
(491, 'Centro de servicios en salud', 23),
(492, 'Cocina', 23),
(493, 'Baño hombres', 23),
(494, 'Formación profesional', 24),
(495, 'Ambiente 10-1', 24),
(496, 'Juridico', 24),
(497, 'Comunicacion', 24),
(498, 'Cocina', 24),
(499, 'Baño mujeres', 24),
(500, 'Direccion', 25),
(501, 'Relaciones corporativas', 25),
(502, 'Cocina', 25),
(503, 'Baño hombres', 25),
(504, 'Agro sena', 26),
(505, 'Apsa', 26),
(506, 'Baño', 26),
(507, 'Bodega', 26),
(508, 'Bodega', 27),
(509, 'Centro simulacion', 16),
(510, 'Ips odontologia', 16),
(511, 'Area administrativa', 16),
(512, 'Enfermeria', 16),
(513, 'Alistamiento', 16),
(514, 'Drogueria', 16),
(515, 'Bienestar al aprendiz de salud CASO', 16),
(516, 'Imagenes diagnosticas', 16),
(517, 'Laboratorio magistral y dosis unitaria', 16),
(518, 'Recepción de material', 16),
(519, 'Bulevar', 16),
(520, 'Contratacion', 16),
(521, 'Seguridad en el trabajo', 16),
(522, 'Nomina', 16),
(523, 'Bienestar social', 16),
(524, 'Restaurante', 16),
(525, 'Baño mujeres', 16),
(526, 'Cocina', 16),
(527, 'Baño mujeres y hombres', 16),
(528, 'Papeleria', 16),
(529, 'Cafeteria', 16),
(530, 'En ventiadero', 16),
(531, 'Empleo', 16),
(532, 'Sindesena', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcategoriasequipos`
--

CREATE TABLE IF NOT EXISTS `tblcategoriasequipos` (
  `idCategoria` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblcategoriasequipos`
--

INSERT INTO `tblcategoriasequipos` (`idCategoria`, `Nombre`) VALUES
(1, 'Aire Acondicionado'),
(2, 'Luminarias'),
(3, 'Otros( muebles, vidrios, ventanas, puertas, etc)'),
(4, 'Electricidad'),
(5, 'Ascensores'),
(6, 'Todas las categorias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcomplejos`
--

CREATE TABLE IF NOT EXISTS `tblcomplejos` (
  `idComplejos` int(100) NOT NULL,
  `nombreComplejos` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblcomplejos`
--

INSERT INTO `tblcomplejos` (`idComplejos`, `nombreComplejos`) VALUES
(1, 'Complejo Central'),
(2, 'Complejo Norte'),
(3, 'Complejo Sur');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcomponentesitems`
--

CREATE TABLE IF NOT EXISTS `tblcomponentesitems` (
  `idComponente` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `idCategoria` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblcomponentesitems`
--

INSERT INTO `tblcomponentesitems` (`idComponente`, `Nombre`, `idCategoria`) VALUES
(1, 'Evaporador', 1),
(2, 'Condensador', 1),
(3, 'Otros', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcuentausuario`
--

CREATE TABLE IF NOT EXISTS `tblcuentausuario` (
  `idCuentaUsuario` int(11) NOT NULL,
  `nombreUsuario` varchar(45) NOT NULL,
  `contrasenia` varchar(45) NOT NULL,
  `numeroIdentificacion` varchar(45) NOT NULL,
  `estado` tinyint(4) NOT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultimoIngreso` varchar(30) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblcuentausuario`
--

INSERT INTO `tblcuentausuario` (`idCuentaUsuario`, `nombreUsuario`, `contrasenia`, `numeroIdentificacion`, `estado`, `fechaRegistro`, `ultimoIngreso`) VALUES
(18, 'Administrador', 'nijGBlC8V71yz+tVC4dMt2TdCBziDD00doJy9dX0Zyk=', '54454465', 1, '2017-02-07 18:18:58', '2017-08-24 10:06:26'),
(23, 'luis', 'vjk3Yl+N+3YL6wEYCrtNb91LUYoT99XxyoI9No2R/sw=', '15256627', 1, '2017-03-08 18:04:58', '2017-03-10 02:51:16'),
(24, 'paola', 'RPXayXZ3pjRW7ASGCx7aSCFGW87JWOFGERsNVSxUH4w=', '43630934', 0, '2017-03-08 18:11:12', '2017-03-14 06:53:02'),
(25, 'andresgallo', 'lAABaYzttnPZFmVsJMJ2XRoSut9sP347AljLwYj/HCs=', '1020431601', 0, '2017-03-08 18:17:10', '2017-03-08 08:19:35'),
(26, 'cmejia', '3MlzLeJcrs+UGMkfOmXLROXG3hsxKbmRfXJ2KYPtEJY=', '70118830', 1, '2017-03-08 18:20:19', '2017-03-22 10:07:41'),
(27, 'vcardona', 'kmOU1i0MMAwrdqPFVYp1rY3gIlkjF1JENCiWkgCad3o=', '71665432', 0, '2017-03-08 18:25:38', '2017-03-08 08:39:43'),
(28, 'jdbedoya', 'jlpvXFMgCIhQTCs+DYYj5VAXzBWQcZC1ZzSKgM5MLPI=', '98589653', 1, '2017-03-08 18:29:01', '2017-03-27 08:44:01'),
(29, 'pablovalencia', '2MKZduEXo7soMFA51NOGdV/4+xvtneL9Ke/YdYA3Fkk=', '1128478329', 1, '2017-03-08 18:32:44', '2017-03-28 07:45:59'),
(30, 'Javier Mallama', 'lCMatunBpMnDi9g8y8geFrPeiHix6CgHlT5eGcBvux8=', '12991856', 1, '2017-03-08 18:37:53', '2017-03-23 08:51:29'),
(31, 'dmejiam', 'MrLEYygc+c1NwvHaqs51cIl+eHU9trjsBapROg+cXuQ=', '1037610311', 1, '2017-03-08 18:39:33', '2017-03-27 10:15:38'),
(32, 'amonsalve', '4Y+vhhZucveZKxmpdOxqhXjwfEX7YOw754A61Yi6YU4=', '1128472995', 1, '2017-03-08 18:42:46', '2017-03-22 09:31:22'),
(33, 'fernando', 'jHSEIZ0Y4ObvE0NYbO1TvSiQx9h4y2HQg6yC9njoR0g=', '71591822', 1, '2017-03-08 18:46:34', NULL),
(34, 'etorresn', 'RXJ8HRUFBdL3x5T9tqSzRmtIPBX7j9rC4kwKX3vuym0=', '88252034', 1, '2017-03-08 20:33:59', '2017-04-20 13:33:00'),
(40, 'chtovar', 'GYdcnw6xQgfFfl7SCtQ7rDqx76sxLczffj3gq+XEe54=', '102355478', 1, '2017-03-09 13:50:06', '2017-03-28 02:04:58'),
(42, 'amayag', 'xpQAAWmM7bZz2RZlbCTCdshvVxatMwsHAbrAiAaJXSo=', '1039447264', 1, '2017-03-09 15:43:19', '2017-03-23 05:46:01'),
(43, 'amsierra', 'RAx8+NUwWT+nqjsxowXKFtcC1F+e3CheZeEeg/vNrAU=', '43042254', 1, '2017-03-10 12:40:30', '2017-03-23 05:39:39'),
(44, 'palm', '679797HyzlfsAjxHRTQqzYCcNZaKYAKZZXCD4CyG8uc=', '436309340', 1, '2017-03-14 16:54:08', '2017-03-28 02:19:37'),
(45, 'ivrojas', 'mDCwfOkUTYJ8T+41OGk/2cU2Lps38kbSrMNafKff/1Y=', '71761148', 1, '2017-03-17 18:56:29', '2017-03-30 10:12:23'),
(46, 'cardona', 'Nd3e7tTzVP4Td31g+JAi+sVaOprzVKcu6rX5LtCqZPs=', '716654322', 1, '2017-03-21 20:04:29', '2017-08-14 10:09:55'),
(47, 'juanesteban', '3idqM4aj9zC6qUQ5waBYeJe7pOMQhwSZq18DZmgIipU=', '1216726372', 1, '2017-08-18 20:25:52', '2017-08-23 07:49:56'),
(48, 'prueba', 'oggYJM3G9EQWqVP6pHcb0bftcIvARSdrEOXkUthDhSg=', '1232123', 1, '2017-08-23 17:12:38', '2017-08-23 12:12:51'),
(49, 'juan', '6ARnYxyk2s8yh6VC85JQYrBDzoA5EqH3KggVRCCQxaQ=', '301645', 1, '2017-08-24 13:25:23', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldepartamentos`
--

CREATE TABLE IF NOT EXISTS `tbldepartamentos` (
  `idDepartamento` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbldepartamentos`
--

INSERT INTO `tbldepartamentos` (`idDepartamento`, `nombre`) VALUES
(1, 'Amazonas'),
(2, 'Antioquia'),
(3, 'Arauca'),
(4, 'Atlántico'),
(5, 'Bolívar'),
(6, 'Boyacá'),
(7, 'Caldas'),
(8, 'Caquetá'),
(9, 'Casanare'),
(10, 'Cauca'),
(11, 'Cesar'),
(12, 'Chocó'),
(13, 'Córdoba'),
(14, 'Cundinamarca'),
(15, 'Guainia'),
(16, 'Guaviare'),
(17, 'Huila'),
(18, 'La Guajira'),
(19, 'Magdalena'),
(20, 'Meta'),
(21, 'Nariño'),
(22, 'Norte de Santander'),
(23, 'Putumayo'),
(24, 'Quindo'),
(25, 'Risaralda'),
(26, 'San Andrés y Providencia'),
(27, 'Santander'),
(28, 'Sucre'),
(29, 'Tolima'),
(30, 'Valle del Cauca'),
(31, 'Vaupés'),
(32, 'Vichada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldetallesencuestas`
--

CREATE TABLE IF NOT EXISTS `tbldetallesencuestas` (
  `idDetalleEncuesta` int(11) NOT NULL,
  `idEncuesta` int(11) NOT NULL,
  `idPregunta` int(11) NOT NULL,
  `Respuesta` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbldetallesencuestas`
--

INSERT INTO `tbldetallesencuestas` (`idDetalleEncuesta`, `idEncuesta`, `idPregunta`, `Respuesta`) VALUES
(1, 1, 1, '5'),
(2, 1, 2, '5'),
(3, 1, 3, 'Si'),
(4, 1, 4, 'Si'),
(5, 1, 5, '5'),
(6, 1, 6, 'aplicativo amigable y facilita la atención de'),
(7, 2, 1, '5'),
(8, 2, 2, '5'),
(9, 2, 3, 'Si'),
(10, 2, 4, 'Si'),
(11, 2, 5, '4'),
(12, 2, 6, 'Se resolvió con éxito '),
(13, 3, 1, '4'),
(14, 3, 2, '3'),
(15, 3, 3, 'Si'),
(16, 3, 4, 'No'),
(17, 3, 5, '5'),
(18, 3, 6, 'Buenas tardes. El procesos debe ser mas ágil,'),
(19, 4, 1, '5'),
(20, 4, 2, '5'),
(21, 4, 3, 'Si'),
(22, 4, 4, 'Si'),
(23, 4, 5, '5'),
(24, 4, 6, 'Servicio realizado el mismo dia'),
(25, 5, 1, '4'),
(26, 5, 2, '5'),
(27, 5, 3, 'Si'),
(28, 5, 4, 'Si'),
(29, 5, 5, '5'),
(30, 5, 6, 'Se solicito el servicio el martes y se atendi'),
(31, 6, 1, '5'),
(32, 6, 2, '5'),
(33, 6, 3, 'Si'),
(34, 6, 4, 'Si'),
(35, 6, 5, '5'),
(36, 6, 6, 'eficaz '),
(37, 7, 1, '5'),
(38, 7, 2, '5'),
(39, 7, 3, 'Si'),
(40, 7, 4, 'Si'),
(41, 7, 5, '5'),
(42, 7, 6, 'eficaz'),
(43, 8, 1, '5'),
(44, 8, 2, '5'),
(45, 8, 3, 'Si'),
(46, 8, 4, 'Si'),
(47, 8, 5, '5'),
(48, 8, 6, 'eficaz '),
(49, 9, 1, '5'),
(50, 9, 2, '5'),
(51, 9, 3, 'Si'),
(52, 9, 4, 'Si'),
(53, 9, 5, '5'),
(54, 9, 6, 'eficaz '),
(55, 10, 1, '5'),
(56, 10, 2, '5'),
(57, 10, 3, 'Si'),
(58, 10, 4, 'Si'),
(59, 10, 5, '5'),
(60, 10, 6, 'eficaz'),
(61, 11, 1, '5'),
(62, 11, 2, '5'),
(63, 11, 3, 'Si'),
(64, 11, 4, 'Si'),
(65, 11, 5, '5'),
(66, 11, 6, 'ninguna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldevoluciones`
--

CREATE TABLE IF NOT EXISTS `tbldevoluciones` (
  `idDevolucion` int(11) NOT NULL,
  `idInsumo` int(11) NOT NULL,
  `fechaDevolucion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad` int(11) NOT NULL,
  `idTipoDevolucion` int(11) NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldiagnosticositems`
--

CREATE TABLE IF NOT EXISTS `tbldiagnosticositems` (
  `idDiagnostico` int(11) NOT NULL,
  `idMantenimiento` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `Imagen` varchar(100) NOT NULL,
  `Descripcion` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbldiagnosticositems`
--

INSERT INTO `tbldiagnosticositems` (`idDiagnostico`, `idMantenimiento`, `idItem`, `Imagen`, `Descripcion`) VALUES
(1, 1, 9, 'brawm.jpg', 'Esto es lo que se cambio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblempresas`
--

CREATE TABLE IF NOT EXISTS `tblempresas` (
  `idEmpresa` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `NIT` varchar(45) NOT NULL,
  `idMunicipio` int(11) DEFAULT NULL,
  `direccion` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `idTipoEmpresa` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblempresas`
--

INSERT INTO `tblempresas` (`idEmpresa`, `nombre`, `NIT`, `idMunicipio`, `direccion`, `correo`, `telefono`, `idTipoEmpresa`, `estado`) VALUES
(27, 'Sena', '1452368-9', 1, 'carrera 89# 55A- 33', 'sena@sena.edu.co', '4478569', 1, 1),
(28, 'Microsoft', '12345641-9', 3, 'calle 89 # 55A Sur', 'Microsoft@Microsoft.com', '4454445', 1, 0),
(29, 'Facebook', '789456321-1', 166, 'carrera 89#55-52', 'facebook@facebook.com', '5569852', 2, 1),
(30, 'Youtube', '55698512-01', 70, 'carrera 89#55A Sur', 'youtube@youtube.com', '5565544', 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblencuestas`
--

CREATE TABLE IF NOT EXISTS `tblencuestas` (
  `idEncuesta` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblencuestas`
--

INSERT INTO `tblencuestas` (`idEncuesta`, `idSolicitud`, `Fecha`) VALUES
(1, 84, '2017-03-08 19:21:07'),
(2, 86, '2017-03-08 19:39:43'),
(3, 88, '2017-03-14 16:41:04'),
(4, 104, '2017-03-15 21:39:09'),
(5, 128, '2017-03-23 11:13:24'),
(6, 115, '2017-03-23 14:49:59'),
(7, 120, '2017-03-23 14:50:21'),
(8, 122, '2017-03-23 14:50:41'),
(9, 126, '2017-03-23 14:51:06'),
(10, 123, '2017-03-23 14:51:32'),
(11, 203, '2017-07-28 16:10:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblentradas`
--

CREATE TABLE IF NOT EXISTS `tblentradas` (
  `idEntrada` int(11) NOT NULL,
  `idInsumo` int(11) NOT NULL,
  `fechaEntrada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblequipos`
--

CREATE TABLE IF NOT EXISTS `tblequipos` (
  `idEquipo` int(11) NOT NULL,
  `Codigo` varchar(45) NOT NULL,
  `idMarca` int(11) NOT NULL,
  `Modelo` varchar(45) NOT NULL,
  `idTipoEquipo` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  `Serie` varchar(45) NOT NULL,
  `Psv` int(11) NOT NULL,
  `FechaFabricacion` varchar(45) NOT NULL,
  `FechaInstalacion` varchar(45) NOT NULL,
  `cuentadante` varchar(45) NOT NULL,
  `dependencia` varchar(45) NOT NULL,
  `placaInventario` varchar(45) NOT NULL,
  `idAmbiente` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblequipos`
--

INSERT INTO `tblequipos` (`idEquipo`, `Codigo`, `idMarca`, `Modelo`, `idTipoEquipo`, `idCategoria`, `Serie`, `Psv`, `FechaFabricacion`, `FechaInstalacion`, `cuentadante`, `dependencia`, `placaInventario`, `idAmbiente`) VALUES
(3, '501', 5, 'ultimo', 1, 1, '123', 0, '2013-06-04', '2016-10-25', '', '', '', 8),
(4, '1234', 5, '2012', 1, 1, '123456', 1, '2010-02-10', '2011-03-02', 'javier', '', '', 169),
(5, '124578', 5, '2017', 1, 1, '123456', 1, '2017-03-09', '2017-05-11', 'juan', '', '', 169),
(6, 'APE  PISO 4', 6, 'XXXXXXXXXXXXXXXXXXXX', 1, 1, 'SSSSSSSSSSSSSSSS', 1, '2010-03-24', '2011-03-24', 'APE MARTA MONSALVE -- GUSTAVO', 'APE', '', 329),
(7, '687874874', 8, 'fdfdf46544654654', 5, 1, '498784798498', 1, '2017-04-12', '2017-04-13', '', '', '89874988', 56),
(8, '564654', 5, '2009', 1, 1, '5465456456465', 1, '2017-06-02', '2017-06-08', 'sena', 'sena', '64654654654', 59),
(9, '65456464', 8, '647654765', 15, 5, '657465', 1, '2017-06-15', '2017-06-20', 'SENA', 'SEWNA', '4152435', 2),
(10, '1223', 5, 'ds', 1, 1, 's', 1, '2017-08-17', '2017-08-31', 'asd', 'ssad', 'sadsa', 55);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblestadosolicitud`
--

CREATE TABLE IF NOT EXISTS `tblestadosolicitud` (
  `idEstado` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblestadosolicitud`
--

INSERT INTO `tblestadosolicitud` (`idEstado`, `Nombre`) VALUES
(1, 'Pendiente'),
(2, 'En proceso'),
(3, 'En ejecución'),
(4, 'En verificación'),
(5, 'Rechazada'),
(6, 'Finalizada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblgeneros`
--

CREATE TABLE IF NOT EXISTS `tblgeneros` (
  `idGenero` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblgeneros`
--

INSERT INTO `tblgeneros` (`idGenero`, `nombre`) VALUES
(1, 'Masculino'),
(2, 'Femenino'),
(3, 'Otro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblinsumos`
--

CREATE TABLE IF NOT EXISTS `tblinsumos` (
  `idInsumo` int(11) NOT NULL,
  `codigo` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `idMarca` int(11) NOT NULL,
  `idPresentacion` int(11) NOT NULL,
  `idUnidadMedida` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblitems`
--

CREATE TABLE IF NOT EXISTS `tblitems` (
  `idItem` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `idComponente` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblitems`
--

INSERT INTO `tblitems` (`idItem`, `Nombre`, `idComponente`) VALUES
(1, 'Serpentín', 1),
(2, 'Bandeja del drenaje', 1),
(3, 'Filtros', 1),
(4, 'Limpieza general', 1),
(5, 'Ventilador', 1),
(6, 'Válvula de expansión', 1),
(7, 'Banda', 1),
(8, 'Poleas vibración', 1),
(9, 'Poleas alineación', 1),
(10, 'Engrase balineras', 1),
(11, 'Motor Evap. Amp', 1),
(12, 'Temperatura agua helada', 1),
(13, 'Carga refrigerante', 2),
(14, 'Compresor AMP', 2),
(15, 'Motor ventilador', 2),
(16, 'Filtro secador', 2),
(17, 'Presión succión', 2),
(18, 'Presión descarga', 2),
(19, 'AMP. Compresor', 2),
(20, 'Lubricación', 2),
(21, 'Temp. Retorno evaporador', 2),
(22, 'Temp. Suministro', 2),
(23, 'Volt. Entrada equipos', 2),
(24, 'Estado de condensador', 2),
(25, 'Operación termostato', 3),
(26, 'Contactores', 3),
(27, 'Alambrado general', 3),
(28, 'Limpieza tablero', 3),
(29, 'Presostato', 3),
(30, 'Timer', 3),
(31, 'Cond. Trifásica', 3),
(32, 'Cond. Monofásica', 3),
(33, 'Evap. Trifásica', 3),
(34, 'Evap. Monofásica', 3),
(35, 'Limpieza difusores', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblitemsmantenimientos`
--

CREATE TABLE IF NOT EXISTS `tblitemsmantenimientos` (
  `idItemMantenimiento` int(11) NOT NULL,
  `idMantenimiento` int(11) NOT NULL,
  `idItem` int(11) NOT NULL,
  `Accion` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblitemsmantenimientos`
--

INSERT INTO `tblitemsmantenimientos` (`idItemMantenimiento`, `idMantenimiento`, `idItem`, `Accion`) VALUES
(1, 1, 9, 'C'),
(2, 3, 1, 'M'),
(3, 3, 4, 'M'),
(4, 3, 9, 'M'),
(5, 3, 12, 'M'),
(6, 3, 14, 'C'),
(7, 4, 1, 'M'),
(8, 4, 14, 'M'),
(9, 5, 1, 'M'),
(10, 5, 4, 'M'),
(11, 5, 14, 'M'),
(12, 6, 1, 'M'),
(13, 7, 1, 'M');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmantenimientos`
--

CREATE TABLE IF NOT EXISTS `tblmantenimientos` (
  `idMantenimiento` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idEquipo` int(11) DEFAULT NULL,
  `idSolicitud` int(11) NOT NULL,
  `predictivo` int(11) NOT NULL,
  `preventivo` int(11) NOT NULL,
  `correctivo` int(11) NOT NULL,
  `observaciones` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblmantenimientos`
--

INSERT INTO `tblmantenimientos` (`idMantenimiento`, `fecha`, `idEquipo`, `idSolicitud`, `predictivo`, `preventivo`, `correctivo`, `observaciones`) VALUES
(1, '2017-03-08 16:45:16', 3, 82, 0, 0, 1, 'El equipo presento falla menores'),
(2, '2017-03-08 16:51:57', 3, 83, 1, 0, 0, 'El aire presento fallas menores'),
(3, '2017-03-08 19:15:10', 4, 84, 1, 1, 1, 'limpieza general'),
(4, '2017-06-02 19:51:12', 8, 196, 0, 0, 1, 'se le hizo una limpieza general'),
(5, '2017-07-13 15:45:10', 3, 201, 0, 0, 1, 'se tal cosa'),
(6, '2017-08-11 14:04:47', 3, 204, 1, 0, 0, 'Prueba sdjf'),
(7, '2017-08-18 20:42:59', 10, 237, 0, 1, 0, 'sads');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmantenimientosotros`
--

CREATE TABLE IF NOT EXISTS `tblmantenimientosotros` (
  `idMantenimientod` int(11) NOT NULL,
  `motivo` varchar(100) CHARACTER SET utf8 NOT NULL,
  `motivo1` varchar(100) CHARACTER SET utf8 NOT NULL,
  `motivo2` varchar(100) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `predictivo` int(11) NOT NULL,
  `preventivo` int(11) NOT NULL,
  `correctivo` int(11) NOT NULL,
  `observaciones` varchar(100) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idSolicitud` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblmantenimientosotros`
--

INSERT INTO `tblmantenimientosotros` (`idMantenimientod`, `motivo`, `motivo1`, `motivo2`, `descripcion`, `predictivo`, `preventivo`, `correctivo`, `observaciones`, `fecha`, `idSolicitud`) VALUES
(1, 'cortocircuito', 'se cambiaron cables', '100 metros de cable N-12', 'se cambio cable defectuoso de acuerdo a la norma', 0, 0, 1, 'cable cambiado\r\n', '2017-03-08 19:36:46', 86),
(2, 'puerta colgada', 'no', 'no', 'la puerta en  el momento se encuentra descolgada se nivela de nuevo y quedo funcionando bien', 1, 1, 1, 'se recomienda que la puerta tiene demacido peso para este sistema de puerta se debede hace run segui', '2017-03-10 13:03:37', 90),
(3, 'se requiere hacer cortes definidos en 3 partes con dimensiones establecidas', 'NO', 'NO', 'Corte en sierra circular de banco', 0, 1, 0, 'se corta tablón de madera en cortes definidos por el Sr. javier mallama', '2017-03-13 15:07:39', 88),
(4, 'Instalación equipo hielera al sistema de agua potable', 'no', 'abasto de doble salida', 'instalación equipo', 1, 0, 0, 'se debe de instalar equipo para formación y servicio de la cocina', '2017-03-13 16:32:11', 96),
(5, 'se realiza apertura de escritorio, por perdida de llave ', 'NO', 'no', 'se realiza apertura de escritorio', 0, 0, 1, 'se hace apertura de escritorio, por perdida de llave en presencia del Sr. luis socarraz, responsable', '2017-03-14 16:30:16', 99),
(6, 'puerta con arrastre en el piso', 'NO', 'NO', 'se hacen ajustes en tornillos, para levantar gato de puerta inferior', 0, 0, 1, 'se corrigen ajustes en tornillo de desplazamiento de la puerta y se organiza gato inferior', '2017-03-14 16:34:27', 97),
(7, 'desperdicio de agua en boceada de inodoro baño hombre', 'si', 'NO', 'se baja fluxometro y se cambia empaque de base vulcanizado y trompo de desagüe. ', 0, 1, 0, 'se cambian elementos deteriorados del fluxometro', '2017-03-14 16:39:33', 98),
(8, 'Movimiento papel para generar espacio y mto de loker', 'no', 'no', 'traslado de papel en el mismo espacio, para generar espacio.', 0, 0, 1, 'ninguna', '2017-03-14 16:57:41', 102),
(9, 'traslado mobiliario', 'no', 'no', 'traslado mobiliario para coordinacion', 1, 0, 0, 'ninguna', '2017-03-15 15:55:23', 104),
(10, 'cambio de chapa escritorio', 'si', 'si', 'se baja cahpa mala de escritorio y se remplaza por una nueva', 1, 0, 0, 'se cambia chapa escritorio por falta de seguridad en él.', '2017-03-16 10:22:19', 100),
(12, 'puerta caída a la cena inferior', 'si', 'si', 'se  cambia bisagra invisible, por rotura de esta', 0, 0, 1, 'se desmonta bisagra por estar rota, impidiendo el cierre normal de la puerta de la alacena', '2017-03-16 14:22:09', 110),
(13, 'sillas en mal estado por falta de tornilleria', 'NO', 'NO', 'se organizan 6 unidades de sillas por falta de tornilleria en la parte de los asientos', 0, 0, 1, 'se ajustan y se les coloca tornillos faltantes a la silleteria', '2017-03-16 14:25:06', 109),
(15, 'botadura de agua llave lavamanos', 'NO', 'NO', 'se baja llave pusch de lavamanos del baño privado de las damas ', 0, 0, 1, 'se baja y se cambia llave pusch de lavamanos,ya cumplía con su vida util', '2017-03-17 10:16:26', 114),
(16, 'llave lavamanos no cierra, queda botando agua', 'si', 'NO', 'se baja y se organiza llave pusch, se coloca anillo regulador y se cambia resorte de ajuste', 0, 0, 1, 'se hace cambio de elementos malos en llave pusch', '2017-03-17 10:19:40', 113),
(17, 'desplazamiento de cajonera en piso 10', 'NO', 'NO', 'se  desplaza cajonera situada en costado de la salida de emergencia para ambiente 10-05', 1, 0, 0, 'se necesita cajonera en el ambiente 10-05', '2017-03-17 11:14:54', 95),
(20, 'traslados', 'no', 'no', 'traslados para el piso 9', 0, 0, 0, 'ninguna', '2017-03-17 11:36:26', 117),
(21, 'daño en chapas de bola', 'si', 'si', 'se cambian 2 chapas en puertas de acceso a la cabina del auditorio de torre sur', 0, 0, 1, 'se cambian 2 chapas en puertas de acceso a la cabina del auditorio de torre su', '2017-03-21 10:18:46', 119),
(24, 'se revienta abasto llave lavamanos y fluxometro inodoro malo', 'si', 'NO', 'se cambia abasto llave lavamanos y se baja y se organiza fluxometro', 0, 0, 1, 'se cambia abasto llave lavamanos y se baja y se organiza fluxometro', '2017-03-21 13:30:47', 127),
(25, 'retira se soporte de extintor malo, se coloca uno nuevo y se reafirma en pared', 'NO', 'NO', 'retira se soporte de extintor malo, se coloca uno nuevo y se reafirma en pared', 0, 1, 0, 'se cambia de soporte de extintor, situado en porteria ferrocarril', '2017-03-22 10:12:56', 128),
(26, 'se presenta oscuridad en los baños por falta de tubos luminarias', 'si', 'NO', 'se cambian 6 tubos luminarias en lamparas, no hay mas existencia de estos elementos', 0, 1, 0, 'se cambian 6 tubos luminarias en lamparas, no hay mas existencia de estos elementos', '2017-03-22 10:57:24', 111),
(27, 'tubo luminaria quemado', 'si', 'NO', 'se cambian 2 tubos luminarias que estaban quemados ', 0, 1, 0, 'se cambian 2 tubos luminarias que estaban quemados, no existen mas elementos de estos para repuestos', '2017-03-22 10:59:38', 123),
(28, 'desplazamiento de sillas', 'no', 'no', 'desplazamiento de sillas y mesas para plazoleta del aprendiz.', 0, 0, 1, 'ninguna', '2017-03-22 12:15:14', 116),
(29, 'desplazamiento de papel', 'no', 'no', 'desplazamiento papel', 0, 0, 1, 'ninguna', '2017-03-22 12:16:30', 103),
(30, 'traslado impresora', 'no', 'no', 'traslado impresora coordinacion', 0, 0, 1, 'ninguna', '2017-03-22 12:20:59', 115),
(31, 'limpieza de montacargas', 'no', 'no', 'limpieza superficial de montacargas', 0, 0, 1, 'ninguna', '2017-03-22 12:22:23', 126),
(33, 'desplazamiento de sillas', 'no', 'no', 'desplazamiento de sillas de la cocina gourmet', 0, 0, 1, 'ninguna', '2017-03-22 12:24:07', 122),
(34, 'charco en rampa parq. motos portería aux.', 'no', 'no', 'charco en rampa', 0, 1, 0, 'ninguna', '2017-03-22 12:26:26', 120),
(36, 'traslado de estanterías', 'no', 'no', 'traslado de estanterías del sótano para el tercer piso archivo', 1, 0, 0, 'ninguna', '2017-03-23 18:19:23', 140),
(37, 'chapa ambiente 7-05 mala', 'NO', 'NO', 'se baja y se organiza chapa, pines de la chapa estaban corridos', 0, 0, 1, 'se baja y se organiza chapa, pines de la chapa estaban corridos', '2017-03-25 10:12:49', 159),
(38, 'chapa de oficina setrasena mala', 'NO', 'NO', 'se baja y se cambia chapa de puerta mala', 0, 1, 0, 'se baja y se cambia chapa de puerta mala', '2017-03-25 10:14:15', 158),
(39, 'organizar estanteria metalica', 'NO', 'NO', 'se organizan 4 cuerpos de estantería metálica y se anclan en espacio de archivo', 0, 1, 0, 'se organizan 4 cuerpos de estantería metálica y se anclan en espacio de archivo', '2017-03-25 10:16:56', 130),
(40, 'armar carpas', 'no', 'no', 'se armaron carpas y se realizo movimiento de sillas.', 0, 0, 0, 'ninguna', '2017-03-27 12:35:58', 121),
(41, 'persianas para archivo', 'no', 'no', 'no hay existencia de persianas para archivo u otro ambiente ', 1, 0, 0, 'no hay existencia de persianas para archivo u otro ambiente ', '2017-03-27 14:44:05', 167),
(42, 'circuitos eléctricos en oficina archivo', 'si', 'no', 'se hacen 2 circuitos eléctricos nuevos por reforma de oficina de archivo', 1, 0, 0, 'se hacen 2 circuitos eléctricos nuevos por reforma de oficina de archivo', '2017-03-27 14:46:26', 129),
(43, 'RE ACOMODAR VÍDEO BEMM', 'no', 'no', 'no aplica este mantenimiento correctivo, ya que estos equipos son manipulados por expertos.', 0, 0, 1, 'no aplica este mantenimiento correctivo, ya que estos equipos son manipulados por expertos.', '2017-03-27 14:48:37', 108),
(44, 'solicitud de lampara nueva', 'si', 'no', 'Se coloca nueva lampara en sitio estratégico para mejor iluminación. ', 1, 0, 0, 'Se coloca nueva lampara en sitio estratégico para mejor iluminación', '2017-03-27 14:51:10', 118),
(45, 'BAÑOS BOTANDO AGUA', 'si', 'no', 'se cambian en ambos inodoros el kit de válvula de cerrado del agua, estaban en malas condiciones', 0, 1, 0, 'se cambian en ambos inodoros el kit de válvula de cerrado del agua, estaban en malas condiciones', '2017-03-27 14:53:23', 170),
(46, 'arreglo silleteria', 'no', 'si', 'se organiza silleteria por tornilleria mala', 0, 0, 1, 'se organiza silleteria por tornilleria mala', '2017-03-27 14:55:07', 169),
(48, 'estanteria', 'no', 'no', 'este servicioya fue realizado', 1, 0, 0, 'este servicioya fue realizado', '2017-03-27 14:58:14', 163),
(49, 'se requiere organizar  puerta biblioteca', 'si', 'no', 'se  monta brazo  hidráulico en puerta de la biblioteca ', 0, 0, 1, 'se  monta brazo  hidráulico en puerta de la biblioteca ', '2017-03-28 12:08:14', 112),
(50, 'ESTABA TODO DAÑADO', 'NO', 'NO', 'SE HIZO EL MANTENIMIENTO', 0, 0, 1, 'NINGUNA', '2017-04-17 16:26:14', 191),
(51, 'estaba dañado el escritorio de este ambiente', 'no', 'no', 'el escritorio se le partio una pata', 0, 0, 1, 'ninguna', '2017-04-18 12:26:42', 192),
(52, 'no fue nada grave', 'no fue nada grave', 'no fue nada grave', 'no fue nada grave', 0, 0, 1, 'ninguna', '2017-04-24 12:54:12', 193),
(53, 'se daño una puerta', 'la chapa', 'no', 'correctivo', 0, 0, 1, 'ninguna', '2017-07-28 15:56:22', 202),
(54, 'la puerta estaba dañada', 'la chapa', 'no', 'correctiva', 0, 0, 1, 'ninguna', '2017-07-28 16:05:53', 203),
(55, 'Cambio', 'si', 'no', 'cambio', 0, 0, 1, 'se cambio un foco', '2017-08-23 12:51:36', 238);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmarcas`
--

CREATE TABLE IF NOT EXISTS `tblmarcas` (
  `idMarca` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmarcasequipos`
--

CREATE TABLE IF NOT EXISTS `tblmarcasequipos` (
  `idMarca` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblmarcasequipos`
--

INSERT INTO `tblmarcasequipos` (`idMarca`, `Nombre`) VALUES
(5, 'LG'),
(6, 'Trane'),
(7, 'york'),
(8, 'SAMSUNG'),
(9, 'Ciiac'),
(10, 'Confortstyle'),
(11, 'Confortfresh'),
(12, 'Blueline'),
(13, 'Westienghouse'),
(14, 'Lennox'),
(15, 'Otros'),
(16, 'LGH');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmodificacionessolicitud`
--

CREATE TABLE IF NOT EXISTS `tblmodificacionessolicitud` (
  `idModificacionSolicitud` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL,
  `idCuentaUsuario` int(11) NOT NULL,
  `idTecnico` varchar(45) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tipoModificacion` int(11) NOT NULL,
  `Motivo` text NOT NULL,
  `idNotificaciones` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblmodificacionessolicitud`
--

INSERT INTO `tblmodificacionessolicitud` (`idModificacionSolicitud`, `idSolicitud`, `idCuentaUsuario`, `idTecnico`, `fecha`, `tipoModificacion`, `Motivo`, `idNotificaciones`) VALUES
(111, 82, 18, NULL, '2017-03-08 16:47:44', 4, 'Solicitud finalizada', 194),
(114, 83, 18, NULL, '2017-03-08 16:52:21', 4, 'Solicitud finalizada', 198),
(115, 85, 18, '1020431601', '2017-03-08 18:48:45', 1, 'Tecnico asignado', 201),
(116, 84, 30, '15256627', '2017-03-08 19:01:26', 1, 'Tecnico asignado', 202),
(118, 84, 23, NULL, '2017-03-08 19:15:12', 5, 'Mantenimiento realizado', 204),
(119, 84, 30, NULL, '2017-03-08 19:17:13', 4, 'Solicitud finalizada', 205),
(120, 86, 32, '71591822', '2017-03-08 19:31:40', 1, 'Tecnico asignado', 207),
(121, 86, 32, '98589653', '2017-03-08 19:31:41', 1, 'Tecnico asignado', 208),
(122, 86, 28, NULL, '2017-03-08 19:36:48', 5, 'Mantenimiento realizado', 209),
(123, 86, 32, NULL, '2017-03-08 19:37:53', 4, 'Solicitud finalizada', 210),
(124, 87, 32, '98589653', '2017-03-08 20:50:59', 1, 'Tecnico asignado', 212),
(125, 88, 34, '102355478', '2017-03-10 12:25:44', 1, 'Tecnico asignado', 216),
(126, 90, 43, '15256627', '2017-03-10 12:48:21', 1, 'Tecnico asignado', 217),
(127, 90, 23, NULL, '2017-03-10 13:03:40', 5, 'Mantenimiento realizado', 218),
(128, 89, 42, '1128478329', '2017-03-10 20:47:54', 1, 'Tecnico asignado', 221),
(129, 92, 34, '71591822', '2017-03-10 22:18:26', 1, 'Tecnico asignado', 222),
(130, 92, 34, '98589653', '2017-03-10 22:18:26', 1, 'Tecnico asignado', 223),
(131, 93, 24, '15256627', '2017-03-13 12:14:29', 1, 'Tecnico asignado', 225),
(132, 95, 34, '102355478', '2017-03-13 14:24:16', 1, 'Tecnico asignado', 228),
(133, 94, 32, '15256627', '2017-03-13 14:39:07', 1, 'Tecnico asignado', 229),
(134, 88, 40, NULL, '2017-03-13 15:07:42', 5, 'Mantenimiento realizado', 230),
(135, 88, 34, NULL, '2017-03-13 15:10:18', 4, 'Solicitud finalizada', 231),
(136, 88, 34, NULL, '2017-03-13 15:10:20', 4, 'Solicitud finalizada', 232),
(137, 91, 34, '102355478', '2017-03-13 15:12:33', 1, 'Tecnico asignado', 233),
(138, 96, 34, '102355478', '2017-03-13 15:39:08', 1, 'Tecnico asignado', 235),
(139, 96, 40, NULL, '2017-03-13 16:32:13', 5, 'Mantenimiento realizado', 236),
(140, 99, 34, '102355478', '2017-03-14 13:39:24', 1, 'Tecnico asignado', 240),
(141, 98, 34, '102355478', '2017-03-14 13:40:01', 1, 'Tecnico asignado', 241),
(142, 97, 34, '102355478', '2017-03-14 13:40:35', 1, 'Tecnico asignado', 242),
(143, 99, 40, NULL, '2017-03-14 16:30:18', 5, 'Mantenimiento realizado', 247),
(144, 97, 40, NULL, '2017-03-14 16:34:28', 5, 'Mantenimiento realizado', 248),
(145, 98, 40, NULL, '2017-03-14 16:39:35', 5, 'Mantenimiento realizado', 249),
(146, 103, 31, '436309340', '2017-03-14 16:48:47', 1, 'Tecnico asignado', 250),
(147, 102, 31, '436309340', '2017-03-14 16:49:41', 1, 'Tecnico asignado', 251),
(148, 100, 31, '102355478', '2017-03-14 16:51:08', 1, 'Tecnico asignado', 252),
(149, 102, 44, NULL, '2017-03-14 16:57:45', 5, 'Mantenimiento realizado', 253),
(150, 101, 42, '1128478329', '2017-03-14 18:52:40', 1, 'Tecnico asignado', 254),
(151, 102, 31, NULL, '2017-03-14 19:05:30', 4, 'Solicitud finalizada', 255),
(152, 102, 31, NULL, '2017-03-14 19:05:32', 4, 'Solicitud finalizada', 256),
(153, 104, 34, '436309340', '2017-03-14 21:40:09', 1, 'Tecnico asignado', 258),
(154, 104, 44, NULL, '2017-03-15 15:55:26', 5, 'Mantenimiento realizado', 262),
(155, 104, 34, NULL, '2017-03-15 21:38:01', 4, 'Solicitud finalizada', 264),
(156, 100, 40, NULL, '2017-03-16 10:22:21', 5, 'Mantenimiento realizado', 268),
(157, 112, 34, '102355478', '2017-03-16 12:47:22', 1, 'Tecnico asignado', 270),
(158, 110, 34, '102355478', '2017-03-16 12:47:56', 1, 'Tecnico asignado', 271),
(159, 109, 34, '102355478', '2017-03-16 12:48:39', 1, 'Tecnico asignado', 272),
(160, 110, 40, NULL, '2017-03-16 14:22:12', 5, 'Mantenimiento realizado', 275),
(161, 109, 40, NULL, '2017-03-16 14:25:10', 5, 'Mantenimiento realizado', 276),
(162, 114, 34, '102355478', '2017-03-16 15:00:17', 1, 'Tecnico asignado', 278),
(163, 113, 34, '102355478', '2017-03-16 15:01:48', 1, 'Tecnico asignado', 279),
(164, 115, 31, '436309340', '2017-03-16 15:10:32', 1, 'Tecnico asignado', 280),
(165, 116, 31, '436309340', '2017-03-16 15:43:44', 1, 'Tecnico asignado', 282),
(166, 88, 34, NULL, '2017-03-16 18:41:40', 4, 'Solicitud finalizada', 283),
(167, 110, 34, NULL, '2017-03-16 18:41:56', 4, 'Solicitud finalizada', 284),
(168, 109, 34, NULL, '2017-03-16 18:42:09', 4, 'Solicitud finalizada', 285),
(169, 98, 34, NULL, '2017-03-16 18:42:22', 4, 'Solicitud finalizada', 286),
(170, 97, 34, NULL, '2017-03-16 18:42:45', 4, 'Solicitud finalizada', 287),
(171, 99, 34, NULL, '2017-03-16 18:43:08', 4, 'Solicitud finalizada', 288),
(172, 96, 34, NULL, '2017-03-16 18:43:21', 4, 'Solicitud finalizada', 289),
(173, 117, 34, '436309340', '2017-03-16 22:16:59', 1, 'Tecnico asignado', 291),
(174, 114, 40, NULL, '2017-03-17 10:16:28', 5, 'Mantenimiento realizado', 292),
(175, 113, 40, NULL, '2017-03-17 10:19:42', 5, 'Mantenimiento realizado', 293),
(176, 95, 40, NULL, '2017-03-17 11:14:57', 5, 'Mantenimiento realizado', 294),
(177, 117, 44, NULL, '2017-03-17 11:36:29', 5, 'Mantenimiento realizado', 295),
(178, 117, 34, NULL, '2017-03-17 13:25:00', 4, 'Solicitud finalizada', 298),
(179, 117, 34, NULL, '2017-03-17 13:25:06', 4, 'Solicitud finalizada', 299),
(180, 118, 34, '102355478', '2017-03-17 15:36:34', 1, 'Tecnico asignado', 301),
(181, 118, 34, '71591822', '2017-03-17 15:36:34', 1, 'Tecnico asignado', 302),
(182, 118, 34, '98589653', '2017-03-17 15:36:34', 1, 'Tecnico asignado', 303),
(183, 120, 34, '436309340', '2017-03-17 15:43:31', 1, 'Tecnico asignado', 304),
(184, 114, 34, NULL, '2017-03-17 15:43:58', 4, 'Solicitud finalizada', 305),
(185, 114, 34, NULL, '2017-03-17 15:43:58', 4, 'Solicitud finalizada', 306),
(186, 113, 34, NULL, '2017-03-17 15:44:18', 4, 'Solicitud finalizada', 307),
(187, 122, 34, '436309340', '2017-03-17 16:41:52', 1, 'Tecnico asignado', 310),
(188, 119, 34, '102355478', '2017-03-17 16:42:33', 1, 'Tecnico asignado', 311),
(189, 108, 34, '102355478', '2017-03-17 16:43:00', 1, 'Tecnico asignado', 312),
(190, 123, 34, '102355478', '2017-03-17 17:07:30', 1, 'Tecnico asignado', 314),
(191, 123, 34, '71591822', '2017-03-17 17:07:30', 1, 'Tecnico asignado', 315),
(192, 123, 34, '98589653', '2017-03-17 17:07:31', 1, 'Tecnico asignado', 316),
(193, 125, 34, '1128478329', '2017-03-17 19:02:41', 1, 'Tecnico asignado', 319),
(194, 125, 34, '71761148', '2017-03-17 19:02:41', 1, 'Tecnico asignado', 320),
(195, 124, 34, '1128478329', '2017-03-17 19:03:06', 1, 'Tecnico asignado', 321),
(196, 124, 34, '71761148', '2017-03-17 19:03:06', 1, 'Tecnico asignado', 322),
(197, 126, 34, '436309340', '2017-03-17 19:34:05', 1, 'Tecnico asignado', 324),
(198, 119, 40, NULL, '2017-03-21 10:18:50', 5, 'Mantenimiento realizado', 325),
(199, 96, 34, NULL, '2017-03-21 12:29:21', 4, 'Solicitud finalizada', 327),
(200, 119, 34, NULL, '2017-03-21 12:31:24', 4, 'Solicitud finalizada', 328),
(201, 127, 34, '102355478', '2017-03-21 12:32:15', 1, 'Tecnico asignado', 329),
(202, 127, 40, NULL, '2017-03-21 13:30:50', 5, 'Mantenimiento realizado', 331),
(203, 128, 34, '102355478', '2017-03-21 16:22:41', 1, 'Tecnico asignado', 333),
(204, 121, 34, '436309340', '2017-03-21 16:23:33', 1, 'Tecnico asignado', 334),
(205, 95, 34, NULL, '2017-03-21 16:24:15', 4, 'Solicitud finalizada', 335),
(206, 95, 34, NULL, '2017-03-21 16:24:17', 4, 'Solicitud finalizada', 336),
(207, 127, 34, NULL, '2017-03-21 16:24:34', 4, 'Solicitud finalizada', 337),
(208, 129, 34, '102355478', '2017-03-21 16:26:12', 1, 'Tecnico asignado', 338),
(209, 129, 34, '98589653', '2017-03-21 16:26:13', 1, 'Tecnico asignado', 339),
(210, 111, 34, '102355478', '2017-03-21 16:26:54', 1, 'Tecnico asignado', 340),
(211, 111, 34, '98589653', '2017-03-21 16:26:55', 1, 'Tecnico asignado', 341),
(212, 106, 32, '15256627', '2017-03-21 17:15:49', 1, 'Tecnico asignado', 342),
(213, 107, 32, '15256627', '2017-03-21 17:16:22', 1, 'Tecnico asignado', 343),
(214, 105, 32, '71591822', '2017-03-21 17:17:06', 1, 'Tecnico asignado', 344),
(215, 105, 32, '98589653', '2017-03-21 17:17:06', 1, 'Tecnico asignado', 345),
(216, 128, 40, NULL, '2017-03-22 10:12:58', 5, 'Mantenimiento realizado', 346),
(217, 111, 40, NULL, '2017-03-22 10:57:26', 5, 'Mantenimiento realizado', 347),
(218, 123, 40, NULL, '2017-03-22 10:59:41', 5, 'Mantenimiento realizado', 348),
(219, 116, 44, NULL, '2017-03-22 12:15:16', 5, 'Mantenimiento realizado', 351),
(220, 116, 31, NULL, '2017-03-22 12:16:03', 4, 'Solicitud finalizada', 352),
(221, 116, 31, NULL, '2017-03-22 12:16:03', 4, 'Solicitud finalizada', 353),
(222, 103, 44, NULL, '2017-03-22 12:16:31', 5, 'Mantenimiento realizado', 355),
(223, 103, 31, NULL, '2017-03-22 12:18:26', 4, 'Solicitud finalizada', 356),
(224, 103, 31, NULL, '2017-03-22 12:18:26', 4, 'Solicitud finalizada', 357),
(225, 115, 44, NULL, '2017-03-22 12:21:01', 5, 'Mantenimiento realizado', 358),
(226, 126, 44, NULL, '2017-03-22 12:22:25', 5, 'Mantenimiento realizado', 359),
(227, 122, 44, NULL, '2017-03-22 12:24:09', 5, 'Mantenimiento realizado', 360),
(228, 120, 44, NULL, '2017-03-22 12:26:28', 5, 'Mantenimiento realizado', 361),
(229, 130, 34, '102355478', '2017-03-22 15:00:30', 1, 'Tecnico asignado', 368),
(230, 123, 34, NULL, '2017-03-22 15:09:02', 4, 'Solicitud finalizada', 369),
(231, 126, 34, NULL, '2017-03-22 15:10:09', 4, 'Solicitud finalizada', 370),
(232, 122, 34, NULL, '2017-03-22 15:10:22', 4, 'Solicitud finalizada', 371),
(233, 120, 34, NULL, '2017-03-22 15:10:39', 4, 'Solicitud finalizada', 372),
(234, 115, 34, NULL, '2017-03-22 15:10:52', 4, 'Solicitud finalizada', 373),
(235, 128, 34, NULL, '2017-03-22 15:11:05', 4, 'Solicitud finalizada', 374),
(236, 131, 32, '15256627', '2017-03-22 19:32:56', 1, 'Tecnico asignado', 393),
(237, 132, 32, '15256627', '2017-03-22 19:34:49', 1, 'Tecnico asignado', 394),
(238, 133, 32, '15256627', '2017-03-22 19:36:14', 1, 'Tecnico asignado', 395),
(239, 90, 32, NULL, '2017-03-22 19:36:56', 4, 'Solicitud finalizada', 396),
(240, 157, 42, '716654322', '2017-03-23 13:30:43', 1, 'Tecnico asignado', 400),
(241, 134, 42, '716654322', '2017-03-23 13:32:16', 1, 'Tecnico asignado', 401),
(242, 135, 42, '716654322', '2017-03-23 13:33:13', 1, 'Tecnico asignado', 402),
(243, 136, 42, '716654322', '2017-03-23 13:33:43', 1, 'Tecnico asignado', 403),
(244, 137, 42, '716654322', '2017-03-23 13:34:15', 1, 'Tecnico asignado', 404),
(245, 138, 42, '716654322', '2017-03-23 13:34:31', 1, 'Tecnico asignado', 405),
(246, 141, 42, '716654322', '2017-03-23 13:35:19', 1, 'Tecnico asignado', 406),
(247, 142, 42, '716654322', '2017-03-23 13:35:40', 1, 'Tecnico asignado', 407),
(248, 143, 42, '716654322', '2017-03-23 13:36:04', 1, 'Tecnico asignado', 408),
(249, 144, 42, '716654322', '2017-03-23 13:36:22', 1, 'Tecnico asignado', 409),
(250, 145, 42, '716654322', '2017-03-23 13:36:38', 1, 'Tecnico asignado', 410),
(251, 146, 42, '716654322', '2017-03-23 13:36:58', 1, 'Tecnico asignado', 411),
(252, 147, 42, '716654322', '2017-03-23 13:42:53', 1, 'Tecnico asignado', 412),
(253, 148, 42, '716654322', '2017-03-23 13:43:27', 1, 'Tecnico asignado', 413),
(254, 149, 42, '716654322', '2017-03-23 13:43:56', 1, 'Tecnico asignado', 414),
(255, 150, 42, '716654322', '2017-03-23 13:44:45', 1, 'Tecnico asignado', 415),
(256, 151, 42, '716654322', '2017-03-23 13:45:48', 1, 'Tecnico asignado', 416),
(257, 152, 42, '716654322', '2017-03-23 13:46:09', 1, 'Tecnico asignado', 417),
(258, 153, 42, '716654322', '2017-03-23 13:46:32', 1, 'Tecnico asignado', 418),
(259, 154, 42, '716654322', '2017-03-23 13:47:04', 1, 'Tecnico asignado', 419),
(260, 155, 42, '716654322', '2017-03-23 13:47:29', 1, 'Tecnico asignado', 420),
(261, 156, 42, '716654322', '2017-03-23 13:47:58', 1, 'Tecnico asignado', 421),
(262, 159, 34, '102355478', '2017-03-23 15:01:02', 1, 'Tecnico asignado', 422),
(263, 158, 34, '102355478', '2017-03-23 15:01:27', 1, 'Tecnico asignado', 423),
(264, 140, 34, '436309340', '2017-03-23 15:02:03', 1, 'Tecnico asignado', 424),
(265, 140, 44, NULL, '2017-03-23 18:19:26', 5, 'Mantenimiento realizado', 429),
(266, 167, 34, '102355478', '2017-03-24 15:12:26', 1, 'Tecnico asignado', 434),
(267, 163, 34, '102355478', '2017-03-24 15:13:16', 1, 'Tecnico asignado', 435),
(268, 159, 40, NULL, '2017-03-25 10:12:52', 5, 'Mantenimiento realizado', 439),
(269, 158, 40, NULL, '2017-03-25 10:14:17', 5, 'Mantenimiento realizado', 440),
(270, 130, 40, NULL, '2017-03-25 10:16:58', 5, 'Mantenimiento realizado', 441),
(271, 159, 34, NULL, '2017-03-27 12:19:18', 4, 'Solicitud finalizada', 442),
(272, 158, 34, NULL, '2017-03-27 12:19:40', 4, 'Solicitud finalizada', 443),
(273, 158, 34, NULL, '2017-03-27 12:19:55', 4, 'Solicitud finalizada', 444),
(274, 140, 34, NULL, '2017-03-27 12:20:07', 4, 'Solicitud finalizada', 445),
(275, 130, 34, NULL, '2017-03-27 12:20:17', 4, 'Solicitud finalizada', 446),
(276, 170, 34, '102355478', '2017-03-27 12:20:46', 1, 'Tecnico asignado', 447),
(277, 169, 34, '102355478', '2017-03-27 12:21:21', 1, 'Tecnico asignado', 448),
(278, 121, 44, NULL, '2017-03-27 12:36:00', 5, 'Mantenimiento realizado', 449),
(279, 167, 40, NULL, '2017-03-27 14:44:07', 5, 'Mantenimiento realizado', 450),
(280, 129, 40, NULL, '2017-03-27 14:46:29', 5, 'Mantenimiento realizado', 451),
(281, 108, 40, NULL, '2017-03-27 14:48:39', 5, 'Mantenimiento realizado', 452),
(282, 118, 40, NULL, '2017-03-27 14:51:12', 5, 'Mantenimiento realizado', 453),
(283, 170, 40, NULL, '2017-03-27 14:53:24', 5, 'Mantenimiento realizado', 454),
(284, 169, 40, NULL, '2017-03-27 14:55:09', 5, 'Mantenimiento realizado', 455),
(285, 163, 40, NULL, '2017-03-27 14:58:15', 5, 'Mantenimiento realizado', 456),
(286, 178, 31, '436309340', '2017-03-27 19:45:55', 1, 'Tecnico asignado', 465),
(287, 179, 31, '436309340', '2017-03-27 20:16:36', 1, 'Tecnico asignado', 467),
(288, 112, 40, NULL, '2017-03-28 12:08:16', 5, 'Mantenimiento realizado', 469),
(289, 191, 18, '716654322', '2017-04-17 16:20:04', 1, 'Tecnico asignado', 476),
(290, 191, 46, NULL, '2017-04-17 16:26:16', 5, 'Mantenimiento realizado', 477),
(291, 192, 18, '716654322', '2017-04-18 12:24:08', 1, 'Tecnico asignado', 478),
(292, 192, 46, NULL, '2017-04-18 12:26:45', 5, 'Mantenimiento realizado', 479),
(293, 193, 18, '716654322', '2017-04-24 12:50:25', 1, 'Tecnico asignado', 481),
(294, 193, 46, NULL, '2017-04-24 12:54:15', 5, 'Mantenimiento realizado', 482),
(295, 186, 18, '0000', '2017-05-12 16:05:31', 1, 'Tecnico asignado', 483),
(296, 180, 18, '1128478329', '2017-05-12 16:07:19', 1, 'Tecnico asignado', 484),
(297, 177, 18, '15256627', '2017-05-12 16:46:54', 1, 'Tecnico asignado', 485),
(298, 194, 18, '716654322', '2017-06-02 19:38:12', 1, 'Tecnico asignado', 487),
(299, 195, 18, '716654322', '2017-06-02 19:44:34', 1, 'Tecnico asignado', 489),
(300, 196, 18, '716654322', '2017-06-02 19:49:33', 1, 'Tecnico asignado', 491),
(301, 196, 46, NULL, '2017-06-02 19:51:15', 5, 'Mantenimiento realizado', 492),
(302, 196, 18, NULL, '2017-06-02 19:51:51', 4, 'Solicitud finalizada', 493),
(303, 197, 18, '716654322', '2017-06-15 18:57:53', 1, 'Tecnico asignado', 495),
(304, 174, 18, '716654322', '2017-06-20 15:54:11', 1, 'Tecnico asignado', 496),
(305, 190, 18, '0000', '2017-06-20 15:58:07', 1, 'Tecnico asignado', 497),
(306, 201, 18, '716654322', '2017-07-13 15:37:04', 1, 'Tecnico asignado', 502),
(307, 201, 46, NULL, '2017-07-13 15:45:12', 5, 'Mantenimiento realizado', 503),
(308, 201, 18, NULL, '2017-07-13 15:47:08', 4, 'Solicitud finalizada', 504),
(309, 202, 18, '716654322', '2017-07-28 15:53:20', 1, 'Tecnico asignado', 506),
(310, 202, 46, NULL, '2017-07-28 15:56:24', 5, 'Mantenimiento realizado', 507),
(311, 202, 18, NULL, '2017-07-28 15:57:07', 4, 'Solicitud finalizada', 508),
(312, 203, 18, '716654322', '2017-07-28 16:03:39', 1, 'Tecnico asignado', 510),
(313, 203, 46, NULL, '2017-07-28 16:05:55', 5, 'Mantenimiento realizado', 511),
(314, 203, 18, NULL, '2017-07-28 16:07:39', 4, 'Solicitud finalizada', 512),
(315, 204, 18, '716654322', '2017-08-11 14:00:39', 1, 'Tecnico asignado', 514),
(316, 204, 46, NULL, '2017-08-11 14:04:49', 5, 'Mantenimiento realizado', 515),
(317, 204, 18, NULL, '2017-08-11 14:05:20', 4, 'Solicitud finalizada', 516),
(318, 200, 18, '716654322', '2017-08-11 16:20:30', 1, 'Tecnico asignado', 518),
(319, 237, 18, '1216726372', '2017-08-18 20:26:13', 1, 'Tecnico asignado', 551),
(320, 237, 47, NULL, '2017-08-18 20:43:01', 5, 'Mantenimiento realizado', 552),
(321, 237, 18, NULL, '2017-08-18 20:43:43', 4, 'Solicitud finalizada', 553),
(322, 237, 18, NULL, '2017-08-18 20:43:48', 4, 'Solicitud finalizada', 554),
(323, 238, 18, '1216726372', '2017-08-23 12:48:41', 1, 'Tecnico asignado', 556),
(324, 238, 18, NULL, '2017-08-23 12:53:50', 4, 'Solicitud finalizada', 557);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmodulos`
--

CREATE TABLE IF NOT EXISTS `tblmodulos` (
  `idModulo` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblmodulos`
--

INSERT INTO `tblmodulos` (`idModulo`, `nombre`) VALUES
(1, 'Gestionar Usuarios'),
(2, 'Gestionar Empresas'),
(3, 'Gestionar Insumos'),
(4, 'Gestionar Equipos'),
(5, 'Gestionar Solicitudes'),
(6, 'Informes'),
(7, 'Planos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmunicipios`
--

CREATE TABLE IF NOT EXISTS `tblmunicipios` (
  `idMunicipio` int(11) NOT NULL,
  `idDepartamento` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1103 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblmunicipios`
--

INSERT INTO `tblmunicipios` (`idMunicipio`, `idDepartamento`, `nombre`) VALUES
(1, 1, 'Leticia'),
(2, 1, 'Puerto Nariño'),
(3, 2, 'Abejorral'),
(4, 2, 'Abriaquí'),
(5, 2, 'Alejandria'),
(6, 2, 'Amagá'),
(7, 2, 'Amalfi'),
(8, 2, 'Andes'),
(9, 2, 'Angelópolis'),
(10, 2, 'Angostura'),
(11, 2, 'Anorí'),
(12, 2, 'Anzá'),
(13, 2, 'Apartadó'),
(14, 2, 'Arboletes'),
(15, 2, 'Argelia'),
(16, 2, 'Armenia'),
(17, 2, 'Barbosa'),
(18, 2, 'Bello'),
(19, 2, 'Belmira'),
(20, 2, 'Betania'),
(21, 2, 'Betulia'),
(22, 2, 'Bolívar'),
(23, 2, 'Briceño'),
(24, 2, 'Burítica'),
(25, 2, 'Caicedo'),
(26, 2, 'Caldas'),
(27, 2, 'Campamento'),
(28, 2, 'Caracolí'),
(29, 2, 'Caramanta'),
(30, 2, 'Carepa'),
(31, 2, 'Carmen de Viboral'),
(32, 2, 'Carolina'),
(33, 2, 'Caucasia'),
(34, 2, 'Cañasgordas'),
(35, 2, 'Chigorodó'),
(36, 2, 'Cisneros'),
(37, 2, 'Cocorná'),
(38, 2, 'Concepción'),
(39, 2, 'Concordia'),
(40, 2, 'Copacabana'),
(41, 2, 'Cáceres'),
(42, 2, 'Dabeiba'),
(43, 2, 'Don Matías'),
(44, 2, 'Ebéjico'),
(45, 2, 'El Bagre'),
(46, 2, 'Entrerríos'),
(47, 2, 'Envigado'),
(48, 2, 'Fredonia'),
(49, 2, 'Frontino'),
(50, 2, 'Giraldo'),
(51, 2, 'Girardota'),
(52, 2, 'Granada'),
(53, 2, 'Guadalupe'),
(54, 2, 'Guarne'),
(55, 2, 'Guatapé'),
(56, 2, 'Gómez Plata'),
(57, 2, 'Heliconia'),
(58, 2, 'Hispania'),
(59, 2, 'Itagüí'),
(60, 2, 'Ituango'),
(61, 2, 'Jardín'),
(62, 2, 'Jericó'),
(63, 2, 'La Ceja'),
(64, 2, 'La Estrella'),
(65, 2, 'La Pintada'),
(66, 2, 'La Unión'),
(67, 2, 'Liborina'),
(68, 2, 'Maceo'),
(69, 2, 'Marinilla'),
(70, 2, 'Medellín'),
(71, 2, 'Montebello'),
(72, 2, 'Murindó'),
(73, 2, 'Mutatá'),
(74, 2, 'Nariño'),
(75, 2, 'Nechí'),
(76, 2, 'Necoclí'),
(77, 2, 'Olaya'),
(78, 2, 'Peque'),
(79, 2, 'Peñol'),
(80, 2, 'Pueblorrico'),
(81, 2, 'Puerto Berrío'),
(82, 2, 'Puerto Nare'),
(83, 2, 'Puerto Triunfo'),
(84, 2, 'Remedios'),
(85, 2, 'Retiro'),
(86, 2, 'Ríonegro'),
(87, 2, 'Sabanalarga'),
(88, 2, 'Sabaneta'),
(89, 2, 'Salgar'),
(90, 2, 'San Andrés de Cuerquía'),
(91, 2, 'San Carlos'),
(92, 2, 'San Francisco'),
(93, 2, 'San Jerónimo'),
(94, 2, 'San José de Montaña'),
(95, 2, 'San Juan de Urabá'),
(96, 2, 'San Luís'),
(97, 2, 'San Pedro'),
(98, 2, 'San Pedro de Urabá'),
(99, 2, 'San Rafael'),
(100, 2, 'San Roque'),
(101, 2, 'San Vicente'),
(102, 2, 'Santa Bárbara'),
(103, 2, 'Santa Fé de Antioquia'),
(104, 2, 'Santa Rosa de Osos'),
(105, 2, 'Santo Domingo'),
(106, 2, 'Santuario'),
(107, 2, 'Segovia'),
(108, 2, 'Sonsón'),
(109, 2, 'Sopetrán'),
(110, 2, 'Tarazá'),
(111, 2, 'Tarso'),
(112, 2, 'Titiribí'),
(113, 2, 'Toledo'),
(114, 2, 'Turbo'),
(115, 2, 'Támesis'),
(116, 2, 'Uramita'),
(117, 2, 'Urrao'),
(118, 2, 'Valdivia'),
(119, 2, 'Valparaiso'),
(120, 2, 'Vegachí'),
(121, 2, 'Venecia'),
(122, 2, 'Vigía del Fuerte'),
(123, 2, 'Yalí'),
(124, 2, 'Yarumal'),
(125, 2, 'Yolombó'),
(126, 2, 'Yondó (Casabe)'),
(127, 2, 'Zaragoza'),
(128, 3, 'Arauca'),
(129, 3, 'Arauquita'),
(130, 3, 'Cravo Norte'),
(131, 3, 'Fortúl'),
(132, 3, 'Puerto Rondón'),
(133, 3, 'Saravena'),
(134, 3, 'Tame'),
(135, 4, 'Baranoa'),
(136, 4, 'Barranquilla'),
(137, 4, 'Campo de la Cruz'),
(138, 4, 'Candelaria'),
(139, 4, 'Galapa'),
(140, 4, 'Juan de Acosta'),
(141, 4, 'Luruaco'),
(142, 4, 'Malambo'),
(143, 4, 'Manatí'),
(144, 4, 'Palmar de Varela'),
(145, 4, 'Piojo'),
(146, 4, 'Polonuevo'),
(147, 4, 'Ponedera'),
(148, 4, 'Puerto Colombia'),
(149, 4, 'Repelón'),
(150, 4, 'Sabanagrande'),
(151, 4, 'Sabanalarga'),
(152, 4, 'Santa Lucía'),
(153, 4, 'Santo Tomás'),
(154, 4, 'Soledad'),
(155, 4, 'Suan'),
(156, 4, 'Tubará'),
(157, 4, 'Usiacuri'),
(158, 5, 'Achí'),
(159, 5, 'Altos del Rosario'),
(160, 5, 'Arenal'),
(161, 5, 'Arjona'),
(162, 5, 'Arroyohondo'),
(163, 5, 'Barranco de Loba'),
(164, 5, 'Calamar'),
(165, 5, 'Cantagallo'),
(166, 5, 'Cartagena'),
(167, 5, 'Cicuco'),
(168, 5, 'Clemencia'),
(169, 5, 'Córdoba'),
(170, 5, 'El Carmen de Bolívar'),
(171, 5, 'El Guamo'),
(172, 5, 'El Peñon'),
(173, 5, 'Hatillo de Loba'),
(174, 5, 'Magangué'),
(175, 5, 'Mahates'),
(176, 5, 'Margarita'),
(177, 5, 'María la Baja'),
(178, 5, 'Mompós'),
(179, 5, 'Montecristo'),
(180, 5, 'Morales'),
(181, 5, 'Norosí'),
(182, 5, 'Pinillos'),
(183, 5, 'Regidor'),
(184, 5, 'Río Viejo'),
(185, 5, 'San Cristobal'),
(186, 5, 'San Estanislao'),
(187, 5, 'San Fernando'),
(188, 5, 'San Jacinto'),
(189, 5, 'San Jacinto del Cauca'),
(190, 5, 'San Juan de Nepomuceno'),
(191, 5, 'San Martín de Loba'),
(192, 5, 'San Pablo'),
(193, 5, 'Santa Catalina'),
(194, 5, 'Santa Rosa '),
(195, 5, 'Santa Rosa del Sur'),
(196, 5, 'Simití'),
(197, 5, 'Soplaviento'),
(198, 5, 'Talaigua Nuevo'),
(199, 5, 'Tiquisio (Puerto Rico)'),
(200, 5, 'Turbaco'),
(201, 5, 'Turbaná'),
(202, 5, 'Villanueva'),
(203, 5, 'Zambrano'),
(204, 6, 'Almeida'),
(205, 6, 'Aquitania'),
(206, 6, 'Arcabuco'),
(207, 6, 'Belén'),
(208, 6, 'Berbeo'),
(209, 6, 'Beteitiva'),
(210, 6, 'Boavita'),
(211, 6, 'Boyacá'),
(212, 6, 'Briceño'),
(213, 6, 'Buenavista'),
(214, 6, 'Busbanza'),
(215, 6, 'Caldas'),
(216, 6, 'Campohermoso'),
(217, 6, 'Cerinza'),
(218, 6, 'Chinavita'),
(219, 6, 'Chiquinquirá'),
(220, 6, 'Chiscas'),
(221, 6, 'Chita'),
(222, 6, 'Chitaraque'),
(223, 6, 'Chivatá'),
(224, 6, 'Chíquiza'),
(225, 6, 'Chívor'),
(226, 6, 'Ciénaga'),
(227, 6, 'Coper'),
(228, 6, 'Corrales'),
(229, 6, 'Covarachía'),
(230, 6, 'Cubará'),
(231, 6, 'Cucaita'),
(232, 6, 'Cuitiva'),
(233, 6, 'Cómbita'),
(234, 6, 'Duitama'),
(235, 6, 'El Cocuy'),
(236, 6, 'El Espino'),
(237, 6, 'Firavitoba'),
(238, 6, 'Floresta'),
(239, 6, 'Gachantivá'),
(240, 6, 'Garagoa'),
(241, 6, 'Guacamayas'),
(242, 6, 'Guateque'),
(243, 6, 'Guayatá'),
(244, 6, 'Guicán'),
(245, 6, 'Gámeza'),
(246, 6, 'Izá'),
(247, 6, 'Jenesano'),
(248, 6, 'Jericó'),
(249, 6, 'La Capilla'),
(250, 6, 'La Uvita'),
(251, 6, 'La Victoria'),
(252, 6, 'Labranzagrande'),
(253, 6, 'Macanal'),
(254, 6, 'Maripí'),
(255, 6, 'Miraflores'),
(256, 6, 'Mongua'),
(257, 6, 'Monguí'),
(258, 6, 'Moniquirá'),
(259, 6, 'Motavita'),
(260, 6, 'Muzo'),
(261, 6, 'Nobsa'),
(262, 6, 'Nuevo Colón'),
(263, 6, 'Oicatá'),
(264, 6, 'Otanche'),
(265, 6, 'Pachavita'),
(266, 6, 'Paipa'),
(267, 6, 'Pajarito'),
(268, 6, 'Panqueba'),
(269, 6, 'Pauna'),
(270, 6, 'Paya'),
(271, 6, 'Paz de Río'),
(272, 6, 'Pesca'),
(273, 6, 'Pisva'),
(274, 6, 'Puerto Boyacá'),
(275, 6, 'Páez'),
(276, 6, 'Quipama'),
(277, 6, 'Ramiriquí'),
(278, 6, 'Rondón'),
(279, 6, 'Ráquira'),
(280, 6, 'Saboyá'),
(281, 6, 'Samacá'),
(282, 6, 'San Eduardo'),
(283, 6, 'San José de Pare'),
(284, 6, 'San Luís de Gaceno'),
(285, 6, 'San Mateo'),
(286, 6, 'San Miguel de Sema'),
(287, 6, 'San Pablo de Borbur'),
(288, 6, 'Santa María'),
(289, 6, 'Santa Rosa de Viterbo'),
(290, 6, 'Santa Sofía'),
(291, 6, 'Santana'),
(292, 6, 'Sativanorte'),
(293, 6, 'Sativasur'),
(294, 6, 'Siachoque'),
(295, 6, 'Soatá'),
(296, 6, 'Socha'),
(297, 6, 'Socotá'),
(298, 6, 'Sogamoso'),
(299, 6, 'Somondoco'),
(300, 6, 'Sora'),
(301, 6, 'Soracá'),
(302, 6, 'Sotaquirá'),
(303, 6, 'Susacón'),
(304, 6, 'Sutamarchán'),
(305, 6, 'Sutatenza'),
(306, 6, 'Sáchica'),
(307, 6, 'Tasco'),
(308, 6, 'Tenza'),
(309, 6, 'Tibaná'),
(310, 6, 'Tibasosa'),
(311, 6, 'Tinjacá'),
(312, 6, 'Tipacoque'),
(313, 6, 'Toca'),
(314, 6, 'Toguí'),
(315, 6, 'Topagá'),
(316, 6, 'Tota'),
(317, 6, 'Tunja'),
(318, 6, 'Tunungua'),
(319, 6, 'Turmequé'),
(320, 6, 'Tuta'),
(321, 6, 'Tutasá'),
(322, 6, 'Ventaquemada'),
(323, 6, 'Villa de Leiva'),
(324, 6, 'Viracachá'),
(325, 6, 'Zetaquirá'),
(326, 6, 'Úmbita'),
(327, 7, 'Aguadas'),
(328, 7, 'Anserma'),
(329, 7, 'Aranzazu'),
(330, 7, 'Belalcázar'),
(331, 7, 'Chinchiná'),
(332, 7, 'Filadelfia'),
(333, 7, 'La Dorada'),
(334, 7, 'La Merced'),
(335, 7, 'La Victoria'),
(336, 7, 'Manizales'),
(337, 7, 'Manzanares'),
(338, 7, 'Marmato'),
(339, 7, 'Marquetalia'),
(340, 7, 'Marulanda'),
(341, 7, 'Neira'),
(342, 7, 'Norcasia'),
(343, 7, 'Palestina'),
(344, 7, 'Pensilvania'),
(345, 7, 'Pácora'),
(346, 7, 'Risaralda'),
(347, 7, 'Río Sucio'),
(348, 7, 'Salamina'),
(349, 7, 'Samaná'),
(350, 7, 'San José'),
(351, 7, 'Supía'),
(352, 7, 'Villamaría'),
(353, 7, 'Viterbo'),
(354, 8, 'Albania'),
(355, 8, 'Belén de los Andaquíes'),
(356, 8, 'Cartagena del Chairá'),
(357, 8, 'Curillo'),
(358, 8, 'El Doncello'),
(359, 8, 'El Paujil'),
(360, 8, 'Florencia'),
(361, 8, 'La Montañita'),
(362, 8, 'Milán'),
(363, 8, 'Morelia'),
(364, 8, 'Puerto Rico'),
(365, 8, 'San José del Fragua'),
(366, 8, 'San Vicente del Caguán'),
(367, 8, 'Solano'),
(368, 8, 'Solita'),
(369, 8, 'Valparaiso'),
(370, 9, 'Aguazul'),
(371, 9, 'Chámeza'),
(372, 9, 'Hato Corozal'),
(373, 9, 'La Salina'),
(374, 9, 'Maní'),
(375, 9, 'Monterrey'),
(376, 9, 'Nunchía'),
(377, 9, 'Orocué'),
(378, 9, 'Paz de Ariporo'),
(379, 9, 'Pore'),
(380, 9, 'Recetor'),
(381, 9, 'Sabanalarga'),
(382, 9, 'San Luís de Palenque'),
(383, 9, 'Sácama'),
(384, 9, 'Tauramena'),
(385, 9, 'Trinidad'),
(386, 9, 'Támara'),
(387, 9, 'Villanueva'),
(388, 9, 'Yopal'),
(389, 10, 'Almaguer'),
(390, 10, 'Argelia'),
(391, 10, 'Balboa'),
(392, 10, 'Bolívar'),
(393, 10, 'Buenos Aires'),
(394, 10, 'Cajibío'),
(395, 10, 'Caldono'),
(396, 10, 'Caloto'),
(397, 10, 'Corinto'),
(398, 10, 'El Tambo'),
(399, 10, 'Florencia'),
(400, 10, 'Guachené'),
(401, 10, 'Guapí'),
(402, 10, 'Inzá'),
(403, 10, 'Jambaló'),
(404, 10, 'La Sierra'),
(405, 10, 'La Vega'),
(406, 10, 'López (Micay)'),
(407, 10, 'Mercaderes'),
(408, 10, 'Miranda'),
(409, 10, 'Morales'),
(410, 10, 'Padilla'),
(411, 10, 'Patía (El Bordo)'),
(412, 10, 'Piamonte'),
(413, 10, 'Piendamó'),
(414, 10, 'Popayán'),
(415, 10, 'Puerto Tejada'),
(416, 10, 'Puracé (Coconuco)'),
(417, 10, 'Páez (Belalcazar)'),
(418, 10, 'Rosas'),
(419, 10, 'San Sebastián'),
(420, 10, 'Santa Rosa'),
(421, 10, 'Santander de Quilichao'),
(422, 10, 'Silvia'),
(423, 10, 'Sotara (Paispamba)'),
(424, 10, 'Sucre'),
(425, 10, 'Suárez'),
(426, 10, 'Timbiquí'),
(427, 10, 'Timbío'),
(428, 10, 'Toribío'),
(429, 10, 'Totoró'),
(430, 10, 'Villa Rica'),
(431, 11, 'Aguachica'),
(432, 11, 'Agustín Codazzi'),
(433, 11, 'Astrea'),
(434, 11, 'Becerríl'),
(435, 11, 'Bosconia'),
(436, 11, 'Chimichagua'),
(437, 11, 'Chiriguaná'),
(438, 11, 'Curumaní'),
(439, 11, 'El Copey'),
(440, 11, 'El Paso'),
(441, 11, 'Gamarra'),
(442, 11, 'Gonzalez'),
(443, 11, 'La Gloria'),
(444, 11, 'La Jagua de Ibirico'),
(445, 11, 'La Paz (Robles)'),
(446, 11, 'Manaure Balcón del Cesar'),
(447, 11, 'Pailitas'),
(448, 11, 'Pelaya'),
(449, 11, 'Pueblo Bello'),
(450, 11, 'Río de oro'),
(451, 11, 'San Alberto'),
(452, 11, 'San Diego'),
(453, 11, 'San Martín'),
(454, 11, 'Tamalameque'),
(455, 11, 'Valledupar'),
(456, 12, 'Acandí'),
(457, 12, 'Alto Baudó (Pie de Pato)'),
(458, 12, 'Atrato (Yuto)'),
(459, 12, 'Bagadó'),
(460, 12, 'Bahía Solano (Mútis)'),
(461, 12, 'Bajo Baudó (Pizarro)'),
(462, 12, 'Belén de Bajirá'),
(463, 12, 'Bojayá (Bellavista)'),
(464, 12, 'Cantón de San Pablo'),
(465, 12, 'Carmen del Darién (CURBARADÓ)'),
(466, 12, 'Condoto'),
(467, 12, 'Cértegui'),
(468, 12, 'El Carmen de Atrato'),
(469, 12, 'Istmina'),
(470, 12, 'Juradó'),
(471, 12, 'Lloró'),
(472, 12, 'Medio Atrato'),
(473, 12, 'Medio Baudó'),
(474, 12, 'Medio San Juan (ANDAGOYA)'),
(475, 12, 'Novita'),
(476, 12, 'Nuquí'),
(477, 12, 'Quibdó'),
(478, 12, 'Río Iró'),
(479, 12, 'Río Quito'),
(480, 12, 'Ríosucio'),
(481, 12, 'San José del Palmar'),
(482, 12, 'Santa Genoveva de Docorodó'),
(483, 12, 'Sipí'),
(484, 12, 'Tadó'),
(485, 12, 'Unguía'),
(486, 12, 'Unión Panamericana (ÁNIMAS)'),
(487, 13, 'Ayapel'),
(488, 13, 'Buenavista'),
(489, 13, 'Canalete'),
(490, 13, 'Cereté'),
(491, 13, 'Chimá'),
(492, 13, 'Chinú'),
(493, 13, 'Ciénaga de Oro'),
(494, 13, 'Cotorra'),
(495, 13, 'La Apartada y La Frontera'),
(496, 13, 'Lorica'),
(497, 13, 'Los Córdobas'),
(498, 13, 'Momil'),
(499, 13, 'Montelíbano'),
(500, 13, 'Monteria'),
(501, 13, 'Moñitos'),
(502, 13, 'Planeta Rica'),
(503, 13, 'Pueblo Nuevo'),
(504, 13, 'Puerto Escondido'),
(505, 13, 'Puerto Libertador'),
(506, 13, 'Purísima'),
(507, 13, 'Sahagún'),
(508, 13, 'San Andrés Sotavento'),
(509, 13, 'San Antero'),
(510, 13, 'San Bernardo del Viento'),
(511, 13, 'San Carlos'),
(512, 13, 'San José de Uré'),
(513, 13, 'San Pelayo'),
(514, 13, 'Tierralta'),
(515, 13, 'Tuchín'),
(516, 13, 'Valencia'),
(517, 14, 'Agua de Dios'),
(518, 14, 'Albán'),
(519, 14, 'Anapoima'),
(520, 14, 'Anolaima'),
(521, 14, 'Apulo'),
(522, 14, 'Arbeláez'),
(523, 14, 'Beltrán'),
(524, 14, 'Bituima'),
(525, 14, 'Bogotá D.C.'),
(526, 14, 'Bojacá'),
(527, 14, 'Cabrera'),
(528, 14, 'Cachipay'),
(529, 14, 'Cajicá'),
(530, 14, 'Caparrapí'),
(531, 14, 'Carmen de Carupa'),
(532, 14, 'Chaguaní'),
(533, 14, 'Chipaque'),
(534, 14, 'Choachí'),
(535, 14, 'Chocontá'),
(536, 14, 'Chía'),
(537, 14, 'Cogua'),
(538, 14, 'Cota'),
(539, 14, 'Cucunubá'),
(540, 14, 'Cáqueza'),
(541, 14, 'El Colegio'),
(542, 14, 'El Peñón'),
(543, 14, 'El Rosal'),
(544, 14, 'Facatativá'),
(545, 14, 'Fosca'),
(546, 14, 'Funza'),
(547, 14, 'Fusagasugá'),
(548, 14, 'Fómeque'),
(549, 14, 'Fúquene'),
(550, 14, 'Gachalá'),
(551, 14, 'Gachancipá'),
(552, 14, 'Gachetá'),
(553, 14, 'Gama'),
(554, 14, 'Girardot'),
(555, 14, 'Granada'),
(556, 14, 'Guachetá'),
(557, 14, 'Guaduas'),
(558, 14, 'Guasca'),
(559, 14, 'Guataquí'),
(560, 14, 'Guatavita'),
(561, 14, 'Guayabal de Siquima'),
(562, 14, 'Guayabetal'),
(563, 14, 'Gutiérrez'),
(564, 14, 'Jerusalén'),
(565, 14, 'Junín'),
(566, 14, 'La Calera'),
(567, 14, 'La Mesa'),
(568, 14, 'La Palma'),
(569, 14, 'La Peña'),
(570, 14, 'La Vega'),
(571, 14, 'Lenguazaque'),
(572, 14, 'Machetá'),
(573, 14, 'Madrid'),
(574, 14, 'Manta'),
(575, 14, 'Medina'),
(576, 14, 'Mosquera'),
(577, 14, 'Nariño'),
(578, 14, 'Nemocón'),
(579, 14, 'Nilo'),
(580, 14, 'Nimaima'),
(581, 14, 'Nocaima'),
(582, 14, 'Pacho'),
(583, 14, 'Paime'),
(584, 14, 'Pandi'),
(585, 14, 'Paratebueno'),
(586, 14, 'Pasca'),
(587, 14, 'Puerto Salgar'),
(588, 14, 'Pulí'),
(589, 14, 'Quebradanegra'),
(590, 14, 'Quetame'),
(591, 14, 'Quipile'),
(592, 14, 'Ricaurte'),
(593, 14, 'San Antonio de Tequendama'),
(594, 14, 'San Bernardo'),
(595, 14, 'San Cayetano'),
(596, 14, 'San Francisco'),
(597, 14, 'San Juan de Río Seco'),
(598, 14, 'Sasaima'),
(599, 14, 'Sesquilé'),
(600, 14, 'Sibaté'),
(601, 14, 'Silvania'),
(602, 14, 'Simijaca'),
(603, 14, 'Soacha'),
(604, 14, 'Sopó'),
(605, 14, 'Subachoque'),
(606, 14, 'Suesca'),
(607, 14, 'Supatá'),
(608, 14, 'Susa'),
(609, 14, 'Sutatausa'),
(610, 14, 'Tabio'),
(611, 14, 'Tausa'),
(612, 14, 'Tena'),
(613, 14, 'Tenjo'),
(614, 14, 'Tibacuy'),
(615, 14, 'Tibirita'),
(616, 14, 'Tocaima'),
(617, 14, 'Tocancipá'),
(618, 14, 'Topaipí'),
(619, 14, 'Ubalá'),
(620, 14, 'Ubaque'),
(621, 14, 'Ubaté'),
(622, 14, 'Une'),
(623, 14, 'Venecia (Ospina Pérez)'),
(624, 14, 'Vergara'),
(625, 14, 'Viani'),
(626, 14, 'Villagómez'),
(627, 14, 'Villapinzón'),
(628, 14, 'Villeta'),
(629, 14, 'Viotá'),
(630, 14, 'Yacopí'),
(631, 14, 'Zipacón'),
(632, 14, 'Zipaquirá'),
(633, 14, 'Útica'),
(634, 15, 'Inírida'),
(635, 16, 'Calamar'),
(636, 16, 'El Retorno'),
(637, 16, 'Miraflores'),
(638, 16, 'San José del Guaviare'),
(639, 17, 'Acevedo'),
(640, 17, 'Agrado'),
(641, 17, 'Aipe'),
(642, 17, 'Algeciras'),
(643, 17, 'Altamira'),
(644, 17, 'Baraya'),
(645, 17, 'Campoalegre'),
(646, 17, 'Colombia'),
(647, 17, 'Elías'),
(648, 17, 'Garzón'),
(649, 17, 'Gigante'),
(650, 17, 'Guadalupe'),
(651, 17, 'Hobo'),
(652, 17, 'Isnos'),
(653, 17, 'La Argentina'),
(654, 17, 'La Plata'),
(655, 17, 'Neiva'),
(656, 17, 'Nátaga'),
(657, 17, 'Oporapa'),
(658, 17, 'Paicol'),
(659, 17, 'Palermo'),
(660, 17, 'Palestina'),
(661, 17, 'Pital'),
(662, 17, 'Pitalito'),
(663, 17, 'Rivera'),
(664, 17, 'Saladoblanco'),
(665, 17, 'San Agustín'),
(666, 17, 'Santa María'),
(667, 17, 'Suaza'),
(668, 17, 'Tarqui'),
(669, 17, 'Tello'),
(670, 17, 'Teruel'),
(671, 17, 'Tesalia'),
(672, 17, 'Timaná'),
(673, 17, 'Villavieja'),
(674, 17, 'Yaguará'),
(675, 17, 'Íquira'),
(676, 18, 'Albania'),
(677, 18, 'Barrancas'),
(678, 18, 'Dibulla'),
(679, 18, 'Distracción'),
(680, 18, 'El Molino'),
(681, 18, 'Fonseca'),
(682, 18, 'Hatonuevo'),
(683, 18, 'La Jagua del Pilar'),
(684, 18, 'Maicao'),
(685, 18, 'Manaure'),
(686, 18, 'Riohacha'),
(687, 18, 'San Juan del Cesar'),
(688, 18, 'Uribia'),
(689, 18, 'Urumita'),
(690, 18, 'Villanueva'),
(691, 19, 'Algarrobo'),
(692, 19, 'Aracataca'),
(693, 19, 'Ariguaní (El Difícil)'),
(694, 19, 'Cerro San Antonio'),
(695, 19, 'Chivolo'),
(696, 19, 'Ciénaga'),
(697, 19, 'Concordia'),
(698, 19, 'El Banco'),
(699, 19, 'El Piñon'),
(700, 19, 'El Retén'),
(701, 19, 'Fundación'),
(702, 19, 'Guamal'),
(703, 19, 'Nueva Granada'),
(704, 19, 'Pedraza'),
(705, 19, 'Pijiño'),
(706, 19, 'Pivijay'),
(707, 19, 'Plato'),
(708, 19, 'Puebloviejo'),
(709, 19, 'Remolino'),
(710, 19, 'Sabanas de San Angel (SAN ANGEL)'),
(711, 19, 'Salamina'),
(712, 19, 'San Sebastián de Buenavista'),
(713, 19, 'San Zenón'),
(714, 19, 'Santa Ana'),
(715, 19, 'Santa Bárbara de Pinto'),
(716, 19, 'Santa Marta'),
(717, 19, 'Sitionuevo'),
(718, 19, 'Tenerife'),
(719, 19, 'Zapayán (PUNTA DE PIEDRAS)'),
(720, 19, 'Zona Bananera (PRADO - SEVILLA)'),
(721, 20, 'Acacías'),
(722, 20, 'Barranca de Upía'),
(723, 20, 'Cabuyaro'),
(724, 20, 'Castilla la Nueva'),
(725, 20, 'Cubarral'),
(726, 20, 'Cumaral'),
(727, 20, 'El Calvario'),
(728, 20, 'El Castillo'),
(729, 20, 'El Dorado'),
(730, 20, 'Fuente de Oro'),
(731, 20, 'Granada'),
(732, 20, 'Guamal'),
(733, 20, 'La Macarena'),
(734, 20, 'Lejanías'),
(735, 20, 'Mapiripan'),
(736, 20, 'Mesetas'),
(737, 20, 'Puerto Concordia'),
(738, 20, 'Puerto Gaitán'),
(739, 20, 'Puerto Lleras'),
(740, 20, 'Puerto López'),
(741, 20, 'Puerto Rico'),
(742, 20, 'Restrepo'),
(743, 20, 'San Carlos de Guaroa'),
(744, 20, 'San Juan de Arama'),
(745, 20, 'San Juanito'),
(746, 20, 'San Martín'),
(747, 20, 'Uribe'),
(748, 20, 'Villavicencio'),
(749, 20, 'Vista Hermosa'),
(750, 21, 'Albán (San José)'),
(751, 21, 'Aldana'),
(752, 21, 'Ancuya'),
(753, 21, 'Arboleda (Berruecos)'),
(754, 21, 'Barbacoas'),
(755, 21, 'Belén'),
(756, 21, 'Buesaco'),
(757, 21, 'Chachaguí'),
(758, 21, 'Colón (Génova)'),
(759, 21, 'Consaca'),
(760, 21, 'Contadero'),
(761, 21, 'Cuaspud (Carlosama)'),
(762, 21, 'Cumbal'),
(763, 21, 'Cumbitara'),
(764, 21, 'Córdoba'),
(765, 21, 'El Charco'),
(766, 21, 'El Peñol'),
(767, 21, 'El Rosario'),
(768, 21, 'El Tablón de Gómez'),
(769, 21, 'El Tambo'),
(770, 21, 'Francisco Pizarro'),
(771, 21, 'Funes'),
(772, 21, 'Guachavés'),
(773, 21, 'Guachucal'),
(774, 21, 'Guaitarilla'),
(775, 21, 'Gualmatán'),
(776, 21, 'Iles'),
(777, 21, 'Imúes'),
(778, 21, 'Ipiales'),
(779, 21, 'La Cruz'),
(780, 21, 'La Florida'),
(781, 21, 'La Llanada'),
(782, 21, 'La Tola'),
(783, 21, 'La Unión'),
(784, 21, 'Leiva'),
(785, 21, 'Linares'),
(786, 21, 'Magüi (Payán)'),
(787, 21, 'Mallama (Piedrancha)'),
(788, 21, 'Mosquera'),
(789, 21, 'Nariño'),
(790, 21, 'Olaya Herrera'),
(791, 21, 'Ospina'),
(792, 21, 'Policarpa'),
(793, 21, 'Potosí'),
(794, 21, 'Providencia'),
(795, 21, 'Puerres'),
(796, 21, 'Pupiales'),
(797, 21, 'Ricaurte'),
(798, 21, 'Roberto Payán (San José)'),
(799, 21, 'Samaniego'),
(800, 21, 'San Bernardo'),
(801, 21, 'San Juan de Pasto'),
(802, 21, 'San Lorenzo'),
(803, 21, 'San Pablo'),
(804, 21, 'San Pedro de Cartago'),
(805, 21, 'Sandoná'),
(806, 21, 'Santa Bárbara (Iscuandé)'),
(807, 21, 'Sapuyes'),
(808, 21, 'Sotomayor (Los Andes)'),
(809, 21, 'Taminango'),
(810, 21, 'Tangua'),
(811, 21, 'Tumaco'),
(812, 21, 'Túquerres'),
(813, 21, 'Yacuanquer'),
(814, 22, 'Arboledas'),
(815, 22, 'Bochalema'),
(816, 22, 'Bucarasica'),
(817, 22, 'Chinácota'),
(818, 22, 'Chitagá'),
(819, 22, 'Convención'),
(820, 22, 'Cucutilla'),
(821, 22, 'Cáchira'),
(822, 22, 'Cácota'),
(823, 22, 'Cúcuta'),
(824, 22, 'Durania'),
(825, 22, 'El Carmen'),
(826, 22, 'El Tarra'),
(827, 22, 'El Zulia'),
(828, 22, 'Gramalote'),
(829, 22, 'Hacarí'),
(830, 22, 'Herrán'),
(831, 22, 'La Esperanza'),
(832, 22, 'La Playa'),
(833, 22, 'Labateca'),
(834, 22, 'Los Patios'),
(835, 22, 'Lourdes'),
(836, 22, 'Mutiscua'),
(837, 22, 'Ocaña'),
(838, 22, 'Pamplona'),
(839, 22, 'Pamplonita'),
(840, 22, 'Puerto Santander'),
(841, 22, 'Ragonvalia'),
(842, 22, 'Salazar'),
(843, 22, 'San Calixto'),
(844, 22, 'San Cayetano'),
(845, 22, 'Santiago'),
(846, 22, 'Sardinata'),
(847, 22, 'Silos'),
(848, 22, 'Teorama'),
(849, 22, 'Tibú'),
(850, 22, 'Toledo'),
(851, 22, 'Villa Caro'),
(852, 22, 'Villa del Rosario'),
(853, 22, 'Ábrego'),
(854, 23, 'Colón'),
(855, 23, 'Mocoa'),
(856, 23, 'Orito'),
(857, 23, 'Puerto Asís'),
(858, 23, 'Puerto Caicedo'),
(859, 23, 'Puerto Guzmán'),
(860, 23, 'Puerto Leguízamo'),
(861, 23, 'San Francisco'),
(862, 23, 'San Miguel'),
(863, 23, 'Santiago'),
(864, 23, 'Sibundoy'),
(865, 23, 'Valle del Guamuez'),
(866, 23, 'Villagarzón'),
(867, 24, 'Armenia'),
(868, 24, 'Buenavista'),
(869, 24, 'Calarcá'),
(870, 24, 'Circasia'),
(871, 24, 'Cordobá'),
(872, 24, 'Filandia'),
(873, 24, 'Génova'),
(874, 24, 'La Tebaida'),
(875, 24, 'Montenegro'),
(876, 24, 'Pijao'),
(877, 24, 'Quimbaya'),
(878, 24, 'Salento'),
(879, 25, 'Apía'),
(880, 25, 'Balboa'),
(881, 25, 'Belén de Umbría'),
(882, 25, 'Dos Quebradas'),
(883, 25, 'Guática'),
(884, 25, 'La Celia'),
(885, 25, 'La Virginia'),
(886, 25, 'Marsella'),
(887, 25, 'Mistrató'),
(888, 25, 'Pereira'),
(889, 25, 'Pueblo Rico'),
(890, 25, 'Quinchía'),
(891, 25, 'Santa Rosa de Cabal'),
(892, 25, 'Santuario'),
(893, 26, 'Providencia'),
(894, 27, 'Aguada'),
(895, 27, 'Albania'),
(896, 27, 'Aratoca'),
(897, 27, 'Barbosa'),
(898, 27, 'Barichara'),
(899, 27, 'Barrancabermeja'),
(900, 27, 'Betulia'),
(901, 27, 'Bolívar'),
(902, 27, 'Bucaramanga'),
(903, 27, 'Cabrera'),
(904, 27, 'California'),
(905, 27, 'Capitanejo'),
(906, 27, 'Carcasí'),
(907, 27, 'Cepita'),
(908, 27, 'Cerrito'),
(909, 27, 'Charalá'),
(910, 27, 'Charta'),
(911, 27, 'Chima'),
(912, 27, 'Chipatá'),
(913, 27, 'Cimitarra'),
(914, 27, 'Concepción'),
(915, 27, 'Confines'),
(916, 27, 'Contratación'),
(917, 27, 'Coromoro'),
(918, 27, 'Curití'),
(919, 27, 'El Carmen'),
(920, 27, 'El Guacamayo'),
(921, 27, 'El Peñon'),
(922, 27, 'El Playón'),
(923, 27, 'Encino'),
(924, 27, 'Enciso'),
(925, 27, 'Floridablanca'),
(926, 27, 'Florián'),
(927, 27, 'Galán'),
(928, 27, 'Girón'),
(929, 27, 'Guaca'),
(930, 27, 'Guadalupe'),
(931, 27, 'Guapota'),
(932, 27, 'Guavatá'),
(933, 27, 'Guepsa'),
(934, 27, 'Gámbita'),
(935, 27, 'Hato'),
(936, 27, 'Jesús María'),
(937, 27, 'Jordán'),
(938, 27, 'La Belleza'),
(939, 27, 'La Paz'),
(940, 27, 'Landázuri'),
(941, 27, 'Lebrija'),
(942, 27, 'Los Santos'),
(943, 27, 'Macaravita'),
(944, 27, 'Matanza'),
(945, 27, 'Mogotes'),
(946, 27, 'Molagavita'),
(947, 27, 'Málaga'),
(948, 27, 'Ocamonte'),
(949, 27, 'Oiba'),
(950, 27, 'Onzaga'),
(951, 27, 'Palmar'),
(952, 27, 'Palmas del Socorro'),
(953, 27, 'Pie de Cuesta'),
(954, 27, 'Pinchote'),
(955, 27, 'Puente Nacional'),
(956, 27, 'Puerto Parra'),
(957, 27, 'Puerto Wilches'),
(958, 27, 'Páramo'),
(959, 27, 'Rio Negro'),
(960, 27, 'Sabana de Torres'),
(961, 27, 'San Andrés'),
(962, 27, 'San Benito'),
(963, 27, 'San Gíl'),
(964, 27, 'San Joaquín'),
(965, 27, 'San José de Miranda'),
(966, 27, 'San Miguel'),
(967, 27, 'San Vicente del Chucurí'),
(968, 27, 'Santa Bárbara'),
(969, 27, 'Santa Helena del Opón'),
(970, 27, 'Simacota'),
(971, 27, 'Socorro'),
(972, 27, 'Suaita'),
(973, 27, 'Sucre'),
(974, 27, 'Suratá'),
(975, 27, 'Tona'),
(976, 27, 'Valle de San José'),
(977, 27, 'Vetas'),
(978, 27, 'Villanueva'),
(979, 27, 'Vélez'),
(980, 27, 'Zapatoca'),
(981, 28, 'Buenavista'),
(982, 28, 'Caimito'),
(983, 28, 'Chalán'),
(984, 28, 'Colosó (Ricaurte)'),
(985, 28, 'Corozal'),
(986, 28, 'Coveñas'),
(987, 28, 'El Roble'),
(988, 28, 'Galeras (Nueva Granada)'),
(989, 28, 'Guaranda'),
(990, 28, 'La Unión'),
(991, 28, 'Los Palmitos'),
(992, 28, 'Majagual'),
(993, 28, 'Morroa'),
(994, 28, 'Ovejas'),
(995, 28, 'Palmito'),
(996, 28, 'Sampués'),
(997, 28, 'San Benito Abad'),
(998, 28, 'San Juan de Betulia'),
(999, 28, 'San Marcos'),
(1000, 28, 'San Onofre'),
(1001, 28, 'San Pedro'),
(1002, 28, 'Sincelejo'),
(1003, 28, 'Sincé'),
(1004, 28, 'Sucre'),
(1005, 28, 'Tolú'),
(1006, 28, 'Tolú Viejo'),
(1007, 29, 'Alpujarra'),
(1008, 29, 'Alvarado'),
(1009, 29, 'Ambalema'),
(1010, 29, 'Anzoátegui'),
(1011, 29, 'Armero (Guayabal)'),
(1012, 29, 'Ataco'),
(1013, 29, 'Cajamarca'),
(1014, 29, 'Carmen de Apicalá'),
(1015, 29, 'Casabianca'),
(1016, 29, 'Chaparral'),
(1017, 29, 'Coello'),
(1018, 29, 'Coyaima'),
(1019, 29, 'Cunday'),
(1020, 29, 'Dolores'),
(1021, 29, 'Espinal'),
(1022, 29, 'Falan'),
(1023, 29, 'Flandes'),
(1024, 29, 'Fresno'),
(1025, 29, 'Guamo'),
(1026, 29, 'Herveo'),
(1027, 29, 'Honda'),
(1028, 29, 'Ibagué'),
(1029, 29, 'Icononzo'),
(1030, 29, 'Lérida'),
(1031, 29, 'Líbano'),
(1032, 29, 'Mariquita'),
(1033, 29, 'Melgar'),
(1034, 29, 'Murillo'),
(1035, 29, 'Natagaima'),
(1036, 29, 'Ortega'),
(1037, 29, 'Palocabildo'),
(1038, 29, 'Piedras'),
(1039, 29, 'Planadas'),
(1040, 29, 'Prado'),
(1041, 29, 'Purificación'),
(1042, 29, 'Rioblanco'),
(1043, 29, 'Roncesvalles'),
(1044, 29, 'Rovira'),
(1045, 29, 'Saldaña'),
(1046, 29, 'San Antonio'),
(1047, 29, 'San Luis'),
(1048, 29, 'Santa Isabel'),
(1049, 29, 'Suárez'),
(1050, 29, 'Valle de San Juan'),
(1051, 29, 'Venadillo'),
(1052, 29, 'Villahermosa'),
(1053, 29, 'Villarrica'),
(1054, 30, 'Alcalá'),
(1055, 30, 'Andalucía'),
(1056, 30, 'Ansermanuevo'),
(1057, 30, 'Argelia'),
(1058, 30, 'Bolívar'),
(1059, 30, 'Buenaventura'),
(1060, 30, 'Buga'),
(1061, 30, 'Bugalagrande'),
(1062, 30, 'Caicedonia'),
(1063, 30, 'Calima (Darién)'),
(1064, 30, 'Calí'),
(1065, 30, 'Candelaria'),
(1066, 30, 'Cartago'),
(1067, 30, 'Dagua'),
(1068, 30, 'El Cairo'),
(1069, 30, 'El Cerrito'),
(1070, 30, 'El Dovio'),
(1071, 30, 'El Águila'),
(1072, 30, 'Florida'),
(1073, 30, 'Ginebra'),
(1074, 30, 'Guacarí'),
(1075, 30, 'Jamundí'),
(1076, 30, 'La Cumbre'),
(1077, 30, 'La Unión'),
(1078, 30, 'La Victoria'),
(1079, 30, 'Obando'),
(1080, 30, 'Palmira'),
(1081, 30, 'Pradera'),
(1082, 30, 'Restrepo'),
(1083, 30, 'Riofrío'),
(1084, 30, 'Roldanillo'),
(1085, 30, 'San Pedro'),
(1086, 30, 'Sevilla'),
(1087, 30, 'Toro'),
(1088, 30, 'Trujillo'),
(1089, 30, 'Tulúa'),
(1090, 30, 'Ulloa'),
(1091, 30, 'Versalles'),
(1092, 30, 'Vijes'),
(1093, 30, 'Yotoco'),
(1094, 30, 'Yumbo'),
(1095, 30, 'Zarzal'),
(1096, 31, 'Carurú'),
(1097, 31, 'Mitú'),
(1098, 31, 'Taraira'),
(1099, 32, 'Cumaribo'),
(1100, 32, 'La Primavera'),
(1101, 32, 'Puerto Carreño'),
(1102, 32, 'Santa Rosalía');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblnotificaciones`
--

CREATE TABLE IF NOT EXISTS `tblnotificaciones` (
  `idNotificaciones` int(11) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Descripcion` text COLLATE utf8_bin NOT NULL,
  `tipoNotificacion` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=558 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `tblnotificaciones`
--

INSERT INTO `tblnotificaciones` (`idNotificaciones`, `Fecha`, `Descripcion`, `tipoNotificacion`, `idSolicitud`) VALUES
(191, '2017-03-08 16:20:34', 'Se ha registrado una nueva solicitud', 0, 82),
(192, '2017-03-08 16:22:31', 'andres osorio ha sido asignado(a) a la solicitud N° 82', 1, 82),
(193, '2017-03-08 16:45:19', 'andres osorio diligenció la ficha de la solicitud N° 82', 5, 82),
(194, '2017-03-08 16:47:44', 'Administrador Administrador finalizó la solicitud N° 82', 6, 82),
(195, '2017-03-08 16:49:20', 'Se ha registrado una nueva solicitud', 0, 83),
(196, '2017-03-08 16:50:13', 'andres osorio ha sido asignado(a) a la solicitud N° 83', 1, 83),
(197, '2017-03-08 16:51:59', 'andres osorio diligenció la ficha de la solicitud N° 83', 5, 83),
(198, '2017-03-08 16:52:21', 'Administrador Administrador finalizó la solicitud N° 83', 6, 83),
(199, '2017-03-08 18:45:12', 'Se ha registrado una nueva solicitud', 0, 84),
(200, '2017-03-08 18:48:00', 'Se ha registrado una nueva solicitud', 0, 85),
(201, '2017-03-08 18:48:45', 'andres gallo ha sido asignado(a) a la solicitud N° 85', 1, 85),
(202, '2017-03-08 19:01:25', 'luis angarita ha sido asignado(a) a la solicitud N° 84', 1, 84),
(203, '2017-03-08 19:01:26', 'juan david vahos ha sido asignado(a) a la solicitud N° 84', 1, 84),
(204, '2017-03-08 19:15:12', 'luis angarita diligenció la ficha de la solicitud N° 84', 5, 84),
(205, '2017-03-08 19:17:13', 'Javier Mallama finalizó la solicitud N° 84', 6, 84),
(206, '2017-03-08 19:24:35', 'Se ha registrado una nueva solicitud', 0, 86),
(207, '2017-03-08 19:31:40', 'luis gonzales ha sido asignado(a) a la solicitud N° 86', 1, 86),
(208, '2017-03-08 19:31:41', 'juan  bedoya ha sido asignado(a) a la solicitud N° 86', 1, 86),
(209, '2017-03-08 19:36:48', 'juan  bedoya diligenció la ficha de la solicitud N° 86', 5, 86),
(210, '2017-03-08 19:37:53', 'anderson molsalve finalizó la solicitud N° 86', 6, 86),
(211, '2017-03-08 20:48:20', 'Se ha registrado una nueva solicitud', 0, 87),
(212, '2017-03-08 20:50:59', 'juan  bedoya ha sido asignado(a) a la solicitud N° 87', 1, 87),
(213, '2017-03-09 12:14:21', 'Se ha registrado una nueva solicitud', 0, 88),
(214, '2017-03-09 16:13:28', 'Se ha registrado una nueva solicitud', 0, 89),
(215, '2017-03-09 17:59:11', 'Se ha registrado una nueva solicitud', 0, 90),
(216, '2017-03-10 12:25:44', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 88', 1, 88),
(217, '2017-03-10 12:48:21', 'Mantenimiento - Luis Angarita ha sido asignado(a) a la solicitud N° 90', 1, 90),
(218, '2017-03-10 13:03:39', 'Mantenimiento - Luis Angarita diligenció la ficha de la solicitud N° 90', 5, 90),
(219, '2017-03-10 13:09:28', 'Se ha registrado una nueva solicitud', 0, 91),
(220, '2017-03-10 18:34:27', 'Se ha registrado una nueva solicitud', 0, 92),
(221, '2017-03-10 20:47:54', 'AA - Juan Valencia ha sido asignado(a) a la solicitud N° 89', 1, 89),
(222, '2017-03-10 22:18:26', 'Electricidad - Luis Gonzales ha sido asignado(a) a la solicitud N° 92', 1, 92),
(223, '2017-03-10 22:18:26', 'Electricidad - Juan  Bedoya ha sido asignado(a) a la solicitud N° 92', 1, 92),
(224, '2017-03-13 12:06:07', 'Se ha registrado una nueva solicitud', 0, 93),
(225, '2017-03-13 12:14:29', 'Mantenimiento - Luis Angarita ha sido asignado(a) a la solicitud N° 93', 1, 93),
(226, '2017-03-13 12:50:52', 'Se ha registrado una nueva solicitud', 0, 94),
(227, '2017-03-13 14:22:56', 'Se ha registrado una nueva solicitud', 0, 95),
(228, '2017-03-13 14:24:16', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 95', 1, 95),
(229, '2017-03-13 14:39:07', 'Mantenimiento - Luis Angarita ha sido asignado(a) a la solicitud N° 94', 1, 94),
(230, '2017-03-13 15:07:42', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 88', 5, 88),
(231, '2017-03-13 15:10:18', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 88', 6, 88),
(232, '2017-03-13 15:10:20', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 88', 6, 88),
(233, '2017-03-13 15:12:33', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 91', 1, 91),
(234, '2017-03-13 15:18:49', 'Se ha registrado una nueva solicitud', 0, 96),
(235, '2017-03-13 15:39:08', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 96', 1, 96),
(236, '2017-03-13 16:32:13', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 96', 5, 96),
(237, '2017-03-13 16:34:31', 'Se ha registrado una nueva solicitud', 0, 97),
(238, '2017-03-13 16:40:02', 'Se ha registrado una nueva solicitud', 0, 98),
(239, '2017-03-14 11:20:05', 'Se ha registrado una nueva solicitud', 0, 99),
(240, '2017-03-14 13:39:24', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 99', 1, 99),
(241, '2017-03-14 13:40:01', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 98', 1, 98),
(242, '2017-03-14 13:40:35', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 97', 1, 97),
(243, '2017-03-14 15:40:51', 'Se ha registrado una nueva solicitud', 0, 100),
(244, '2017-03-14 16:24:07', 'Se ha registrado una nueva solicitud', 0, 101),
(245, '2017-03-14 16:25:07', 'Se ha registrado una nueva solicitud', 0, 102),
(246, '2017-03-14 16:26:29', 'Se ha registrado una nueva solicitud', 0, 103),
(247, '2017-03-14 16:30:18', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 99', 5, 99),
(248, '2017-03-14 16:34:28', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 97', 5, 97),
(249, '2017-03-14 16:39:35', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 98', 5, 98),
(250, '2017-03-14 16:48:47', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 103', 1, 103),
(251, '2017-03-14 16:49:41', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 102', 1, 102),
(252, '2017-03-14 16:51:08', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 100', 1, 100),
(253, '2017-03-14 16:57:45', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 102', 5, 102),
(254, '2017-03-14 18:52:40', 'AA - Juan Valencia ha sido asignado(a) a la solicitud N° 101', 1, 101),
(255, '2017-03-14 19:05:30', 'Logistica - Ing. David Mejía finalizó la solicitud N° 102', 6, 102),
(256, '2017-03-14 19:05:32', 'Logistica - Ing. David Mejía finalizó la solicitud N° 102', 6, 102),
(257, '2017-03-14 20:52:43', 'Se ha registrado una nueva solicitud', 0, 104),
(258, '2017-03-14 21:40:09', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 104', 1, 104),
(259, '2017-03-15 15:19:18', 'Se ha registrado una nueva solicitud', 0, 105),
(260, '2017-03-15 15:21:18', 'Se ha registrado una nueva solicitud', 0, 106),
(261, '2017-03-15 15:24:17', 'Se ha registrado una nueva solicitud', 0, 107),
(262, '2017-03-15 15:55:26', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 104', 5, 104),
(263, '2017-03-15 20:26:13', 'Se ha registrado una nueva solicitud', 0, 108),
(264, '2017-03-15 21:38:01', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 104', 6, 104),
(265, '2017-03-16 10:14:16', 'Se ha registrado una nueva solicitud', 0, 109),
(266, '2017-03-16 10:16:09', 'Se ha registrado una nueva solicitud', 0, 110),
(267, '2017-03-16 10:18:01', 'Se ha registrado una nueva solicitud', 0, 111),
(268, '2017-03-16 10:22:21', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 100', 5, 100),
(269, '2017-03-16 12:45:45', 'Se ha registrado una nueva solicitud', 0, 112),
(270, '2017-03-16 12:47:22', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 112', 1, 112),
(271, '2017-03-16 12:47:56', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 110', 1, 110),
(272, '2017-03-16 12:48:39', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 109', 1, 109),
(273, '2017-03-16 14:15:57', 'Se ha registrado una nueva solicitud', 0, 113),
(274, '2017-03-16 14:17:54', 'Se ha registrado una nueva solicitud', 0, 114),
(275, '2017-03-16 14:22:12', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 110', 5, 110),
(276, '2017-03-16 14:25:10', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 109', 5, 109),
(277, '2017-03-16 14:59:11', 'Se ha registrado una nueva solicitud', 0, 115),
(278, '2017-03-16 15:00:17', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 114', 1, 114),
(279, '2017-03-16 15:01:48', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 113', 1, 113),
(280, '2017-03-16 15:10:32', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 115', 1, 115),
(281, '2017-03-16 15:42:39', 'Se ha registrado una nueva solicitud', 0, 116),
(282, '2017-03-16 15:43:44', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 116', 1, 116),
(283, '2017-03-16 18:41:40', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 88', 6, 88),
(284, '2017-03-16 18:41:56', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 110', 6, 110),
(285, '2017-03-16 18:42:09', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 109', 6, 109),
(286, '2017-03-16 18:42:22', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 98', 6, 98),
(287, '2017-03-16 18:42:45', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 97', 6, 97),
(288, '2017-03-16 18:43:08', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 99', 6, 99),
(289, '2017-03-16 18:43:21', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 96', 6, 96),
(290, '2017-03-16 22:15:44', 'Se ha registrado una nueva solicitud', 0, 117),
(291, '2017-03-16 22:16:59', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 117', 1, 117),
(292, '2017-03-17 10:16:28', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 114', 5, 114),
(293, '2017-03-17 10:19:42', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 113', 5, 113),
(294, '2017-03-17 11:14:57', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 95', 5, 95),
(295, '2017-03-17 11:36:29', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 117', 5, 117),
(296, '2017-03-17 12:15:12', 'Se ha registrado una nueva solicitud', 0, 118),
(297, '2017-03-17 13:14:05', 'Se ha registrado una nueva solicitud', 0, 119),
(298, '2017-03-17 13:25:00', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 117', 6, 117),
(299, '2017-03-17 13:25:06', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 117', 6, 117),
(300, '2017-03-17 13:37:08', 'Se ha registrado una nueva solicitud', 0, 120),
(301, '2017-03-17 15:36:34', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 118', 1, 118),
(302, '2017-03-17 15:36:34', 'Electricidad - Luis Gonzales ha sido asignado(a) a la solicitud N° 118', 1, 118),
(303, '2017-03-17 15:36:34', 'Electricidad - Juan  Bedoya ha sido asignado(a) a la solicitud N° 118', 1, 118),
(304, '2017-03-17 15:43:31', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 120', 1, 120),
(305, '2017-03-17 15:43:58', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 114', 6, 114),
(306, '2017-03-17 15:43:58', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 114', 6, 114),
(307, '2017-03-17 15:44:18', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 113', 6, 113),
(308, '2017-03-17 16:06:51', 'Se ha registrado una nueva solicitud', 0, 121),
(309, '2017-03-17 16:40:58', 'Se ha registrado una nueva solicitud', 0, 122),
(310, '2017-03-17 16:41:52', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 122', 1, 122),
(311, '2017-03-17 16:42:33', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 119', 1, 119),
(312, '2017-03-17 16:43:00', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 108', 1, 108),
(313, '2017-03-17 17:06:39', 'Se ha registrado una nueva solicitud', 0, 123),
(314, '2017-03-17 17:07:30', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 123', 1, 123),
(315, '2017-03-17 17:07:30', 'Electricidad - Luis Gonzales ha sido asignado(a) a la solicitud N° 123', 1, 123),
(316, '2017-03-17 17:07:31', 'Electricidad - Juan  Bedoya ha sido asignado(a) a la solicitud N° 123', 1, 123),
(317, '2017-03-17 18:59:56', 'Se ha registrado una nueva solicitud', 0, 124),
(318, '2017-03-17 19:01:13', 'Se ha registrado una nueva solicitud', 0, 125),
(319, '2017-03-17 19:02:41', 'AA - Juan Valencia ha sido asignado(a) a la solicitud N° 125', 1, 125),
(320, '2017-03-17 19:02:41', 'AA - Ivan  Rojas ha sido asignado(a) a la solicitud N° 125', 1, 125),
(321, '2017-03-17 19:03:06', 'AA - Juan Valencia ha sido asignado(a) a la solicitud N° 124', 1, 124),
(322, '2017-03-17 19:03:06', 'AA - Ivan  Rojas ha sido asignado(a) a la solicitud N° 124', 1, 124),
(323, '2017-03-17 19:33:18', 'Se ha registrado una nueva solicitud', 0, 126),
(324, '2017-03-17 19:34:05', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 126', 1, 126),
(325, '2017-03-21 10:18:50', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 119', 5, 119),
(326, '2017-03-21 11:50:12', 'Se ha registrado una nueva solicitud', 0, 127),
(327, '2017-03-21 12:29:21', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 96', 6, 96),
(328, '2017-03-21 12:31:24', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 119', 6, 119),
(329, '2017-03-21 12:32:15', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 127', 1, 127),
(330, '2017-03-21 12:36:18', 'Se ha registrado una nueva solicitud', 0, 128),
(331, '2017-03-21 13:30:50', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 127', 5, 127),
(332, '2017-03-21 14:02:36', 'Se ha registrado una nueva solicitud', 0, 129),
(333, '2017-03-21 16:22:41', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 128', 1, 128),
(334, '2017-03-21 16:23:33', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 121', 1, 121),
(335, '2017-03-21 16:24:15', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 95', 6, 95),
(336, '2017-03-21 16:24:17', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 95', 6, 95),
(337, '2017-03-21 16:24:34', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 127', 6, 127),
(338, '2017-03-21 16:26:12', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 129', 1, 129),
(339, '2017-03-21 16:26:13', 'Electricidad - Juan  Bedoya ha sido asignado(a) a la solicitud N° 129', 1, 129),
(340, '2017-03-21 16:26:54', 'Mantenimiento - Carlos Henao ha sido asignado(a) a la solicitud N° 111', 1, 111),
(341, '2017-03-21 16:26:55', 'Electricidad - Juan  Bedoya ha sido asignado(a) a la solicitud N° 111', 1, 111),
(342, '2017-03-21 17:15:49', 'Mantenimiento - Luis Angarita ha sido asignado(a) a la solicitud N° 106', 1, 106),
(343, '2017-03-21 17:16:22', 'Mantenimiento - Luis Angarita ha sido asignado(a) a la solicitud N° 107', 1, 107),
(344, '2017-03-21 17:17:06', 'Electricidad - Luis Gonzales ha sido asignado(a) a la solicitud N° 105', 1, 105),
(345, '2017-03-21 17:17:06', 'Electricidad - Juan  Bedoya ha sido asignado(a) a la solicitud N° 105', 1, 105),
(346, '2017-03-22 10:12:58', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 128', 5, 128),
(347, '2017-03-22 10:57:26', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 111', 5, 111),
(348, '2017-03-22 10:59:41', 'Mantenimiento - Carlos Henao diligenció la ficha de la solicitud N° 123', 5, 123),
(349, '2017-03-22 11:05:09', 'Se ha registrado una nueva solicitud', 0, 130),
(350, '2017-03-22 11:57:32', 'Se ha registrado una nueva solicitud', 0, 131),
(351, '2017-03-22 12:15:16', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 116', 5, 116),
(352, '2017-03-22 12:16:03', 'Logistica - Ing. David Mejía finalizó la solicitud N° 116', 6, 116),
(353, '2017-03-22 12:16:03', 'Logistica - Ing. David Mejía finalizó la solicitud N° 116', 6, 116),
(354, '2017-03-22 12:16:21', 'Se ha registrado una nueva solicitud', 0, 132),
(355, '2017-03-22 12:16:31', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 103', 5, 103),
(356, '2017-03-22 12:18:26', 'Logistica - Ing. David Mejía finalizó la solicitud N° 103', 6, 103),
(357, '2017-03-22 12:18:26', 'Logistica - Ing. David Mejía finalizó la solicitud N° 103', 6, 103),
(358, '2017-03-22 12:21:01', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 115', 5, 115),
(359, '2017-03-22 12:22:25', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 126', 5, 126),
(360, '2017-03-22 12:24:09', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 122', 5, 122),
(361, '2017-03-22 12:26:28', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 120', 5, 120),
(362, '2017-03-22 13:16:07', 'Se ha registrado una nueva solicitud', 0, 133),
(363, '2017-03-22 14:30:52', 'Se ha registrado una nueva solicitud', 0, 134),
(364, '2017-03-22 14:39:31', 'Se ha registrado una nueva solicitud', 0, 135),
(365, '2017-03-22 14:43:28', 'Se ha registrado una nueva solicitud', 0, 136),
(366, '2017-03-22 14:52:34', 'Se ha registrado una nueva solicitud', 0, 137),
(367, '2017-03-22 14:55:27', 'Se ha registrado una nueva solicitud', 0, 138),
(368, '2017-03-22 15:00:30', ' Carlos Henao ha sido asignado(a) a la solicitud N° 130', 1, 130),
(369, '2017-03-22 15:09:02', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 123', 6, 123),
(370, '2017-03-22 15:10:09', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 126', 6, 126),
(371, '2017-03-22 15:10:22', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 122', 6, 122),
(372, '2017-03-22 15:10:39', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 120', 6, 120),
(373, '2017-03-22 15:10:52', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 115', 6, 115),
(374, '2017-03-22 15:11:05', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 128', 6, 128),
(375, '2017-03-22 15:14:50', 'Se ha registrado una nueva solicitud', 0, 139),
(376, '2017-03-22 15:15:57', 'Se ha registrado una nueva solicitud', 0, 140),
(377, '2017-03-22 15:26:50', 'Se ha registrado una nueva solicitud', 0, 141),
(378, '2017-03-22 15:28:58', 'Se ha registrado una nueva solicitud', 0, 142),
(379, '2017-03-22 15:30:03', 'Se ha registrado una nueva solicitud', 0, 143),
(380, '2017-03-22 15:32:27', 'Se ha registrado una nueva solicitud', 0, 144),
(381, '2017-03-22 15:33:45', 'Se ha registrado una nueva solicitud', 0, 145),
(382, '2017-03-22 15:36:08', 'Se ha registrado una nueva solicitud', 0, 146),
(383, '2017-03-22 15:38:00', 'Se ha registrado una nueva solicitud', 0, 147),
(384, '2017-03-22 15:39:42', 'Se ha registrado una nueva solicitud', 0, 148),
(385, '2017-03-22 15:46:47', 'Se ha registrado una nueva solicitud', 0, 149),
(386, '2017-03-22 15:47:46', 'Se ha registrado una nueva solicitud', 0, 150),
(387, '2017-03-22 15:49:33', 'Se ha registrado una nueva solicitud', 0, 151),
(388, '2017-03-22 15:53:45', 'Se ha registrado una nueva solicitud', 0, 152),
(389, '2017-03-22 15:58:35', 'Se ha registrado una nueva solicitud', 0, 153),
(390, '2017-03-22 16:01:19', 'Se ha registrado una nueva solicitud', 0, 154),
(391, '2017-03-22 16:03:51', 'Se ha registrado una nueva solicitud', 0, 155),
(392, '2017-03-22 16:07:46', 'Se ha registrado una nueva solicitud', 0, 156),
(393, '2017-03-22 19:32:56', 'Mantenimiento - Luis Angarita ha sido asignado(a) a la solicitud N° 131', 1, 131),
(394, '2017-03-22 19:34:49', 'Mantenimiento - Luis Angarita ha sido asignado(a) a la solicitud N° 132', 1, 132),
(395, '2017-03-22 19:36:14', 'Mantenimiento - Luis Angarita ha sido asignado(a) a la solicitud N° 133', 1, 133),
(396, '2017-03-22 19:36:56', 'Infraestructura - Ing. Anderson Molsalve finalizó la solicitud N° 90', 6, 90),
(397, '2017-03-22 20:07:23', 'Se ha registrado una nueva solicitud', 0, 157),
(398, '2017-03-23 12:29:00', 'Se ha registrado una nueva solicitud', 0, 158),
(399, '2017-03-23 12:31:27', 'Se ha registrado una nueva solicitud', 0, 159),
(400, '2017-03-23 13:30:43', 'victor hugo ha sido asignado(a) a la solicitud N° 157', 1, 157),
(401, '2017-03-23 13:32:16', 'victor hugo ha sido asignado(a) a la solicitud N° 134', 1, 134),
(402, '2017-03-23 13:33:12', 'victor hugo ha sido asignado(a) a la solicitud N° 135', 1, 135),
(403, '2017-03-23 13:33:43', 'victor hugo ha sido asignado(a) a la solicitud N° 136', 1, 136),
(404, '2017-03-23 13:34:15', 'victor hugo ha sido asignado(a) a la solicitud N° 137', 1, 137),
(405, '2017-03-23 13:34:31', 'victor hugo ha sido asignado(a) a la solicitud N° 138', 1, 138),
(406, '2017-03-23 13:35:19', 'victor hugo ha sido asignado(a) a la solicitud N° 141', 1, 141),
(407, '2017-03-23 13:35:40', 'victor hugo ha sido asignado(a) a la solicitud N° 142', 1, 142),
(408, '2017-03-23 13:36:04', 'victor hugo ha sido asignado(a) a la solicitud N° 143', 1, 143),
(409, '2017-03-23 13:36:22', 'victor hugo ha sido asignado(a) a la solicitud N° 144', 1, 144),
(410, '2017-03-23 13:36:38', 'victor hugo ha sido asignado(a) a la solicitud N° 145', 1, 145),
(411, '2017-03-23 13:36:58', 'victor hugo ha sido asignado(a) a la solicitud N° 146', 1, 146),
(412, '2017-03-23 13:42:53', 'victor hugo ha sido asignado(a) a la solicitud N° 147', 1, 147),
(413, '2017-03-23 13:43:27', 'victor hugo ha sido asignado(a) a la solicitud N° 148', 1, 148),
(414, '2017-03-23 13:43:56', 'victor hugo ha sido asignado(a) a la solicitud N° 149', 1, 149),
(415, '2017-03-23 13:44:45', 'victor hugo ha sido asignado(a) a la solicitud N° 150', 1, 150),
(416, '2017-03-23 13:45:48', 'victor hugo ha sido asignado(a) a la solicitud N° 151', 1, 151),
(417, '2017-03-23 13:46:09', 'victor hugo ha sido asignado(a) a la solicitud N° 152', 1, 152),
(418, '2017-03-23 13:46:31', 'victor hugo ha sido asignado(a) a la solicitud N° 153', 1, 153),
(419, '2017-03-23 13:47:03', 'victor hugo ha sido asignado(a) a la solicitud N° 154', 1, 154),
(420, '2017-03-23 13:47:29', 'victor hugo ha sido asignado(a) a la solicitud N° 155', 1, 155),
(421, '2017-03-23 13:47:58', 'victor hugo ha sido asignado(a) a la solicitud N° 156', 1, 156),
(422, '2017-03-23 15:01:02', ' Carlos Henao ha sido asignado(a) a la solicitud N° 159', 1, 159),
(423, '2017-03-23 15:01:27', ' Carlos Henao ha sido asignado(a) a la solicitud N° 158', 1, 158),
(424, '2017-03-23 15:02:03', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 140', 1, 140),
(425, '2017-03-23 15:43:17', 'Se ha registrado una nueva solicitud', 0, 160),
(426, '2017-03-23 15:46:50', 'Se ha registrado una nueva solicitud', 0, 161),
(427, '2017-03-23 15:51:54', 'Se ha registrado una nueva solicitud', 0, 162),
(428, '2017-03-23 17:48:03', 'Se ha registrado una nueva solicitud', 0, 163),
(429, '2017-03-23 18:19:26', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 140', 5, 140),
(430, '2017-03-23 18:45:31', 'Se ha registrado una nueva solicitud', 0, 164),
(431, '2017-03-23 18:52:17', 'Se ha registrado una nueva solicitud', 0, 165),
(432, '2017-03-23 18:57:00', 'Se ha registrado una nueva solicitud', 0, 166),
(433, '2017-03-23 20:51:42', 'Se ha registrado una nueva solicitud', 0, 167),
(434, '2017-03-24 15:12:26', ' Carlos Henao ha sido asignado(a) a la solicitud N° 167', 1, 167),
(435, '2017-03-24 15:13:16', ' Carlos Henao ha sido asignado(a) a la solicitud N° 163', 1, 163),
(436, '2017-03-24 16:07:21', 'Se ha registrado una nueva solicitud', 0, 168),
(437, '2017-03-25 10:07:41', 'Se ha registrado una nueva solicitud', 0, 169),
(438, '2017-03-25 10:10:37', 'Se ha registrado una nueva solicitud', 0, 170),
(439, '2017-03-25 10:12:52', ' Carlos Henao diligenció la ficha de la solicitud N° 159', 5, 159),
(440, '2017-03-25 10:14:17', ' Carlos Henao diligenció la ficha de la solicitud N° 158', 5, 158),
(441, '2017-03-25 10:16:58', ' Carlos Henao diligenció la ficha de la solicitud N° 130', 5, 130),
(442, '2017-03-27 12:19:18', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 159', 6, 159),
(443, '2017-03-27 12:19:40', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 158', 6, 158),
(444, '2017-03-27 12:19:55', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 158', 6, 158),
(445, '2017-03-27 12:20:07', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 140', 6, 140),
(446, '2017-03-27 12:20:17', 'Infraestructura - Efrain  Torres finalizó la solicitud N° 130', 6, 130),
(447, '2017-03-27 12:20:46', ' Carlos Henao ha sido asignado(a) a la solicitud N° 170', 1, 170),
(448, '2017-03-27 12:21:21', ' Carlos Henao ha sido asignado(a) a la solicitud N° 169', 1, 169),
(449, '2017-03-27 12:36:00', 'SEISO Paola Londoño diligenció la ficha de la solicitud N° 121', 5, 121),
(450, '2017-03-27 14:44:07', ' Carlos Henao diligenció la ficha de la solicitud N° 167', 5, 167),
(451, '2017-03-27 14:46:29', ' Carlos Henao diligenció la ficha de la solicitud N° 129', 5, 129),
(452, '2017-03-27 14:48:39', ' Carlos Henao diligenció la ficha de la solicitud N° 108', 5, 108),
(453, '2017-03-27 14:51:12', ' Carlos Henao diligenció la ficha de la solicitud N° 118', 5, 118),
(454, '2017-03-27 14:53:24', ' Carlos Henao diligenció la ficha de la solicitud N° 170', 5, 170),
(455, '2017-03-27 14:55:09', ' Carlos Henao diligenció la ficha de la solicitud N° 169', 5, 169),
(456, '2017-03-27 14:58:15', ' Carlos Henao diligenció la ficha de la solicitud N° 163', 5, 163),
(457, '2017-03-27 15:02:27', 'Se ha registrado una nueva solicitud', 0, 171),
(458, '2017-03-27 16:55:40', 'Se ha registrado una nueva solicitud', 0, 172),
(459, '2017-03-27 16:56:54', 'Se ha registrado una nueva solicitud', 0, 173),
(460, '2017-03-27 16:59:20', 'Se ha registrado una nueva solicitud', 0, 174),
(461, '2017-03-27 17:01:40', 'Se ha registrado una nueva solicitud', 0, 175),
(462, '2017-03-27 17:03:55', 'Se ha registrado una nueva solicitud', 0, 176),
(463, '2017-03-27 17:05:37', 'Se ha registrado una nueva solicitud', 0, 177),
(464, '2017-03-27 19:44:29', 'Se ha registrado una nueva solicitud', 0, 178),
(465, '2017-03-27 19:45:55', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 178', 1, 178),
(466, '2017-03-27 20:12:19', 'Se ha registrado una nueva solicitud', 0, 179),
(467, '2017-03-27 20:16:36', 'SEISO Paola Londoño ha sido asignado(a) a la solicitud N° 179', 1, 179),
(468, '2017-03-28 11:28:29', 'Se ha registrado una nueva solicitud', 0, 180),
(469, '2017-03-28 12:08:16', ' Carlos Henao diligenció la ficha de la solicitud N° 112', 5, 112),
(470, '2017-03-28 16:01:28', 'Se ha registrado una nueva solicitud', 0, 181),
(471, '2017-03-30 14:55:27', 'Se ha registrado una nueva solicitud', 0, 188),
(472, '2017-03-30 15:09:03', 'Se ha registrado una nueva solicitud', 0, 189),
(473, '2017-04-07 18:21:52', 'Se ha registrado una nueva solicitud', 0, 190),
(474, '2017-04-17 15:44:47', 'Se ha registrado una nueva solicitud', 0, 191),
(475, '2017-04-17 16:12:40', 'Se ha registrado una nueva solicitud', 0, 192),
(476, '2017-04-17 16:20:04', 'victor hugo ha sido asignado(a) a la solicitud N° 191', 1, 191),
(477, '2017-04-17 16:26:16', 'victor hugo diligenció la ficha de la solicitud N° 191', 5, 191),
(478, '2017-04-18 12:24:08', 'victor hugo ha sido asignado(a) a la solicitud N° 192', 1, 192),
(479, '2017-04-18 12:26:45', 'victor hugo diligenció la ficha de la solicitud N° 192', 5, 192),
(480, '2017-04-24 12:44:38', 'Se ha registrado una nueva solicitud', 0, 193),
(481, '2017-04-24 12:50:25', 'victor hugo ha sido asignado(a) a la solicitud N° 193', 1, 193),
(482, '2017-04-24 12:54:15', 'victor hugo diligenció la ficha de la solicitud N° 193', 5, 193),
(483, '2017-05-12 16:05:31', 'Carlos  Henao ha sido asignado(a) a la solicitud N° 186', 1, 186),
(484, '2017-05-12 16:07:19', 'Juan Valencia ha sido asignado(a) a la solicitud N° 180', 1, 180),
(485, '2017-05-12 16:46:54', 'Luis Angarita ha sido asignado(a) a la solicitud N° 177', 1, 177),
(486, '2017-06-02 19:36:35', 'Se ha registrado una nueva solicitud', 0, 194),
(487, '2017-06-02 19:38:12', 'victor hugo ha sido asignado(a) a la solicitud N° 194', 1, 194),
(488, '2017-06-02 19:43:48', 'Se ha registrado una nueva solicitud', 0, 195),
(489, '2017-06-02 19:44:34', 'victor hugo ha sido asignado(a) a la solicitud N° 195', 1, 195),
(490, '2017-06-02 19:48:42', 'Se ha registrado una nueva solicitud', 0, 196),
(491, '2017-06-02 19:49:33', 'victor hugo ha sido asignado(a) a la solicitud N° 196', 1, 196),
(492, '2017-06-02 19:51:15', 'victor hugo diligenció la ficha de la solicitud N° 196', 5, 196),
(493, '2017-06-02 19:51:51', 'Administrador Administrador finalizó la solicitud N° 196', 6, 196),
(494, '2017-06-15 18:55:02', 'Se ha registrado una nueva solicitud', 0, 197),
(495, '2017-06-15 18:57:53', 'victor hugo ha sido asignado(a) a la solicitud N° 197', 1, 197),
(496, '2017-06-20 15:54:11', 'victor hugo ha sido asignado(a) a la solicitud N° 174', 1, 174),
(497, '2017-06-20 15:58:07', 'Carlos  Henao ha sido asignado(a) a la solicitud N° 190', 1, 190),
(498, '2017-07-06 16:47:26', 'Se ha registrado una nueva solicitud', 0, 198),
(499, '2017-07-06 16:48:35', 'Se ha registrado una nueva solicitud', 0, 199),
(500, '2017-07-06 16:54:02', 'Se ha registrado una nueva solicitud', 0, 200),
(501, '2017-07-13 15:33:55', 'Se ha registrado una nueva solicitud', 0, 201),
(502, '2017-07-13 15:37:03', 'victor hugo ha sido asignado(a) a la solicitud N° 201', 1, 201),
(503, '2017-07-13 15:45:12', 'victor hugo diligenció la ficha de la solicitud N° 201', 5, 201),
(504, '2017-07-13 15:47:08', 'Administrador Administrador finalizó la solicitud N° 201', 6, 201),
(505, '2017-07-28 15:52:01', 'Se ha registrado una nueva solicitud', 0, 202),
(506, '2017-07-28 15:53:20', 'victor hugo ha sido asignado(a) a la solicitud N° 202', 1, 202),
(507, '2017-07-28 15:56:24', 'victor hugo diligenció la ficha de la solicitud N° 202', 5, 202),
(508, '2017-07-28 15:57:07', 'Administrador Administrador finalizó la solicitud N° 202', 6, 202),
(509, '2017-07-28 16:02:09', 'Se ha registrado una nueva solicitud', 0, 203),
(510, '2017-07-28 16:03:39', 'victor hugo ha sido asignado(a) a la solicitud N° 203', 1, 203),
(511, '2017-07-28 16:05:55', 'victor hugo diligenció la ficha de la solicitud N° 203', 5, 203),
(512, '2017-07-28 16:07:39', 'Administrador Administrador finalizó la solicitud N° 203', 6, 203),
(513, '2017-08-10 16:34:06', 'Se ha registrado una nueva solicitud', 0, 204),
(514, '2017-08-11 14:00:39', 'victor hugo ha sido asignado(a) a la solicitud N° 204', 1, 204),
(515, '2017-08-11 14:04:49', 'victor hugo diligenció la ficha de la solicitud N° 204', 5, 204),
(516, '2017-08-11 14:05:20', 'Administrador Administrador finalizó la solicitud N° 204', 6, 204),
(517, '2017-08-11 16:19:56', 'Se ha registrado una nueva solicitud', 0, 205),
(518, '2017-08-11 16:20:30', 'victor hugo ha sido asignado(a) a la solicitud N° 200', 1, 200),
(519, '2017-08-11 17:07:10', 'Se ha registrado una nueva solicitud', 0, 206),
(520, '2017-08-14 14:01:59', 'Se ha registrado una nueva solicitud', 0, 207),
(521, '2017-08-14 19:05:47', 'Se ha registrado una nueva solicitud', 0, 208),
(522, '2017-08-14 19:07:55', 'Se ha registrado una nueva solicitud', 0, 209),
(523, '2017-08-14 19:13:37', 'Se ha registrado una nueva solicitud', 0, 210),
(524, '2017-08-14 19:17:11', 'Se ha registrado una nueva solicitud', 0, 211),
(525, '2017-08-14 19:22:04', 'Se ha registrado una nueva solicitud', 0, 212),
(526, '2017-08-14 19:22:31', 'Se ha registrado una nueva solicitud', 0, 213),
(527, '2017-08-14 19:59:49', 'Se ha registrado una nueva solicitud', 0, 214),
(528, '2017-08-14 20:02:44', 'Se ha registrado una nueva solicitud', 0, 215),
(529, '2017-08-15 12:45:57', 'Se ha registrado una nueva solicitud', 0, 216),
(530, '2017-08-15 12:48:07', 'Se ha registrado una nueva solicitud', 0, 217),
(531, '2017-08-15 12:50:54', 'Se ha registrado una nueva solicitud', 0, 218),
(532, '2017-08-15 12:52:26', 'Se ha registrado una nueva solicitud', 0, 219),
(533, '2017-08-15 13:02:24', 'Se ha registrado una nueva solicitud', 0, 220),
(534, '2017-08-15 13:05:42', 'Se ha registrado una nueva solicitud', 0, 221),
(535, '2017-08-15 13:14:54', 'Se ha registrado una nueva solicitud', 0, 222),
(536, '2017-08-15 13:34:52', 'Se ha registrado una nueva solicitud', 0, 223),
(537, '2017-08-15 13:36:47', 'Se ha registrado una nueva solicitud', 0, 224),
(538, '2017-08-15 13:44:28', 'Se ha registrado una nueva solicitud', 0, 225),
(539, '2017-08-15 13:51:22', 'Se ha registrado una nueva solicitud', 0, 226),
(540, '2017-08-15 13:54:47', 'Se ha registrado una nueva solicitud', 0, 227),
(541, '2017-08-15 14:05:48', 'Se ha registrado una nueva solicitud', 0, 228),
(542, '2017-08-15 15:36:13', 'Se ha registrado una nueva solicitud', 0, 229),
(543, '2017-08-15 15:42:07', 'Se ha registrado una nueva solicitud', 0, 230),
(544, '2017-08-15 15:50:23', 'Se ha registrado una nueva solicitud', 0, 231),
(545, '2017-08-15 16:22:30', 'Se ha registrado una nueva solicitud', 0, 232),
(546, '2017-08-15 16:26:10', 'Se ha registrado una nueva solicitud', 0, 233),
(547, '2017-08-15 16:28:53', 'Se ha registrado una nueva solicitud', 0, 234),
(548, '2017-08-15 16:42:04', 'Se ha registrado una nueva solicitud', 0, 235),
(549, '2017-08-15 16:46:47', 'Se ha registrado una nueva solicitud', 0, 236),
(550, '2017-08-15 19:00:14', 'Se ha registrado una nueva solicitud', 0, 237),
(551, '2017-08-18 20:26:12', 'Juan Pulgarin ha sido asignado(a) a la solicitud N° 237', 1, 237),
(552, '2017-08-18 20:43:01', 'Juan Pulgarin diligenció la ficha de la solicitud N° 237', 5, 237),
(553, '2017-08-18 20:43:43', 'Administrador Administrador finalizó la solicitud N° 237', 6, 237),
(554, '2017-08-18 20:43:48', 'Administrador Administrador finalizó la solicitud N° 237', 6, 237),
(555, '2017-08-23 12:46:57', 'Se ha registrado una nueva solicitud', 0, 238),
(556, '2017-08-23 12:48:41', 'Juan Pulgarin ha sido asignado(a) a la solicitud N° 238', 1, 238),
(557, '2017-08-23 12:53:49', 'Administrador Administrador finalizó la solicitud N° 238', 6, 238);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpermisos`
--

CREATE TABLE IF NOT EXISTS `tblpermisos` (
  `idPermiso` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `verModulo` tinyint(4) NOT NULL,
  `idModulo` int(11) NOT NULL,
  `idRol` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblpermisos`
--

INSERT INTO `tblpermisos` (`idPermiso`, `nombre`, `verModulo`, `idModulo`, `idRol`) VALUES
(1, 'Consultar usuarios', 1, 1, 3),
(2, 'Agregar usuarios', 0, 1, 1),
(3, 'Modificar información de usuarios', 0, 1, 1),
(4, 'Consultar detalles de usuarios', 0, 1, 1),
(5, 'Crear cuentas de usuarios', 0, 1, 1),
(6, 'Consultar empresas', 1, 2, 1),
(7, 'Agregar empresas', 0, 2, 1),
(8, 'Modificar información de empresas', 0, 2, 1),
(9, 'Consultar detalles de empresas', 0, 2, 1),
(10, 'Consultar insumos', 1, 3, 1),
(11, 'Agregar insumos', 0, 3, 1),
(12, 'Modificar información de insumos', 0, 3, 1),
(13, 'Consultar detalles de insumos', 0, 3, 1),
(14, 'Registrar entradas', 0, 3, 1),
(15, 'Consultar entradas', 0, 3, 1),
(16, 'Registrar devoluciones', 0, 3, 1),
(17, 'Consultar devoluciones', 0, 3, 1),
(18, 'Agregar marcas', 0, 3, 1),
(19, 'Consultar marcas', 0, 3, 1),
(20, 'Agregar presentaciones', 0, 3, 1),
(21, 'Consultar presentaciones', 0, 3, 1),
(22, 'Modificar contraseña de los usuarios', 0, 1, 1),
(23, 'Consultar estado de la cuenta de los usuarios', 0, 1, 1),
(24, 'Modificar permisos de usuarios', 0, 1, 1),
(26, 'Generar informes de cuentas de usuarios', 1, 6, 1),
(27, 'Generar informes de usuarios registrados', 1, 6, 1),
(28, 'Generar informes detallados por usuarios', 1, 6, 1),
(29, 'Generar informes de insumos', 1, 6, 1),
(30, 'Generar informes de entradas de insumos', 1, 6, 1),
(31, 'Generar informes de bajas de insumos', 1, 6, 1),
(32, 'Generar informes detallados por insumos', 1, 6, 1),
(33, 'Consultar solicitudes', 1, 5, 2),
(34, 'Consultar detalles de solicitudes', 0, 5, 3),
(35, 'Asignar técnicos a solicitudes', 0, 5, 1),
(36, 'Rechazar solicitudes / Verificar solicitudes', 0, 5, 1),
(37, 'Diligenciar fichas tecnicas', 0, 5, 2),
(38, 'Consultar equipos', 1, 4, 3),
(39, 'Consultar detalles de equipos', 0, 4, 3),
(40, 'Modificar equipos', 0, 4, 3),
(41, 'Agregar equipos', 0, 4, 3),
(42, 'Agregar marcas de equipos', 0, 4, 3),
(43, 'Consultar marcas de equipos', 0, 4, 3),
(44, 'Gestionar aires acondicionados', 1, 5, 1),
(45, 'Gestionar luminarias (No implementado)', 1, 5, 1),
(46, 'Generar informes de fichas técnicas', 1, 6, 3),
(47, 'Gestionar planos', 1, 7, 3),
(48, 'Modificar ambientes', 1, 7, 3),
(49, 'Gestionar eléctricas (No implementado)', 1, 5, 1),
(50, 'Generar informe de cambios por categoria', 1, 6, 3),
(51, 'Generar informe de cambios por equipo', 1, 6, 3),
(52, 'Gestionar otros', 1, 5, 1),
(55, 'Generar informe categoria por fechas', 1, 6, 3),
(56, 'Gestionar Ascensores', 1, 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpermisosusuario`
--

CREATE TABLE IF NOT EXISTS `tblpermisosusuario` (
  `idPermisoUsuario` int(11) NOT NULL,
  `idCuentaUsuario` int(11) NOT NULL,
  `idPermiso` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=821 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblpermisosusuario`
--

INSERT INTO `tblpermisosusuario` (`idPermisoUsuario`, `idCuentaUsuario`, `idPermiso`) VALUES
(276, 18, 1),
(277, 18, 2),
(278, 18, 3),
(279, 18, 4),
(281, 18, 22),
(282, 18, 5),
(283, 18, 23),
(284, 18, 24),
(285, 18, 38),
(286, 18, 39),
(287, 18, 40),
(288, 18, 41),
(289, 18, 42),
(290, 18, 43),
(291, 18, 34),
(292, 18, 36),
(293, 18, 35),
(294, 18, 44),
(295, 18, 26),
(296, 18, 27),
(297, 18, 28),
(298, 18, 29),
(299, 18, 30),
(300, 18, 31),
(301, 18, 32),
(302, 18, 51),
(303, 18, 50),
(304, 18, 46),
(305, 18, 48),
(306, 18, 47),
(340, 18, 52),
(342, 18, 49),
(347, 18, 45),
(354, 18, 55),
(361, 23, 33),
(362, 23, 34),
(363, 23, 37),
(364, 23, 38),
(365, 23, 39),
(366, 23, 40),
(367, 23, 41),
(368, 23, 42),
(369, 23, 43),
(370, 24, 1),
(371, 24, 2),
(372, 24, 3),
(373, 24, 4),
(374, 24, 5),
(375, 24, 22),
(376, 24, 23),
(377, 24, 24),
(384, 24, 34),
(385, 24, 35),
(386, 24, 36),
(387, 24, 44),
(388, 24, 45),
(389, 24, 49),
(390, 24, 52),
(391, 25, 33),
(392, 25, 34),
(393, 25, 37),
(394, 25, 38),
(395, 25, 39),
(396, 25, 40),
(397, 25, 41),
(398, 25, 42),
(399, 25, 43),
(400, 26, 1),
(401, 26, 2),
(402, 26, 3),
(403, 26, 4),
(404, 26, 5),
(405, 26, 22),
(406, 26, 23),
(407, 26, 24),
(408, 26, 34),
(409, 26, 35),
(410, 26, 36),
(411, 26, 44),
(412, 26, 45),
(413, 26, 49),
(414, 26, 52),
(415, 26, 26),
(416, 26, 27),
(417, 26, 28),
(418, 26, 29),
(419, 26, 30),
(420, 26, 31),
(421, 26, 32),
(422, 26, 46),
(423, 26, 50),
(424, 26, 51),
(425, 27, 38),
(426, 27, 39),
(427, 27, 40),
(428, 27, 41),
(429, 27, 42),
(430, 27, 43),
(431, 27, 34),
(432, 27, 35),
(433, 27, 36),
(434, 27, 44),
(435, 27, 45),
(436, 27, 49),
(437, 27, 52),
(438, 28, 38),
(439, 28, 39),
(440, 28, 40),
(441, 28, 41),
(442, 28, 42),
(443, 28, 43),
(444, 28, 33),
(445, 28, 34),
(446, 28, 37),
(447, 29, 38),
(448, 29, 39),
(449, 29, 40),
(450, 29, 41),
(451, 29, 42),
(452, 29, 43),
(453, 29, 33),
(454, 29, 34),
(455, 29, 37),
(456, 30, 1),
(457, 30, 2),
(458, 30, 3),
(459, 30, 4),
(460, 30, 5),
(461, 30, 22),
(462, 30, 23),
(463, 30, 24),
(464, 30, 6),
(465, 30, 7),
(466, 30, 8),
(467, 30, 9),
(468, 30, 10),
(469, 30, 11),
(470, 30, 12),
(471, 30, 13),
(472, 30, 14),
(473, 30, 15),
(474, 30, 16),
(475, 30, 17),
(476, 30, 18),
(477, 30, 19),
(478, 30, 20),
(479, 30, 21),
(480, 30, 38),
(481, 30, 39),
(482, 30, 40),
(483, 30, 41),
(484, 30, 42),
(485, 30, 43),
(486, 30, 34),
(487, 30, 36),
(488, 30, 35),
(489, 30, 44),
(490, 30, 45),
(491, 30, 52),
(492, 30, 49),
(493, 30, 26),
(494, 30, 27),
(495, 30, 28),
(496, 30, 29),
(497, 30, 30),
(498, 30, 32),
(499, 30, 31),
(500, 30, 46),
(501, 30, 50),
(502, 30, 51),
(503, 30, 47),
(504, 30, 48),
(505, 31, 1),
(506, 31, 2),
(507, 31, 3),
(508, 31, 4),
(509, 31, 5),
(510, 31, 22),
(511, 31, 23),
(512, 31, 24),
(513, 31, 34),
(514, 31, 35),
(515, 31, 36),
(516, 31, 44),
(517, 31, 45),
(518, 31, 49),
(519, 31, 52),
(520, 31, 26),
(521, 31, 27),
(522, 31, 28),
(523, 31, 29),
(524, 31, 30),
(525, 31, 31),
(526, 31, 32),
(527, 31, 46),
(528, 31, 50),
(529, 31, 51),
(530, 31, 38),
(531, 31, 39),
(532, 31, 40),
(533, 31, 41),
(534, 31, 42),
(535, 31, 43),
(536, 32, 34),
(537, 32, 35),
(538, 32, 36),
(539, 32, 44),
(540, 32, 45),
(541, 32, 49),
(542, 32, 52),
(543, 32, 1),
(544, 32, 2),
(545, 32, 3),
(546, 32, 4),
(547, 32, 5),
(548, 32, 22),
(549, 32, 23),
(550, 32, 24),
(551, 32, 38),
(552, 32, 39),
(553, 32, 40),
(554, 32, 41),
(555, 32, 42),
(556, 32, 43),
(557, 32, 26),
(558, 32, 27),
(559, 32, 28),
(560, 32, 29),
(561, 32, 30),
(562, 32, 31),
(563, 32, 32),
(564, 32, 46),
(565, 32, 50),
(566, 32, 51),
(567, 33, 33),
(568, 33, 34),
(569, 33, 37),
(570, 33, 38),
(571, 33, 39),
(572, 33, 40),
(573, 33, 41),
(574, 33, 42),
(575, 33, 43),
(576, 34, 1),
(577, 34, 2),
(578, 34, 3),
(579, 34, 4),
(580, 34, 5),
(581, 34, 22),
(582, 34, 23),
(583, 34, 24),
(584, 33, 1),
(585, 33, 46),
(586, 33, 50),
(587, 33, 51),
(588, 33, 47),
(589, 33, 48),
(590, 34, 6),
(591, 34, 7),
(592, 34, 8),
(593, 34, 9),
(594, 34, 10),
(595, 34, 11),
(596, 34, 12),
(597, 34, 13),
(598, 34, 14),
(599, 34, 15),
(600, 34, 16),
(601, 34, 17),
(602, 34, 18),
(603, 34, 19),
(604, 34, 20),
(605, 34, 21),
(606, 34, 38),
(607, 34, 39),
(608, 34, 40),
(609, 34, 41),
(610, 34, 42),
(611, 34, 43),
(612, 34, 34),
(613, 34, 35),
(614, 34, 36),
(615, 34, 44),
(616, 34, 45),
(617, 34, 49),
(618, 34, 52),
(619, 34, 26),
(620, 34, 27),
(621, 34, 28),
(622, 34, 29),
(623, 34, 30),
(624, 34, 31),
(625, 34, 32),
(626, 34, 46),
(627, 34, 50),
(628, 34, 51),
(629, 34, 47),
(630, 34, 48),
(631, 42, 1),
(632, 42, 2),
(633, 42, 3),
(634, 42, 4),
(635, 42, 5),
(636, 42, 22),
(637, 42, 23),
(638, 42, 24),
(639, 42, 6),
(640, 42, 7),
(641, 42, 8),
(642, 42, 9),
(643, 42, 10),
(644, 42, 11),
(645, 42, 12),
(646, 42, 13),
(647, 42, 14),
(648, 42, 15),
(649, 42, 16),
(650, 42, 17),
(651, 42, 18),
(652, 42, 19),
(653, 42, 20),
(654, 42, 21),
(655, 42, 38),
(656, 42, 39),
(657, 42, 40),
(658, 42, 41),
(659, 42, 42),
(660, 42, 43),
(661, 42, 34),
(662, 42, 35),
(663, 42, 36),
(664, 42, 44),
(665, 42, 45),
(666, 42, 49),
(667, 42, 52),
(668, 42, 26),
(669, 42, 27),
(670, 42, 28),
(671, 42, 29),
(672, 42, 30),
(673, 42, 31),
(674, 42, 32),
(675, 42, 46),
(676, 42, 50),
(677, 42, 51),
(678, 42, 47),
(679, 42, 48),
(680, 43, 1),
(681, 43, 3),
(682, 43, 2),
(683, 43, 4),
(684, 43, 5),
(685, 43, 22),
(686, 43, 23),
(687, 43, 24),
(688, 43, 6),
(689, 43, 7),
(690, 43, 8),
(691, 43, 9),
(692, 43, 10),
(693, 43, 11),
(694, 43, 12),
(695, 43, 13),
(696, 43, 14),
(697, 43, 15),
(698, 43, 16),
(699, 43, 17),
(700, 43, 18),
(702, 43, 19),
(703, 43, 20),
(704, 43, 21),
(705, 43, 38),
(706, 43, 39),
(707, 43, 40),
(708, 43, 41),
(709, 43, 42),
(710, 43, 43),
(711, 43, 34),
(712, 43, 35),
(713, 43, 36),
(714, 43, 44),
(715, 43, 45),
(716, 43, 49),
(717, 43, 52),
(718, 43, 26),
(719, 43, 27),
(720, 43, 28),
(721, 43, 29),
(722, 43, 30),
(723, 43, 31),
(724, 43, 32),
(725, 43, 46),
(726, 43, 50),
(727, 43, 51),
(728, 43, 48),
(729, 43, 47),
(730, 40, 1),
(731, 40, 33),
(732, 40, 34),
(733, 40, 37),
(734, 40, 38),
(735, 40, 39),
(736, 40, 40),
(737, 40, 41),
(738, 40, 42),
(739, 40, 43),
(740, 40, 46),
(741, 40, 50),
(742, 40, 51),
(743, 40, 47),
(744, 40, 48),
(745, 44, 50),
(746, 44, 51),
(747, 44, 46),
(748, 44, 38),
(749, 44, 39),
(750, 44, 33),
(751, 44, 34),
(752, 44, 37),
(753, 44, 1),
(754, 45, 1),
(755, 45, 33),
(756, 45, 34),
(757, 45, 37),
(758, 45, 38),
(759, 45, 39),
(760, 45, 40),
(761, 45, 41),
(762, 45, 42),
(763, 45, 43),
(764, 45, 46),
(765, 45, 50),
(766, 45, 51),
(767, 45, 47),
(768, 45, 48),
(769, 29, 1),
(770, 29, 46),
(771, 29, 50),
(772, 29, 51),
(773, 29, 47),
(774, 29, 48),
(775, 46, 33),
(776, 46, 34),
(778, 46, 38),
(779, 46, 39),
(780, 46, 40),
(781, 46, 41),
(782, 46, 42),
(783, 46, 43),
(784, 46, 46),
(785, 46, 50),
(786, 46, 51),
(787, 18, 56),
(789, 46, 1),
(790, 46, 37),
(791, 46, 47),
(792, 46, 48),
(793, 47, 1),
(794, 47, 38),
(795, 47, 39),
(797, 47, 41),
(798, 47, 40),
(799, 47, 42),
(800, 47, 43),
(801, 47, 33),
(802, 47, 34),
(803, 47, 37),
(804, 47, 55),
(805, 47, 51),
(806, 47, 50),
(807, 47, 46),
(808, 47, 47),
(809, 47, 48),
(811, 48, 38),
(812, 48, 39),
(814, 48, 41),
(815, 48, 40),
(816, 48, 42),
(817, 48, 43),
(818, 48, 33),
(819, 48, 34),
(820, 48, 37);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpisos`
--

CREATE TABLE IF NOT EXISTS `tblpisos` (
  `idPiso` int(11) NOT NULL,
  `Nombre` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `idTorre` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblpisos`
--

INSERT INTO `tblpisos` (`idPiso`, `Nombre`, `idTorre`) VALUES
(1, 'Sótano', 1),
(2, '1', 1),
(3, '2', 1),
(4, '3', 1),
(5, '4', 1),
(6, '5', 1),
(7, '6', 1),
(8, '7', 1),
(9, '8', 1),
(10, '9', 1),
(11, '10', 1),
(12, '1', 3),
(13, '2', 3),
(14, 'Sótano', 2),
(15, '1', 2),
(16, '2', 2),
(17, '3', 2),
(18, '4', 2),
(19, '5', 2),
(20, '6', 2),
(21, '7', 2),
(22, '8', 2),
(23, '9', 2),
(24, '10', 2),
(25, '11', 2),
(26, '12', 2),
(27, '13', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblplazosolicitud`
--

CREATE TABLE IF NOT EXISTS `tblplazosolicitud` (
  `idPlazoSolicitud` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL,
  `idCuentaUsuario` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Motivo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpreguntasencuesta`
--

CREATE TABLE IF NOT EXISTS `tblpreguntasencuesta` (
  `idPregunta` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  `tipoPregunta` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblpreguntasencuesta`
--

INSERT INTO `tblpreguntasencuesta` (`idPregunta`, `Descripcion`, `tipoPregunta`) VALUES
(1, '¿Cual ha sido su impresión sobre el servicio prestado?', '1'),
(2, 'Califique la organización con la que se llevó a cabo el mantenimiento solicitado', '1'),
(3, '¿Considera óptimo el método utilizado para enviar solicitudes de mantenimiento?', '2'),
(4, '¿Considera que obtuvo una respuesta oportuna a la solicitud realizada?', '2'),
(5, 'Califique el software de gestión de mantenimientos SAM', '1'),
(6, 'Describa algunas observaciones sobre el servicio recibido', '3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpresentacion`
--

CREATE TABLE IF NOT EXISTS `tblpresentacion` (
  `idPresentacion` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblpresentacion`
--

INSERT INTO `tblpresentacion` (`idPresentacion`, `nombre`, `estado`) VALUES
(1, '20 centimetros', 1),
(2, '30 centimetros', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblriesgos`
--

CREATE TABLE IF NOT EXISTS `tblriesgos` (
  `idRiesgo` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `idTipoRiesgo` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblriesgos`
--

INSERT INTO `tblriesgos` (`idRiesgo`, `descripcion`, `idTipoRiesgo`) VALUES
(1, 'Derrame de aceites o cumbustibles', 1),
(2, 'Generación de residuos peligrosos', 1),
(3, 'Uso de agua y/o energia', 1),
(4, 'Generación de residuos no peligrosos', 1),
(5, 'Poda de árboles o grama no controlada', 1),
(6, 'Ruido', 2),
(7, 'Humos de soldadura / Material particulado', 2),
(8, 'Posturas inadecuadas y manipulación de cargas', 2),
(9, 'Radiaciones ultravioletas', 2),
(10, 'Trabajos en alturas', 2),
(11, 'Vehículos en movimientos', 2),
(12, 'Mecanismos en movimientos', 2),
(13, 'Superficies calientes', 2),
(14, 'Energía eléctrica', 2),
(15, 'Biológico', 2),
(16, 'Ataca capa de ozono (SAO)', 1),
(17, 'Calentamiento Global (G.W)', 1),
(18, 'toxicos', 2),
(19, 'Quemaduras', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblriesgosmantenimiento`
--

CREATE TABLE IF NOT EXISTS `tblriesgosmantenimiento` (
  `idRiesgoMantenimiento` int(11) NOT NULL,
  `idRiesgo` int(11) NOT NULL,
  `idMantenimiento` int(11) DEFAULT NULL,
  `fuente` text CHARACTER SET utf8 NOT NULL,
  `idMantenimientod` int(11) DEFAULT NULL,
  `controlesExistentes` text CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblriesgosmantenimiento`
--

INSERT INTO `tblriesgosmantenimiento` (`idRiesgoMantenimiento`, `idRiesgo`, `idMantenimiento`, `fuente`, `idMantenimientod`, `controlesExistentes`) VALUES
(1, 6, 1, 'desconocido', NULL, 'desconocido'),
(2, 3, 2, 'desconocido', NULL, 'desconocido'),
(3, 2, 3, 'aceite', NULL, 'cubeta'),
(4, 4, NULL, 'fija', 1, 'se reutiliza'),
(5, 6, NULL, 'chillido', 2, 'lubricar'),
(6, 3, NULL, 'maquina sierra de banco', 3, 'uso de gafas, guantes, tapa oídos de copa'),
(7, 6, NULL, 'equipo de corte', 3, 'se utilIza elementos EPP'),
(8, 3, NULL, 'sistema de agua potable y circuito eléctrico a 110 v', 4, 'uso de elementos EPP'),
(9, 3, NULL, 'perdida de agua', 7, 'secases de repuestos para fluxometros'),
(10, 3, NULL, 'agua', 16, 'no se tienen repuestos para esta llaves'),
(11, 6, NULL, 'uso de taladro', 17, 'uso de elementos de EPP'),
(12, 6, NULL, 'golpeteo con martillo', 21, 'uso de los elementos EPP'),
(13, 6, NULL, 'taladreado', 25, 'uso elementos epp'),
(14, 6, NULL, 'uso de taladro y martillo', 39, 'se  usan elementos epp'),
(15, 6, NULL, 'taladrado y martillado', 42, 'se usan elementos EPP'),
(16, 6, NULL, 'taladro y martillado', 44, 'se usan los elementos EPP'),
(17, 6, NULL, 'taladro', 49, 'se usan elementos epp'),
(18, 3, NULL, 'SI', 50, 'SI'),
(19, 4, NULL, 'ninguna', 51, 'si'),
(20, 3, NULL, 'electrica', 52, 'si'),
(21, 3, 4, 'electrica', NULL, 'todos los posibles'),
(22, 3, 5, 'electrica', NULL, 'todos'),
(23, 10, 5, 'ninguna', NULL, 'todos'),
(24, 4, NULL, 'cualquier cosa', 53, 'todos'),
(25, 10, NULL, 'ninguno', 53, 'todos'),
(26, 4, NULL, 'ninguna', 54, 'todos'),
(27, 1, 6, 'fd', NULL, 'd'),
(28, 1, 7, 'wqewqe', NULL, 'wqewqe'),
(29, 4, NULL, 'SDDSF', 55, 'CAMBIO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblroles`
--

CREATE TABLE IF NOT EXISTS `tblroles` (
  `idRol` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblroles`
--

INSERT INTO `tblroles` (`idRol`, `nombre`) VALUES
(1, 'Administrativo'),
(2, 'Técnico'),
(3, 'Administrativo_Tecnico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblsalidas`
--

CREATE TABLE IF NOT EXISTS `tblsalidas` (
  `idSalida` int(11) NOT NULL,
  `idInsumo` int(11) NOT NULL,
  `fechaSalida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblsinequipo`
--

CREATE TABLE IF NOT EXISTS `tblsinequipo` (
  `idEquipo` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblsinequipo`
--

INSERT INTO `tblsinequipo` (`idEquipo`, `Nombre`) VALUES
(1, 'Se daño el articulo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblsolicitud`
--

CREATE TABLE IF NOT EXISTS `tblsolicitud` (
  `idsolicitud` int(11) NOT NULL,
  `idambiente` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  `primerNombre` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `segundoNombre` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `primerApellido` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `segundoApellido` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `correo` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `descripcion` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `idestado` int(11) NOT NULL DEFAULT '1',
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaInicio` varchar(45) DEFAULT NULL,
  `fechaFinal` varchar(45) DEFAULT NULL,
  `motivoRechazo` text,
  `prioridad` int(11) DEFAULT '1',
  `img` text CHARACTER SET utf8
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblsolicitud`
--

INSERT INTO `tblsolicitud` (`idsolicitud`, `idambiente`, `idCategoria`, `primerNombre`, `segundoNombre`, `primerApellido`, `segundoApellido`, `correo`, `descripcion`, `idestado`, `fechaRegistro`, `fechaInicio`, `fechaFinal`, `motivoRechazo`, `prioridad`, `img`) VALUES
(82, 56, 1, 'juan', '', 'valdez', '', 'jvaldez@misena.edu.co', 'el aire no enfria', 6, '2017-03-08 16:20:34', '2017-03-08', '2017-03-14', NULL, 1, ''),
(83, 56, 1, 'pedro', '', 'jimenez', '', 'afosorio45@misena.edu.co', 'no esta funcionado el aire ', 6, '2017-03-08 16:49:20', '2017-06-08', '2017-07-20', NULL, 1, 'images.jpg'),
(84, 169, 1, 'Argelid', '', 'Jaramillo', 'Isaza', 'arjaramillo@sena.edu.co', 'Se presentan altas temperaturas en la sala de juntas, y se encuentra encendido el equipo, se escucha ruido de los motores y el calor persiste.', 6, '2017-03-08 18:45:12', '2017-03-09', '2017-03-15', NULL, 2, ''),
(85, 70, 1, 'diego', '', 'ortiz', '', 'drortiz94@sena.edu.co', 'el aire no esta enfriando bien', 3, '2017-03-08 18:48:00', '2017-03-08', '2017-03-14', NULL, 1, ''),
(86, 55, 4, 'Argelid', '', 'Jaramillo', 'Isaza', 'arjaramillo@sena.edu.co', 'cables sueltos en sala de archivo', 6, '2017-03-08 19:24:35', '2017-03-08', '2017-03-10', NULL, 1, ''),
(87, 165, 4, 'anders6n', '', '06nsa3ve', '', 'amonsalve@sena.edu.co', 'cables expuestos', 3, '2017-03-08 20:48:20', '2017-03-08', '2017-03-10', NULL, 1, NULL),
(88, 218, 3, 'Javier ', '', 'Mallama', 'Benavides', 'jmallama@sena.edu.co', 'Se requiere corte de una tabla en 3 partes ya señaladas, la cual se encuentra en el taller de mantenimiento entregada al Señor Luis Eduardo.', 6, '2017-03-09 12:14:21', '2017-03-10', '2017-03-14', NULL, 1, ''),
(89, 300, 1, 'Javier', '', 'Mallama', 'Benavides', 'jmallama@sena.edu.co', 'Solicito la instalación de un aire acondicionado portátil en el piso 6 ambiente 6-6, debido a que en el aplicativo SAM no esta registrado el piso 6 realice la solicitud como si fuera en el piso 1. placa SENA 940114718, serial 6200049, Marca Kalley Btu/h 12000, Modelo K-AC12TP, el equipo ya se encuentra en el lugar.', 3, '2017-03-09 16:13:27', '2017-03-13', '2017-03-16', NULL, 1, ''),
(90, 285, 3, 'campo', 'elias', 'loaiza', 'echeverri', 'cloaiza@sena.edu.co', 'la puerta del contac center (BPO) esta colgada por lo tanto es imposible hecharle llave.', 6, '2017-03-09 17:59:11', '2017-03-10', '2017-03-10', NULL, 1, ''),
(91, 99, 3, 'Efrain', '', 'Torres', 'Noguera', 'etorresn@sena.edu.co', 'Ambiente sin puerta', 3, '2017-03-10 13:09:28', '2017-03-13', '2017-05-31', NULL, 2, 'registro fotografico.jpg'),
(92, 25, 4, 'Juan', 'Pablo', 'Gomez', 'Jaramillo', 'jpgomez222@misena.edu.co', 'switch de donde se prende la luz no se encuentra pegado a la pared.', 3, '2017-03-10 18:34:27', '2017-03-10', '2017-03-13', NULL, 2, ''),
(93, 417, 3, 'Javier ', '', 'Mmallama', 'Benavides', 'jmallama@sena.edu.co', 'En el pasillo frente a los laboratorios de bilinguismo, hay una ventana que cuando llueve se entra el agua por ahí, solicito su reparación ', 3, '2017-03-13 12:06:07', '2017-03-13', '2017-03-13', NULL, 1, ''),
(94, 372, 3, 'carlos', 'mario', 'mejia', 'velez', 'cmejia@sena.edu.co', 'resanar hueco de cielo razo falso en esquina de la zona de comidas del piso 4', 3, '2017-03-13 12:50:52', '2017-03-23', '2017-03-24', NULL, 3, ''),
(95, 190, 3, 'Andres', '', 'Agudelo', '', 'aagudelog@sena.edu.co', 'Se requiere trasladar mueble de la salida de emergencia piso 10 al ambiente 10-05 e instalarlo al lado del televisor según lo ya acordado.', 6, '2017-03-13 14:22:56', '2017-03-13', '2017-03-14', NULL, 3, ''),
(96, 27, 3, 'carlos', '', 'henao', '', 'chtovar@sena.edu.co', 'se solicita por parte de la instructora tulia, la instalación de hielera a el sistema de agua potable', 6, '2017-03-13 15:18:49', '2017-03-13', '2017-03-18', NULL, 3, ''),
(97, 140, 3, 'Carlos', '', 'Henao', '', 'chtovar@sena.edu.co', 'puerta vidriera colgada', 6, '2017-03-13 16:34:31', '2017-03-14', '2017-03-18', NULL, 2, ''),
(98, 125, 3, 'Carlos', '', 'Henao', '', 'chtovar@sena.edu.co', 'se requiere observar fluxometro por perdida de agua , baño hombres ', 6, '2017-03-13 16:40:02', '2017-03-14', '2017-03-18', NULL, 2, ''),
(99, 178, 3, 'carlos', '', 'henao', '', 'chtovar@sena.edu.co', 'se solicita apertura de cajoneras de escritorio Sr. luis socarraz ', 6, '2017-03-14 11:20:04', '2017-03-14', '2017-03-18', NULL, 3, ''),
(100, 171, 3, 'Leidy ', 'Marcela ', 'Galeano ', 'Monsalve', 'lmgaleanom@sena.edu.co', 'Solitud de traslado de escritorio según lo acordado con el encargado de mantenimiento\r\n\r\nSolicitud de instalación de cerradura de locker y escritorio', 4, '2017-03-14 15:40:51', '2017-03-14', '2017-03-14', NULL, 3, ''),
(101, 229, 1, 'Hector', 'Dario', 'Ricaurte', 'Hurtado', 'h.ricaurte@sena.edu.co', 'Requiere revisión aire acondicionado sala impresion offset', 3, '2017-03-14 16:24:07', '2017-03-14', '2017-03-21', NULL, 1, ''),
(102, 45, 3, 'carlos', '', 'henao', '', 'chtovar@sena.edu.co', 'se requiere de traslado y arreglo de locke para espacio requerido en el sótano, para guardar elementos de seguridad ambiental.', 6, '2017-03-14 16:25:07', '2017-03-14', '2017-03-14', NULL, 1, ''),
(103, 229, 3, 'hector', 'dario', 'ricaurte', 'hurtado', 'h.ricaurte@sena.edu.co', 'traslado papel parcial situado en parqueadero torre norte', 6, '2017-03-14 16:26:29', '2017-03-15', '2017-03-17', NULL, 3, ''),
(104, 172, 3, 'Efrain', '', 'Torres', 'Noguera', 'etorresn@sena.edu.co', 'Se solicita el traslado del mobiliario de los dos apoyos misionales, que actualmente se encuentran ubicados en el ingreso de las oficinas para que queden en el ingreso de las coordinaciones.', 6, '2017-03-14 20:52:43', '2017-03-14', '2017-03-14', NULL, 1, ''),
(105, 300, 4, 'JAVIER ', '', 'MALLAMA', 'BENAVIDES', 'jmallama@sena.edu.co', 'Solicito instalación de ventilador en la oficina de Competencias Laborales ubicada en el piso 9 ', 3, '2017-03-15 15:19:18', '2017-03-21', '2017-03-23', NULL, 1, ''),
(106, 399, 3, 'JAVIER ', '', 'MALLAMA ', 'BENAVIDES', 'jmallama@sena.edu.co', 'Solicito el cambio de un vidrio quebrado en la sala de instructores piso 9', 3, '2017-03-15 15:21:18', '2017-03-21', '2017-03-23', NULL, 2, ''),
(107, 300, 3, 'JAVIER', '', 'MALLAMA', 'BENAVIDES', 'jmallama@sena.edu.co', 'Solicito anclar 21 lockers o casilleros al muro de drywall en la sala de profesores del piso 9', 3, '2017-03-15 15:24:17', '2017-03-21', '2017-03-25', NULL, 1, ''),
(108, 25, 3, 'David', '', 'Mejía', 'Mejía', 'dmejiam@sena.edu.co', 'Reacomodar el Video Beam del Auditorio del Segundo Piso Torre Norte, ya que en un evento fue movido y no está apuntando hacia el telón que proyecta la imagen.', 4, '2017-03-15 20:26:13', '2017-03-17', '2017-03-25', NULL, 1, ''),
(109, 113, 3, 'Francisco', '', 'perez', '', 'chtovar@sena.edu.co', 'se solicita el arreglo de 6 sillas malas , por falta de tornilleria', 6, '2017-03-16 10:14:16', '2017-03-16', '2017-03-18', NULL, 2, ''),
(110, 22, 3, 'francisco ', '', 'perez', '', 'chtovar@sena.edu.co', 'se requiere organizar puerta alacena inferior de la cocineta', 6, '2017-03-16 10:16:09', '2017-03-16', '2017-03-18', NULL, 2, ''),
(111, 98, 4, 'francisco ', '', 'perez', '', 'chtovar@sena.edu.co', 'se presenta oscuridad en los baños por falta de tubos luminarias en las lamparas', 4, '2017-03-16 10:18:01', '2017-03-21', '2017-03-25', NULL, 1, ''),
(112, 48, 3, 'Lina', 'Marcela', 'Gutierrez', 'Castillo', 'lmgutierrezc@sena.edu.co', 'Buenos días\r\nAgradecería desde el área de mantenimiento se pueda  revisar nuevamente la puerta de ingreso a la biblioteca, lo ideal es la que la puerta pueda quedar cerrada perfectamente cuándo un usuario sale o ingresa a la  biblioteca, esto nos ayudaría no solo a contratar el flujo del aire acondicionado, si no también, evitar el ingreso de los gaticos.\r\nMuchas gracias de antemano.', 4, '2017-03-16 12:45:45', '2017-03-16', '2017-03-18', NULL, 1, ''),
(113, 8, 3, 'francisco ', '', 'perez', '', 'chtovar@sena.edu.co', 'se requiere de arreglo llave pusch lavamanos baño hombres', 6, '2017-03-16 14:15:57', '2017-03-16', '2017-03-17', NULL, 1, ''),
(114, 165, 3, 'carlos ', '', 'henao', '', 'chtovar@sena.edu.co', 'se requiere de arreglo llave pusch lavamanos , baño privado administración, bota demasiada agua', 6, '2017-03-16 14:17:54', '2017-03-16', '2017-03-17', NULL, 1, ''),
(115, 170, 3, 'Efrain ', '', 'Torres', 'Noguera', 'etorresn@sena.edu.co', 'Se solicita el traslado de la impresora que se encuentra en la oficina de la coordinación misional para el area de las oficinas de afuera, y que se ingrese la impresora blanca hp que se encuentra en las salida de emergencia, así mismo retirar la impresora de infraestructura que no funciona.', 6, '2017-03-16 14:59:11', '2017-03-16', '2017-03-16', NULL, 1, ''),
(116, 268, 3, 'David ', '', 'Mejía ', 'Mejía ', 'dmejiam@sena.edu.co', 'Traslado de 3 mesas y 7 sillas de Plazoleta de Aprendices de Torre Sur para Terrza 4 piso Torre Norte a las 5: 00 pm', 6, '2017-03-16 15:42:39', '2017-03-16', '2017-03-16', NULL, 1, ''),
(117, 178, 3, 'Juan', 'Guillermo', 'Ruiz ', 'Zapata', 'jruiz@sena.edu.co', 'Solicito el traslado de todo el equipo del área de contrato de aprendizaje para el piso 9', 6, '2017-03-16 22:15:44', '2017-03-16', '2017-03-16', NULL, 2, ''),
(118, 50, 2, 'Jorge', 'Iván', 'Quiros', 'Valencia', 'jquirosv@sena.edu.co', 'En el sistio donde esta ubicado el escritorio ni tiene cerca una lampara, por tal motivo la iluminación no es la correcta, solicito que trasladen una lampara que esta en el espacio de archivo y ponerla cerca al escritorio para mejorar la iluminación. ', 4, '2017-03-17 12:15:12', '2017-03-17', '2017-03-21', NULL, 2, 'Sin título.jpg'),
(119, 269, 3, 'David ', '', 'Mejía ', 'Mejía ', 'dmejiam@sena.edu.co', 'Cambio de chapas de dos puertas del Auditorio Carlos Castro, ya que están malas y no se puede cerrar la cabina para mantener los equipos protegidos', 6, '2017-03-17 13:14:05', '2017-03-17', '2017-03-25', NULL, 1, ''),
(120, 1, 3, 'Efrain ', '', 'Torres ', '', 'etorresn@sena.edu.co', 'Se observa acumulación de agua en la rampa del parqueadero auxiliar torre norte', 6, '2017-03-17 13:37:08', '2017-03-17', '2017-12-31', NULL, 3, ''),
(121, 49, 3, 'Nicolás', '', 'Espinosa', 'Santana', 'nespinosa@sena.edu.co', 'Solicito instalación de las 3 carpas y 100 (Cien) sillas del Centro de Servicios Gestión Empresarial para evento de "Integración instructores" para el día 03/25/2017 a las 12:00 pm', 4, '2017-03-17 16:06:51', '2017-03-21', '2017-03-24', NULL, 1, ''),
(122, 45, 3, 'Efrain ', '', 'Torres ', '', 'etorresn@sena.edu.co', 'Se requiere el traslado de sillas que se encuentran el la sede de cocina gourmet para la torre norte.', 6, '2017-03-17 16:40:58', '2017-03-17', '2017-03-22', NULL, 3, ''),
(123, 178, 2, 'Efrain ', '', 'Torres', '', 'etorresn@sena.edu.co', 'La luminara que esta entre la impresora y mi puesto de trabajo tiene un tubo que esta parpadeando y esto causa incomodidad para laborar.', 6, '2017-03-17 17:06:39', '2017-03-17', '2017-03-18', NULL, 2, ''),
(124, 181, 1, 'Juan ', 'Pablo', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'Se requiere mantenimiento preventivo', 3, '2017-03-17 18:59:56', '2017-03-17', '2017-03-17', NULL, 2, ''),
(125, 183, 1, 'Juan ', 'Pablo ', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'se requiere mantenimiento preventivo ', 3, '2017-03-17 19:01:13', '2017-03-17', '2017-03-17', NULL, 2, ''),
(126, 2, 3, 'Efrain ', '', 'Torres', '', 'etorresn@sena.edu.co', 'Se requiere limpieza superficial del montacargas', 6, '2017-03-17 19:33:18', '2017-03-17', '2017-03-17', NULL, 3, ''),
(127, 7, 3, 'francisco', '', 'perez', '', 'chtovar@sena.edu.co', 'se revienta abasto llave lavamanos y fluxometro inodoro malo', 6, '2017-03-21 11:50:12', '2017-03-21', '2017-03-21', NULL, 2, ''),
(128, 5, 3, 'argelid ', '', 'jaramillo', 'isaza', 'arjaramillo@sena.edu.co', 'soporte de extintor flojo', 6, '2017-03-21 12:36:18', '2017-03-21', '2017-03-21', NULL, 1, ''),
(129, 61, 4, 'Maria', '', 'Eglandid', '', 'mrestre@sena.edu.co', 'se requiere de nuevo circuito eléctrico para pasar escritorio y se necesita de 2 tomas adicionales para conectar equipos que se necesitan', 4, '2017-03-21 14:02:36', '2017-03-21', '2017-03-24', NULL, 1, ''),
(130, 61, 3, 'Maria Eglandid', '', ' Eglandid', '', 'mrestre@sena.edu.co', 'se solicita organizar estantería metálica, 4 cuerpos', 6, '2017-03-22 11:05:09', '2017-03-22', '2017-03-22', NULL, 1, ''),
(131, 304, 3, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Puerta del  Contac Center  (BPO) piso 1, se encuentra colgada y hay que meterle el hombro para poder cerrarla.\r\nLlave pegada a la cerradura  del aula 411 y ya no permite abrir desde afuera.\r\n\r\n', 3, '2017-03-22 11:57:32', '2017-03-22', '2017-03-22', NULL, 1, ''),
(132, 381, 3, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Cambio de 2 llaves sencillas de Lavamanos  por Llave Ahorradora de Push, se esta desperdiciando mucha agua al quedar abierta la llave', 3, '2017-03-22 12:16:21', '2017-03-22', '2017-03-25', NULL, 2, 'Baño 5° piso Hombres C Comercio.jpg'),
(133, 322, 3, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Recortar 10 cm. de patas  de 5 mesas en madera del piso 3° Almasena.', 3, '2017-03-22 13:16:07', '2017-04-07', '2017-04-15', NULL, 3, 'RECORTE PATAS MESAS AULA 3 PISO ALMASENA 1.jpg'),
(134, 230, 1, 'victor  ', 'hugo', 'cardona', 'bernal', 'vcardona@sena.edu.co', 'minisplit  con  fuga  de gas  refrigerante  R22   congelado ..', 3, '2017-03-22 14:30:52', '2017-03-23', '2017-03-24', NULL, 1, ''),
(135, 275, 1, 'victor', 'hugo', 'cardona ', 'bernal', 'vcardona@sena.edu.co', 'equipo U.C.A 5TR  60000  BTU marca  YORK     PREWSENTA  FUGA DE GAS REFRIGERANTE  Y  HUMEDAD .....ESTA  UBICADO EN LA  TERRAZA PISO 12.....EL  SAM   SOLO  TIENE  HASTA  PISO  5  EN  TORRE SUR  ..DEBEMOS  SOLICITAR  LO  RE-DISEÑEN  EN  FABRICA DE  SOFTWARE ', 3, '2017-03-22 14:39:31', '2017-03-23', '2017-03-31', NULL, 1, ''),
(136, 322, 1, 'victor ', 'hugo', 'cardona ', 'bernal', 'vcardona@sena.edu.co', 'cambio de compresor, presurizacion ,vacio y  carga de refrigerante R410a  en  UCA   Minisplit   24000 btu   Marca CIIAC    ', 3, '2017-03-22 14:43:28', '2017-03-23', '2017-03-31', NULL, 1, ''),
(137, 266, 1, 'victor ', 'hugo', 'cardona ', 'bernal', 'vcardona@sena.edu.co', 'reparacion de bomba de agua de condensados  en consola  cassette  MARCA  YORK de salon # 6  de contact  center  BPO  ', 3, '2017-03-22 14:52:34', '2017-03-23', '2017-03-31', NULL, 1, ''),
(138, 51, 1, 'VICTOR ', 'HUGO', 'CARDONA ', 'BERNAL', 'vcardona@sena.edu.co', 'desmonte y traslado de  equipo de aire GEVA  12000 BTU  MARCA  TRAINE   ,  Y  POSTERIO  INSTALACION  EN  RACK ALEDAÑO  DE SISTEMAS  FORMACION ALUMNOS ', 3, '2017-03-22 14:55:27', '2017-03-23', '2017-03-31', NULL, 1, ''),
(139, 327, 2, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Organizar lámparas de 60 x 60 de las aulas 318 y 506 que tiene el balastro y cableado por fuera y les falta las rejillas.', 2, '2017-03-22 15:14:50', NULL, NULL, NULL, 1, 'lampara aula 506 y 318.jpg'),
(140, 60, 3, 'Efrain ', '', 'Torres ', '', 'etorresn@sena.edu.co', 'Se solicita el traslado de 4 estanterías metálicas del sótano al piso 3, archivo documental', 6, '2017-03-22 15:15:57', '2017-03-23', '2017-03-23', NULL, 1, ''),
(141, 188, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'mantenimiento preventivo', 3, '2017-03-22 15:26:50', '2017-03-23', '2017-03-31', NULL, 1, ''),
(142, 163, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'mantenimiento preventivo unidad manejadora #1', 3, '2017-03-22 15:28:58', '2017-03-23', '2017-03-31', NULL, 1, ''),
(143, 164, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'mantenimiento preventivo unidad manejadora #2', 3, '2017-03-22 15:30:03', '2017-03-23', '2017-03-31', NULL, 1, ''),
(144, 153, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', '\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nmantenimiento preventivo unidad manejadora de aire en el cuarto tecnico en el ambiente 8-06\r\n', 3, '2017-03-22 15:32:27', '2017-03-23', '2017-03-31', NULL, 1, ''),
(145, 149, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'mantenimiento preventivo unidad manejadora de aire en el cuarto tecnico', 3, '2017-03-22 15:33:45', '2017-03-23', '2017-03-31', NULL, 1, ''),
(146, 135, 1, 'Juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'mantenimiento preventivo unidad manejadora de aire cuarto tecnico cerca a la terraza norte', 3, '2017-03-22 15:36:08', '2017-03-23', '2017-03-31', NULL, 1, ''),
(147, 77, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'mantenimiento preventivo unidad manejadora de aire cuarto tecnico al lado de terraza norte', 3, '2017-03-22 15:38:00', '2017-03-23', '2017-03-31', NULL, 1, ''),
(148, 84, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'mantenimiento preventivo unidad manejadora de aire cuarto tecnico, al lado de terraza sur', 3, '2017-03-22 15:39:42', '2017-03-23', '2017-03-31', NULL, 1, ''),
(149, 366, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'instalacion moto compresor de refrigerante 410a , al aire acondicionado del ambiente 411. con señor Hector Raul Lopez', 3, '2017-03-22 15:46:47', '2017-03-23', '2017-03-31', NULL, 1, ''),
(150, 367, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'instalacion moto compresor de refrigerante 410a , al aire acondicionado del ambiente 412. con señor Hector Raul Lopez', 3, '2017-03-22 15:47:46', '2017-03-23', '2017-03-31', NULL, 1, ''),
(151, 323, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'instalacion moto compresor de refrigerante 410a , al aire acondicionado del ambiente 320. con el señor Hector Raul Lopez', 3, '2017-03-22 15:49:33', '2017-03-23', '2017-03-31', NULL, 1, ''),
(152, 258, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'instalacion aire acondcionado de refrigerante 410a , del ambiente primer piso de la agencia publica emprleo, entrada por avenida del ferrocarril. realizado  con el señor Hector Raul Lopez', 3, '2017-03-22 15:53:45', '2017-03-23', '2017-03-31', NULL, 1, ''),
(153, 368, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'instalacion aire acondcionado desmontados para la reparacion y/o cambio del piso en la terraza de piso 2 al lado del bienestar y droqgueria. 2 equipo de aire acondiconado de refrigerante 410a  y 1 de refrigerante 22. realizado con el señor Hector Raul Lopez', 3, '2017-03-22 15:58:35', '2017-03-23', '2017-03-31', NULL, 1, ''),
(154, 369, 1, 'juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'instalacion motocompresor de refrigerante 410a, al aire acondicionado del ambiente 3 1/2 - 2. con el señor Hector Raul Lopez.', 3, '2017-03-22 16:01:19', '2017-03-23', '2017-03-31', NULL, 1, ''),
(155, 370, 1, 'Juan', '', 'Valencia', '', 'jpvalencia9@misena.edu.co', 'Instalacion 4 equipos desmontados de aire acondcionado con refrigerante 22, para reparacion y/o cambio del piso en la terraza lado norte piso 5. ', 3, '2017-03-22 16:03:51', '2017-03-23', '2017-03-31', NULL, 1, ''),
(156, 324, 1, 'juan', '', 'Pablo', '', 'jpvalencia92@misena.edu.co', 'Piso 6. Instalación bomba condensado al aire acondicionado del ambiente 602, con Ivan Dario Rojas y Hector Raul Lopez.', 3, '2017-03-22 16:07:46', '2017-03-23', '2017-03-31', NULL, 1, ''),
(157, 388, 1, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Mantenimiento de Equipo Aire Acondicionado piso 4 ½ Oficina de Mirian Fanny, tiene dañado el Blower, Héctor lo desmontó', 3, '2017-03-22 20:07:23', '2017-03-23', '2017-03-31', NULL, 1, ''),
(158, 41, 3, 'jairo', '', 'velasquez', '', 'javelas@sena.edu.co', 'cambio  de  chapa oficina SETRASENA ', 6, '2017-03-23 12:29:00', '2017-03-23', '2017-03-25', NULL, 1, ''),
(159, 130, 3, 'Francisco ', '', 'perez', '', 'chtovar@sena.edu.co', 'chapa de ambiente 7-05, no abre, no se a podido dictar formación ', 6, '2017-03-23 12:31:27', '2017-03-23', '2017-03-23', NULL, 1, ''),
(160, 301, 3, 'Olga', 'Cecilia', 'Pineda', '', 'ocpinedac@sena.edu.co', 'Reforma total de mueble:  cam,bio rieles, chapa y pintura', 2, '2017-03-23 15:43:17', NULL, NULL, NULL, 3, ''),
(161, 313, 3, 'Claudia', 'Elena ', 'Lopez', 'Perez ', 'celopez@sena.edu.co', 'Reforma de mueble: cambio chapilla y mueble de oficiina y desarme de muebe para trasladarlo a otra oficina', 2, '2017-03-23 15:46:50', NULL, NULL, NULL, 3, ''),
(162, 310, 3, 'Amparo ', 'del Socorro', 'Sierra', 'Arcila', 'amsierra@sena.edu.co', 'Pintura en lugar donde estaba la recepcion ya que quedo un parche', 2, '2017-03-23 15:51:54', NULL, NULL, NULL, 3, ''),
(163, 172, 3, 'MARTA', 'LUCIA', 'ISAZA', 'SUAREZ', 'misaza@sena.edu.co', 'Solicitud instalación estantería en el tercer piso- Oficina Gestión documental', 4, '2017-03-23 17:48:03', '2017-03-24', '2017-03-24', NULL, 3, ''),
(164, 306, 1, 'Javier', '', 'Mallama', 'Benavides', 'jmallama@sena.edu.co', 'Solicito reparación del aire acondicionado del ambiente 6-4, el cual presenta un goteo constante.', 1, '2017-03-23 18:45:31', NULL, NULL, NULL, 1, ''),
(165, 371, 1, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Revisión de equipos de aire acondicionado en Contac Center 1° piso y aula 701 7° piso, estan botando agua y no están enfriando.\r\n', 2, '2017-03-23 18:52:17', NULL, NULL, NULL, 1, ''),
(166, 301, 4, 'Javier', '', 'Mallama', 'Benavides', 'jmallama@sena.edu.co', 'Solicito reparación del circuito eléctrico del laboratorio de procesos magistrales, ubicado en el piso 2 alado del imágenes diagnosticas ', 1, '2017-03-23 18:57:00', NULL, NULL, NULL, 1, ''),
(167, 59, 3, 'Maria', '', 'Restrepo ', '', 'mrestre@sena.edu.co', 'Se requieren cortinas o persianas para el archivo', 4, '2017-03-23 20:51:42', '2017-03-24', '2017-04-01', NULL, 1, ''),
(168, 97, 3, 'Erik', 'Humberto', 'Arbelaez ', 'Hincapie', 'earbelaez@sena.edu.co', 'La presente para el préstamo de la terraza torre Norte piso 4 el día  28 de Marzo en el horario de 11:00 am a 3:00 pm. responde la instructora: Mireya Mejia Burgos quien ejecuta la actividad con los aprendices de la ficha 1026088', 2, '2017-03-24 16:07:21', NULL, NULL, NULL, 1, ''),
(169, 160, 3, 'Francisco', '', 'perez', '', 'chtovar@sena.edu.co', 'arreglo silleteria', 4, '2017-03-25 10:07:41', '2017-03-27', '2017-03-27', NULL, 3, ''),
(170, 8, 3, 'Francisco', '', 'perez', '', 'chtovar@sena.edu.co', 'baños de hombres y mujeres inodoros botando agua', 4, '2017-03-25 10:10:37', '2017-03-27', '2017-03-27', NULL, 3, ''),
(171, 266, 3, 'Francisco', 'JAVIER', 'JARAMILLO', 'VILLEGAS', 'francojara@misena.edu.co', 'Retirar del ambiente del contact center, una mesa deteriorada que se encuentra en el pasillo, además descargarla del inventario.', 2, '2017-03-27 15:02:27', NULL, NULL, NULL, 1, ''),
(172, 56, 1, 'Juan', '', 'valencia', '', 'jpvalencia92@misena.edu.co', 'mantenimiento preventivo uma en el cuarto tecnico de fabrica de software. con el senñor Ivan Dario Rojas', 1, '2017-03-27 16:55:40', NULL, NULL, NULL, 1, ''),
(173, 61, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'Se realiza mantenimiento uma ubicada en archivo. Se realiza con el señor Ivan Dario Rojas.', 1, '2017-03-27 16:56:54', NULL, NULL, NULL, 1, ''),
(174, 65, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'Se realiza mantenimiento preventivo a la UMA ubicada en el cuarto técnico al lado de la cocineta. Se realiza con el señor Ivan Darios Rojas.', 3, '2017-03-27 16:59:20', '2017-06-20', '2017-06-25', NULL, 1, ''),
(175, 6, 1, 'Juan', '', 'Valencia', '', 'jpavalencia92@misena.edu.co', 'Se realiza mantenimiento preventivo a la UMA ubicada en el cuarto técnico en artes gráficas. Se realiza con el señor Ivan Dario Rojas', 2, '2017-03-27 17:01:40', NULL, NULL, NULL, 1, ''),
(176, 9, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'Se realiza mantenimiento a la UMA de la biblioteca y esta ubicada en el cuarto técnico de simulación. Se realiza con el señor Ivan Dario Rojas.', 2, '2017-03-27 17:03:55', NULL, NULL, NULL, 1, ''),
(177, 17, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'se hace Mantenimiento preventivo a la UMA de simulación ubicada en el cuarto técnico de simulación. Se realiza con el señor Ivan Dario Rojas.', 3, '2017-03-27 17:05:37', '2017-05-12', '2017-05-23', NULL, 1, ''),
(178, 268, 3, 'David', '', 'Mejía', 'Mejía', 'dmejiam@sena.edu.co', 'Realizar traslado de 8 mesas y 8 sillas desde el auditorio de Videoconferencias, hacia la plazoleta de aprendices en Torre Sur, para un evento de universidades a las 9:00 am, y  devolverlas a las 5:00 pm a Torre norte ', 3, '2017-03-27 19:44:29', '2017-03-28', '2017-03-28', NULL, 1, ''),
(179, 269, 3, 'Johnny ', 'Martín ', 'Romero', 'Zuleta', 'lsmoreno87@misena.edu.co', 'Se necesitan 4 mesas y 8 sillas para evento que se llevará a cabo el día 03/28/2017 a las 6:00 pm. Trasladar sillas desde el auditorio de Videoconferencia hacia el Auditorio Carlos Castro en Torre sur ', 3, '2017-03-27 20:12:19', '2017-03-28', '2017-03-28', NULL, 1, ''),
(180, 1, 1, 'Juan', '', 'Valencia', '', 'jpvalencia92@misena.edu.co', 'Se le realizo mantenimiento preventivo a la UMA ubicada en el cuarto técnico del sótano, la cual suministra el aire acondicionado en el auditorio de videoconferencia. \r\nSe la cambiaran las guatas de los filtros, con los señores Ivan Dario Rojas Carmona y David Mazo.  ', 3, '2017-03-28 11:28:29', '2017-05-12', '2017-05-18', NULL, 1, ''),
(181, 97, 3, 'JEY', 'JOSE', 'AGUDELO', 'ORTEGA', 'jjagudelo@sena.edu.co', 'Reserva de la terraza del cuarto piso costado norte para el próximo jueves 30 de marzo del 2017 en el horario de 06:00 a 09:00 am', 1, '2017-03-28 16:01:28', NULL, NULL, NULL, 1, ''),
(182, 356, 3, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Traslado cilindro de chapas de la Puerta  del 5°piso a la puerta del 3° piso ', 2, '2017-03-29 12:05:50', NULL, NULL, NULL, 1, ''),
(183, 374, 2, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Instalación de canaleta  para conducir cables e instalación de 2 tomas dobles en Puesto de trabajo de Mónica Rodriguez ', 2, '2017-03-29 12:14:06', NULL, NULL, NULL, 3, ''),
(184, 265, 3, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Tapar con cemento 2 huecos que están en el piso del aula de Bilinguismo  Centro de Comercio', 2, '2017-03-29 12:24:57', NULL, NULL, NULL, 1, ''),
(185, 366, 2, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'independizar iluminación de aulas 412 y 413\r\naulas 414 y 415', 2, '2017-03-29 12:40:52', NULL, NULL, NULL, 1, ''),
(186, 334, 1, 'Carlos', 'Mario', 'Mejía', 'Vélez', 'cmejia@sena.edu.co', 'Favor revisar al aire acondicionado del aula 317 está chorreando agua.', 3, '2017-03-29 13:30:48', '2017-05-12', '2017-05-17', NULL, 1, ''),
(187, 268, 3, 'Blanca', 'Libia', 'Manco', 'Berrío', 'blalima@sena.edu.co', 'Para evento de matrículas de aprendices, programado para los días 30y 31 de marzo, se nos asignó la pzoleta contínua al salón de los espjos, se necesita el traslado de 70 sillas y 6 mesas del Centro de Servicios y Gestión Empresarial. el evento empezará a las 8:00 am y terminará a las 4:00 pm ambos días. ', 3, '2017-03-29 16:38:37', '2017-03-30', '2017-03-31', NULL, 1, ''),
(188, 56, 5, 'yirleison', '', 'palomeque', '', 'ypalomeque@misena.edu.co', 'el ascensor se varo', 2, '2017-03-30 14:55:27', NULL, NULL, NULL, 1, ''),
(189, 50, 5, 'juan', '', 'gomez', '', 'jgomez@misena.edu.co', 'se daño', 2, '2017-03-30 15:09:03', NULL, NULL, NULL, 1, ''),
(190, 34, 3, 'dfdfdf', 'dfdfdfd', 'dfdfdfd', 'dfdf', 'ffdfd@misena.edu.co', 'cvdfdfdfdf', 3, '2017-04-07 18:21:52', '2017-06-21', '2017-06-26', NULL, 1, ''),
(191, 56, 2, 'diego', '', 'ortiz', '', 'drortiz94@misena.edu.co', 'se daño esta guevonada', 4, '2017-04-17 15:44:47', '2017-04-17', '2017-04-22', NULL, 1, ''),
(192, 321, 3, 'yirleison', '', 'palomeque', '', 'drortiz94@misena.edu.co', 'se daño un escritorio', 4, '2017-04-17 16:12:40', '2017-04-18', '2017-04-23', NULL, 1, '10197859.jpg'),
(193, 56, 3, 'juan ', 'pablo', 'muñoz', '', 'jpmunoz26@misena.edu.co', 'se daño la puerta de la entrada', 4, '2017-04-24 12:44:38', '2017-04-24', '2017-04-30', NULL, 1, ''),
(194, 50, 1, 'juan', 'pablo', 'muñoz', 'romero', 'jpmunoz26@misena.edu.co', 'El aire no enfria ', 3, '2017-06-02 19:36:35', '2017-06-02', '2017-06-07', NULL, 1, ''),
(195, 57, 1, 'Diego ', 'raul', 'ortiz', 'hernandez', 'drortiz94@misena.edu.co', 'el aire acondicionado no esta enfriando', 3, '2017-06-02 19:43:47', '2017-06-02', '2017-06-07', NULL, 1, ''),
(196, 59, 1, 'Diego ', 'raul', 'ortiz', 'hernandez', 'drortiz94@misena.edu.co', 'el aire de la oficina no esta enfriando', 6, '2017-06-02 19:48:42', '2017-06-02', '2017-06-07', NULL, 1, ''),
(197, 54, 5, 'diego ', 'RAUL', 'ortiz', 'hernandez', 'drortiz94@misena.edu.co', 'se daño', 3, '2017-06-15 18:55:02', '2017-06-15', '2017-06-20', NULL, 1, ''),
(198, 52, 1, 'yessi', '', 'zapata', '', 'yzapata@misena.edu.co', 'hola', 2, '2017-07-06 16:47:25', NULL, NULL, NULL, 1, 'alfalfa.jpg'),
(199, 24, 1, 'diego', '', 'ortiz', '', 'dortiz@misena.edu.co', 'como estas', 2, '2017-07-06 16:48:35', NULL, NULL, NULL, 1, 'alfalfa.jpg'),
(200, 31, 1, 'leon', '', 'chanci', '', 'lchanci@misena.edu.co', 'hla', 3, '2017-07-06 16:54:01', '2017-08-11', '2017-08-25', NULL, 1, 'alfalfa.jpg'),
(201, 53, 1, 'alexandra', '', 'pino', '', 'apinom@sena.edu.co', 'el aire acondicionado no esta enfriando bien', 6, '2017-07-13 15:33:55', '2017-07-13', '2017-07-18', NULL, 2, ''),
(202, 50, 3, 'omar', '', 'lopez', '', 'olopezj@misena.edu.co', 'la perta del ambiente se daño', 6, '2017-07-28 15:52:01', '2017-07-28', '2017-08-02', NULL, 1, ''),
(203, 31, 3, 'bertha', '', 'morales', '', 'bpmorales@misena.edu.co', 'la puerta esta dañada', 6, '2017-07-28 16:02:09', '2017-07-28', '2017-08-04', NULL, 1, ''),
(204, 8, 1, 'leon', '', 'chanci', '', 'leon@misena.edu.co', 'se daño', 6, '2017-08-10 16:34:06', '2017-08-11', '2017-08-23', NULL, 1, ''),
(205, 55, 3, 'diego ', 'raul', 'ortiz', 'hernandez', 'drortiz94@misena.edu.co', 'se daño la puerta\r\n', 1, '2017-08-11 16:19:56', NULL, NULL, NULL, 1, ''),
(206, 54, 1, 'alexandra', '', 'pino', '', 'alexandrapino@misena.edu.co', 'el aire no enfria', 2, '2017-08-11 17:07:10', NULL, NULL, NULL, 1, ''),
(207, 27, 5, 'prueba', 'prueba', 'prueba', 'pprueba', 'jepulgarin16@misena.edu.co', 'prueba', 1, '2017-08-14 14:01:58', NULL, NULL, NULL, 1, ''),
(208, 3, 2, 'ik', 'oi', 'iio', 'iiiuoi', 'jep@misena.edu.co', 'iuoiuo', 5, '2017-08-14 19:05:47', NULL, NULL, 'u9i', 1, 'alfalfa.jpg'),
(209, 1, 2, 'ty', 'rtyrty', 'tryrt', 'rtyrt', 'a@misena.edu.co', 'hola', 1, '2017-08-14 19:07:55', NULL, NULL, NULL, 1, 'internet.jpg'),
(210, 3, 1, 'sdasdsa', 'sadasd', 'asdasd', 'asdasdsa', 'a@misena.edu.co', 'fgfdfg', 2, '2017-08-14 19:13:37', NULL, NULL, NULL, 1, ''),
(211, 5, 2, '<z', 'asd', 'sada', 'asdsa', 'w@misena.edu.co', 'dsfdfsd', 1, '2017-08-14 19:17:11', NULL, NULL, NULL, 1, ''),
(212, 27, 2, 'vcx', 'sadas', 'sadasd', 'sadasd', 'a@misena.edu.co', 'asdasdas', 1, '2017-08-14 19:22:04', NULL, NULL, NULL, 1, ''),
(213, 369, 2, 'd', 'df', 'sdf', 'sdf', 'a@misena.edu.co', '<', 1, '2017-08-14 19:22:30', NULL, NULL, NULL, 1, ''),
(214, 38, 2, 'dsad', 'sadsad', 'sadsad', 'sadsad', 'asdasd@sena.edu.co', '<>', 1, '2017-08-14 19:59:49', NULL, NULL, NULL, 1, ''),
(215, 27, 1, 'sdgd', 'asdsf', 'dsfdsf', 'sdfsdf', 'a@misena.edu.co', 'abcdefghijkmñnopq', 5, '2017-08-14 20:02:43', NULL, NULL, 'prueba', 1, 'internet.jpg'),
(216, 114, 2, 'jsadjdsj', '', 'jsjsjss', '', 'a@misena.edu.co', 'llllllllll', 1, '2017-08-15 12:45:57', NULL, NULL, NULL, 1, ''),
(217, 262, 2, 'juan', '', 'asdsa', '', 'asdsad@sena.edu.co', 'Á', 1, '2017-08-15 12:48:07', NULL, NULL, NULL, 1, ''),
(218, 519, 2, 'w', '', 'asd', '', 'a@misena.edu.co', 'ÁÉ', 2, '2017-08-15 12:50:54', NULL, NULL, NULL, 1, ''),
(219, 58, 1, 'zx', '', 'xc', '', 'zxc@misena.edu.co', '<script>sadsad>', 1, '2017-08-15 12:52:26', NULL, NULL, NULL, 1, ''),
(220, 53, 1, 'A', '', 'A', '', 'A@misena.edu.co', '<script>alert("o si ");</script>', 2, '2017-08-15 13:02:24', NULL, NULL, NULL, 1, ''),
(221, 13, 1, 'a', '', 'aa', '', 'a@misena.edu.co', 'a-zA-ZáéíóúüñÁÉÍÓÚÜÑ', 2, '2017-08-15 13:05:42', NULL, NULL, NULL, 1, ''),
(222, 42, 2, 'asd', '', 'ad', '', 'a@misena.edu.co', 'dsa<asdasdsdsa>', 1, '2017-08-15 13:14:54', NULL, NULL, NULL, 1, ''),
(223, 511, 2, 'da', '', 'sd', '', 'dsadas@misena.edu.co', '<', 1, '2017-08-15 13:34:52', NULL, NULL, NULL, 1, ''),
(224, 261, 2, 'ada', '', 'adsd', '', 'adas@misena.edu.co', ' <', 2, '2017-08-15 13:36:47', NULL, NULL, NULL, 1, ''),
(225, 17, 2, 'a', '', 'a', '', 'a@misena.edu.co', 'a<', 2, '2017-08-15 13:44:28', NULL, NULL, NULL, 1, ''),
(226, 330, 1, 'ws', '', 'sd', '', 'a@misena.edu.co', '<script>', 2, '2017-08-15 13:51:22', NULL, NULL, NULL, 1, ''),
(227, 442, 1, 'a', '', 'asd', '', 'jepsdsad@misena.edu.co', '<scrip>for(;)alert("hola");<script>', 2, '2017-08-15 13:54:47', NULL, NULL, NULL, 1, ''),
(228, 198, 2, 'dad', 'asd', 'asdasd', '', 'a@misena.edu.co', '<script>for()</script>', 1, '2017-08-15 14:05:48', NULL, NULL, NULL, 1, ''),
(229, 203, 1, 'ds', '', 'sdfsd', '', 'a@misena.edu.co', '<>', 1, '2017-08-15 15:36:13', NULL, NULL, NULL, 1, ''),
(230, 379, 1, 'sda', '', 'asd', '', 'a@misena.edu.co', '68454684', 1, '2017-08-15 15:42:07', NULL, NULL, NULL, 1, ''),
(231, 101, 1, 'ds', '', 'asd', '', 'asd@misena.edu.co', '5446546545', 1, '2017-08-15 15:50:23', NULL, NULL, NULL, 1, ''),
(232, 148, 1, 'Juan', 'Esteban', 'Pulgarin', 'Acevedo', 'jepulgarin16@misena.edu.co', '', 2, '2017-08-15 16:22:29', NULL, NULL, NULL, 1, ''),
(233, 510, 2, 'weqwe', 'asdasd', 'sadasd', 'asdsadsadsa', 'je@misena.edu.co', '', 1, '2017-08-15 16:26:10', NULL, NULL, NULL, 1, ''),
(234, 167, 2, 'wqe', 'qwe', 'wqe', 'qwe', 'a@misena.edu.co', 'dsadasdadsd', 1, '2017-08-15 16:28:53', NULL, NULL, NULL, 1, ''),
(235, 117, 1, 'qwewq', 'wqewqe', 'wqeqwe', 'qweqwewq', 'a@misena.edu.co', 'Hola mundo ', 2, '2017-08-15 16:42:04', NULL, NULL, NULL, 1, ''),
(236, 10, 1, 'ew', 'qweqw', 'qwe', 'qweqw', 'a@misena.edu.co', 'sadisoajdoahasjdhnaosdjid', 1, '2017-08-15 16:46:47', NULL, NULL, NULL, 1, ''),
(237, 55, 1, 'asdsad', 'adsad', 'asdsad', 'sadasd', 'DSDSAD@misena.edu.co', 'dasdasd', 6, '2017-08-15 19:00:14', '2017-08-18', '2017-08-31', NULL, 1, ''),
(238, 29, 2, 'Alejandro', '', 'Velez', '', 'avelez90@misena.edu.co', 'Se daño el foco.', 6, '2017-08-23 12:46:57', '2017-08-23', '2017-08-31', NULL, 1, '10197859.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltecnicosolicitudes`
--

CREATE TABLE IF NOT EXISTS `tbltecnicosolicitudes` (
  `idTecnicoSolicitud` int(11) NOT NULL,
  `idSolicitud` int(11) NOT NULL,
  `numeroIdentificacion` varchar(45) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idCuentaUsuario` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbltecnicosolicitudes`
--

INSERT INTO `tbltecnicosolicitudes` (`idTecnicoSolicitud`, `idSolicitud`, `numeroIdentificacion`, `fecha`, `idCuentaUsuario`) VALUES
(69, 85, '1020431601', '2017-03-08 18:48:45', 18),
(70, 84, '15256627', '2017-03-08 19:01:25', 30),
(72, 86, '71591822', '2017-03-08 19:31:40', 32),
(73, 86, '98589653', '2017-03-08 19:31:41', 32),
(74, 87, '98589653', '2017-03-08 20:50:59', 32),
(75, 88, '102355478', '2017-03-10 12:25:43', 34),
(76, 90, '15256627', '2017-03-10 12:48:21', 43),
(77, 89, '1128478329', '2017-03-10 20:47:54', 42),
(78, 92, '71591822', '2017-03-10 22:18:26', 34),
(79, 92, '98589653', '2017-03-10 22:18:26', 34),
(80, 93, '15256627', '2017-03-13 12:14:29', 24),
(81, 95, '102355478', '2017-03-13 14:24:16', 34),
(82, 94, '15256627', '2017-03-13 14:39:07', 32),
(83, 91, '102355478', '2017-03-13 15:12:33', 34),
(84, 96, '102355478', '2017-03-13 15:39:08', 34),
(85, 99, '102355478', '2017-03-14 13:39:24', 34),
(86, 98, '102355478', '2017-03-14 13:40:01', 34),
(87, 97, '102355478', '2017-03-14 13:40:35', 34),
(88, 103, '436309340', '2017-03-14 16:48:47', 31),
(89, 102, '436309340', '2017-03-14 16:49:41', 31),
(90, 100, '102355478', '2017-03-14 16:51:08', 31),
(91, 101, '1128478329', '2017-03-14 18:52:40', 42),
(92, 104, '436309340', '2017-03-14 21:40:09', 34),
(94, 110, '102355478', '2017-03-16 12:47:56', 34),
(95, 109, '102355478', '2017-03-16 12:48:39', 34),
(96, 114, '102355478', '2017-03-16 15:00:17', 34),
(97, 113, '102355478', '2017-03-16 15:01:48', 34),
(98, 115, '436309340', '2017-03-16 15:10:32', 31),
(99, 116, '436309340', '2017-03-16 15:43:44', 31),
(100, 117, '436309340', '2017-03-16 22:16:59', 34),
(101, 118, '102355478', '2017-03-17 15:36:34', 34),
(102, 118, '71591822', '2017-03-17 15:36:34', 34),
(103, 118, '98589653', '2017-03-17 15:36:34', 34),
(104, 120, '436309340', '2017-03-17 15:43:31', 34),
(105, 122, '436309340', '2017-03-17 16:41:52', 34),
(106, 119, '102355478', '2017-03-17 16:42:33', 34),
(107, 108, '102355478', '2017-03-17 16:43:00', 34),
(108, 123, '102355478', '2017-03-17 17:07:30', 34),
(109, 123, '71591822', '2017-03-17 17:07:30', 34),
(110, 123, '98589653', '2017-03-17 17:07:31', 34),
(111, 125, '1128478329', '2017-03-17 19:02:41', 34),
(112, 125, '71761148', '2017-03-17 19:02:41', 34),
(113, 124, '1128478329', '2017-03-17 19:03:06', 34),
(114, 124, '71761148', '2017-03-17 19:03:06', 34),
(115, 126, '436309340', '2017-03-17 19:34:05', 34),
(116, 127, '102355478', '2017-03-21 12:32:15', 34),
(117, 128, '102355478', '2017-03-21 16:22:41', 34),
(118, 121, '436309340', '2017-03-21 16:23:33', 34),
(119, 129, '102355478', '2017-03-21 16:26:12', 34),
(120, 129, '98589653', '2017-03-21 16:26:13', 34),
(121, 111, '102355478', '2017-03-21 16:26:54', 34),
(122, 111, '98589653', '2017-03-21 16:26:54', 34),
(123, 106, '15256627', '2017-03-21 17:15:49', 32),
(124, 107, '15256627', '2017-03-21 17:16:22', 32),
(125, 105, '71591822', '2017-03-21 17:17:06', 32),
(126, 105, '98589653', '2017-03-21 17:17:06', 32),
(127, 130, '102355478', '2017-03-22 15:00:30', 34),
(131, 112, '102355478', '2017-03-22 15:08:37', 34),
(132, 131, '15256627', '2017-03-22 19:32:56', 32),
(133, 132, '15256627', '2017-03-22 19:34:49', 32),
(134, 133, '15256627', '2017-03-22 19:36:14', 32),
(135, 157, '716654322', '2017-03-23 13:30:43', 42),
(136, 134, '716654322', '2017-03-23 13:32:16', 42),
(137, 135, '716654322', '2017-03-23 13:33:12', 42),
(138, 136, '716654322', '2017-03-23 13:33:43', 42),
(139, 137, '716654322', '2017-03-23 13:34:15', 42),
(140, 138, '716654322', '2017-03-23 13:34:31', 42),
(141, 141, '716654322', '2017-03-23 13:35:19', 42),
(142, 142, '716654322', '2017-03-23 13:35:39', 42),
(143, 143, '716654322', '2017-03-23 13:36:04', 42),
(144, 144, '716654322', '2017-03-23 13:36:22', 42),
(145, 145, '716654322', '2017-03-23 13:36:38', 42),
(146, 146, '716654322', '2017-03-23 13:36:58', 42),
(147, 147, '716654322', '2017-03-23 13:42:53', 42),
(148, 148, '716654322', '2017-03-23 13:43:27', 42),
(149, 149, '716654322', '2017-03-23 13:43:56', 42),
(150, 150, '716654322', '2017-03-23 13:44:45', 42),
(151, 151, '716654322', '2017-03-23 13:45:48', 42),
(152, 152, '716654322', '2017-03-23 13:46:09', 42),
(153, 153, '716654322', '2017-03-23 13:46:31', 42),
(154, 154, '716654322', '2017-03-23 13:47:03', 42),
(155, 155, '716654322', '2017-03-23 13:47:29', 42),
(156, 156, '716654322', '2017-03-23 13:47:58', 42),
(157, 159, '102355478', '2017-03-23 15:01:02', 34),
(158, 158, '102355478', '2017-03-23 15:01:27', 34),
(159, 140, '436309340', '2017-03-23 15:02:03', 34),
(160, 167, '102355478', '2017-03-24 15:12:26', 34),
(161, 163, '102355478', '2017-03-24 15:13:16', 34),
(162, 170, '102355478', '2017-03-27 12:20:46', 34),
(163, 169, '102355478', '2017-03-27 12:21:21', 34),
(164, 178, '436309340', '2017-03-27 19:45:55', 31),
(165, 179, '436309340', '2017-03-27 20:16:36', 31),
(166, 191, '716654322', '2017-04-17 16:20:04', 18),
(167, 192, '716654322', '2017-04-18 12:24:08', 18),
(168, 193, '716654322', '2017-04-24 12:50:25', 18),
(169, 186, '0000', '2017-05-12 16:05:31', 18),
(170, 180, '1128478329', '2017-05-12 16:07:19', 18),
(171, 177, '15256627', '2017-05-12 16:46:54', 18),
(172, 194, '716654322', '2017-06-02 19:38:12', 18),
(173, 195, '716654322', '2017-06-02 19:44:34', 18),
(174, 196, '716654322', '2017-06-02 19:49:33', 18),
(175, 197, '716654322', '2017-06-15 18:57:53', 18),
(176, 174, '716654322', '2017-06-20 15:54:11', 18),
(177, 190, '0000', '2017-06-20 15:58:07', 18),
(178, 201, '716654322', '2017-07-13 15:37:03', 18),
(179, 202, '716654322', '2017-07-28 15:53:20', 18),
(180, 203, '716654322', '2017-07-28 16:03:39', 18),
(181, 204, '716654322', '2017-08-11 14:00:39', 18),
(182, 200, '716654322', '2017-08-11 16:20:30', 18),
(183, 237, '1216726372', '2017-08-18 20:26:12', 18),
(184, 238, '1216726372', '2017-08-23 12:48:40', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltipoempresa`
--

CREATE TABLE IF NOT EXISTS `tbltipoempresa` (
  `idTipoEmpresa` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbltipoempresa`
--

INSERT INTO `tbltipoempresa` (`idTipoEmpresa`, `nombre`) VALUES
(1, 'Proveedora de insumos'),
(2, 'Prestadora de servicios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltipoidentificacion`
--

CREATE TABLE IF NOT EXISTS `tbltipoidentificacion` (
  `idTipoIdentificacion` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `abreviacion` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbltipoidentificacion`
--

INSERT INTO `tbltipoidentificacion` (`idTipoIdentificacion`, `nombre`, `abreviacion`) VALUES
(1, 'Cédula de ciudadanía', 'C.C.'),
(2, 'Tarjeta de identidad', 'T.I.'),
(3, 'Cédula de extranjería', 'C.E.'),
(4, 'Documento nacional de identificación', 'D.N.I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltiposdevolucion`
--

CREATE TABLE IF NOT EXISTS `tbltiposdevolucion` (
  `idTipoDevolucion` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbltiposdevolucion`
--

INSERT INTO `tbltiposdevolucion` (`idTipoDevolucion`, `nombre`) VALUES
(1, 'Garantia'),
(2, 'Daño');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltiposequipos`
--

CREATE TABLE IF NOT EXISTS `tbltiposequipos` (
  `idTipoEquipo` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `idCategoria` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbltiposequipos`
--

INSERT INTO `tbltiposequipos` (`idTipoEquipo`, `Nombre`, `idCategoria`) VALUES
(1, 'Empotrado', 1),
(2, 'LED', 2),
(3, 'Infraestructura', 3),
(4, 'reflectores', 4),
(5, 'Fan-coil', 1),
(6, 'U.M.A', 1),
(7, 'U.C.A', 1),
(8, 'Mini-split', 1),
(9, 'Chiller', 1),
(10, 'Paquete', 1),
(11, 'Ventana', 1),
(12, 'Cassette', 1),
(13, 'VRF-Multiv', 1),
(14, 'Portatiles', 1),
(15, 'equipo Ascensor', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltiposriesgos`
--

CREATE TABLE IF NOT EXISTS `tbltiposriesgos` (
  `idTipoRiesgo` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbltiposriesgos`
--

INSERT INTO `tbltiposriesgos` (`idTipoRiesgo`, `Nombre`) VALUES
(1, 'Riesgo Ambiental'),
(2, 'Riesgo en seguridad y salud');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltorres`
--

CREATE TABLE IF NOT EXISTS `tbltorres` (
  `idTorre` int(11) NOT NULL,
  `Nombre` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `idComplejos` int(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbltorres`
--

INSERT INTO `tbltorres` (`idTorre`, `Nombre`, `idComplejos`) VALUES
(1, 'Torre norte', 1),
(2, 'Torre sur', 1),
(3, 'Gimnasio', 1),
(4, 'Agencia pública de empleo', 1),
(5, 'Piscina', 1),
(6, 'Tecnoparque', 1),
(7, 'Torre 5', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblunidadesmedida`
--

CREATE TABLE IF NOT EXISTS `tblunidadesmedida` (
  `idUnidadMedida` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `abreviacion` varchar(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblunidadesmedida`
--

INSERT INTO `tblunidadesmedida` (`idUnidadMedida`, `nombre`, `abreviacion`) VALUES
(1, 'Metros', 'm'),
(2, 'Centimetros', 'cm'),
(3, 'Unidades', 'un');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblusuarionotificaciones`
--

CREATE TABLE IF NOT EXISTS `tblusuarionotificaciones` (
  `idUsuarioNotificaciones` int(11) NOT NULL,
  `Estado` int(11) NOT NULL,
  `idNotificaciones` int(11) NOT NULL,
  `idCuentaUsuario` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3837 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `tblusuarionotificaciones`
--

INSERT INTO `tblusuarionotificaciones` (`idUsuarioNotificaciones`, `Estado`, `idNotificaciones`, `idCuentaUsuario`) VALUES
(234, 0, 191, 18),
(235, 0, 192, 18),
(237, 0, 193, 18),
(238, 0, 194, 18),
(239, 0, 195, 18),
(240, 0, 196, 18),
(242, 0, 197, 18),
(243, 0, 198, 18),
(244, 0, 199, 18),
(245, 0, 199, 24),
(246, 0, 199, 26),
(247, 0, 199, 27),
(248, 0, 199, 30),
(249, 0, 199, 31),
(250, 0, 199, 32),
(251, 0, 200, 18),
(252, 0, 200, 24),
(253, 0, 200, 26),
(254, 0, 200, 27),
(255, 0, 200, 30),
(256, 0, 200, 31),
(257, 0, 200, 32),
(258, 0, 201, 18),
(259, 0, 201, 24),
(260, 0, 201, 26),
(261, 0, 201, 27),
(262, 0, 201, 30),
(263, 0, 201, 31),
(264, 0, 201, 32),
(265, 0, 201, 25),
(266, 0, 202, 18),
(267, 0, 202, 24),
(268, 0, 202, 26),
(269, 0, 202, 27),
(270, 0, 202, 30),
(271, 0, 202, 31),
(272, 0, 202, 32),
(273, 1, 202, 23),
(274, 0, 203, 18),
(275, 0, 203, 24),
(276, 0, 203, 26),
(277, 0, 203, 27),
(278, 0, 203, 30),
(279, 0, 203, 31),
(280, 0, 203, 32),
(282, 0, 204, 18),
(283, 0, 204, 24),
(284, 0, 204, 26),
(285, 0, 204, 27),
(286, 0, 204, 30),
(287, 0, 204, 31),
(288, 0, 204, 32),
(289, 0, 205, 18),
(290, 0, 205, 24),
(291, 0, 205, 26),
(292, 0, 205, 27),
(293, 0, 205, 30),
(294, 0, 205, 31),
(295, 0, 205, 32),
(296, 0, 206, 18),
(297, 0, 206, 24),
(298, 0, 206, 26),
(299, 0, 206, 27),
(300, 0, 206, 30),
(301, 0, 206, 31),
(302, 0, 206, 32),
(303, 0, 207, 18),
(304, 0, 207, 24),
(305, 0, 207, 26),
(306, 0, 207, 27),
(307, 0, 207, 30),
(308, 0, 207, 31),
(309, 0, 207, 32),
(310, 1, 207, 33),
(311, 0, 208, 18),
(312, 0, 208, 24),
(313, 0, 208, 26),
(314, 0, 208, 27),
(315, 0, 208, 30),
(316, 0, 208, 31),
(317, 0, 208, 32),
(318, 0, 208, 28),
(319, 0, 209, 18),
(320, 0, 209, 24),
(321, 0, 209, 26),
(322, 1, 209, 27),
(323, 0, 209, 30),
(324, 0, 209, 31),
(325, 0, 209, 32),
(326, 0, 210, 18),
(327, 0, 210, 24),
(328, 0, 210, 26),
(329, 1, 210, 27),
(330, 0, 210, 30),
(331, 0, 210, 31),
(332, 0, 210, 32),
(333, 0, 211, 18),
(334, 0, 211, 24),
(335, 0, 211, 26),
(336, 1, 211, 27),
(337, 0, 211, 30),
(338, 0, 211, 31),
(339, 0, 211, 32),
(340, 0, 212, 18),
(341, 0, 212, 24),
(342, 0, 212, 26),
(343, 1, 212, 27),
(344, 0, 212, 30),
(345, 0, 212, 31),
(346, 0, 212, 32),
(347, 1, 212, 28),
(348, 0, 213, 18),
(349, 0, 213, 24),
(350, 0, 213, 26),
(351, 1, 213, 27),
(352, 0, 213, 30),
(353, 0, 213, 31),
(354, 0, 213, 32),
(355, 0, 213, 34),
(356, 0, 214, 18),
(357, 0, 214, 24),
(358, 0, 214, 26),
(359, 1, 214, 27),
(360, 0, 214, 30),
(361, 0, 214, 31),
(362, 0, 214, 32),
(363, 0, 214, 34),
(364, 0, 214, 42),
(365, 0, 215, 18),
(366, 0, 215, 24),
(367, 0, 215, 26),
(368, 1, 215, 27),
(369, 1, 215, 30),
(370, 0, 215, 31),
(371, 0, 215, 32),
(372, 0, 215, 34),
(373, 0, 215, 42),
(374, 0, 216, 18),
(375, 0, 216, 24),
(376, 0, 216, 26),
(377, 1, 216, 27),
(378, 1, 216, 30),
(379, 0, 216, 31),
(380, 0, 216, 32),
(381, 0, 216, 34),
(382, 0, 216, 42),
(383, 1, 216, 40),
(384, 0, 217, 18),
(385, 0, 217, 24),
(386, 0, 217, 26),
(387, 1, 217, 27),
(388, 1, 217, 30),
(389, 0, 217, 31),
(390, 0, 217, 32),
(391, 0, 217, 34),
(392, 0, 217, 42),
(393, 0, 217, 43),
(394, 1, 217, 23),
(395, 0, 218, 18),
(396, 0, 218, 24),
(397, 0, 218, 26),
(398, 1, 218, 27),
(399, 1, 218, 30),
(400, 0, 218, 31),
(401, 0, 218, 32),
(402, 0, 218, 34),
(403, 0, 218, 42),
(404, 0, 218, 43),
(405, 0, 219, 18),
(406, 0, 219, 24),
(407, 0, 219, 26),
(408, 1, 219, 27),
(409, 1, 219, 30),
(410, 0, 219, 31),
(411, 0, 219, 32),
(412, 0, 219, 34),
(413, 0, 219, 42),
(414, 0, 219, 43),
(415, 0, 220, 18),
(416, 0, 220, 24),
(417, 0, 220, 26),
(418, 1, 220, 27),
(419, 1, 220, 30),
(420, 0, 220, 31),
(421, 0, 220, 32),
(422, 0, 220, 34),
(423, 0, 220, 42),
(424, 0, 220, 43),
(425, 0, 221, 18),
(426, 0, 221, 24),
(427, 0, 221, 26),
(428, 1, 221, 27),
(429, 1, 221, 30),
(430, 0, 221, 31),
(431, 0, 221, 32),
(432, 0, 221, 34),
(433, 0, 221, 42),
(434, 0, 221, 43),
(435, 0, 221, 29),
(436, 0, 222, 18),
(437, 0, 222, 24),
(438, 0, 222, 26),
(439, 1, 222, 27),
(440, 1, 222, 30),
(441, 0, 222, 31),
(442, 0, 222, 32),
(443, 0, 222, 34),
(444, 0, 222, 42),
(445, 0, 222, 43),
(446, 1, 222, 33),
(447, 0, 223, 18),
(448, 0, 223, 24),
(449, 0, 223, 26),
(450, 1, 223, 27),
(451, 1, 223, 30),
(452, 0, 223, 31),
(453, 0, 223, 32),
(454, 0, 223, 34),
(455, 0, 223, 42),
(456, 0, 223, 43),
(457, 1, 223, 28),
(458, 0, 224, 18),
(459, 0, 224, 24),
(460, 0, 224, 26),
(461, 1, 224, 27),
(462, 1, 224, 30),
(463, 0, 224, 31),
(464, 0, 224, 32),
(465, 0, 224, 34),
(466, 0, 224, 42),
(467, 0, 224, 43),
(468, 0, 225, 18),
(469, 0, 225, 24),
(470, 0, 225, 26),
(471, 1, 225, 27),
(472, 1, 225, 30),
(473, 0, 225, 31),
(474, 0, 225, 32),
(475, 0, 225, 34),
(476, 0, 225, 42),
(477, 0, 225, 43),
(478, 1, 225, 23),
(479, 0, 226, 18),
(480, 0, 226, 24),
(481, 0, 226, 26),
(482, 1, 226, 27),
(483, 1, 226, 30),
(484, 0, 226, 31),
(485, 0, 226, 32),
(486, 0, 226, 34),
(487, 0, 226, 42),
(488, 0, 226, 43),
(489, 0, 227, 18),
(490, 0, 227, 24),
(491, 0, 227, 26),
(492, 1, 227, 27),
(493, 1, 227, 30),
(494, 0, 227, 31),
(495, 0, 227, 32),
(496, 0, 227, 34),
(497, 0, 227, 42),
(498, 0, 227, 43),
(499, 0, 228, 18),
(500, 0, 228, 24),
(501, 0, 228, 26),
(502, 1, 228, 27),
(503, 1, 228, 30),
(504, 0, 228, 31),
(505, 0, 228, 32),
(506, 0, 228, 34),
(507, 0, 228, 42),
(508, 0, 228, 43),
(509, 1, 228, 40),
(510, 0, 229, 18),
(511, 0, 229, 24),
(512, 0, 229, 26),
(513, 1, 229, 27),
(514, 1, 229, 30),
(515, 0, 229, 31),
(516, 0, 229, 32),
(517, 0, 229, 34),
(518, 0, 229, 42),
(519, 0, 229, 43),
(520, 1, 229, 23),
(521, 0, 230, 18),
(522, 0, 230, 24),
(523, 0, 230, 26),
(524, 1, 230, 27),
(525, 1, 230, 30),
(526, 0, 230, 31),
(527, 0, 230, 32),
(528, 0, 230, 34),
(529, 0, 230, 42),
(530, 0, 230, 43),
(531, 0, 231, 18),
(532, 0, 231, 24),
(533, 0, 231, 26),
(534, 1, 231, 27),
(535, 1, 231, 30),
(536, 0, 231, 31),
(537, 0, 231, 32),
(538, 0, 231, 34),
(539, 0, 231, 42),
(540, 0, 231, 43),
(541, 0, 232, 18),
(542, 0, 232, 24),
(543, 0, 232, 26),
(544, 1, 232, 27),
(545, 1, 232, 30),
(546, 0, 232, 31),
(547, 0, 232, 32),
(548, 0, 232, 34),
(549, 0, 232, 42),
(550, 0, 232, 43),
(551, 0, 233, 18),
(552, 0, 233, 24),
(553, 0, 233, 26),
(554, 1, 233, 27),
(555, 1, 233, 30),
(556, 0, 233, 31),
(557, 0, 233, 32),
(558, 0, 233, 34),
(559, 0, 233, 42),
(560, 0, 233, 43),
(561, 1, 233, 40),
(562, 0, 234, 18),
(563, 0, 234, 24),
(564, 0, 234, 26),
(565, 1, 234, 27),
(566, 1, 234, 30),
(567, 0, 234, 31),
(568, 0, 234, 32),
(569, 0, 234, 34),
(570, 0, 234, 42),
(571, 0, 234, 43),
(572, 0, 235, 18),
(573, 0, 235, 24),
(574, 0, 235, 26),
(575, 1, 235, 27),
(576, 1, 235, 30),
(577, 0, 235, 31),
(578, 0, 235, 32),
(579, 0, 235, 34),
(580, 0, 235, 42),
(581, 0, 235, 43),
(582, 1, 235, 40),
(583, 0, 236, 18),
(584, 0, 236, 24),
(585, 0, 236, 26),
(586, 1, 236, 27),
(587, 1, 236, 30),
(588, 0, 236, 31),
(589, 0, 236, 32),
(590, 0, 236, 34),
(591, 0, 236, 42),
(592, 0, 236, 43),
(593, 0, 237, 18),
(594, 0, 237, 24),
(595, 0, 237, 26),
(596, 1, 237, 27),
(597, 1, 237, 30),
(598, 0, 237, 31),
(599, 0, 237, 32),
(600, 0, 237, 34),
(601, 0, 237, 42),
(602, 0, 237, 43),
(603, 0, 238, 18),
(604, 0, 238, 24),
(605, 0, 238, 26),
(606, 1, 238, 27),
(607, 1, 238, 30),
(608, 0, 238, 31),
(609, 0, 238, 32),
(610, 0, 238, 34),
(611, 0, 238, 42),
(612, 0, 238, 43),
(613, 0, 239, 18),
(614, 0, 239, 24),
(615, 0, 239, 26),
(616, 1, 239, 27),
(617, 1, 239, 30),
(618, 0, 239, 31),
(619, 0, 239, 32),
(620, 0, 239, 34),
(621, 0, 239, 42),
(622, 0, 239, 43),
(623, 0, 240, 18),
(624, 0, 240, 24),
(625, 0, 240, 26),
(626, 1, 240, 27),
(627, 1, 240, 30),
(628, 0, 240, 31),
(629, 0, 240, 32),
(630, 0, 240, 34),
(631, 0, 240, 42),
(632, 0, 240, 43),
(633, 1, 240, 40),
(634, 0, 241, 18),
(635, 0, 241, 24),
(636, 0, 241, 26),
(637, 1, 241, 27),
(638, 1, 241, 30),
(639, 0, 241, 31),
(640, 0, 241, 32),
(641, 0, 241, 34),
(642, 0, 241, 42),
(643, 0, 241, 43),
(644, 1, 241, 40),
(645, 0, 242, 18),
(646, 0, 242, 24),
(647, 0, 242, 26),
(648, 1, 242, 27),
(649, 1, 242, 30),
(650, 0, 242, 31),
(651, 0, 242, 32),
(652, 0, 242, 34),
(653, 0, 242, 42),
(654, 0, 242, 43),
(655, 1, 242, 40),
(656, 0, 243, 18),
(657, 0, 243, 24),
(658, 0, 243, 26),
(659, 1, 243, 27),
(660, 1, 243, 30),
(661, 0, 243, 31),
(662, 0, 243, 32),
(663, 0, 243, 34),
(664, 0, 243, 42),
(665, 0, 243, 43),
(666, 0, 244, 18),
(667, 0, 244, 24),
(668, 0, 244, 26),
(669, 1, 244, 27),
(670, 1, 244, 30),
(671, 0, 244, 31),
(672, 0, 244, 32),
(673, 0, 244, 34),
(674, 0, 244, 42),
(675, 0, 244, 43),
(676, 0, 245, 18),
(677, 0, 245, 24),
(678, 0, 245, 26),
(679, 1, 245, 27),
(680, 1, 245, 30),
(681, 0, 245, 31),
(682, 0, 245, 32),
(683, 0, 245, 34),
(684, 0, 245, 42),
(685, 0, 245, 43),
(686, 0, 246, 18),
(687, 0, 246, 24),
(688, 0, 246, 26),
(689, 1, 246, 27),
(690, 1, 246, 30),
(691, 0, 246, 31),
(692, 0, 246, 32),
(693, 0, 246, 34),
(694, 0, 246, 42),
(695, 0, 246, 43),
(696, 0, 247, 18),
(697, 0, 247, 24),
(698, 0, 247, 26),
(699, 1, 247, 27),
(700, 1, 247, 30),
(701, 0, 247, 31),
(702, 0, 247, 32),
(703, 0, 247, 34),
(704, 0, 247, 42),
(705, 0, 247, 43),
(706, 0, 248, 18),
(707, 0, 248, 24),
(708, 0, 248, 26),
(709, 1, 248, 27),
(710, 1, 248, 30),
(711, 0, 248, 31),
(712, 0, 248, 32),
(713, 0, 248, 34),
(714, 0, 248, 42),
(715, 0, 248, 43),
(716, 0, 249, 18),
(717, 0, 249, 24),
(718, 0, 249, 26),
(719, 1, 249, 27),
(720, 1, 249, 30),
(721, 0, 249, 31),
(722, 0, 249, 32),
(723, 0, 249, 34),
(724, 0, 249, 42),
(725, 0, 249, 43),
(726, 0, 250, 18),
(727, 1, 250, 24),
(728, 0, 250, 26),
(729, 1, 250, 27),
(730, 1, 250, 30),
(731, 0, 250, 31),
(732, 0, 250, 32),
(733, 0, 250, 34),
(734, 0, 250, 42),
(735, 0, 250, 43),
(736, 0, 251, 18),
(737, 1, 251, 24),
(738, 0, 251, 26),
(739, 1, 251, 27),
(740, 1, 251, 30),
(741, 0, 251, 31),
(742, 0, 251, 32),
(743, 0, 251, 34),
(744, 0, 251, 42),
(745, 0, 251, 43),
(746, 0, 252, 18),
(747, 1, 252, 24),
(748, 0, 252, 26),
(749, 1, 252, 27),
(750, 1, 252, 30),
(751, 0, 252, 31),
(752, 0, 252, 32),
(753, 0, 252, 34),
(754, 0, 252, 42),
(755, 0, 252, 43),
(756, 1, 252, 40),
(757, 0, 253, 18),
(758, 1, 253, 24),
(759, 0, 253, 26),
(760, 1, 253, 27),
(761, 1, 253, 30),
(762, 0, 253, 31),
(763, 0, 253, 32),
(764, 0, 253, 34),
(765, 0, 253, 42),
(766, 0, 253, 43),
(767, 0, 254, 18),
(768, 1, 254, 24),
(769, 0, 254, 26),
(770, 1, 254, 27),
(771, 1, 254, 30),
(772, 0, 254, 31),
(773, 0, 254, 32),
(774, 0, 254, 34),
(775, 0, 254, 42),
(776, 0, 254, 43),
(777, 0, 254, 29),
(778, 0, 255, 18),
(779, 1, 255, 24),
(780, 0, 255, 26),
(781, 1, 255, 27),
(782, 1, 255, 30),
(783, 0, 255, 31),
(784, 0, 255, 32),
(785, 0, 255, 34),
(786, 0, 255, 42),
(787, 0, 255, 43),
(788, 0, 256, 18),
(789, 1, 256, 24),
(790, 0, 256, 26),
(791, 1, 256, 27),
(792, 1, 256, 30),
(793, 0, 256, 31),
(794, 0, 256, 32),
(795, 0, 256, 34),
(796, 0, 256, 42),
(797, 0, 256, 43),
(798, 0, 257, 18),
(799, 1, 257, 24),
(800, 0, 257, 26),
(801, 1, 257, 27),
(802, 1, 257, 30),
(803, 0, 257, 31),
(804, 0, 257, 32),
(805, 0, 257, 34),
(806, 0, 257, 42),
(807, 0, 257, 43),
(808, 0, 258, 18),
(809, 1, 258, 24),
(810, 0, 258, 26),
(811, 1, 258, 27),
(812, 1, 258, 30),
(813, 0, 258, 31),
(814, 0, 258, 32),
(815, 0, 258, 34),
(816, 0, 258, 42),
(817, 0, 258, 43),
(818, 0, 258, 44),
(819, 0, 259, 18),
(820, 1, 259, 24),
(821, 0, 259, 26),
(822, 1, 259, 27),
(823, 1, 259, 30),
(824, 0, 259, 31),
(825, 0, 259, 32),
(826, 0, 259, 34),
(827, 0, 259, 42),
(828, 0, 259, 43),
(829, 0, 260, 18),
(830, 1, 260, 24),
(831, 0, 260, 26),
(832, 1, 260, 27),
(833, 1, 260, 30),
(834, 0, 260, 31),
(835, 0, 260, 32),
(836, 0, 260, 34),
(837, 0, 260, 42),
(838, 0, 260, 43),
(839, 0, 261, 18),
(840, 1, 261, 24),
(841, 0, 261, 26),
(842, 1, 261, 27),
(843, 1, 261, 30),
(844, 0, 261, 31),
(845, 0, 261, 32),
(846, 0, 261, 34),
(847, 0, 261, 42),
(848, 0, 261, 43),
(849, 0, 262, 18),
(850, 1, 262, 24),
(851, 0, 262, 26),
(852, 1, 262, 27),
(853, 1, 262, 30),
(854, 0, 262, 31),
(855, 0, 262, 32),
(856, 0, 262, 34),
(857, 0, 262, 42),
(858, 0, 262, 43),
(859, 0, 263, 18),
(860, 1, 263, 24),
(861, 0, 263, 26),
(862, 1, 263, 27),
(863, 1, 263, 30),
(864, 0, 263, 31),
(865, 0, 263, 32),
(866, 0, 263, 34),
(867, 0, 263, 42),
(868, 0, 263, 43),
(869, 0, 264, 18),
(870, 1, 264, 24),
(871, 0, 264, 26),
(872, 1, 264, 27),
(873, 1, 264, 30),
(874, 0, 264, 31),
(875, 0, 264, 32),
(876, 0, 264, 34),
(877, 0, 264, 42),
(878, 0, 264, 43),
(879, 0, 265, 18),
(880, 1, 265, 24),
(881, 0, 265, 26),
(882, 1, 265, 27),
(883, 1, 265, 30),
(884, 0, 265, 31),
(885, 0, 265, 32),
(886, 0, 265, 34),
(887, 0, 265, 42),
(888, 0, 265, 43),
(889, 0, 266, 18),
(890, 1, 266, 24),
(891, 0, 266, 26),
(892, 1, 266, 27),
(893, 1, 266, 30),
(894, 0, 266, 31),
(895, 0, 266, 32),
(896, 0, 266, 34),
(897, 0, 266, 42),
(898, 0, 266, 43),
(899, 0, 267, 18),
(900, 1, 267, 24),
(901, 0, 267, 26),
(902, 1, 267, 27),
(903, 1, 267, 30),
(904, 0, 267, 31),
(905, 0, 267, 32),
(906, 0, 267, 34),
(907, 0, 267, 42),
(908, 0, 267, 43),
(909, 0, 268, 18),
(910, 1, 268, 24),
(911, 0, 268, 26),
(912, 1, 268, 27),
(913, 1, 268, 30),
(914, 0, 268, 31),
(915, 0, 268, 32),
(916, 0, 268, 34),
(917, 0, 268, 42),
(918, 0, 268, 43),
(919, 0, 269, 18),
(920, 1, 269, 24),
(921, 0, 269, 26),
(922, 1, 269, 27),
(923, 1, 269, 30),
(924, 0, 269, 31),
(925, 0, 269, 32),
(926, 0, 269, 34),
(927, 0, 269, 42),
(928, 0, 269, 43),
(929, 0, 270, 18),
(930, 1, 270, 24),
(931, 0, 270, 26),
(932, 1, 270, 27),
(933, 1, 270, 30),
(934, 0, 270, 31),
(935, 0, 270, 32),
(936, 0, 270, 34),
(937, 0, 270, 42),
(938, 0, 270, 43),
(939, 1, 270, 40),
(940, 0, 271, 18),
(941, 1, 271, 24),
(942, 0, 271, 26),
(943, 1, 271, 27),
(944, 1, 271, 30),
(945, 0, 271, 31),
(946, 0, 271, 32),
(947, 0, 271, 34),
(948, 0, 271, 42),
(949, 0, 271, 43),
(950, 1, 271, 40),
(951, 0, 272, 18),
(952, 1, 272, 24),
(953, 0, 272, 26),
(954, 1, 272, 27),
(955, 1, 272, 30),
(956, 0, 272, 31),
(957, 0, 272, 32),
(958, 0, 272, 34),
(959, 0, 272, 42),
(960, 0, 272, 43),
(961, 1, 272, 40),
(962, 0, 273, 18),
(963, 1, 273, 24),
(964, 0, 273, 26),
(965, 1, 273, 27),
(966, 1, 273, 30),
(967, 0, 273, 31),
(968, 0, 273, 32),
(969, 0, 273, 34),
(970, 0, 273, 42),
(971, 0, 273, 43),
(972, 0, 274, 18),
(973, 1, 274, 24),
(974, 0, 274, 26),
(975, 1, 274, 27),
(976, 1, 274, 30),
(977, 0, 274, 31),
(978, 0, 274, 32),
(979, 0, 274, 34),
(980, 0, 274, 42),
(981, 0, 274, 43),
(982, 0, 275, 18),
(983, 1, 275, 24),
(984, 0, 275, 26),
(985, 1, 275, 27),
(986, 1, 275, 30),
(987, 0, 275, 31),
(988, 0, 275, 32),
(989, 0, 275, 34),
(990, 0, 275, 42),
(991, 0, 275, 43),
(992, 0, 276, 18),
(993, 1, 276, 24),
(994, 0, 276, 26),
(995, 1, 276, 27),
(996, 1, 276, 30),
(997, 0, 276, 31),
(998, 0, 276, 32),
(999, 0, 276, 34),
(1000, 0, 276, 42),
(1001, 0, 276, 43),
(1002, 0, 277, 18),
(1003, 1, 277, 24),
(1004, 0, 277, 26),
(1005, 1, 277, 27),
(1006, 1, 277, 30),
(1007, 0, 277, 31),
(1008, 0, 277, 32),
(1009, 0, 277, 34),
(1010, 0, 277, 42),
(1011, 0, 277, 43),
(1012, 0, 278, 18),
(1013, 1, 278, 24),
(1014, 0, 278, 26),
(1015, 1, 278, 27),
(1016, 1, 278, 30),
(1017, 0, 278, 31),
(1018, 0, 278, 32),
(1019, 0, 278, 34),
(1020, 0, 278, 42),
(1021, 0, 278, 43),
(1022, 1, 278, 40),
(1023, 0, 279, 18),
(1024, 1, 279, 24),
(1025, 0, 279, 26),
(1026, 1, 279, 27),
(1027, 1, 279, 30),
(1028, 0, 279, 31),
(1029, 0, 279, 32),
(1030, 0, 279, 34),
(1031, 0, 279, 42),
(1032, 0, 279, 43),
(1033, 1, 279, 40),
(1034, 0, 280, 18),
(1035, 1, 280, 24),
(1036, 0, 280, 26),
(1037, 1, 280, 27),
(1038, 1, 280, 30),
(1039, 0, 280, 31),
(1040, 0, 280, 32),
(1041, 0, 280, 34),
(1042, 0, 280, 42),
(1043, 0, 280, 43),
(1044, 0, 280, 44),
(1045, 0, 281, 18),
(1046, 1, 281, 24),
(1047, 0, 281, 26),
(1048, 1, 281, 27),
(1049, 1, 281, 30),
(1050, 0, 281, 31),
(1051, 0, 281, 32),
(1052, 0, 281, 34),
(1053, 0, 281, 42),
(1054, 0, 281, 43),
(1055, 0, 282, 18),
(1056, 1, 282, 24),
(1057, 0, 282, 26),
(1058, 1, 282, 27),
(1059, 1, 282, 30),
(1060, 0, 282, 31),
(1061, 0, 282, 32),
(1062, 0, 282, 34),
(1063, 0, 282, 42),
(1064, 0, 282, 43),
(1065, 0, 282, 44),
(1066, 0, 283, 18),
(1067, 1, 283, 24),
(1068, 0, 283, 26),
(1069, 1, 283, 27),
(1070, 1, 283, 30),
(1071, 0, 283, 31),
(1072, 0, 283, 32),
(1073, 0, 283, 34),
(1074, 0, 283, 42),
(1075, 0, 283, 43),
(1076, 0, 284, 18),
(1077, 1, 284, 24),
(1078, 0, 284, 26),
(1079, 1, 284, 27),
(1080, 1, 284, 30),
(1081, 0, 284, 31),
(1082, 0, 284, 32),
(1083, 0, 284, 34),
(1084, 0, 284, 42),
(1085, 0, 284, 43),
(1086, 0, 285, 18),
(1087, 1, 285, 24),
(1088, 0, 285, 26),
(1089, 1, 285, 27),
(1090, 1, 285, 30),
(1091, 0, 285, 31),
(1092, 0, 285, 32),
(1093, 0, 285, 34),
(1094, 0, 285, 42),
(1095, 0, 285, 43),
(1096, 0, 286, 18),
(1097, 1, 286, 24),
(1098, 0, 286, 26),
(1099, 1, 286, 27),
(1100, 1, 286, 30),
(1101, 0, 286, 31),
(1102, 0, 286, 32),
(1103, 0, 286, 34),
(1104, 0, 286, 42),
(1105, 0, 286, 43),
(1106, 0, 287, 18),
(1107, 1, 287, 24),
(1108, 0, 287, 26),
(1109, 1, 287, 27),
(1110, 1, 287, 30),
(1111, 0, 287, 31),
(1112, 0, 287, 32),
(1113, 0, 287, 34),
(1114, 0, 287, 42),
(1115, 0, 287, 43),
(1116, 0, 288, 18),
(1117, 1, 288, 24),
(1118, 0, 288, 26),
(1119, 1, 288, 27),
(1120, 1, 288, 30),
(1121, 0, 288, 31),
(1122, 0, 288, 32),
(1123, 0, 288, 34),
(1124, 0, 288, 42),
(1125, 0, 288, 43),
(1126, 0, 289, 18),
(1127, 1, 289, 24),
(1128, 0, 289, 26),
(1129, 1, 289, 27),
(1130, 1, 289, 30),
(1131, 0, 289, 31),
(1132, 0, 289, 32),
(1133, 0, 289, 34),
(1134, 0, 289, 42),
(1135, 0, 289, 43),
(1136, 0, 290, 18),
(1137, 1, 290, 24),
(1138, 0, 290, 26),
(1139, 1, 290, 27),
(1140, 1, 290, 30),
(1141, 0, 290, 31),
(1142, 0, 290, 32),
(1143, 0, 290, 34),
(1144, 0, 290, 42),
(1145, 0, 290, 43),
(1146, 0, 291, 18),
(1147, 1, 291, 24),
(1148, 0, 291, 26),
(1149, 1, 291, 27),
(1150, 1, 291, 30),
(1151, 0, 291, 31),
(1152, 0, 291, 32),
(1153, 0, 291, 34),
(1154, 0, 291, 42),
(1155, 0, 291, 43),
(1156, 0, 291, 44),
(1157, 0, 292, 18),
(1158, 1, 292, 24),
(1159, 0, 292, 26),
(1160, 1, 292, 27),
(1161, 1, 292, 30),
(1162, 0, 292, 31),
(1163, 0, 292, 32),
(1164, 0, 292, 34),
(1165, 0, 292, 42),
(1166, 0, 292, 43),
(1167, 0, 293, 18),
(1168, 1, 293, 24),
(1169, 0, 293, 26),
(1170, 1, 293, 27),
(1171, 1, 293, 30),
(1172, 0, 293, 31),
(1173, 0, 293, 32),
(1174, 0, 293, 34),
(1175, 0, 293, 42),
(1176, 0, 293, 43),
(1177, 0, 294, 18),
(1178, 1, 294, 24),
(1179, 0, 294, 26),
(1180, 1, 294, 27),
(1181, 1, 294, 30),
(1182, 0, 294, 31),
(1183, 0, 294, 32),
(1184, 0, 294, 34),
(1185, 0, 294, 42),
(1186, 0, 294, 43),
(1187, 0, 295, 18),
(1188, 1, 295, 24),
(1189, 0, 295, 26),
(1190, 1, 295, 27),
(1191, 1, 295, 30),
(1192, 0, 295, 31),
(1193, 0, 295, 32),
(1194, 0, 295, 34),
(1195, 0, 295, 42),
(1196, 0, 295, 43),
(1197, 1, 296, 24),
(1198, 0, 296, 26),
(1199, 1, 296, 27),
(1200, 1, 296, 30),
(1201, 0, 296, 31),
(1202, 0, 296, 32),
(1203, 0, 296, 34),
(1204, 0, 296, 42),
(1205, 0, 296, 43),
(1206, 0, 297, 18),
(1207, 1, 297, 24),
(1208, 0, 297, 26),
(1209, 1, 297, 27),
(1210, 1, 297, 30),
(1211, 0, 297, 31),
(1212, 0, 297, 32),
(1213, 0, 297, 34),
(1214, 0, 297, 42),
(1215, 0, 297, 43),
(1216, 0, 298, 18),
(1217, 1, 298, 24),
(1218, 0, 298, 26),
(1219, 1, 298, 27),
(1220, 1, 298, 30),
(1221, 0, 298, 31),
(1222, 0, 298, 32),
(1223, 0, 298, 34),
(1224, 0, 298, 42),
(1225, 0, 298, 43),
(1226, 0, 299, 18),
(1227, 1, 299, 24),
(1228, 0, 299, 26),
(1229, 1, 299, 27),
(1230, 1, 299, 30),
(1231, 0, 299, 31),
(1232, 0, 299, 32),
(1233, 0, 299, 34),
(1234, 0, 299, 42),
(1235, 0, 299, 43),
(1236, 0, 300, 18),
(1237, 1, 300, 24),
(1238, 0, 300, 26),
(1239, 1, 300, 27),
(1240, 1, 300, 30),
(1241, 0, 300, 31),
(1242, 0, 300, 32),
(1243, 0, 300, 34),
(1244, 0, 300, 42),
(1245, 0, 300, 43),
(1246, 1, 301, 24),
(1247, 0, 301, 26),
(1248, 1, 301, 27),
(1249, 1, 301, 30),
(1250, 0, 301, 31),
(1251, 0, 301, 32),
(1252, 0, 301, 34),
(1253, 0, 301, 42),
(1254, 0, 301, 43),
(1255, 1, 301, 40),
(1256, 1, 302, 24),
(1257, 0, 302, 26),
(1258, 1, 302, 27),
(1259, 1, 302, 30),
(1260, 0, 302, 31),
(1261, 0, 302, 32),
(1262, 0, 302, 34),
(1263, 0, 302, 42),
(1264, 0, 302, 43),
(1265, 1, 302, 33),
(1266, 1, 303, 24),
(1267, 0, 303, 26),
(1268, 1, 303, 27),
(1269, 1, 303, 30),
(1270, 0, 303, 31),
(1271, 0, 303, 32),
(1272, 0, 303, 34),
(1273, 0, 303, 42),
(1274, 0, 303, 43),
(1275, 1, 303, 28),
(1276, 0, 304, 18),
(1277, 1, 304, 24),
(1278, 0, 304, 26),
(1279, 1, 304, 27),
(1280, 1, 304, 30),
(1281, 0, 304, 31),
(1282, 0, 304, 32),
(1283, 0, 304, 34),
(1284, 0, 304, 42),
(1285, 0, 304, 43),
(1286, 0, 304, 44),
(1287, 0, 305, 18),
(1288, 1, 305, 24),
(1289, 0, 305, 26),
(1290, 1, 305, 27),
(1291, 1, 305, 30),
(1292, 0, 305, 31),
(1293, 0, 305, 32),
(1294, 0, 305, 34),
(1295, 0, 305, 42),
(1296, 0, 305, 43),
(1297, 0, 306, 18),
(1298, 1, 306, 24),
(1299, 0, 306, 26),
(1300, 1, 306, 27),
(1301, 1, 306, 30),
(1302, 0, 306, 31),
(1303, 0, 306, 32),
(1304, 0, 306, 34),
(1305, 0, 306, 42),
(1306, 0, 306, 43),
(1307, 0, 307, 18),
(1308, 1, 307, 24),
(1309, 0, 307, 26),
(1310, 1, 307, 27),
(1311, 1, 307, 30),
(1312, 0, 307, 31),
(1313, 0, 307, 32),
(1314, 0, 307, 34),
(1315, 0, 307, 42),
(1316, 0, 307, 43),
(1317, 0, 308, 18),
(1318, 1, 308, 24),
(1319, 0, 308, 26),
(1320, 1, 308, 27),
(1321, 1, 308, 30),
(1322, 0, 308, 31),
(1323, 0, 308, 32),
(1324, 0, 308, 34),
(1325, 0, 308, 42),
(1326, 0, 308, 43),
(1327, 0, 309, 18),
(1328, 1, 309, 24),
(1329, 0, 309, 26),
(1330, 1, 309, 27),
(1331, 1, 309, 30),
(1332, 0, 309, 31),
(1333, 0, 309, 32),
(1334, 0, 309, 34),
(1335, 0, 309, 42),
(1336, 0, 309, 43),
(1337, 0, 310, 18),
(1338, 1, 310, 24),
(1339, 0, 310, 26),
(1340, 1, 310, 27),
(1341, 1, 310, 30),
(1342, 0, 310, 31),
(1343, 0, 310, 32),
(1344, 0, 310, 34),
(1345, 0, 310, 42),
(1346, 0, 310, 43),
(1347, 0, 310, 44),
(1348, 0, 311, 18),
(1349, 1, 311, 24),
(1350, 0, 311, 26),
(1351, 1, 311, 27),
(1352, 1, 311, 30),
(1353, 0, 311, 31),
(1354, 0, 311, 32),
(1355, 0, 311, 34),
(1356, 0, 311, 42),
(1357, 0, 311, 43),
(1358, 1, 311, 40),
(1359, 0, 312, 18),
(1360, 1, 312, 24),
(1361, 0, 312, 26),
(1362, 1, 312, 27),
(1363, 1, 312, 30),
(1364, 0, 312, 31),
(1365, 0, 312, 32),
(1366, 0, 312, 34),
(1367, 0, 312, 42),
(1368, 0, 312, 43),
(1369, 1, 312, 40),
(1370, 1, 313, 24),
(1371, 0, 313, 26),
(1372, 1, 313, 27),
(1373, 1, 313, 30),
(1374, 0, 313, 31),
(1375, 0, 313, 32),
(1376, 0, 313, 34),
(1377, 0, 313, 42),
(1378, 0, 313, 43),
(1379, 1, 314, 24),
(1380, 0, 314, 26),
(1381, 1, 314, 27),
(1382, 1, 314, 30),
(1383, 0, 314, 31),
(1384, 0, 314, 32),
(1385, 0, 314, 34),
(1386, 0, 314, 42),
(1387, 0, 314, 43),
(1388, 1, 314, 40),
(1389, 1, 315, 24),
(1390, 0, 315, 26),
(1391, 1, 315, 27),
(1392, 1, 315, 30),
(1393, 0, 315, 31),
(1394, 0, 315, 32),
(1395, 0, 315, 34),
(1396, 0, 315, 42),
(1397, 0, 315, 43),
(1398, 1, 315, 33),
(1399, 1, 316, 24),
(1400, 0, 316, 26),
(1401, 1, 316, 27),
(1402, 1, 316, 30),
(1403, 0, 316, 31),
(1404, 0, 316, 32),
(1405, 0, 316, 34),
(1406, 0, 316, 42),
(1407, 0, 316, 43),
(1408, 1, 316, 28),
(1409, 0, 317, 18),
(1410, 1, 317, 24),
(1411, 0, 317, 26),
(1412, 1, 317, 27),
(1413, 1, 317, 30),
(1414, 0, 317, 31),
(1415, 0, 317, 32),
(1416, 0, 317, 34),
(1417, 0, 317, 42),
(1418, 0, 317, 43),
(1419, 0, 318, 18),
(1420, 1, 318, 24),
(1421, 0, 318, 26),
(1422, 1, 318, 27),
(1423, 1, 318, 30),
(1424, 0, 318, 31),
(1425, 0, 318, 32),
(1426, 0, 318, 34),
(1427, 0, 318, 42),
(1428, 0, 318, 43),
(1429, 0, 319, 18),
(1430, 1, 319, 24),
(1431, 0, 319, 26),
(1432, 1, 319, 27),
(1433, 1, 319, 30),
(1434, 0, 319, 31),
(1435, 0, 319, 32),
(1436, 0, 319, 34),
(1437, 0, 319, 42),
(1438, 0, 319, 43),
(1439, 0, 319, 29),
(1440, 0, 320, 18),
(1441, 1, 320, 24),
(1442, 0, 320, 26),
(1443, 1, 320, 27),
(1444, 1, 320, 30),
(1445, 0, 320, 31),
(1446, 0, 320, 32),
(1447, 0, 320, 34),
(1448, 0, 320, 42),
(1449, 0, 320, 43),
(1450, 1, 320, 45),
(1451, 0, 321, 18),
(1452, 1, 321, 24),
(1453, 0, 321, 26),
(1454, 1, 321, 27),
(1455, 1, 321, 30),
(1456, 0, 321, 31),
(1457, 0, 321, 32),
(1458, 0, 321, 34),
(1459, 0, 321, 42),
(1460, 0, 321, 43),
(1461, 0, 321, 29),
(1462, 0, 322, 18),
(1463, 1, 322, 24),
(1464, 0, 322, 26),
(1465, 1, 322, 27),
(1466, 1, 322, 30),
(1467, 0, 322, 31),
(1468, 0, 322, 32),
(1469, 0, 322, 34),
(1470, 0, 322, 42),
(1471, 0, 322, 43),
(1472, 1, 322, 45),
(1473, 0, 323, 18),
(1474, 1, 323, 24),
(1475, 0, 323, 26),
(1476, 1, 323, 27),
(1477, 1, 323, 30),
(1478, 0, 323, 31),
(1479, 0, 323, 32),
(1480, 0, 323, 34),
(1481, 0, 323, 42),
(1482, 0, 323, 43),
(1483, 0, 324, 18),
(1484, 1, 324, 24),
(1485, 0, 324, 26),
(1486, 1, 324, 27),
(1487, 1, 324, 30),
(1488, 0, 324, 31),
(1489, 0, 324, 32),
(1490, 0, 324, 34),
(1491, 0, 324, 42),
(1492, 0, 324, 43),
(1493, 0, 324, 44),
(1494, 0, 325, 18),
(1495, 1, 325, 24),
(1496, 0, 325, 26),
(1497, 1, 325, 27),
(1498, 1, 325, 30),
(1499, 0, 325, 31),
(1500, 0, 325, 32),
(1501, 0, 325, 34),
(1502, 0, 325, 42),
(1503, 0, 325, 43),
(1504, 0, 326, 18),
(1505, 1, 326, 24),
(1506, 0, 326, 26),
(1507, 1, 326, 27),
(1508, 1, 326, 30),
(1509, 0, 326, 31),
(1510, 0, 326, 32),
(1511, 0, 326, 34),
(1512, 0, 326, 42),
(1513, 0, 326, 43),
(1514, 0, 327, 18),
(1515, 1, 327, 24),
(1516, 0, 327, 26),
(1517, 1, 327, 27),
(1518, 1, 327, 30),
(1519, 0, 327, 31),
(1520, 0, 327, 32),
(1521, 0, 327, 34),
(1522, 0, 327, 42),
(1523, 0, 327, 43),
(1524, 0, 328, 18),
(1525, 1, 328, 24),
(1526, 0, 328, 26),
(1527, 1, 328, 27),
(1528, 1, 328, 30),
(1529, 0, 328, 31),
(1530, 0, 328, 32),
(1531, 0, 328, 34),
(1532, 0, 328, 42),
(1533, 0, 328, 43),
(1534, 0, 329, 18),
(1535, 1, 329, 24),
(1536, 0, 329, 26),
(1537, 1, 329, 27),
(1538, 1, 329, 30),
(1539, 0, 329, 31),
(1540, 0, 329, 32),
(1541, 0, 329, 34),
(1542, 0, 329, 42),
(1543, 0, 329, 43),
(1544, 1, 329, 40),
(1545, 0, 330, 18),
(1546, 1, 330, 24),
(1547, 0, 330, 26),
(1548, 1, 330, 27),
(1549, 1, 330, 30),
(1550, 0, 330, 31),
(1551, 0, 330, 32),
(1552, 0, 330, 34),
(1553, 0, 330, 42),
(1554, 0, 330, 43),
(1555, 0, 331, 18),
(1556, 1, 331, 24),
(1557, 0, 331, 26),
(1558, 1, 331, 27),
(1559, 1, 331, 30),
(1560, 0, 331, 31),
(1561, 0, 331, 32),
(1562, 0, 331, 34),
(1563, 0, 331, 42),
(1564, 0, 331, 43),
(1565, 0, 332, 18),
(1566, 1, 332, 24),
(1567, 0, 332, 26),
(1568, 1, 332, 27),
(1569, 1, 332, 30),
(1570, 0, 332, 31),
(1571, 0, 332, 32),
(1572, 0, 332, 34),
(1573, 0, 332, 42),
(1574, 0, 332, 43),
(1575, 0, 333, 18),
(1576, 1, 333, 24),
(1577, 0, 333, 26),
(1578, 1, 333, 27),
(1579, 1, 333, 30),
(1580, 0, 333, 31),
(1581, 0, 333, 32),
(1582, 0, 333, 34),
(1583, 0, 333, 42),
(1584, 0, 333, 43),
(1585, 1, 333, 40),
(1586, 0, 334, 18),
(1587, 1, 334, 24),
(1588, 0, 334, 26),
(1589, 1, 334, 27),
(1590, 1, 334, 30),
(1591, 0, 334, 31),
(1592, 0, 334, 32),
(1593, 0, 334, 34),
(1594, 0, 334, 42),
(1595, 0, 334, 43),
(1596, 0, 334, 44),
(1597, 0, 335, 18),
(1598, 1, 335, 24),
(1599, 0, 335, 26),
(1600, 1, 335, 27),
(1601, 1, 335, 30),
(1602, 0, 335, 31),
(1603, 0, 335, 32),
(1604, 0, 335, 34),
(1605, 0, 335, 42),
(1606, 0, 335, 43),
(1607, 0, 336, 18),
(1608, 1, 336, 24),
(1609, 0, 336, 26),
(1610, 1, 336, 27),
(1611, 1, 336, 30),
(1612, 0, 336, 31),
(1613, 0, 336, 32),
(1614, 0, 336, 34),
(1615, 0, 336, 42),
(1616, 0, 336, 43),
(1617, 0, 337, 18),
(1618, 1, 337, 24),
(1619, 0, 337, 26),
(1620, 1, 337, 27),
(1621, 1, 337, 30),
(1622, 0, 337, 31),
(1623, 0, 337, 32),
(1624, 0, 337, 34),
(1625, 0, 337, 42),
(1626, 0, 337, 43),
(1627, 0, 338, 18),
(1628, 1, 338, 24),
(1629, 0, 338, 26),
(1630, 1, 338, 27),
(1631, 1, 338, 30),
(1632, 0, 338, 31),
(1633, 0, 338, 32),
(1634, 0, 338, 34),
(1635, 0, 338, 42),
(1636, 0, 338, 43),
(1637, 1, 338, 40),
(1638, 0, 339, 18),
(1639, 1, 339, 24),
(1640, 0, 339, 26),
(1641, 1, 339, 27),
(1642, 1, 339, 30),
(1643, 0, 339, 31),
(1644, 0, 339, 32),
(1645, 0, 339, 34),
(1646, 0, 339, 42),
(1647, 0, 339, 43),
(1648, 1, 339, 28),
(1649, 0, 340, 18),
(1650, 1, 340, 24),
(1651, 0, 340, 26),
(1652, 1, 340, 27),
(1653, 1, 340, 30),
(1654, 0, 340, 31),
(1655, 0, 340, 32),
(1656, 0, 340, 34),
(1657, 0, 340, 42),
(1658, 0, 340, 43),
(1659, 1, 340, 40),
(1660, 0, 341, 18),
(1661, 1, 341, 24),
(1662, 0, 341, 26),
(1663, 1, 341, 27),
(1664, 1, 341, 30),
(1665, 0, 341, 31),
(1666, 0, 341, 32),
(1667, 0, 341, 34),
(1668, 0, 341, 42),
(1669, 0, 341, 43),
(1670, 1, 341, 28),
(1671, 0, 342, 18),
(1672, 1, 342, 24),
(1673, 0, 342, 26),
(1674, 1, 342, 27),
(1675, 1, 342, 30),
(1676, 0, 342, 31),
(1677, 0, 342, 32),
(1678, 0, 342, 34),
(1679, 0, 342, 42),
(1680, 0, 342, 43),
(1681, 1, 342, 23),
(1682, 0, 343, 18),
(1683, 1, 343, 24),
(1684, 0, 343, 26),
(1685, 1, 343, 27),
(1686, 1, 343, 30),
(1687, 0, 343, 31),
(1688, 0, 343, 32),
(1689, 0, 343, 34),
(1690, 0, 343, 42),
(1691, 0, 343, 43),
(1692, 1, 343, 23),
(1693, 0, 344, 18),
(1694, 1, 344, 24),
(1695, 0, 344, 26),
(1696, 1, 344, 27),
(1697, 1, 344, 30),
(1698, 0, 344, 31),
(1699, 0, 344, 32),
(1700, 0, 344, 34),
(1701, 0, 344, 42),
(1702, 0, 344, 43),
(1703, 1, 344, 33),
(1704, 0, 345, 18),
(1705, 1, 345, 24),
(1706, 0, 345, 26),
(1707, 1, 345, 27),
(1708, 1, 345, 30),
(1709, 0, 345, 31),
(1710, 0, 345, 32),
(1711, 0, 345, 34),
(1712, 0, 345, 42),
(1713, 0, 345, 43),
(1714, 1, 345, 28),
(1715, 0, 346, 18),
(1716, 1, 346, 24),
(1717, 0, 346, 26),
(1718, 1, 346, 27),
(1719, 1, 346, 30),
(1720, 0, 346, 31),
(1721, 0, 346, 32),
(1722, 0, 346, 34),
(1723, 0, 346, 42),
(1724, 1, 346, 43),
(1725, 0, 347, 18),
(1726, 1, 347, 24),
(1727, 0, 347, 26),
(1728, 1, 347, 27),
(1729, 1, 347, 30),
(1730, 0, 347, 31),
(1731, 0, 347, 32),
(1732, 0, 347, 34),
(1733, 0, 347, 42),
(1734, 1, 347, 43),
(1735, 1, 348, 24),
(1736, 0, 348, 26),
(1737, 1, 348, 27),
(1738, 1, 348, 30),
(1739, 0, 348, 31),
(1740, 0, 348, 32),
(1741, 0, 348, 34),
(1742, 0, 348, 42),
(1743, 1, 348, 43),
(1744, 0, 349, 18),
(1745, 1, 349, 24),
(1746, 0, 349, 26),
(1747, 1, 349, 27),
(1748, 1, 349, 30),
(1749, 0, 349, 31),
(1750, 0, 349, 32),
(1751, 0, 349, 34),
(1752, 0, 349, 42),
(1753, 1, 349, 43),
(1754, 0, 350, 18),
(1755, 1, 350, 24),
(1756, 0, 350, 26),
(1757, 1, 350, 27),
(1758, 1, 350, 30),
(1759, 0, 350, 31),
(1760, 0, 350, 32),
(1761, 0, 350, 34),
(1762, 0, 350, 42),
(1763, 1, 350, 43),
(1764, 0, 351, 18),
(1765, 1, 351, 24),
(1766, 0, 351, 26),
(1767, 1, 351, 27),
(1768, 1, 351, 30),
(1769, 0, 351, 31),
(1770, 0, 351, 32),
(1771, 0, 351, 34),
(1772, 0, 351, 42),
(1773, 1, 351, 43),
(1774, 0, 352, 18),
(1775, 1, 352, 24),
(1776, 0, 352, 26),
(1777, 1, 352, 27),
(1778, 1, 352, 30),
(1779, 0, 352, 31),
(1780, 0, 352, 32),
(1781, 0, 352, 34),
(1782, 0, 352, 42),
(1783, 1, 352, 43),
(1784, 0, 353, 18),
(1785, 1, 353, 24),
(1786, 0, 353, 26),
(1787, 1, 353, 27),
(1788, 1, 353, 30),
(1789, 0, 353, 31),
(1790, 0, 353, 32),
(1791, 0, 353, 34),
(1792, 0, 353, 42),
(1793, 1, 353, 43),
(1794, 0, 354, 18),
(1795, 1, 354, 24),
(1796, 0, 354, 26),
(1797, 1, 354, 27),
(1798, 1, 354, 30),
(1799, 0, 354, 31),
(1800, 0, 354, 32),
(1801, 0, 354, 34),
(1802, 0, 354, 42),
(1803, 1, 354, 43),
(1804, 0, 355, 18),
(1805, 1, 355, 24),
(1806, 0, 355, 26),
(1807, 1, 355, 27),
(1808, 1, 355, 30),
(1809, 0, 355, 31),
(1810, 0, 355, 32),
(1811, 0, 355, 34),
(1812, 0, 355, 42),
(1813, 1, 355, 43),
(1814, 0, 356, 18),
(1815, 1, 356, 24),
(1816, 0, 356, 26),
(1817, 1, 356, 27),
(1818, 1, 356, 30),
(1819, 0, 356, 31),
(1820, 0, 356, 32),
(1821, 0, 356, 34),
(1822, 0, 356, 42),
(1823, 1, 356, 43),
(1824, 0, 357, 18),
(1825, 1, 357, 24),
(1826, 0, 357, 26),
(1827, 1, 357, 27),
(1828, 1, 357, 30),
(1829, 0, 357, 31),
(1830, 0, 357, 32),
(1831, 0, 357, 34),
(1832, 0, 357, 42),
(1833, 1, 357, 43),
(1834, 0, 358, 18),
(1835, 1, 358, 24),
(1836, 0, 358, 26),
(1837, 1, 358, 27),
(1838, 1, 358, 30),
(1839, 0, 358, 31),
(1840, 0, 358, 32),
(1841, 0, 358, 34),
(1842, 0, 358, 42),
(1843, 1, 358, 43),
(1844, 0, 359, 18),
(1845, 1, 359, 24),
(1846, 0, 359, 26),
(1847, 1, 359, 27),
(1848, 1, 359, 30),
(1849, 0, 359, 31),
(1850, 0, 359, 32),
(1851, 0, 359, 34),
(1852, 0, 359, 42),
(1853, 1, 359, 43),
(1854, 0, 360, 18),
(1855, 1, 360, 24),
(1856, 0, 360, 26),
(1857, 1, 360, 27),
(1858, 1, 360, 30),
(1859, 0, 360, 31),
(1860, 0, 360, 32),
(1861, 0, 360, 34),
(1862, 0, 360, 42),
(1863, 1, 360, 43),
(1864, 0, 361, 18),
(1865, 1, 361, 24),
(1866, 0, 361, 26),
(1867, 1, 361, 27),
(1868, 1, 361, 30),
(1869, 0, 361, 31),
(1870, 0, 361, 32),
(1871, 0, 361, 34),
(1872, 0, 361, 42),
(1873, 1, 361, 43),
(1874, 0, 362, 18),
(1875, 1, 362, 24),
(1876, 1, 362, 26),
(1877, 1, 362, 27),
(1878, 1, 362, 30),
(1879, 0, 362, 31),
(1880, 0, 362, 32),
(1881, 0, 362, 34),
(1882, 0, 362, 42),
(1883, 1, 362, 43),
(1884, 0, 363, 18),
(1885, 1, 363, 24),
(1886, 1, 363, 26),
(1887, 1, 363, 27),
(1888, 1, 363, 30),
(1889, 0, 363, 31),
(1890, 0, 363, 32),
(1891, 0, 363, 34),
(1892, 0, 363, 42),
(1893, 1, 363, 43),
(1894, 0, 364, 18),
(1895, 1, 364, 24),
(1896, 1, 364, 26),
(1897, 1, 364, 27),
(1898, 1, 364, 30),
(1899, 0, 364, 31),
(1900, 0, 364, 32),
(1901, 0, 364, 34),
(1902, 0, 364, 42),
(1903, 1, 364, 43),
(1904, 0, 365, 18),
(1905, 1, 365, 24),
(1906, 1, 365, 26),
(1907, 1, 365, 27),
(1908, 1, 365, 30),
(1909, 0, 365, 31),
(1910, 0, 365, 32),
(1911, 0, 365, 34),
(1912, 0, 365, 42),
(1913, 1, 365, 43),
(1914, 0, 366, 18),
(1915, 1, 366, 24),
(1916, 1, 366, 26),
(1917, 1, 366, 27),
(1918, 1, 366, 30),
(1919, 0, 366, 31),
(1920, 0, 366, 32),
(1921, 0, 366, 34),
(1922, 0, 366, 42),
(1923, 1, 366, 43),
(1924, 0, 367, 18),
(1925, 1, 367, 24),
(1926, 1, 367, 26),
(1927, 1, 367, 27),
(1928, 1, 367, 30),
(1929, 0, 367, 31),
(1930, 0, 367, 32),
(1931, 0, 367, 34),
(1932, 0, 367, 42),
(1933, 1, 367, 43),
(1934, 0, 368, 18),
(1935, 1, 368, 24),
(1936, 1, 368, 26),
(1937, 1, 368, 27),
(1938, 1, 368, 30),
(1939, 0, 368, 31),
(1940, 0, 368, 32),
(1941, 0, 368, 34),
(1942, 0, 368, 42),
(1943, 1, 368, 43),
(1944, 1, 368, 40),
(1945, 1, 369, 24),
(1946, 1, 369, 26),
(1947, 1, 369, 27),
(1948, 1, 369, 30),
(1949, 0, 369, 31),
(1950, 0, 369, 32),
(1951, 0, 369, 34),
(1952, 0, 369, 42),
(1953, 1, 369, 43),
(1954, 0, 370, 18),
(1955, 1, 370, 24),
(1956, 1, 370, 26),
(1957, 1, 370, 27),
(1958, 1, 370, 30),
(1959, 0, 370, 31),
(1960, 0, 370, 32),
(1961, 0, 370, 34),
(1962, 0, 370, 42),
(1963, 1, 370, 43),
(1964, 0, 371, 18),
(1965, 1, 371, 24),
(1966, 1, 371, 26),
(1967, 1, 371, 27),
(1968, 1, 371, 30),
(1969, 0, 371, 31),
(1970, 0, 371, 32),
(1971, 0, 371, 34),
(1972, 0, 371, 42),
(1973, 1, 371, 43),
(1974, 0, 372, 18),
(1975, 1, 372, 24),
(1976, 1, 372, 26),
(1977, 1, 372, 27),
(1978, 1, 372, 30),
(1979, 0, 372, 31),
(1980, 0, 372, 32),
(1981, 0, 372, 34),
(1982, 0, 372, 42),
(1983, 1, 372, 43),
(1984, 0, 373, 18),
(1985, 1, 373, 24),
(1986, 1, 373, 26),
(1987, 1, 373, 27),
(1988, 1, 373, 30),
(1989, 0, 373, 31),
(1990, 0, 373, 32),
(1991, 0, 373, 34),
(1992, 0, 373, 42),
(1993, 1, 373, 43),
(1994, 0, 374, 18),
(1995, 1, 374, 24),
(1996, 1, 374, 26),
(1997, 1, 374, 27),
(1998, 1, 374, 30),
(1999, 0, 374, 31),
(2000, 0, 374, 32),
(2001, 0, 374, 34),
(2002, 0, 374, 42),
(2003, 1, 374, 43),
(2004, 1, 375, 24),
(2005, 1, 375, 26),
(2006, 1, 375, 27),
(2007, 1, 375, 30),
(2008, 0, 375, 31),
(2009, 0, 375, 32),
(2010, 0, 375, 34),
(2011, 0, 375, 42),
(2012, 1, 375, 43),
(2013, 0, 376, 18),
(2014, 1, 376, 24),
(2015, 1, 376, 26),
(2016, 1, 376, 27),
(2017, 1, 376, 30),
(2018, 0, 376, 31),
(2019, 0, 376, 32),
(2020, 0, 376, 34),
(2021, 0, 376, 42),
(2022, 1, 376, 43),
(2023, 0, 377, 18),
(2024, 1, 377, 24),
(2025, 1, 377, 26),
(2026, 1, 377, 27),
(2027, 1, 377, 30),
(2028, 0, 377, 31),
(2029, 0, 377, 32),
(2030, 0, 377, 34),
(2031, 0, 377, 42),
(2032, 1, 377, 43),
(2033, 0, 378, 18),
(2034, 1, 378, 24),
(2035, 1, 378, 26),
(2036, 1, 378, 27),
(2037, 1, 378, 30),
(2038, 0, 378, 31),
(2039, 0, 378, 32),
(2040, 0, 378, 34),
(2041, 0, 378, 42),
(2042, 1, 378, 43),
(2043, 0, 379, 18),
(2044, 1, 379, 24),
(2045, 1, 379, 26),
(2046, 1, 379, 27),
(2047, 1, 379, 30),
(2048, 0, 379, 31),
(2049, 0, 379, 32),
(2050, 0, 379, 34),
(2051, 0, 379, 42),
(2052, 1, 379, 43),
(2053, 0, 380, 18),
(2054, 1, 380, 24),
(2055, 1, 380, 26),
(2056, 1, 380, 27),
(2057, 1, 380, 30),
(2058, 0, 380, 31),
(2059, 0, 380, 32),
(2060, 0, 380, 34),
(2061, 0, 380, 42),
(2062, 1, 380, 43),
(2063, 0, 381, 18),
(2064, 1, 381, 24),
(2065, 1, 381, 26),
(2066, 1, 381, 27),
(2067, 1, 381, 30),
(2068, 0, 381, 31),
(2069, 0, 381, 32),
(2070, 0, 381, 34),
(2071, 0, 381, 42),
(2072, 1, 381, 43),
(2073, 0, 382, 18),
(2074, 1, 382, 24),
(2075, 1, 382, 26),
(2076, 1, 382, 27),
(2077, 1, 382, 30),
(2078, 0, 382, 31),
(2079, 0, 382, 32),
(2080, 0, 382, 34),
(2081, 0, 382, 42),
(2082, 1, 382, 43),
(2083, 0, 383, 18),
(2084, 1, 383, 24),
(2085, 1, 383, 26),
(2086, 1, 383, 27),
(2087, 1, 383, 30),
(2088, 0, 383, 31),
(2089, 0, 383, 32),
(2090, 0, 383, 34),
(2091, 0, 383, 42),
(2092, 1, 383, 43),
(2093, 0, 384, 18),
(2094, 1, 384, 24),
(2095, 1, 384, 26),
(2096, 1, 384, 27),
(2097, 1, 384, 30),
(2098, 0, 384, 31),
(2099, 0, 384, 32),
(2100, 0, 384, 34),
(2101, 0, 384, 42),
(2102, 1, 384, 43),
(2103, 0, 385, 18),
(2104, 1, 385, 24),
(2105, 1, 385, 26),
(2106, 1, 385, 27),
(2107, 1, 385, 30),
(2108, 0, 385, 31),
(2109, 0, 385, 32),
(2110, 0, 385, 34),
(2111, 0, 385, 42),
(2112, 1, 385, 43),
(2113, 0, 386, 18),
(2114, 1, 386, 24),
(2115, 1, 386, 26),
(2116, 1, 386, 27),
(2117, 1, 386, 30),
(2118, 0, 386, 31),
(2119, 0, 386, 32),
(2120, 0, 386, 34),
(2121, 0, 386, 42),
(2122, 1, 386, 43),
(2123, 0, 387, 18),
(2124, 1, 387, 24),
(2125, 1, 387, 26),
(2126, 1, 387, 27),
(2127, 1, 387, 30),
(2128, 0, 387, 31),
(2129, 0, 387, 32),
(2130, 0, 387, 34),
(2131, 0, 387, 42),
(2132, 1, 387, 43),
(2133, 0, 388, 18),
(2134, 1, 388, 24),
(2135, 1, 388, 26),
(2136, 1, 388, 27),
(2137, 1, 388, 30),
(2138, 0, 388, 31),
(2139, 0, 388, 32),
(2140, 0, 388, 34),
(2141, 0, 388, 42),
(2142, 1, 388, 43),
(2143, 0, 389, 18),
(2144, 1, 389, 24),
(2145, 1, 389, 26),
(2146, 1, 389, 27),
(2147, 1, 389, 30),
(2148, 0, 389, 31),
(2149, 0, 389, 32),
(2150, 0, 389, 34),
(2151, 0, 389, 42),
(2152, 1, 389, 43),
(2153, 0, 390, 18),
(2154, 1, 390, 24),
(2155, 1, 390, 26),
(2156, 1, 390, 27),
(2157, 1, 390, 30),
(2158, 0, 390, 31),
(2159, 0, 390, 32),
(2160, 0, 390, 34),
(2161, 0, 390, 42),
(2162, 1, 390, 43),
(2163, 0, 391, 18),
(2164, 1, 391, 24),
(2165, 1, 391, 26),
(2166, 1, 391, 27),
(2167, 1, 391, 30),
(2168, 0, 391, 31),
(2169, 0, 391, 32),
(2170, 0, 391, 34),
(2171, 0, 391, 42),
(2172, 1, 391, 43),
(2173, 0, 392, 18),
(2174, 1, 392, 24),
(2175, 1, 392, 26),
(2176, 1, 392, 27),
(2177, 1, 392, 30),
(2178, 0, 392, 31),
(2179, 0, 392, 32),
(2180, 0, 392, 34),
(2181, 0, 392, 42),
(2182, 1, 392, 43),
(2183, 0, 393, 18),
(2184, 1, 393, 24),
(2185, 1, 393, 26),
(2186, 1, 393, 27),
(2187, 1, 393, 30),
(2188, 0, 393, 31),
(2189, 1, 393, 32),
(2190, 0, 393, 34),
(2191, 0, 393, 42),
(2192, 1, 393, 43),
(2193, 1, 393, 23),
(2194, 0, 394, 18),
(2195, 1, 394, 24),
(2196, 1, 394, 26),
(2197, 1, 394, 27),
(2198, 1, 394, 30),
(2199, 0, 394, 31),
(2200, 1, 394, 32),
(2201, 0, 394, 34),
(2202, 0, 394, 42),
(2203, 1, 394, 43),
(2204, 1, 394, 23),
(2205, 0, 395, 18),
(2206, 1, 395, 24),
(2207, 1, 395, 26),
(2208, 1, 395, 27),
(2209, 1, 395, 30),
(2210, 0, 395, 31),
(2211, 1, 395, 32),
(2212, 0, 395, 34),
(2213, 0, 395, 42),
(2214, 1, 395, 43),
(2215, 1, 395, 23),
(2216, 0, 396, 18),
(2217, 1, 396, 24),
(2218, 1, 396, 26),
(2219, 1, 396, 27),
(2220, 1, 396, 30),
(2221, 0, 396, 31),
(2222, 1, 396, 32),
(2223, 0, 396, 34),
(2224, 0, 396, 42),
(2225, 1, 396, 43),
(2226, 0, 397, 18),
(2227, 1, 397, 24),
(2228, 1, 397, 26),
(2229, 1, 397, 27),
(2230, 1, 397, 30),
(2231, 0, 397, 31),
(2232, 1, 397, 32),
(2233, 0, 397, 34),
(2234, 0, 397, 42),
(2235, 1, 397, 43),
(2236, 0, 398, 18),
(2237, 1, 398, 24),
(2238, 1, 398, 26),
(2239, 1, 398, 27),
(2240, 1, 398, 30),
(2241, 0, 398, 31),
(2242, 1, 398, 32),
(2243, 0, 398, 34),
(2244, 0, 398, 42),
(2245, 1, 398, 43),
(2246, 0, 399, 18),
(2247, 1, 399, 24),
(2248, 1, 399, 26),
(2249, 1, 399, 27),
(2250, 1, 399, 30),
(2251, 0, 399, 31),
(2252, 1, 399, 32),
(2253, 0, 399, 34),
(2254, 0, 399, 42),
(2255, 1, 399, 43),
(2256, 0, 400, 18),
(2257, 1, 400, 24),
(2258, 1, 400, 26),
(2259, 1, 400, 27),
(2260, 1, 400, 30),
(2261, 0, 400, 31),
(2262, 1, 400, 32),
(2263, 0, 400, 34),
(2264, 0, 400, 42),
(2265, 1, 400, 43),
(2266, 0, 400, 46),
(2267, 0, 401, 18),
(2268, 1, 401, 24),
(2269, 1, 401, 26),
(2270, 1, 401, 27),
(2271, 1, 401, 30),
(2272, 0, 401, 31),
(2273, 1, 401, 32),
(2274, 0, 401, 34),
(2275, 0, 401, 42),
(2276, 1, 401, 43),
(2277, 0, 401, 46),
(2278, 0, 402, 18),
(2279, 1, 402, 24),
(2280, 1, 402, 26),
(2281, 1, 402, 27),
(2282, 1, 402, 30),
(2283, 0, 402, 31),
(2284, 1, 402, 32),
(2285, 0, 402, 34),
(2286, 0, 402, 42),
(2287, 1, 402, 43),
(2288, 0, 402, 46),
(2289, 0, 403, 18),
(2290, 1, 403, 24),
(2291, 1, 403, 26),
(2292, 1, 403, 27),
(2293, 1, 403, 30),
(2294, 0, 403, 31),
(2295, 1, 403, 32),
(2296, 0, 403, 34),
(2297, 0, 403, 42),
(2298, 1, 403, 43),
(2299, 0, 403, 46),
(2300, 0, 404, 18),
(2301, 1, 404, 24),
(2302, 1, 404, 26),
(2303, 1, 404, 27),
(2304, 1, 404, 30),
(2305, 0, 404, 31),
(2306, 1, 404, 32),
(2307, 0, 404, 34),
(2308, 0, 404, 42),
(2309, 1, 404, 43),
(2310, 0, 404, 46),
(2311, 0, 405, 18),
(2312, 1, 405, 24),
(2313, 1, 405, 26),
(2314, 1, 405, 27),
(2315, 1, 405, 30),
(2316, 0, 405, 31),
(2317, 1, 405, 32),
(2318, 0, 405, 34),
(2319, 0, 405, 42),
(2320, 1, 405, 43),
(2321, 0, 405, 46),
(2322, 0, 406, 18),
(2323, 1, 406, 24),
(2324, 1, 406, 26),
(2325, 1, 406, 27),
(2326, 1, 406, 30),
(2327, 0, 406, 31),
(2328, 1, 406, 32),
(2329, 0, 406, 34),
(2330, 0, 406, 42),
(2331, 1, 406, 43),
(2332, 0, 406, 46),
(2333, 0, 407, 18),
(2334, 1, 407, 24),
(2335, 1, 407, 26),
(2336, 1, 407, 27),
(2337, 1, 407, 30),
(2338, 0, 407, 31),
(2339, 1, 407, 32),
(2340, 0, 407, 34),
(2341, 0, 407, 42),
(2342, 1, 407, 43),
(2343, 0, 407, 46),
(2344, 0, 408, 18),
(2345, 1, 408, 24),
(2346, 1, 408, 26),
(2347, 1, 408, 27),
(2348, 1, 408, 30),
(2349, 0, 408, 31),
(2350, 1, 408, 32),
(2351, 0, 408, 34),
(2352, 0, 408, 42),
(2353, 1, 408, 43),
(2354, 0, 408, 46),
(2355, 0, 409, 18),
(2356, 1, 409, 24),
(2357, 1, 409, 26),
(2358, 1, 409, 27),
(2359, 1, 409, 30),
(2360, 0, 409, 31),
(2361, 1, 409, 32),
(2362, 0, 409, 34),
(2363, 0, 409, 42),
(2364, 1, 409, 43),
(2365, 0, 409, 46),
(2366, 0, 410, 18),
(2367, 1, 410, 24),
(2368, 1, 410, 26),
(2369, 1, 410, 27),
(2370, 1, 410, 30),
(2371, 0, 410, 31),
(2372, 1, 410, 32),
(2373, 0, 410, 34),
(2374, 0, 410, 42),
(2375, 1, 410, 43),
(2376, 0, 410, 46),
(2377, 0, 411, 18),
(2378, 1, 411, 24),
(2379, 1, 411, 26),
(2380, 1, 411, 27),
(2381, 1, 411, 30),
(2382, 0, 411, 31),
(2383, 1, 411, 32),
(2384, 0, 411, 34),
(2385, 0, 411, 42),
(2386, 1, 411, 43),
(2387, 0, 411, 46),
(2388, 0, 412, 18),
(2389, 1, 412, 24),
(2390, 1, 412, 26),
(2391, 1, 412, 27),
(2392, 1, 412, 30),
(2393, 0, 412, 31),
(2394, 1, 412, 32),
(2395, 0, 412, 34),
(2396, 0, 412, 42),
(2397, 1, 412, 43),
(2398, 0, 412, 46),
(2399, 0, 413, 18),
(2400, 1, 413, 24),
(2401, 1, 413, 26),
(2402, 1, 413, 27),
(2403, 1, 413, 30),
(2404, 0, 413, 31),
(2405, 1, 413, 32),
(2406, 0, 413, 34),
(2407, 0, 413, 42),
(2408, 1, 413, 43),
(2409, 0, 413, 46),
(2410, 0, 414, 18),
(2411, 1, 414, 24),
(2412, 1, 414, 26),
(2413, 1, 414, 27),
(2414, 1, 414, 30),
(2415, 0, 414, 31),
(2416, 1, 414, 32),
(2417, 0, 414, 34),
(2418, 0, 414, 42),
(2419, 1, 414, 43),
(2420, 0, 414, 46),
(2421, 0, 415, 18),
(2422, 1, 415, 24),
(2423, 1, 415, 26),
(2424, 1, 415, 27),
(2425, 1, 415, 30),
(2426, 0, 415, 31),
(2427, 1, 415, 32),
(2428, 0, 415, 34),
(2429, 0, 415, 42),
(2430, 1, 415, 43),
(2431, 0, 415, 46),
(2432, 0, 416, 18),
(2433, 1, 416, 24),
(2434, 1, 416, 26),
(2435, 1, 416, 27),
(2436, 1, 416, 30),
(2437, 0, 416, 31),
(2438, 1, 416, 32),
(2439, 0, 416, 34),
(2440, 0, 416, 42),
(2441, 1, 416, 43),
(2442, 0, 416, 46),
(2443, 0, 417, 18),
(2444, 1, 417, 24),
(2445, 1, 417, 26),
(2446, 1, 417, 27),
(2447, 1, 417, 30),
(2448, 0, 417, 31),
(2449, 1, 417, 32),
(2450, 0, 417, 34),
(2451, 0, 417, 42),
(2452, 1, 417, 43),
(2453, 0, 417, 46),
(2454, 0, 418, 18),
(2455, 1, 418, 24),
(2456, 1, 418, 26),
(2457, 1, 418, 27),
(2458, 1, 418, 30),
(2459, 0, 418, 31),
(2460, 1, 418, 32),
(2461, 0, 418, 34),
(2462, 0, 418, 42),
(2463, 1, 418, 43),
(2464, 0, 418, 46),
(2465, 0, 419, 18),
(2466, 1, 419, 24),
(2467, 1, 419, 26),
(2468, 1, 419, 27),
(2469, 1, 419, 30),
(2470, 0, 419, 31),
(2471, 1, 419, 32),
(2472, 0, 419, 34),
(2473, 0, 419, 42),
(2474, 1, 419, 43),
(2475, 0, 419, 46),
(2476, 0, 420, 18),
(2477, 1, 420, 24),
(2478, 1, 420, 26),
(2479, 1, 420, 27),
(2480, 1, 420, 30),
(2481, 0, 420, 31),
(2482, 1, 420, 32),
(2483, 0, 420, 34),
(2484, 0, 420, 42),
(2485, 1, 420, 43),
(2486, 0, 420, 46),
(2487, 0, 421, 18),
(2488, 1, 421, 24),
(2489, 1, 421, 26),
(2490, 1, 421, 27),
(2491, 1, 421, 30),
(2492, 0, 421, 31),
(2493, 1, 421, 32),
(2494, 0, 421, 34),
(2495, 0, 421, 42),
(2496, 1, 421, 43),
(2497, 0, 421, 46),
(2498, 0, 422, 18),
(2499, 1, 422, 24),
(2500, 1, 422, 26),
(2501, 1, 422, 27),
(2502, 1, 422, 30),
(2503, 0, 422, 31),
(2504, 1, 422, 32),
(2505, 0, 422, 34),
(2506, 0, 422, 42),
(2507, 1, 422, 43),
(2508, 1, 422, 40),
(2509, 0, 423, 18),
(2510, 1, 423, 24),
(2511, 1, 423, 26),
(2512, 1, 423, 27),
(2513, 1, 423, 30),
(2514, 0, 423, 31),
(2515, 1, 423, 32),
(2516, 0, 423, 34),
(2517, 0, 423, 42),
(2518, 1, 423, 43),
(2519, 1, 423, 40),
(2520, 0, 424, 18),
(2521, 1, 424, 24),
(2522, 1, 424, 26),
(2523, 1, 424, 27),
(2524, 1, 424, 30),
(2525, 0, 424, 31),
(2526, 1, 424, 32),
(2527, 0, 424, 34),
(2528, 0, 424, 42),
(2529, 1, 424, 43),
(2530, 0, 424, 44),
(2531, 0, 425, 18),
(2532, 1, 425, 24),
(2533, 1, 425, 26),
(2534, 1, 425, 27),
(2535, 1, 425, 30),
(2536, 0, 425, 31),
(2537, 1, 425, 32),
(2538, 0, 425, 34),
(2539, 0, 425, 42),
(2540, 1, 425, 43),
(2541, 0, 426, 18),
(2542, 1, 426, 24),
(2543, 1, 426, 26),
(2544, 1, 426, 27),
(2545, 1, 426, 30),
(2546, 0, 426, 31),
(2547, 1, 426, 32),
(2548, 0, 426, 34),
(2549, 0, 426, 42),
(2550, 1, 426, 43),
(2551, 0, 427, 18),
(2552, 1, 427, 24),
(2553, 1, 427, 26),
(2554, 1, 427, 27),
(2555, 1, 427, 30),
(2556, 0, 427, 31),
(2557, 1, 427, 32),
(2558, 0, 427, 34),
(2559, 1, 427, 42),
(2560, 1, 427, 43),
(2561, 0, 428, 18),
(2562, 1, 428, 24),
(2563, 1, 428, 26),
(2564, 1, 428, 27),
(2565, 1, 428, 30),
(2566, 0, 428, 31),
(2567, 1, 428, 32),
(2568, 0, 428, 34),
(2569, 1, 428, 42),
(2570, 1, 428, 43),
(2571, 0, 429, 18),
(2572, 1, 429, 24),
(2573, 1, 429, 26),
(2574, 1, 429, 27),
(2575, 1, 429, 30),
(2576, 0, 429, 31),
(2577, 1, 429, 32),
(2578, 0, 429, 34),
(2579, 1, 429, 42),
(2580, 1, 429, 43),
(2581, 0, 430, 18),
(2582, 1, 430, 24),
(2583, 1, 430, 26),
(2584, 1, 430, 27),
(2585, 1, 430, 30),
(2586, 0, 430, 31),
(2587, 1, 430, 32),
(2588, 0, 430, 34),
(2589, 1, 430, 42),
(2590, 1, 430, 43),
(2591, 0, 431, 18),
(2592, 1, 431, 24),
(2593, 1, 431, 26),
(2594, 1, 431, 27),
(2595, 1, 431, 30),
(2596, 0, 431, 31),
(2597, 1, 431, 32),
(2598, 0, 431, 34),
(2599, 1, 431, 42),
(2600, 1, 431, 43),
(2601, 0, 432, 18),
(2602, 1, 432, 24),
(2603, 1, 432, 26),
(2604, 1, 432, 27),
(2605, 1, 432, 30),
(2606, 0, 432, 31),
(2607, 1, 432, 32),
(2608, 0, 432, 34),
(2609, 1, 432, 42),
(2610, 1, 432, 43),
(2611, 0, 433, 18),
(2612, 1, 433, 24),
(2613, 1, 433, 26),
(2614, 1, 433, 27),
(2615, 1, 433, 30),
(2616, 0, 433, 31),
(2617, 1, 433, 32),
(2618, 0, 433, 34),
(2619, 1, 433, 42),
(2620, 1, 433, 43),
(2621, 0, 434, 18),
(2622, 1, 434, 24),
(2623, 1, 434, 26),
(2624, 1, 434, 27),
(2625, 1, 434, 30),
(2626, 0, 434, 31),
(2627, 1, 434, 32),
(2628, 0, 434, 34),
(2629, 1, 434, 42),
(2630, 1, 434, 43),
(2631, 1, 434, 40),
(2632, 0, 435, 18),
(2633, 1, 435, 24),
(2634, 1, 435, 26),
(2635, 1, 435, 27),
(2636, 1, 435, 30),
(2637, 0, 435, 31),
(2638, 1, 435, 32),
(2639, 0, 435, 34),
(2640, 1, 435, 42),
(2641, 1, 435, 43),
(2642, 1, 435, 40),
(2643, 0, 436, 18),
(2644, 1, 436, 24),
(2645, 1, 436, 26),
(2646, 1, 436, 27),
(2647, 1, 436, 30),
(2648, 0, 436, 31),
(2649, 1, 436, 32),
(2650, 0, 436, 34),
(2651, 1, 436, 42),
(2652, 1, 436, 43),
(2653, 0, 437, 18),
(2654, 1, 437, 24),
(2655, 1, 437, 26),
(2656, 1, 437, 27),
(2657, 1, 437, 30),
(2658, 0, 437, 31),
(2659, 1, 437, 32),
(2660, 0, 437, 34),
(2661, 1, 437, 42),
(2662, 1, 437, 43),
(2663, 0, 438, 18),
(2664, 1, 438, 24),
(2665, 1, 438, 26),
(2666, 1, 438, 27),
(2667, 1, 438, 30),
(2668, 0, 438, 31),
(2669, 1, 438, 32),
(2670, 0, 438, 34),
(2671, 1, 438, 42),
(2672, 1, 438, 43),
(2673, 0, 439, 18),
(2674, 1, 439, 24),
(2675, 1, 439, 26),
(2676, 1, 439, 27),
(2677, 1, 439, 30),
(2678, 0, 439, 31),
(2679, 1, 439, 32),
(2680, 0, 439, 34),
(2681, 1, 439, 42),
(2682, 1, 439, 43),
(2683, 0, 440, 18),
(2684, 1, 440, 24),
(2685, 1, 440, 26),
(2686, 1, 440, 27),
(2687, 1, 440, 30),
(2688, 0, 440, 31),
(2689, 1, 440, 32),
(2690, 0, 440, 34),
(2691, 1, 440, 42),
(2692, 1, 440, 43),
(2693, 0, 441, 18),
(2694, 1, 441, 24),
(2695, 1, 441, 26),
(2696, 1, 441, 27),
(2697, 1, 441, 30),
(2698, 0, 441, 31),
(2699, 1, 441, 32),
(2700, 0, 441, 34),
(2701, 1, 441, 42),
(2702, 1, 441, 43),
(2703, 0, 442, 18),
(2704, 1, 442, 24),
(2705, 1, 442, 26),
(2706, 1, 442, 27),
(2707, 1, 442, 30),
(2708, 0, 442, 31),
(2709, 1, 442, 32),
(2710, 0, 442, 34),
(2711, 1, 442, 42),
(2712, 1, 442, 43),
(2713, 0, 443, 18),
(2714, 1, 443, 24),
(2715, 1, 443, 26),
(2716, 1, 443, 27),
(2717, 1, 443, 30),
(2718, 0, 443, 31),
(2719, 1, 443, 32),
(2720, 0, 443, 34),
(2721, 1, 443, 42),
(2722, 1, 443, 43),
(2723, 0, 444, 18),
(2724, 1, 444, 24),
(2725, 1, 444, 26),
(2726, 1, 444, 27),
(2727, 1, 444, 30),
(2728, 0, 444, 31),
(2729, 1, 444, 32),
(2730, 0, 444, 34),
(2731, 1, 444, 42),
(2732, 1, 444, 43),
(2733, 0, 445, 18),
(2734, 1, 445, 24),
(2735, 1, 445, 26),
(2736, 1, 445, 27),
(2737, 1, 445, 30),
(2738, 0, 445, 31),
(2739, 1, 445, 32),
(2740, 0, 445, 34),
(2741, 1, 445, 42),
(2742, 1, 445, 43),
(2743, 0, 446, 18),
(2744, 1, 446, 24),
(2745, 1, 446, 26),
(2746, 1, 446, 27),
(2747, 1, 446, 30),
(2748, 0, 446, 31),
(2749, 1, 446, 32),
(2750, 0, 446, 34),
(2751, 1, 446, 42),
(2752, 1, 446, 43),
(2753, 0, 447, 18),
(2754, 1, 447, 24),
(2755, 1, 447, 26),
(2756, 1, 447, 27),
(2757, 1, 447, 30),
(2758, 0, 447, 31),
(2759, 1, 447, 32),
(2760, 0, 447, 34),
(2761, 1, 447, 42),
(2762, 1, 447, 43),
(2763, 1, 447, 40),
(2764, 0, 448, 18),
(2765, 1, 448, 24),
(2766, 1, 448, 26),
(2767, 1, 448, 27),
(2768, 1, 448, 30),
(2769, 0, 448, 31),
(2770, 1, 448, 32),
(2771, 0, 448, 34),
(2772, 1, 448, 42),
(2773, 1, 448, 43),
(2774, 1, 448, 40),
(2775, 0, 449, 18),
(2776, 1, 449, 24),
(2777, 1, 449, 26),
(2778, 1, 449, 27),
(2779, 1, 449, 30),
(2780, 0, 449, 31),
(2781, 1, 449, 32),
(2782, 0, 449, 34),
(2783, 1, 449, 42),
(2784, 1, 449, 43),
(2785, 0, 450, 18),
(2786, 1, 450, 24),
(2787, 1, 450, 26),
(2788, 1, 450, 27),
(2789, 1, 450, 30),
(2790, 0, 450, 31),
(2791, 1, 450, 32),
(2792, 0, 450, 34),
(2793, 1, 450, 42),
(2794, 1, 450, 43),
(2795, 0, 451, 18),
(2796, 1, 451, 24),
(2797, 1, 451, 26),
(2798, 1, 451, 27),
(2799, 1, 451, 30),
(2800, 0, 451, 31),
(2801, 1, 451, 32),
(2802, 0, 451, 34),
(2803, 1, 451, 42),
(2804, 1, 451, 43),
(2805, 0, 452, 18),
(2806, 1, 452, 24),
(2807, 1, 452, 26),
(2808, 1, 452, 27),
(2809, 1, 452, 30),
(2810, 0, 452, 31),
(2811, 1, 452, 32),
(2812, 0, 452, 34),
(2813, 1, 452, 42),
(2814, 1, 452, 43),
(2815, 1, 453, 24),
(2816, 1, 453, 26),
(2817, 1, 453, 27),
(2818, 1, 453, 30),
(2819, 0, 453, 31),
(2820, 1, 453, 32),
(2821, 0, 453, 34),
(2822, 1, 453, 42),
(2823, 1, 453, 43),
(2824, 0, 454, 18),
(2825, 1, 454, 24),
(2826, 1, 454, 26),
(2827, 1, 454, 27),
(2828, 1, 454, 30),
(2829, 0, 454, 31),
(2830, 1, 454, 32),
(2831, 0, 454, 34),
(2832, 1, 454, 42),
(2833, 1, 454, 43),
(2834, 0, 455, 18),
(2835, 1, 455, 24),
(2836, 1, 455, 26),
(2837, 1, 455, 27),
(2838, 1, 455, 30),
(2839, 0, 455, 31),
(2840, 1, 455, 32),
(2841, 0, 455, 34),
(2842, 1, 455, 42),
(2843, 1, 455, 43),
(2844, 0, 456, 18),
(2845, 1, 456, 24),
(2846, 1, 456, 26),
(2847, 1, 456, 27),
(2848, 1, 456, 30),
(2849, 0, 456, 31),
(2850, 1, 456, 32),
(2851, 0, 456, 34),
(2852, 1, 456, 42),
(2853, 1, 456, 43),
(2854, 0, 457, 18),
(2855, 1, 457, 24),
(2856, 1, 457, 26),
(2857, 1, 457, 27),
(2858, 1, 457, 30),
(2859, 0, 457, 31),
(2860, 1, 457, 32),
(2861, 0, 457, 34),
(2862, 1, 457, 42),
(2863, 1, 457, 43),
(2864, 0, 458, 18),
(2865, 1, 458, 24),
(2866, 1, 458, 26),
(2867, 1, 458, 27),
(2868, 1, 458, 30),
(2869, 0, 458, 31),
(2870, 1, 458, 32),
(2871, 0, 458, 34),
(2872, 1, 458, 42),
(2873, 1, 458, 43),
(2874, 0, 459, 18),
(2875, 1, 459, 24),
(2876, 1, 459, 26),
(2877, 1, 459, 27),
(2878, 1, 459, 30),
(2879, 0, 459, 31),
(2880, 1, 459, 32),
(2881, 0, 459, 34),
(2882, 1, 459, 42),
(2883, 1, 459, 43),
(2884, 0, 460, 18),
(2885, 1, 460, 24),
(2886, 1, 460, 26),
(2887, 1, 460, 27),
(2888, 1, 460, 30),
(2889, 0, 460, 31),
(2890, 1, 460, 32),
(2891, 0, 460, 34),
(2892, 1, 460, 42),
(2893, 1, 460, 43),
(2894, 0, 461, 18),
(2895, 1, 461, 24),
(2896, 1, 461, 26),
(2897, 1, 461, 27),
(2898, 1, 461, 30),
(2899, 0, 461, 31),
(2900, 1, 461, 32),
(2901, 0, 461, 34),
(2902, 1, 461, 42),
(2903, 1, 461, 43),
(2904, 0, 462, 18),
(2905, 1, 462, 24),
(2906, 1, 462, 26),
(2907, 1, 462, 27),
(2908, 1, 462, 30),
(2909, 0, 462, 31),
(2910, 1, 462, 32),
(2911, 0, 462, 34),
(2912, 1, 462, 42),
(2913, 1, 462, 43),
(2914, 0, 463, 18),
(2915, 1, 463, 24),
(2916, 1, 463, 26),
(2917, 1, 463, 27),
(2918, 1, 463, 30),
(2919, 0, 463, 31),
(2920, 1, 463, 32),
(2921, 0, 463, 34),
(2922, 1, 463, 42),
(2923, 1, 463, 43),
(2924, 0, 464, 18),
(2925, 1, 464, 24),
(2926, 1, 464, 26),
(2927, 1, 464, 27),
(2928, 1, 464, 30),
(2929, 0, 464, 31),
(2930, 1, 464, 32),
(2931, 0, 464, 34),
(2932, 1, 464, 42),
(2933, 1, 464, 43),
(2934, 0, 465, 18),
(2935, 1, 465, 24),
(2936, 1, 465, 26),
(2937, 1, 465, 27),
(2938, 1, 465, 30),
(2939, 0, 465, 31),
(2940, 1, 465, 32),
(2941, 0, 465, 34),
(2942, 1, 465, 42),
(2943, 1, 465, 43),
(2944, 0, 465, 44),
(2945, 0, 466, 18),
(2946, 1, 466, 24),
(2947, 1, 466, 26),
(2948, 1, 466, 27),
(2949, 1, 466, 30),
(2950, 1, 466, 31),
(2951, 1, 466, 32),
(2952, 0, 466, 34),
(2953, 1, 466, 42),
(2954, 1, 466, 43),
(2955, 0, 467, 18),
(2956, 1, 467, 24),
(2957, 1, 467, 26),
(2958, 1, 467, 27),
(2959, 1, 467, 30),
(2960, 1, 467, 31),
(2961, 1, 467, 32),
(2962, 0, 467, 34),
(2963, 1, 467, 42),
(2964, 1, 467, 43),
(2965, 0, 467, 44),
(2966, 0, 468, 18),
(2967, 1, 468, 24),
(2968, 1, 468, 26),
(2969, 1, 468, 27),
(2970, 1, 468, 30),
(2971, 1, 468, 31),
(2972, 1, 468, 32),
(2973, 0, 468, 34),
(2974, 1, 468, 42),
(2975, 1, 468, 43),
(2976, 0, 469, 18),
(2977, 1, 469, 24),
(2978, 1, 469, 26),
(2979, 1, 469, 27),
(2980, 1, 469, 30),
(2981, 1, 469, 31),
(2982, 1, 469, 32),
(2983, 0, 469, 34),
(2984, 1, 469, 42),
(2985, 1, 469, 43),
(2986, 0, 470, 18),
(2987, 1, 470, 24),
(2988, 1, 470, 26),
(2989, 1, 470, 27),
(2990, 1, 470, 30),
(2991, 1, 470, 31),
(2992, 1, 470, 32),
(2993, 0, 470, 34),
(2994, 1, 470, 42),
(2995, 1, 470, 43),
(2996, 0, 472, 18),
(2997, 0, 473, 18),
(2998, 1, 473, 24),
(2999, 1, 473, 26),
(3000, 1, 473, 27),
(3001, 1, 473, 30),
(3002, 1, 473, 31),
(3003, 1, 473, 32),
(3004, 0, 473, 34),
(3005, 1, 473, 42),
(3006, 1, 473, 43),
(3007, 0, 474, 18),
(3008, 1, 474, 24),
(3009, 1, 474, 26),
(3010, 1, 474, 27),
(3011, 1, 474, 30),
(3012, 1, 474, 31),
(3013, 1, 474, 32),
(3014, 0, 474, 34),
(3015, 1, 474, 42),
(3016, 1, 474, 43),
(3017, 0, 475, 18),
(3018, 1, 475, 24),
(3019, 1, 475, 26),
(3020, 1, 475, 27),
(3021, 1, 475, 30),
(3022, 1, 475, 31),
(3023, 1, 475, 32),
(3024, 0, 475, 34),
(3025, 1, 475, 42),
(3026, 1, 475, 43),
(3027, 0, 476, 18),
(3028, 1, 476, 24),
(3029, 1, 476, 26),
(3030, 1, 476, 27),
(3031, 1, 476, 30),
(3032, 1, 476, 31),
(3033, 1, 476, 32),
(3034, 0, 476, 34),
(3035, 1, 476, 42),
(3036, 1, 476, 43),
(3037, 0, 476, 46),
(3038, 0, 477, 18),
(3039, 1, 477, 24),
(3040, 1, 477, 26),
(3041, 1, 477, 27),
(3042, 1, 477, 30),
(3043, 1, 477, 31),
(3044, 1, 477, 32),
(3045, 0, 477, 34),
(3046, 1, 477, 42),
(3047, 1, 477, 43),
(3048, 0, 478, 18),
(3049, 1, 478, 24);
INSERT INTO `tblusuarionotificaciones` (`idUsuarioNotificaciones`, `Estado`, `idNotificaciones`, `idCuentaUsuario`) VALUES
(3050, 1, 478, 26),
(3051, 1, 478, 27),
(3052, 1, 478, 30),
(3053, 1, 478, 31),
(3054, 1, 478, 32),
(3055, 0, 478, 34),
(3056, 1, 478, 42),
(3057, 1, 478, 43),
(3058, 0, 478, 46),
(3059, 0, 479, 18),
(3060, 1, 479, 24),
(3061, 1, 479, 26),
(3062, 1, 479, 27),
(3063, 1, 479, 30),
(3064, 1, 479, 31),
(3065, 1, 479, 32),
(3066, 0, 479, 34),
(3067, 1, 479, 42),
(3068, 1, 479, 43),
(3069, 0, 480, 18),
(3070, 1, 480, 24),
(3071, 1, 480, 26),
(3072, 1, 480, 27),
(3073, 1, 480, 30),
(3074, 1, 480, 31),
(3075, 1, 480, 32),
(3076, 1, 480, 34),
(3077, 1, 480, 42),
(3078, 1, 480, 43),
(3079, 0, 481, 18),
(3080, 1, 481, 24),
(3081, 1, 481, 26),
(3082, 1, 481, 27),
(3083, 1, 481, 30),
(3084, 1, 481, 31),
(3085, 1, 481, 32),
(3086, 1, 481, 34),
(3087, 1, 481, 42),
(3088, 1, 481, 43),
(3089, 0, 481, 46),
(3090, 0, 482, 18),
(3091, 1, 482, 24),
(3092, 1, 482, 26),
(3093, 1, 482, 27),
(3094, 1, 482, 30),
(3095, 1, 482, 31),
(3096, 1, 482, 32),
(3097, 1, 482, 34),
(3098, 1, 482, 42),
(3099, 1, 482, 43),
(3100, 0, 483, 18),
(3101, 1, 483, 24),
(3102, 1, 483, 26),
(3103, 1, 483, 27),
(3104, 1, 483, 30),
(3105, 1, 483, 31),
(3106, 1, 483, 32),
(3107, 1, 483, 34),
(3108, 1, 483, 42),
(3109, 1, 483, 43),
(3110, 0, 484, 18),
(3111, 1, 484, 24),
(3112, 1, 484, 26),
(3113, 1, 484, 27),
(3114, 1, 484, 30),
(3115, 1, 484, 31),
(3116, 1, 484, 32),
(3117, 1, 484, 34),
(3118, 1, 484, 42),
(3119, 1, 484, 43),
(3120, 1, 484, 29),
(3121, 0, 485, 18),
(3122, 1, 485, 24),
(3123, 1, 485, 26),
(3124, 1, 485, 27),
(3125, 1, 485, 30),
(3126, 1, 485, 31),
(3127, 1, 485, 32),
(3128, 1, 485, 34),
(3129, 1, 485, 42),
(3130, 1, 485, 43),
(3131, 1, 485, 23),
(3132, 0, 486, 18),
(3133, 1, 486, 24),
(3134, 1, 486, 26),
(3135, 1, 486, 27),
(3136, 1, 486, 30),
(3137, 1, 486, 31),
(3138, 1, 486, 32),
(3139, 1, 486, 34),
(3140, 1, 486, 42),
(3141, 1, 486, 43),
(3142, 0, 487, 18),
(3143, 1, 487, 24),
(3144, 1, 487, 26),
(3145, 1, 487, 27),
(3146, 1, 487, 30),
(3147, 1, 487, 31),
(3148, 1, 487, 32),
(3149, 1, 487, 34),
(3150, 1, 487, 42),
(3151, 1, 487, 43),
(3152, 0, 487, 46),
(3153, 0, 488, 18),
(3154, 1, 488, 24),
(3155, 1, 488, 26),
(3156, 1, 488, 27),
(3157, 1, 488, 30),
(3158, 1, 488, 31),
(3159, 1, 488, 32),
(3160, 1, 488, 34),
(3161, 1, 488, 42),
(3162, 1, 488, 43),
(3163, 0, 489, 18),
(3164, 1, 489, 24),
(3165, 1, 489, 26),
(3166, 1, 489, 27),
(3167, 1, 489, 30),
(3168, 1, 489, 31),
(3169, 1, 489, 32),
(3170, 1, 489, 34),
(3171, 1, 489, 42),
(3172, 1, 489, 43),
(3173, 0, 489, 46),
(3174, 0, 490, 18),
(3175, 1, 490, 24),
(3176, 1, 490, 26),
(3177, 1, 490, 27),
(3178, 1, 490, 30),
(3179, 1, 490, 31),
(3180, 1, 490, 32),
(3181, 1, 490, 34),
(3182, 1, 490, 42),
(3183, 1, 490, 43),
(3184, 0, 491, 18),
(3185, 1, 491, 24),
(3186, 1, 491, 26),
(3187, 1, 491, 27),
(3188, 1, 491, 30),
(3189, 1, 491, 31),
(3190, 1, 491, 32),
(3191, 1, 491, 34),
(3192, 1, 491, 42),
(3193, 1, 491, 43),
(3194, 0, 491, 46),
(3195, 0, 492, 18),
(3196, 1, 492, 24),
(3197, 1, 492, 26),
(3198, 1, 492, 27),
(3199, 1, 492, 30),
(3200, 1, 492, 31),
(3201, 1, 492, 32),
(3202, 1, 492, 34),
(3203, 1, 492, 42),
(3204, 1, 492, 43),
(3205, 0, 493, 18),
(3206, 1, 493, 24),
(3207, 1, 493, 26),
(3208, 1, 493, 27),
(3209, 1, 493, 30),
(3210, 1, 493, 31),
(3211, 1, 493, 32),
(3212, 1, 493, 34),
(3213, 1, 493, 42),
(3214, 1, 493, 43),
(3215, 0, 494, 18),
(3216, 0, 495, 18),
(3217, 0, 495, 46),
(3218, 0, 496, 18),
(3219, 1, 496, 24),
(3220, 1, 496, 26),
(3221, 1, 496, 27),
(3222, 1, 496, 30),
(3223, 1, 496, 31),
(3224, 1, 496, 32),
(3225, 1, 496, 34),
(3226, 1, 496, 42),
(3227, 1, 496, 43),
(3228, 0, 496, 46),
(3229, 0, 497, 18),
(3230, 1, 497, 24),
(3231, 1, 497, 26),
(3232, 1, 497, 27),
(3233, 1, 497, 30),
(3234, 1, 497, 31),
(3235, 1, 497, 32),
(3236, 1, 497, 34),
(3237, 1, 497, 42),
(3238, 1, 497, 43),
(3239, 0, 498, 18),
(3240, 1, 498, 24),
(3241, 1, 498, 26),
(3242, 1, 498, 27),
(3243, 1, 498, 30),
(3244, 1, 498, 31),
(3245, 1, 498, 32),
(3246, 1, 498, 34),
(3247, 1, 498, 42),
(3248, 1, 498, 43),
(3249, 0, 499, 18),
(3250, 1, 499, 24),
(3251, 1, 499, 26),
(3252, 1, 499, 27),
(3253, 1, 499, 30),
(3254, 1, 499, 31),
(3255, 1, 499, 32),
(3256, 1, 499, 34),
(3257, 1, 499, 42),
(3258, 1, 499, 43),
(3259, 0, 500, 18),
(3260, 1, 500, 24),
(3261, 1, 500, 26),
(3262, 1, 500, 27),
(3263, 1, 500, 30),
(3264, 1, 500, 31),
(3265, 1, 500, 32),
(3266, 1, 500, 34),
(3267, 1, 500, 42),
(3268, 1, 500, 43),
(3269, 0, 501, 18),
(3270, 1, 501, 24),
(3271, 1, 501, 26),
(3272, 1, 501, 27),
(3273, 1, 501, 30),
(3274, 1, 501, 31),
(3275, 1, 501, 32),
(3276, 1, 501, 34),
(3277, 1, 501, 42),
(3278, 1, 501, 43),
(3279, 0, 502, 18),
(3280, 1, 502, 24),
(3281, 1, 502, 26),
(3282, 1, 502, 27),
(3283, 1, 502, 30),
(3284, 1, 502, 31),
(3285, 1, 502, 32),
(3286, 1, 502, 34),
(3287, 1, 502, 42),
(3288, 1, 502, 43),
(3289, 1, 502, 46),
(3290, 0, 503, 18),
(3291, 1, 503, 24),
(3292, 1, 503, 26),
(3293, 1, 503, 27),
(3294, 1, 503, 30),
(3295, 1, 503, 31),
(3296, 1, 503, 32),
(3297, 1, 503, 34),
(3298, 1, 503, 42),
(3299, 1, 503, 43),
(3300, 0, 504, 18),
(3301, 1, 504, 24),
(3302, 1, 504, 26),
(3303, 1, 504, 27),
(3304, 1, 504, 30),
(3305, 1, 504, 31),
(3306, 1, 504, 32),
(3307, 1, 504, 34),
(3308, 1, 504, 42),
(3309, 1, 504, 43),
(3310, 0, 505, 18),
(3311, 1, 505, 24),
(3312, 1, 505, 26),
(3313, 1, 505, 27),
(3314, 1, 505, 30),
(3315, 1, 505, 31),
(3316, 1, 505, 32),
(3317, 1, 505, 34),
(3318, 1, 505, 42),
(3319, 1, 505, 43),
(3320, 0, 506, 18),
(3321, 1, 506, 24),
(3322, 1, 506, 26),
(3323, 1, 506, 27),
(3324, 1, 506, 30),
(3325, 1, 506, 31),
(3326, 1, 506, 32),
(3327, 1, 506, 34),
(3328, 1, 506, 42),
(3329, 1, 506, 43),
(3330, 1, 506, 46),
(3331, 0, 507, 18),
(3332, 1, 507, 24),
(3333, 1, 507, 26),
(3334, 1, 507, 27),
(3335, 1, 507, 30),
(3336, 1, 507, 31),
(3337, 1, 507, 32),
(3338, 1, 507, 34),
(3339, 1, 507, 42),
(3340, 1, 507, 43),
(3341, 0, 508, 18),
(3342, 1, 508, 24),
(3343, 1, 508, 26),
(3344, 1, 508, 27),
(3345, 1, 508, 30),
(3346, 1, 508, 31),
(3347, 1, 508, 32),
(3348, 1, 508, 34),
(3349, 1, 508, 42),
(3350, 1, 508, 43),
(3351, 0, 509, 18),
(3352, 1, 509, 24),
(3353, 1, 509, 26),
(3354, 1, 509, 27),
(3355, 1, 509, 30),
(3356, 1, 509, 31),
(3357, 1, 509, 32),
(3358, 1, 509, 34),
(3359, 1, 509, 42),
(3360, 1, 509, 43),
(3361, 0, 510, 18),
(3362, 1, 510, 24),
(3363, 1, 510, 26),
(3364, 1, 510, 27),
(3365, 1, 510, 30),
(3366, 1, 510, 31),
(3367, 1, 510, 32),
(3368, 1, 510, 34),
(3369, 1, 510, 42),
(3370, 1, 510, 43),
(3371, 1, 510, 46),
(3372, 0, 511, 18),
(3373, 1, 511, 24),
(3374, 1, 511, 26),
(3375, 1, 511, 27),
(3376, 1, 511, 30),
(3377, 1, 511, 31),
(3378, 1, 511, 32),
(3379, 1, 511, 34),
(3380, 1, 511, 42),
(3381, 1, 511, 43),
(3382, 0, 512, 18),
(3383, 1, 512, 24),
(3384, 1, 512, 26),
(3385, 1, 512, 27),
(3386, 1, 512, 30),
(3387, 1, 512, 31),
(3388, 1, 512, 32),
(3389, 1, 512, 34),
(3390, 1, 512, 42),
(3391, 1, 512, 43),
(3392, 0, 513, 18),
(3393, 1, 513, 24),
(3394, 1, 513, 26),
(3395, 1, 513, 27),
(3396, 1, 513, 30),
(3397, 1, 513, 31),
(3398, 1, 513, 32),
(3399, 1, 513, 34),
(3400, 1, 513, 42),
(3401, 1, 513, 43),
(3402, 0, 514, 18),
(3403, 1, 514, 24),
(3404, 1, 514, 26),
(3405, 1, 514, 27),
(3406, 1, 514, 30),
(3407, 1, 514, 31),
(3408, 1, 514, 32),
(3409, 1, 514, 34),
(3410, 1, 514, 42),
(3411, 1, 514, 43),
(3412, 1, 514, 46),
(3413, 0, 515, 18),
(3414, 1, 515, 24),
(3415, 1, 515, 26),
(3416, 1, 515, 27),
(3417, 1, 515, 30),
(3418, 1, 515, 31),
(3419, 1, 515, 32),
(3420, 1, 515, 34),
(3421, 1, 515, 42),
(3422, 1, 515, 43),
(3423, 0, 516, 18),
(3424, 1, 516, 24),
(3425, 1, 516, 26),
(3426, 1, 516, 27),
(3427, 1, 516, 30),
(3428, 1, 516, 31),
(3429, 1, 516, 32),
(3430, 1, 516, 34),
(3431, 1, 516, 42),
(3432, 1, 516, 43),
(3433, 0, 517, 18),
(3434, 1, 517, 24),
(3435, 1, 517, 26),
(3436, 1, 517, 27),
(3437, 1, 517, 30),
(3438, 1, 517, 31),
(3439, 1, 517, 32),
(3440, 1, 517, 34),
(3441, 1, 517, 42),
(3442, 1, 517, 43),
(3443, 0, 518, 18),
(3444, 1, 518, 24),
(3445, 1, 518, 26),
(3446, 1, 518, 27),
(3447, 1, 518, 30),
(3448, 1, 518, 31),
(3449, 1, 518, 32),
(3450, 1, 518, 34),
(3451, 1, 518, 42),
(3452, 1, 518, 43),
(3453, 1, 518, 46),
(3454, 0, 519, 18),
(3455, 1, 519, 24),
(3456, 1, 519, 26),
(3457, 1, 519, 27),
(3458, 1, 519, 30),
(3459, 1, 519, 31),
(3460, 1, 519, 32),
(3461, 1, 519, 34),
(3462, 1, 519, 42),
(3463, 1, 519, 43),
(3464, 0, 520, 18),
(3465, 0, 521, 18),
(3466, 1, 521, 24),
(3467, 1, 521, 26),
(3468, 1, 521, 27),
(3469, 1, 521, 30),
(3470, 1, 521, 31),
(3471, 1, 521, 32),
(3472, 1, 521, 34),
(3473, 1, 521, 42),
(3474, 1, 521, 43),
(3475, 0, 522, 18),
(3476, 1, 522, 24),
(3477, 1, 522, 26),
(3478, 1, 522, 27),
(3479, 1, 522, 30),
(3480, 1, 522, 31),
(3481, 1, 522, 32),
(3482, 1, 522, 34),
(3483, 1, 522, 42),
(3484, 1, 522, 43),
(3485, 0, 523, 18),
(3486, 1, 523, 24),
(3487, 1, 523, 26),
(3488, 1, 523, 27),
(3489, 1, 523, 30),
(3490, 1, 523, 31),
(3491, 1, 523, 32),
(3492, 1, 523, 34),
(3493, 1, 523, 42),
(3494, 1, 523, 43),
(3495, 0, 524, 18),
(3496, 1, 524, 24),
(3497, 1, 524, 26),
(3498, 1, 524, 27),
(3499, 1, 524, 30),
(3500, 1, 524, 31),
(3501, 1, 524, 32),
(3502, 1, 524, 34),
(3503, 1, 524, 42),
(3504, 1, 524, 43),
(3505, 0, 525, 18),
(3506, 1, 525, 24),
(3507, 1, 525, 26),
(3508, 1, 525, 27),
(3509, 1, 525, 30),
(3510, 1, 525, 31),
(3511, 1, 525, 32),
(3512, 1, 525, 34),
(3513, 1, 525, 42),
(3514, 1, 525, 43),
(3515, 0, 526, 18),
(3516, 1, 526, 24),
(3517, 1, 526, 26),
(3518, 1, 526, 27),
(3519, 1, 526, 30),
(3520, 1, 526, 31),
(3521, 1, 526, 32),
(3522, 1, 526, 34),
(3523, 1, 526, 42),
(3524, 1, 526, 43),
(3525, 0, 527, 18),
(3526, 1, 527, 24),
(3527, 1, 527, 26),
(3528, 1, 527, 27),
(3529, 1, 527, 30),
(3530, 1, 527, 31),
(3531, 1, 527, 32),
(3532, 1, 527, 34),
(3533, 1, 527, 42),
(3534, 1, 527, 43),
(3535, 0, 528, 18),
(3536, 1, 528, 24),
(3537, 1, 528, 26),
(3538, 1, 528, 27),
(3539, 1, 528, 30),
(3540, 1, 528, 31),
(3541, 1, 528, 32),
(3542, 1, 528, 34),
(3543, 1, 528, 42),
(3544, 1, 528, 43),
(3545, 0, 529, 18),
(3546, 1, 529, 24),
(3547, 1, 529, 26),
(3548, 1, 529, 27),
(3549, 1, 529, 30),
(3550, 1, 529, 31),
(3551, 1, 529, 32),
(3552, 1, 529, 34),
(3553, 1, 529, 42),
(3554, 1, 529, 43),
(3555, 0, 530, 18),
(3556, 1, 530, 24),
(3557, 1, 530, 26),
(3558, 1, 530, 27),
(3559, 1, 530, 30),
(3560, 1, 530, 31),
(3561, 1, 530, 32),
(3562, 1, 530, 34),
(3563, 1, 530, 42),
(3564, 1, 530, 43),
(3565, 0, 531, 18),
(3566, 1, 531, 24),
(3567, 1, 531, 26),
(3568, 1, 531, 27),
(3569, 1, 531, 30),
(3570, 1, 531, 31),
(3571, 1, 531, 32),
(3572, 1, 531, 34),
(3573, 1, 531, 42),
(3574, 1, 531, 43),
(3575, 0, 532, 18),
(3576, 1, 532, 24),
(3577, 1, 532, 26),
(3578, 1, 532, 27),
(3579, 1, 532, 30),
(3580, 1, 532, 31),
(3581, 1, 532, 32),
(3582, 1, 532, 34),
(3583, 1, 532, 42),
(3584, 1, 532, 43),
(3585, 0, 533, 18),
(3586, 1, 533, 24),
(3587, 1, 533, 26),
(3588, 1, 533, 27),
(3589, 1, 533, 30),
(3590, 1, 533, 31),
(3591, 1, 533, 32),
(3592, 1, 533, 34),
(3593, 1, 533, 42),
(3594, 1, 533, 43),
(3595, 0, 534, 18),
(3596, 1, 534, 24),
(3597, 1, 534, 26),
(3598, 1, 534, 27),
(3599, 1, 534, 30),
(3600, 1, 534, 31),
(3601, 1, 534, 32),
(3602, 1, 534, 34),
(3603, 1, 534, 42),
(3604, 1, 534, 43),
(3605, 0, 535, 18),
(3606, 1, 535, 24),
(3607, 1, 535, 26),
(3608, 1, 535, 27),
(3609, 1, 535, 30),
(3610, 1, 535, 31),
(3611, 1, 535, 32),
(3612, 1, 535, 34),
(3613, 1, 535, 42),
(3614, 1, 535, 43),
(3615, 0, 536, 18),
(3616, 1, 536, 24),
(3617, 1, 536, 26),
(3618, 1, 536, 27),
(3619, 1, 536, 30),
(3620, 1, 536, 31),
(3621, 1, 536, 32),
(3622, 1, 536, 34),
(3623, 1, 536, 42),
(3624, 1, 536, 43),
(3625, 0, 537, 18),
(3626, 1, 537, 24),
(3627, 1, 537, 26),
(3628, 1, 537, 27),
(3629, 1, 537, 30),
(3630, 1, 537, 31),
(3631, 1, 537, 32),
(3632, 1, 537, 34),
(3633, 1, 537, 42),
(3634, 1, 537, 43),
(3635, 0, 538, 18),
(3636, 1, 538, 24),
(3637, 1, 538, 26),
(3638, 1, 538, 27),
(3639, 1, 538, 30),
(3640, 1, 538, 31),
(3641, 1, 538, 32),
(3642, 1, 538, 34),
(3643, 1, 538, 42),
(3644, 1, 538, 43),
(3645, 0, 539, 18),
(3646, 1, 539, 24),
(3647, 1, 539, 26),
(3648, 1, 539, 27),
(3649, 1, 539, 30),
(3650, 1, 539, 31),
(3651, 1, 539, 32),
(3652, 1, 539, 34),
(3653, 1, 539, 42),
(3654, 1, 539, 43),
(3655, 0, 540, 18),
(3656, 1, 540, 24),
(3657, 1, 540, 26),
(3658, 1, 540, 27),
(3659, 1, 540, 30),
(3660, 1, 540, 31),
(3661, 1, 540, 32),
(3662, 1, 540, 34),
(3663, 1, 540, 42),
(3664, 1, 540, 43),
(3665, 0, 541, 18),
(3666, 1, 541, 24),
(3667, 1, 541, 26),
(3668, 1, 541, 27),
(3669, 1, 541, 30),
(3670, 1, 541, 31),
(3671, 1, 541, 32),
(3672, 1, 541, 34),
(3673, 1, 541, 42),
(3674, 1, 541, 43),
(3675, 0, 542, 18),
(3676, 1, 542, 24),
(3677, 1, 542, 26),
(3678, 1, 542, 27),
(3679, 1, 542, 30),
(3680, 1, 542, 31),
(3681, 1, 542, 32),
(3682, 1, 542, 34),
(3683, 1, 542, 42),
(3684, 1, 542, 43),
(3685, 0, 543, 18),
(3686, 1, 543, 24),
(3687, 1, 543, 26),
(3688, 1, 543, 27),
(3689, 1, 543, 30),
(3690, 1, 543, 31),
(3691, 1, 543, 32),
(3692, 1, 543, 34),
(3693, 1, 543, 42),
(3694, 1, 543, 43),
(3695, 0, 544, 18),
(3696, 1, 544, 24),
(3697, 1, 544, 26),
(3698, 1, 544, 27),
(3699, 1, 544, 30),
(3700, 1, 544, 31),
(3701, 1, 544, 32),
(3702, 1, 544, 34),
(3703, 1, 544, 42),
(3704, 1, 544, 43),
(3705, 0, 545, 18),
(3706, 1, 545, 24),
(3707, 1, 545, 26),
(3708, 1, 545, 27),
(3709, 1, 545, 30),
(3710, 1, 545, 31),
(3711, 1, 545, 32),
(3712, 1, 545, 34),
(3713, 1, 545, 42),
(3714, 1, 545, 43),
(3715, 0, 546, 18),
(3716, 1, 546, 24),
(3717, 1, 546, 26),
(3718, 1, 546, 27),
(3719, 1, 546, 30),
(3720, 1, 546, 31),
(3721, 1, 546, 32),
(3722, 1, 546, 34),
(3723, 1, 546, 42),
(3724, 1, 546, 43),
(3725, 0, 547, 18),
(3726, 1, 547, 24),
(3727, 1, 547, 26),
(3728, 1, 547, 27),
(3729, 1, 547, 30),
(3730, 1, 547, 31),
(3731, 1, 547, 32),
(3732, 1, 547, 34),
(3733, 1, 547, 42),
(3734, 1, 547, 43),
(3735, 0, 548, 18),
(3736, 1, 548, 24),
(3737, 1, 548, 26),
(3738, 1, 548, 27),
(3739, 1, 548, 30),
(3740, 1, 548, 31),
(3741, 1, 548, 32),
(3742, 1, 548, 34),
(3743, 1, 548, 42),
(3744, 1, 548, 43),
(3745, 0, 549, 18),
(3746, 1, 549, 24),
(3747, 1, 549, 26),
(3748, 1, 549, 27),
(3749, 1, 549, 30),
(3750, 1, 549, 31),
(3751, 1, 549, 32),
(3752, 1, 549, 34),
(3753, 1, 549, 42),
(3754, 1, 549, 43),
(3755, 0, 550, 18),
(3756, 1, 550, 24),
(3757, 1, 550, 26),
(3758, 1, 550, 27),
(3759, 1, 550, 30),
(3760, 1, 550, 31),
(3761, 1, 550, 32),
(3762, 1, 550, 34),
(3763, 1, 550, 42),
(3764, 1, 550, 43),
(3765, 0, 551, 18),
(3766, 1, 551, 24),
(3767, 1, 551, 26),
(3768, 1, 551, 27),
(3769, 1, 551, 30),
(3770, 1, 551, 31),
(3771, 1, 551, 32),
(3772, 1, 551, 34),
(3773, 1, 551, 42),
(3774, 1, 551, 43),
(3775, 1, 551, 47),
(3776, 0, 552, 18),
(3777, 1, 552, 24),
(3778, 1, 552, 26),
(3779, 1, 552, 27),
(3780, 1, 552, 30),
(3781, 1, 552, 31),
(3782, 1, 552, 32),
(3783, 1, 552, 34),
(3784, 1, 552, 42),
(3785, 1, 552, 43),
(3786, 0, 553, 18),
(3787, 1, 553, 24),
(3788, 1, 553, 26),
(3789, 1, 553, 27),
(3790, 1, 553, 30),
(3791, 1, 553, 31),
(3792, 1, 553, 32),
(3793, 1, 553, 34),
(3794, 1, 553, 42),
(3795, 1, 553, 43),
(3796, 0, 554, 18),
(3797, 1, 554, 24),
(3798, 1, 554, 26),
(3799, 1, 554, 27),
(3800, 1, 554, 30),
(3801, 1, 554, 31),
(3802, 1, 554, 32),
(3803, 1, 554, 34),
(3804, 1, 554, 42),
(3805, 1, 554, 43),
(3806, 0, 555, 18),
(3807, 1, 555, 24),
(3808, 1, 555, 26),
(3809, 1, 555, 27),
(3810, 1, 555, 30),
(3811, 1, 555, 31),
(3812, 1, 555, 32),
(3813, 1, 555, 34),
(3814, 1, 555, 42),
(3815, 1, 555, 43),
(3816, 1, 556, 18),
(3817, 1, 556, 24),
(3818, 1, 556, 26),
(3819, 1, 556, 27),
(3820, 1, 556, 30),
(3821, 1, 556, 31),
(3822, 1, 556, 32),
(3823, 1, 556, 34),
(3824, 1, 556, 42),
(3825, 1, 556, 43),
(3826, 1, 556, 47),
(3827, 1, 557, 18),
(3828, 1, 557, 24),
(3829, 1, 557, 26),
(3830, 1, 557, 27),
(3831, 1, 557, 30),
(3832, 1, 557, 31),
(3833, 1, 557, 32),
(3834, 1, 557, 34),
(3835, 1, 557, 42),
(3836, 1, 557, 43);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblusuarios`
--

CREATE TABLE IF NOT EXISTS `tblusuarios` (
  `perfil` varchar(100) DEFAULT NULL,
  `primerNombre` varchar(45) NOT NULL,
  `segundoNombre` varchar(45) DEFAULT NULL,
  `primerApellido` varchar(45) NOT NULL,
  `segundoApellido` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `idTipoIdentificacion` int(4) NOT NULL,
  `numeroIdentificacion` varchar(45) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `idMunicipio` int(11) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `correoElectronico` varchar(45) NOT NULL,
  `idGenero` int(11) NOT NULL,
  `idRol` int(11) NOT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tblusuarios`
--

INSERT INTO `tblusuarios` (`perfil`, `primerNombre`, `segundoNombre`, `primerApellido`, `segundoApellido`, `idTipoIdentificacion`, `numeroIdentificacion`, `telefono`, `celular`, `idMunicipio`, `direccion`, `correoElectronico`, `idGenero`, `idRol`, `fechaRegistro`) VALUES
('No disponible-Mantenimiento ', 'Carlos ', 'Alberto ', 'Henao', '', 1, '0000', '576000042107', '3145051097', 70, 'Calle 51 57-70 ', 'tovar@sena.edu.co', 1, 2, '2017-03-08 22:06:31'),
('SIESO', 'Andres', 'Felipe', 'Gallo', 'Castañeda', 1, '1020431601', '4612844', '3014078109', 18, 'clle 32 #58-34 cabañas', 'af1gallo@misena.edu.co', 1, 2, '2017-03-08 18:16:18'),
('Null', ' Carlos', 'Alberto', 'Henao', 'Tovar', 1, '102355478', '576000042107', '3206614190', 59, 'clle 51 #57-70', 'chtovar@sena.edu.co', 1, 2, '2017-03-09 13:49:47'),
('Logistica - Ing.', 'David', '', 'Mejía', 'Mejía', 1, '1037610311', '3192472394', '3192472394', 70, 'Circular 4 #71-46 Apto 103', 'dmejiam@sena.edu.co', 1, 1, '2017-03-08 18:39:01'),
('Infraestructura Arq.', 'Adriana', 'Lucia', 'Maya', 'Gañan', 1, '1039447264', '57600042039', '3127432588', 70, 'Calle 51 # 57-70 Piso 2 del edificio alterno ', 'amayag@sena.edu.co', 1, 1, '2017-03-09 15:42:27'),
('Infraestructura ', 'Ing. Anderson', '', 'Molsalve', 'Muñoz', 1, '1128472995', '3504946784', '3504946784', 70, 'calle 51 #57-70', 'amonsalve@sena.edu.co', 1, 1, '2017-03-08 18:42:17'),
('AA ', 'Juan', 'Pablo', 'Valencia', 'Ospina', 1, '1128478329', '576000042267', '3128559415', 70, 'clle 93f #55a-70', 'jpvalencia92@misena.edu.co', 1, 2, '2017-03-08 18:31:34'),
('Aires', 'Juan', '', 'Pulgarin', 'Acevedo', 1, '1216726372', '7229646', '121654244444', 70, 'wqeqweqw', 'jepulgarin16@misena.edu.co', 1, 2, '2017-08-18 20:25:32'),
('s', 'prueba', 'prueba', 'juan', 'apellido', 1, '1232123', '213212', '123223321', 70, 'dasdasd', 'j@misena.edu.co', 1, 2, '2017-08-23 17:12:15'),
('Asensores', 'Koleman', '', 'Asensores', '', 1, '123456', '322041', '', 70, 'Carrera 79 d 44-15', 'comercial@asensoreskoleman.com', 3, 2, '2017-08-24 13:58:31'),
('Null', 'Javier', '', 'Mallama', 'Benavides', 1, '12991856', '4636853', '3117866306', 70, 'Calle 107 No 70 - 65', 'jmallama@sena.edu.co', 1, 1, '2017-03-08 18:36:59'),
('Mantenimiento ', 'Luis', 'Eduardo', 'Angarita', 'Gonzalez', 1, '15256627', '4711399', '3117130983', 70, 'clle 97# 76-25', 'luiseag82@hotmail.com', 1, 2, '2017-03-08 18:04:13'),
('dasdsad', 'asdasd', 'sadasd', 'asdsad', 'asdsad', 2, '301645', '5457454', '546846300000', 5, 'asdasd', 'a@misena.edu.co', 3, 2, '2017-08-24 13:24:58'),
('Infraestructura ', 'Amparo del Soccoro', '', 'Sierra', 'Arcila', 1, '43042254', '576000042143', '3014299794', 70, 'Calle 51 # 57 70 ', 'amsierra@sena.edu.co', 1, 1, '2017-03-10 12:39:58'),
('SEISO ', 'Paola', 'Andrea', 'Londoño', 'Mazo', 1, '43630934', '576000042044', '3015784902', 70, 'calle 51 N 57-70', 'supervisoraseiso@hotmail.com', 2, 1, '2017-03-08 18:10:20'),
('SEISO ', 'Paola', 'Andrea', 'Londoño', 'Mazo', 1, '436309340', '576000042044', '3015784902', 70, 'calle 51 57-70', 'crispin-10@hotmail.es', 1, 2, '2017-03-14 16:47:18'),
('gerente', 'Administrador', '', 'Administrador', '', 1, '54454465', '321456564', '56565654', 70, 'sshf', 'drortiz94@misena.edu.co', 1, 1, '2017-02-07 18:18:19'),
('Infraestructura ', 'Carlos', 'Mario', 'Mejía', 'Vélez', 1, '70118830', '42753', '1', 70, 'Coordinador Centro de Comercio', 'cmejia@sena.edu.co', 1, 1, '2017-03-08 18:19:30'),
('Electricidad ', 'Luis', 'Fernando', 'Gonzales', 'Hincapié', 1, '71591822', '5760000', '3216211764', 70, 'clle71 #57-70', 'lfgonzalez@sena.edu.co', 1, 2, '2017-03-08 18:45:55'),
('AA ', 'Victor', 'Hugo', 'Cardona', 'Bernal', 1, '71665432', '42268', '3137663346', 70, 'cra 89 #42-28', 'cardona@sena.edu.co', 1, 1, '2017-03-08 18:24:58'),
('Null', 'victor', '', 'hugo', 'cardona', 1, '716654322', '3137663346', '3137663346', 70, 'clle 51 #57-70', 'vcardona@sena.edu.co', 1, 2, '2017-03-21 20:03:10'),
('AA ', 'Ivan ', 'Dario', 'Rojas', 'Carmona', 1, '71761148', '57600042267', '3207412835', 70, 'calle 51 # 57-70', 'ivrojas@sena.edu.co', 1, 2, '2017-03-17 18:55:56'),
('Infraestructura ', 'Efrain ', '', 'Torres', 'Noguera', 1, '88252034', '576000042014', '3133415363', 70, 'Calle 51 57-70', 'etorresn@sena.edu.co', 1, 1, '2017-03-08 20:33:30'),
('Electricidad ', 'Juan ', 'Diego', 'Bedoya', 'Quintero', 1, '98589653', '5760000', '3205438919', 70, 'cra 92 #92-02', 'jdbedoya@sena.edu.co', 1, 2, '2017-03-08 18:28:15');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tblambientes`
--
ALTER TABLE `tblambientes`
  ADD PRIMARY KEY (`idAmbiente`), ADD KEY `fk_ambientes_pisos` (`idPiso`);

--
-- Indices de la tabla `tblcategoriasequipos`
--
ALTER TABLE `tblcategoriasequipos`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `tblcomplejos`
--
ALTER TABLE `tblcomplejos`
  ADD PRIMARY KEY (`idComplejos`);

--
-- Indices de la tabla `tblcomponentesitems`
--
ALTER TABLE `tblcomponentesitems`
  ADD PRIMARY KEY (`idComponente`), ADD KEY `fk_idCategoriaComponente` (`idCategoria`);

--
-- Indices de la tabla `tblcuentausuario`
--
ALTER TABLE `tblcuentausuario`
  ADD PRIMARY KEY (`idCuentaUsuario`), ADD KEY `fk_numeroIdentificacionCuentaUsuario` (`numeroIdentificacion`);

--
-- Indices de la tabla `tbldepartamentos`
--
ALTER TABLE `tbldepartamentos`
  ADD PRIMARY KEY (`idDepartamento`);

--
-- Indices de la tabla `tbldetallesencuestas`
--
ALTER TABLE `tbldetallesencuestas`
  ADD PRIMARY KEY (`idDetalleEncuesta`), ADD KEY `fkdetallesencuestas` (`idEncuesta`), ADD KEY `idPregunta` (`idPregunta`);

--
-- Indices de la tabla `tbldevoluciones`
--
ALTER TABLE `tbldevoluciones`
  ADD PRIMARY KEY (`idDevolucion`), ADD KEY `fk_idInsumoBajas` (`idInsumo`), ADD KEY `fk_idTipoDevolucion` (`idTipoDevolucion`);

--
-- Indices de la tabla `tbldiagnosticositems`
--
ALTER TABLE `tbldiagnosticositems`
  ADD PRIMARY KEY (`idDiagnostico`), ADD KEY `fkDiagnosticosMantenimientos` (`idMantenimiento`), ADD KEY `fkDiagnosticosItems` (`idItem`);

--
-- Indices de la tabla `tblempresas`
--
ALTER TABLE `tblempresas`
  ADD PRIMARY KEY (`idEmpresa`), ADD KEY `fk_idMunicipioEmpresa` (`idMunicipio`), ADD KEY `fk_idTipoEmpresa` (`idTipoEmpresa`);

--
-- Indices de la tabla `tblencuestas`
--
ALTER TABLE `tblencuestas`
  ADD PRIMARY KEY (`idEncuesta`), ADD KEY `fkIdSolicitudEncuesta` (`idSolicitud`);

--
-- Indices de la tabla `tblentradas`
--
ALTER TABLE `tblentradas`
  ADD PRIMARY KEY (`idEntrada`), ADD KEY `fk_idInsumoEntradas` (`idInsumo`);

--
-- Indices de la tabla `tblequipos`
--
ALTER TABLE `tblequipos`
  ADD PRIMARY KEY (`idEquipo`), ADD UNIQUE KEY `idEquipo` (`idEquipo`), ADD KEY `fk_marcas_equipos` (`idMarca`), ADD KEY `fk_modelos_equipos` (`Modelo`), ADD KEY `fk_series_equipos` (`Serie`), ADD KEY `fk_ambientes_equipos` (`idAmbiente`), ADD KEY `fk_idTipoEquipo` (`idTipoEquipo`), ADD KEY `fk_CategoriaEquipo` (`idCategoria`);

--
-- Indices de la tabla `tblestadosolicitud`
--
ALTER TABLE `tblestadosolicitud`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indices de la tabla `tblgeneros`
--
ALTER TABLE `tblgeneros`
  ADD PRIMARY KEY (`idGenero`);

--
-- Indices de la tabla `tblinsumos`
--
ALTER TABLE `tblinsumos`
  ADD PRIMARY KEY (`idInsumo`), ADD KEY `fk_idMarcaInsumos` (`idMarca`), ADD KEY `fk_idPresentacionInsumos` (`idPresentacion`), ADD KEY `fk_idUnidadMedidaInsumo` (`idUnidadMedida`);

--
-- Indices de la tabla `tblitems`
--
ALTER TABLE `tblitems`
  ADD PRIMARY KEY (`idItem`), ADD KEY `fk_categorias_items` (`idComponente`);

--
-- Indices de la tabla `tblitemsmantenimientos`
--
ALTER TABLE `tblitemsmantenimientos`
  ADD PRIMARY KEY (`idItemMantenimiento`), ADD KEY `fk_items_mantenimientosaires` (`idMantenimiento`), ADD KEY `fk_itemsmantenimiento_itemsaires` (`idItem`);

--
-- Indices de la tabla `tblmantenimientos`
--
ALTER TABLE `tblmantenimientos`
  ADD PRIMARY KEY (`idMantenimiento`), ADD KEY `fk_equipo_mantenimiento` (`idEquipo`), ADD KEY `fk_idSolicitudMantenimiento` (`idSolicitud`);

--
-- Indices de la tabla `tblmantenimientosotros`
--
ALTER TABLE `tblmantenimientosotros`
  ADD PRIMARY KEY (`idMantenimientod`), ADD UNIQUE KEY `fk_idSolicitudMantenimientod` (`idSolicitud`);

--
-- Indices de la tabla `tblmarcas`
--
ALTER TABLE `tblmarcas`
  ADD PRIMARY KEY (`idMarca`);

--
-- Indices de la tabla `tblmarcasequipos`
--
ALTER TABLE `tblmarcasequipos`
  ADD PRIMARY KEY (`idMarca`);

--
-- Indices de la tabla `tblmodificacionessolicitud`
--
ALTER TABLE `tblmodificacionessolicitud`
  ADD PRIMARY KEY (`idModificacionSolicitud`), ADD KEY `fk_idCuentaUsuarioSolicitud` (`idCuentaUsuario`), ADD KEY `fk_idSolicitudModificaciones` (`idSolicitud`), ADD KEY `fkIdTecnico` (`idTecnico`), ADD KEY `fk_tblmodificacionesIdNotificaciones` (`idNotificaciones`);

--
-- Indices de la tabla `tblmodulos`
--
ALTER TABLE `tblmodulos`
  ADD PRIMARY KEY (`idModulo`);

--
-- Indices de la tabla `tblmunicipios`
--
ALTER TABLE `tblmunicipios`
  ADD PRIMARY KEY (`idMunicipio`), ADD KEY `fk_idDepartamento` (`idDepartamento`);

--
-- Indices de la tabla `tblnotificaciones`
--
ALTER TABLE `tblnotificaciones`
  ADD PRIMARY KEY (`idNotificaciones`), ADD KEY `fk_idSolicitudNotificaciones` (`idSolicitud`);

--
-- Indices de la tabla `tblpermisos`
--
ALTER TABLE `tblpermisos`
  ADD PRIMARY KEY (`idPermiso`), ADD KEY `fk_idModuloPermisos` (`idModulo`), ADD KEY `fk_idRolPermisos` (`idRol`);

--
-- Indices de la tabla `tblpermisosusuario`
--
ALTER TABLE `tblpermisosusuario`
  ADD PRIMARY KEY (`idPermisoUsuario`), ADD KEY `fk_idPermisoPermisosUsuario` (`idPermiso`), ADD KEY `fk_idCuentaUsuarioPermisosUsuario` (`idCuentaUsuario`);

--
-- Indices de la tabla `tblpisos`
--
ALTER TABLE `tblpisos`
  ADD PRIMARY KEY (`idPiso`), ADD KEY `fk_torres_pisos` (`idTorre`);

--
-- Indices de la tabla `tblplazosolicitud`
--
ALTER TABLE `tblplazosolicitud`
  ADD PRIMARY KEY (`idPlazoSolicitud`), ADD KEY `fk_idCuentaUsuarioPlazo` (`idCuentaUsuario`), ADD KEY `fk_idPlazoSolicitud` (`idSolicitud`);

--
-- Indices de la tabla `tblpreguntasencuesta`
--
ALTER TABLE `tblpreguntasencuesta`
  ADD PRIMARY KEY (`idPregunta`);

--
-- Indices de la tabla `tblpresentacion`
--
ALTER TABLE `tblpresentacion`
  ADD PRIMARY KEY (`idPresentacion`);

--
-- Indices de la tabla `tblriesgos`
--
ALTER TABLE `tblriesgos`
  ADD PRIMARY KEY (`idRiesgo`), ADD KEY `fk_idTipoRiesgo` (`idTipoRiesgo`);

--
-- Indices de la tabla `tblriesgosmantenimiento`
--
ALTER TABLE `tblriesgosmantenimiento`
  ADD PRIMARY KEY (`idRiesgoMantenimiento`), ADD KEY `fk_idRiesgo` (`idRiesgo`), ADD KEY `fk_idMantenimientoRiesgo` (`idMantenimiento`), ADD KEY `fk_idMantenimientoRiesgod` (`idMantenimientod`);

--
-- Indices de la tabla `tblroles`
--
ALTER TABLE `tblroles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `tblsalidas`
--
ALTER TABLE `tblsalidas`
  ADD KEY `fk_idInsumoSalidas` (`idInsumo`);

--
-- Indices de la tabla `tblsinequipo`
--
ALTER TABLE `tblsinequipo`
  ADD PRIMARY KEY (`idEquipo`);

--
-- Indices de la tabla `tblsolicitud`
--
ALTER TABLE `tblsolicitud`
  ADD PRIMARY KEY (`idsolicitud`), ADD KEY `fk_ambientes_solicitud` (`idambiente`), ADD KEY `fk_estado_solicitud` (`idestado`), ADD KEY `fk_idTipoEquipoSolicitud` (`idCategoria`);

--
-- Indices de la tabla `tbltecnicosolicitudes`
--
ALTER TABLE `tbltecnicosolicitudes`
  ADD PRIMARY KEY (`idTecnicoSolicitud`), ADD KEY `fk_numeroIdentificacionSolicitud` (`numeroIdentificacion`), ADD KEY `fk_idSolicitudTecnico` (`idSolicitud`), ADD KEY `fk_idCuentaUsuarioTecnicoSolicitudes` (`idCuentaUsuario`);

--
-- Indices de la tabla `tbltipoempresa`
--
ALTER TABLE `tbltipoempresa`
  ADD PRIMARY KEY (`idTipoEmpresa`);

--
-- Indices de la tabla `tbltipoidentificacion`
--
ALTER TABLE `tbltipoidentificacion`
  ADD PRIMARY KEY (`idTipoIdentificacion`);

--
-- Indices de la tabla `tbltiposdevolucion`
--
ALTER TABLE `tbltiposdevolucion`
  ADD PRIMARY KEY (`idTipoDevolucion`);

--
-- Indices de la tabla `tbltiposequipos`
--
ALTER TABLE `tbltiposequipos`
  ADD PRIMARY KEY (`idTipoEquipo`), ADD KEY `fk_idCategoriaTipoEquipo` (`idCategoria`);

--
-- Indices de la tabla `tbltiposriesgos`
--
ALTER TABLE `tbltiposriesgos`
  ADD PRIMARY KEY (`idTipoRiesgo`);

--
-- Indices de la tabla `tbltorres`
--
ALTER TABLE `tbltorres`
  ADD PRIMARY KEY (`idTorre`), ADD KEY `fk_complejos_torres` (`idComplejos`);

--
-- Indices de la tabla `tblunidadesmedida`
--
ALTER TABLE `tblunidadesmedida`
  ADD PRIMARY KEY (`idUnidadMedida`);

--
-- Indices de la tabla `tblusuarionotificaciones`
--
ALTER TABLE `tblusuarionotificaciones`
  ADD PRIMARY KEY (`idUsuarioNotificaciones`), ADD KEY `fk_notificaciones` (`idNotificaciones`), ADD KEY `fk_cuentausuarionotificaciones` (`idCuentaUsuario`);

--
-- Indices de la tabla `tblusuarios`
--
ALTER TABLE `tblusuarios`
  ADD PRIMARY KEY (`numeroIdentificacion`), ADD KEY `fk_idGeneroUsuario` (`idGenero`), ADD KEY `fk_idMunicipioUsuario` (`idMunicipio`), ADD KEY `fk_idTipoIdentificacionUsuario` (`idTipoIdentificacion`), ADD KEY `fk_idRolUsuario` (`idRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tblambientes`
--
ALTER TABLE `tblambientes`
  MODIFY `idAmbiente` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=533;
--
-- AUTO_INCREMENT de la tabla `tblcategoriasequipos`
--
ALTER TABLE `tblcategoriasequipos`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `tblcomplejos`
--
ALTER TABLE `tblcomplejos`
  MODIFY `idComplejos` int(100) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tblcomponentesitems`
--
ALTER TABLE `tblcomponentesitems`
  MODIFY `idComponente` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tblcuentausuario`
--
ALTER TABLE `tblcuentausuario`
  MODIFY `idCuentaUsuario` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=50;
--
-- AUTO_INCREMENT de la tabla `tbldepartamentos`
--
ALTER TABLE `tbldepartamentos`
  MODIFY `idDepartamento` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT de la tabla `tbldetallesencuestas`
--
ALTER TABLE `tbldetallesencuestas`
  MODIFY `idDetalleEncuesta` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=67;
--
-- AUTO_INCREMENT de la tabla `tbldevoluciones`
--
ALTER TABLE `tbldevoluciones`
  MODIFY `idDevolucion` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbldiagnosticositems`
--
ALTER TABLE `tbldiagnosticositems`
  MODIFY `idDiagnostico` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tblempresas`
--
ALTER TABLE `tblempresas`
  MODIFY `idEmpresa` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT de la tabla `tblencuestas`
--
ALTER TABLE `tblencuestas`
  MODIFY `idEncuesta` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `tblentradas`
--
ALTER TABLE `tblentradas`
  MODIFY `idEntrada` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tblequipos`
--
ALTER TABLE `tblequipos`
  MODIFY `idEquipo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `tblestadosolicitud`
--
ALTER TABLE `tblestadosolicitud`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `tblgeneros`
--
ALTER TABLE `tblgeneros`
  MODIFY `idGenero` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tblinsumos`
--
ALTER TABLE `tblinsumos`
  MODIFY `idInsumo` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tblitems`
--
ALTER TABLE `tblitems`
  MODIFY `idItem` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT de la tabla `tblitemsmantenimientos`
--
ALTER TABLE `tblitemsmantenimientos`
  MODIFY `idItemMantenimiento` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `tblmantenimientos`
--
ALTER TABLE `tblmantenimientos`
  MODIFY `idMantenimiento` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `tblmantenimientosotros`
--
ALTER TABLE `tblmantenimientosotros`
  MODIFY `idMantenimientod` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=56;
--
-- AUTO_INCREMENT de la tabla `tblmarcas`
--
ALTER TABLE `tblmarcas`
  MODIFY `idMarca` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tblmarcasequipos`
--
ALTER TABLE `tblmarcasequipos`
  MODIFY `idMarca` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `tblmodificacionessolicitud`
--
ALTER TABLE `tblmodificacionessolicitud`
  MODIFY `idModificacionSolicitud` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=325;
--
-- AUTO_INCREMENT de la tabla `tblmodulos`
--
ALTER TABLE `tblmodulos`
  MODIFY `idModulo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `tblmunicipios`
--
ALTER TABLE `tblmunicipios`
  MODIFY `idMunicipio` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1103;
--
-- AUTO_INCREMENT de la tabla `tblnotificaciones`
--
ALTER TABLE `tblnotificaciones`
  MODIFY `idNotificaciones` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=558;
--
-- AUTO_INCREMENT de la tabla `tblpermisos`
--
ALTER TABLE `tblpermisos`
  MODIFY `idPermiso` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT de la tabla `tblpermisosusuario`
--
ALTER TABLE `tblpermisosusuario`
  MODIFY `idPermisoUsuario` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=821;
--
-- AUTO_INCREMENT de la tabla `tblpisos`
--
ALTER TABLE `tblpisos`
  MODIFY `idPiso` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT de la tabla `tblplazosolicitud`
--
ALTER TABLE `tblplazosolicitud`
  MODIFY `idPlazoSolicitud` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tblpreguntasencuesta`
--
ALTER TABLE `tblpreguntasencuesta`
  MODIFY `idPregunta` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `tblpresentacion`
--
ALTER TABLE `tblpresentacion`
  MODIFY `idPresentacion` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tblriesgos`
--
ALTER TABLE `tblriesgos`
  MODIFY `idRiesgo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT de la tabla `tblriesgosmantenimiento`
--
ALTER TABLE `tblriesgosmantenimiento`
  MODIFY `idRiesgoMantenimiento` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT de la tabla `tblroles`
--
ALTER TABLE `tblroles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tblsinequipo`
--
ALTER TABLE `tblsinequipo`
  MODIFY `idEquipo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tblsolicitud`
--
ALTER TABLE `tblsolicitud`
  MODIFY `idsolicitud` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=239;
--
-- AUTO_INCREMENT de la tabla `tbltecnicosolicitudes`
--
ALTER TABLE `tbltecnicosolicitudes`
  MODIFY `idTecnicoSolicitud` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=185;
--
-- AUTO_INCREMENT de la tabla `tbltipoempresa`
--
ALTER TABLE `tbltipoempresa`
  MODIFY `idTipoEmpresa` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbltipoidentificacion`
--
ALTER TABLE `tbltipoidentificacion`
  MODIFY `idTipoIdentificacion` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tbltiposdevolucion`
--
ALTER TABLE `tbltiposdevolucion`
  MODIFY `idTipoDevolucion` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbltiposequipos`
--
ALTER TABLE `tbltiposequipos`
  MODIFY `idTipoEquipo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `tbltiposriesgos`
--
ALTER TABLE `tbltiposriesgos`
  MODIFY `idTipoRiesgo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbltorres`
--
ALTER TABLE `tbltorres`
  MODIFY `idTorre` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `tblunidadesmedida`
--
ALTER TABLE `tblunidadesmedida`
  MODIFY `idUnidadMedida` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tblusuarionotificaciones`
--
ALTER TABLE `tblusuarionotificaciones`
  MODIFY `idUsuarioNotificaciones` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3837;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tblambientes`
--
ALTER TABLE `tblambientes`
ADD CONSTRAINT `fk_ambientes_pisos` FOREIGN KEY (`idPiso`) REFERENCES `tblpisos` (`idPiso`);

--
-- Filtros para la tabla `tblcomponentesitems`
--
ALTER TABLE `tblcomponentesitems`
ADD CONSTRAINT `fk_idCategoriaComponente` FOREIGN KEY (`idCategoria`) REFERENCES `tblcategoriasequipos` (`idCategoria`);

--
-- Filtros para la tabla `tblcuentausuario`
--
ALTER TABLE `tblcuentausuario`
ADD CONSTRAINT `fk_numeroIdentificacionCuentaUsuario` FOREIGN KEY (`numeroIdentificacion`) REFERENCES `tblusuarios` (`numeroIdentificacion`);

--
-- Filtros para la tabla `tbldetallesencuestas`
--
ALTER TABLE `tbldetallesencuestas`
ADD CONSTRAINT `fkdetallesencuestas` FOREIGN KEY (`idEncuesta`) REFERENCES `tblencuestas` (`idEncuesta`),
ADD CONSTRAINT `idPregunta` FOREIGN KEY (`idPregunta`) REFERENCES `tblpreguntasencuesta` (`idPregunta`);

--
-- Filtros para la tabla `tbldevoluciones`
--
ALTER TABLE `tbldevoluciones`
ADD CONSTRAINT `fk_idInsumoBajas` FOREIGN KEY (`idInsumo`) REFERENCES `tblinsumos` (`idInsumo`),
ADD CONSTRAINT `fk_idTipoDevolucion` FOREIGN KEY (`idTipoDevolucion`) REFERENCES `tbltiposdevolucion` (`idTipoDevolucion`);

--
-- Filtros para la tabla `tbldiagnosticositems`
--
ALTER TABLE `tbldiagnosticositems`
ADD CONSTRAINT `fkDiagnosticosItems` FOREIGN KEY (`idItem`) REFERENCES `tblitems` (`idItem`),
ADD CONSTRAINT `fkDiagnosticosMantenimientos` FOREIGN KEY (`idMantenimiento`) REFERENCES `tblmantenimientos` (`idMantenimiento`);

--
-- Filtros para la tabla `tblempresas`
--
ALTER TABLE `tblempresas`
ADD CONSTRAINT `fk_idMunicipioEmpresa` FOREIGN KEY (`idMunicipio`) REFERENCES `tblmunicipios` (`idMunicipio`),
ADD CONSTRAINT `fk_idTipoEmpresa` FOREIGN KEY (`idTipoEmpresa`) REFERENCES `tbltipoempresa` (`idTipoEmpresa`);

--
-- Filtros para la tabla `tblencuestas`
--
ALTER TABLE `tblencuestas`
ADD CONSTRAINT `fkIdSolicitudEncuesta` FOREIGN KEY (`idSolicitud`) REFERENCES `tblsolicitud` (`idsolicitud`);

--
-- Filtros para la tabla `tblentradas`
--
ALTER TABLE `tblentradas`
ADD CONSTRAINT `fk_idInsumoEntradas` FOREIGN KEY (`idInsumo`) REFERENCES `tblinsumos` (`idInsumo`);

--
-- Filtros para la tabla `tblequipos`
--
ALTER TABLE `tblequipos`
ADD CONSTRAINT `fk_CategoriaEquipo` FOREIGN KEY (`idCategoria`) REFERENCES `tblcategoriasequipos` (`idCategoria`),
ADD CONSTRAINT `fk_ambientes_equipos` FOREIGN KEY (`idAmbiente`) REFERENCES `tblambientes` (`idAmbiente`),
ADD CONSTRAINT `fk_idTipoEquipo` FOREIGN KEY (`idTipoEquipo`) REFERENCES `tbltiposequipos` (`idTipoEquipo`),
ADD CONSTRAINT `fk_marcas_equipos` FOREIGN KEY (`idMarca`) REFERENCES `tblmarcasequipos` (`idMarca`);

--
-- Filtros para la tabla `tblinsumos`
--
ALTER TABLE `tblinsumos`
ADD CONSTRAINT `fk_idMarcaInsumos` FOREIGN KEY (`idMarca`) REFERENCES `tblmarcas` (`idMarca`),
ADD CONSTRAINT `fk_idPresentacionInsumos` FOREIGN KEY (`idPresentacion`) REFERENCES `tblpresentacion` (`idPresentacion`),
ADD CONSTRAINT `fk_idUnidadMedidaInsumo` FOREIGN KEY (`idUnidadMedida`) REFERENCES `tblunidadesmedida` (`idUnidadMedida`);

--
-- Filtros para la tabla `tblitems`
--
ALTER TABLE `tblitems`
ADD CONSTRAINT `fk_idComponenteItem` FOREIGN KEY (`idComponente`) REFERENCES `tblcomponentesitems` (`idComponente`);

--
-- Filtros para la tabla `tblitemsmantenimientos`
--
ALTER TABLE `tblitemsmantenimientos`
ADD CONSTRAINT `fk_idItemMantenimiento` FOREIGN KEY (`idItem`) REFERENCES `tblitems` (`idItem`),
ADD CONSTRAINT `fk_idMantenimientoItems` FOREIGN KEY (`idMantenimiento`) REFERENCES `tblmantenimientos` (`idMantenimiento`);

--
-- Filtros para la tabla `tblmantenimientos`
--
ALTER TABLE `tblmantenimientos`
ADD CONSTRAINT `fk_equipo_mantenimiento` FOREIGN KEY (`idEquipo`) REFERENCES `tblequipos` (`idEquipo`),
ADD CONSTRAINT `fk_idSolicitudMantenimiento` FOREIGN KEY (`idSolicitud`) REFERENCES `tblsolicitud` (`idsolicitud`);

--
-- Filtros para la tabla `tblmantenimientosotros`
--
ALTER TABLE `tblmantenimientosotros`
ADD CONSTRAINT `tblmantenimientosotros_ibfk_1` FOREIGN KEY (`idSolicitud`) REFERENCES `tblsolicitud` (`idsolicitud`);

--
-- Filtros para la tabla `tblmodificacionessolicitud`
--
ALTER TABLE `tblmodificacionessolicitud`
ADD CONSTRAINT `fkIdTecnico` FOREIGN KEY (`idTecnico`) REFERENCES `tblusuarios` (`numeroIdentificacion`),
ADD CONSTRAINT `fk_idCuentaUsuarioSolicitud` FOREIGN KEY (`idCuentaUsuario`) REFERENCES `tblcuentausuario` (`idCuentaUsuario`),
ADD CONSTRAINT `fk_idSolicitudModificaciones` FOREIGN KEY (`idSolicitud`) REFERENCES `tblsolicitud` (`idsolicitud`),
ADD CONSTRAINT `fk_tblmodificacionesIdNotificaciones` FOREIGN KEY (`idNotificaciones`) REFERENCES `tblnotificaciones` (`idNotificaciones`);

--
-- Filtros para la tabla `tblmunicipios`
--
ALTER TABLE `tblmunicipios`
ADD CONSTRAINT `fk_IdDepartamento` FOREIGN KEY (`idDepartamento`) REFERENCES `tbldepartamentos` (`idDepartamento`);

--
-- Filtros para la tabla `tblnotificaciones`
--
ALTER TABLE `tblnotificaciones`
ADD CONSTRAINT `fk_idSolicitudNotificaciones` FOREIGN KEY (`idSolicitud`) REFERENCES `tblsolicitud` (`idsolicitud`);

--
-- Filtros para la tabla `tblpermisos`
--
ALTER TABLE `tblpermisos`
ADD CONSTRAINT `fk_idModuloPermisos` FOREIGN KEY (`idModulo`) REFERENCES `tblmodulos` (`idModulo`),
ADD CONSTRAINT `fk_idRolPermisos` FOREIGN KEY (`idRol`) REFERENCES `tblroles` (`idRol`);

--
-- Filtros para la tabla `tblpermisosusuario`
--
ALTER TABLE `tblpermisosusuario`
ADD CONSTRAINT `fk_idCuentaUsuarioPermisosUsuario` FOREIGN KEY (`idCuentaUsuario`) REFERENCES `tblcuentausuario` (`idCuentaUsuario`),
ADD CONSTRAINT `fk_idPermisoPermisosUsuario` FOREIGN KEY (`idPermiso`) REFERENCES `tblpermisos` (`idPermiso`);

--
-- Filtros para la tabla `tblpisos`
--
ALTER TABLE `tblpisos`
ADD CONSTRAINT `fk_torres_pisos` FOREIGN KEY (`idTorre`) REFERENCES `tbltorres` (`idTorre`);

--
-- Filtros para la tabla `tblplazosolicitud`
--
ALTER TABLE `tblplazosolicitud`
ADD CONSTRAINT `fk_idCuentaUsuarioPlazo` FOREIGN KEY (`idCuentaUsuario`) REFERENCES `tblcuentausuario` (`idCuentaUsuario`),
ADD CONSTRAINT `fk_idPlazoSolicitud` FOREIGN KEY (`idSolicitud`) REFERENCES `tblsolicitud` (`idsolicitud`);

--
-- Filtros para la tabla `tblriesgos`
--
ALTER TABLE `tblriesgos`
ADD CONSTRAINT `fk_idTipoRiesgo` FOREIGN KEY (`idTipoRiesgo`) REFERENCES `tbltiposriesgos` (`idTipoRiesgo`);

--
-- Filtros para la tabla `tblriesgosmantenimiento`
--
ALTER TABLE `tblriesgosmantenimiento`
ADD CONSTRAINT `fk_idRiesgo` FOREIGN KEY (`idRiesgo`) REFERENCES `tblriesgos` (`idRiesgo`),
ADD CONSTRAINT `tblriesgosmantenimiento_ibfk_1` FOREIGN KEY (`idMantenimiento`) REFERENCES `tblmantenimientos` (`idMantenimiento`),
ADD CONSTRAINT `tblriesgosmantenimiento_ibfk_2` FOREIGN KEY (`idMantenimientod`) REFERENCES `tblmantenimientosotros` (`idMantenimientod`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tblsalidas`
--
ALTER TABLE `tblsalidas`
ADD CONSTRAINT `fk_idInsumoSalidas` FOREIGN KEY (`idInsumo`) REFERENCES `tblinsumos` (`idInsumo`);

--
-- Filtros para la tabla `tblsolicitud`
--
ALTER TABLE `tblsolicitud`
ADD CONSTRAINT `fk_ambientes_solicitud` FOREIGN KEY (`idambiente`) REFERENCES `tblambientes` (`idAmbiente`),
ADD CONSTRAINT `fk_estado_solicitud` FOREIGN KEY (`idestado`) REFERENCES `tblestadosolicitud` (`idEstado`),
ADD CONSTRAINT `fk_idCategoriaSolicitud` FOREIGN KEY (`idCategoria`) REFERENCES `tblcategoriasequipos` (`idCategoria`);

--
-- Filtros para la tabla `tbltecnicosolicitudes`
--
ALTER TABLE `tbltecnicosolicitudes`
ADD CONSTRAINT `fk_idCuentaUsuarioTecnicoSolicitudes` FOREIGN KEY (`idCuentaUsuario`) REFERENCES `tblcuentausuario` (`idCuentaUsuario`),
ADD CONSTRAINT `fk_idSolicitudTecnico` FOREIGN KEY (`idSolicitud`) REFERENCES `tblsolicitud` (`idsolicitud`),
ADD CONSTRAINT `fk_numeroIdentificacionSolicitud` FOREIGN KEY (`numeroIdentificacion`) REFERENCES `tblusuarios` (`numeroIdentificacion`);

--
-- Filtros para la tabla `tbltiposequipos`
--
ALTER TABLE `tbltiposequipos`
ADD CONSTRAINT `fk_idCategoriaTipoEquipo` FOREIGN KEY (`idCategoria`) REFERENCES `tblcategoriasequipos` (`idCategoria`);

--
-- Filtros para la tabla `tbltorres`
--
ALTER TABLE `tbltorres`
ADD CONSTRAINT `tbltorres_ibfk_1` FOREIGN KEY (`idComplejos`) REFERENCES `tblcomplejos` (`idComplejos`);

--
-- Filtros para la tabla `tblusuarionotificaciones`
--
ALTER TABLE `tblusuarionotificaciones`
ADD CONSTRAINT `fk_cuentausuarionotificaciones` FOREIGN KEY (`idCuentaUsuario`) REFERENCES `tblcuentausuario` (`idCuentaUsuario`),
ADD CONSTRAINT `fk_idNotificacionesUsuarios` FOREIGN KEY (`idNotificaciones`) REFERENCES `tblnotificaciones` (`idNotificaciones`);

--
-- Filtros para la tabla `tblusuarios`
--
ALTER TABLE `tblusuarios`
ADD CONSTRAINT `fk_idGeneroUsuario` FOREIGN KEY (`idGenero`) REFERENCES `tblgeneros` (`idGenero`),
ADD CONSTRAINT `fk_idMunicipioUsuario` FOREIGN KEY (`idMunicipio`) REFERENCES `tblmunicipios` (`idMunicipio`),
ADD CONSTRAINT `fk_idRolUsuario` FOREIGN KEY (`idRol`) REFERENCES `tblroles` (`idRol`),
ADD CONSTRAINT `fk_idTipoIdentificacionUsuario` FOREIGN KEY (`idTipoIdentificacion`) REFERENCES `tbltipoidentificacion` (`idTipoIdentificacion`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
