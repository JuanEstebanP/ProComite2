-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-10-2017 a las 17:22:50
-- Versión del servidor: 10.1.25-MariaDB
-- Versión de PHP: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gc`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarCliente` (IN `sp_idCliente` INT, IN `sp_nombreCliente` VARCHAR(20), IN `sp_apellidoCliente` VARCHAR(20), IN `sp_telefonoCliente` VARCHAR(10), IN `sp_correoCliente` VARCHAR(50))  NO SQL
BEGIN

UPDATE tbl_cliente SET
nombre=sp_nombreCliente, apellido=sp_apellidoCliente, telefono=sp_telefonoCliente, correo=sp_correoCliente
WHERE id_cliente = sp_idCliente;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarInstructor` (IN `sp_idInstructor` INT, IN `sp_nombre` VARCHAR(40), IN `sp_apellido` VARCHAR(40), IN `sp_documento` VARCHAR(12), IN `sp_correo` VARCHAR(50))  NO SQL
BEGIN

update tbl_instructores SET
nombre=sp_nombre, apellido=sp_apellido, documento=sp_documento, correo=sp_correo
WHERE id_instructor = sp_idInstructor;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aprendicesXestado` ()  NO SQL
BEGIN
SELECT * FROM tbl_aprendiz WHERE estado =!1 OR estado = !2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asistencia` (IN `id` INT, IN `instrc` INT)  NO SQL
BEGIN
INSERT INTO tbl_comite VALUES (NULL, id , instrc);
UPDATE tbl_programacioncomite p set p.estado = 1 where p.id_programacion=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_conFicha` ()  NO SQL
BEGIN
SELECT * from tbl_fichagrupo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaAprendices` (IN `id` INT)  NO SQL
BEGIN
SELECT a.id_aprendiz, a.nombre, a.apellido, a.documento, a.correo FROM tbl_aprendiz a JOIN tbl_detallesaprendizproyecto dp on dp.id_aprendiz=a.id_aprendiz JOIN tbl_fichaproyecto fp on fp.id_ficha=dp.id_ficha where fp.id_ficha = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarAprendices` ()  NO SQL
BEGIN

SELECT * FROM tbl_aprendiz;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultaraprendicesXid` (IN `id` INT)  NO SQL
BEGIN
SELECT * FROM tbl_aprendiz a JOIN tbl_detallesaprendizgrupo d ON d.id_aprendiz=a.id_aprendiz WHERE d.id_fichaGrupo = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarClientes` ()  NO SQL
BEGIN

SELECT * FROM tbl_cliente;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Consultarfichagrupo` ()  NO SQL
BEGIN
SELECT f.id_fichaGrupo,f.numeroFicha,CONCAT(i.nombre, ' ', I.apellido )AS titularFicha, f.iniciolectiva,f.finlectiva FROM tbl_fichagrupo f join tbl_instructores i on f.titularFicha=i.id_instructor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarFichasArh` ()  NO SQL
BEGIN
SELECT fh.estado,fh.titulo, fh.obj_general, fh.id_ficha,fh.observacion , fh.Url,c.nombre,e.nombreEstado, e.id_estado  FROM tbl_fichaproyecto fh 
join tbl_cliente c on(fh.id_cliente=c.id_cliente) 
JOIN tbl_estados e ON(fh.estado=e.id_estado) ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarFichasproyectos` ()  NO SQL
SELECT * from tbl_fichaproyecto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Consultarinstructor` ()  NO SQL
BEGIN
SELECT id_instructor,documento,nombre from tbl_instructores;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarInstructores` ()  NO SQL
BEGIN

SELECT * FROM tbl_instructores;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarProgramacion` ()  NO SQL
BEGIN
SELECT *FROM tbl_programacioncomite;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Consultarproyectos` (IN `fg` INT)  NO SQL
BEGIN
SELECT * FROM tbl_fichaproyecto WHERE id_fichaGrupo = fg;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_dtllProyectoprogra` (IN `id` INT)  NO SQL
BEGIN
INSERT INTO tbl_dtllproyectoprogra (id_detalle,id_ficha,id_programacion)
VALUES (NULL,id,(SELECT MAX(id_programacion)FROM tbl_programacioncomite));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarAprendiz` (IN `id` INT, IN `nomb` VARCHAR(20), IN `apell` VARCHAR(20), IN `docu` VARCHAR(20), IN `correo` VARCHAR(45))  NO SQL
BEGIN
UPDATE tbl_aprendiz SET nombre = nomb, apellido = apell, documento = docu, correo = correo WHERE id_aprendiz = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarFicha` (IN `id` INT, IN `num` INT, IN `titular` INT, IN `ilectiva` DATE, IN `flectiva` DATE)  NO SQL
BEGIN 
UPDATE tbl_fichagrupo SET numeroFicha = num, titularFicha = titular, iniciolectiva = ilectiva, finlectiva = flectiva WHERE id_fichaGrupo = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarFichaproyecto` (IN `id` INT, IN `nom` VARCHAR(50), IN `obje` VARCHAR(100), IN `version` VARCHAR(5), IN `urls` VARCHAR(50), IN `cliente` INT, IN `fkficha` INT, IN `esta` INT)  NO SQL
BEGIN

UPDATE tbl_fichaproyecto SET id_ficha = id, titulo = nom, obj_general = obje, version = version, Url=urls,id_cliente = cliente,id_fichaGrupo=fkficha,estado=esta WHERE id_ficha = id;
insert into tbl_dtllproyecto (id_dtllProyecto, Url, id_ficha) VALUES (null,urls,id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EditarProgramacion` (IN `sp_idprogramacion` INT, IN `sp_titulo` VARCHAR(40), IN `sp_fecha` DATE, IN `sp_hora` TIME, IN `sp_lugar` VARCHAR(40))  NO SQL
BEGIN
UPDATE tbl_programacioncomite SET tbl_programacioncomite.fecha=sp_fecha,tbl_programacioncomite.titulo=sp_titulo, tbl_programacioncomite.hora=sp_hora,
tbl_programacioncomite.lugar=sp_lugar
WHERE tbl_programacioncomite.id_programacion=sp_idprogramacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EvaluarFicha` (IN `idf` INT, IN `obs` VARCHAR(100), IN `ide` INT)  NO SQL
BEGIN
UPDATE tbl_fichaproyecto SET estado = ide WHERE id_ficha = idf;
UPDATE tbl_fichaproyecto SET observacion = obs WHERE id_ficha = idf;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fichasBG` (IN `id` INT)  NO SQL
BEGIN
SELECT fp.titulo, fp.obj_general, fp.version FROM tbl_fichaproyecto fp JOIN tbl_fichagrupo fg ON (fp.id_fichaGrupo=fg.id_fichaGrupo) WHERE numeroFicha = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Fichasgru` ()  NO SQL
BEGIN
SELECT id_fichaGrupo, numeroFicha FROM tbl_fichagrupo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Fichasgrupos` ()  NO SQL
BEGIN
SELECT * FROM tbl_fichagrupo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Fichasproyectos` ()  NO SQL
BEGIN
SELECT f.id_ficha,f.titulo,f.obj_general,f.version,c.nombre  id_cliente,fi.numeroFicha id_fichaGrupo,e.nombreEstado estado FROM tbl_fichaproyecto f JOIN tbl_estados e ON e.id_estado=f.estado JOIN tbl_cliente c ON c.id_cliente=f.id_cliente JOIN tbl_fichagrupo fi ON fi.id_fichaGrupo=f.id_fichaGrupo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fichasXestado` ()  NO SQL
BEGIN
SELECT f.id_ficha, f.titulo, f.obj_general, e.nombreEstado, fg.numeroFicha FROM tbl_fichaproyecto f JOIN tbl_estados e ON (f.estado=e.id_estado) JOIN tbl_fichagrupo fg ON (f.id_fichaGrupo=fg.id_fichaGrupo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fichasXprogramacion` (IN `id` INT)  NO SQL
BEGIN
SELECT fp.id_ficha, fp.titulo, fp.obj_general from tbl_fichaproyecto fp JOIN tbl_dtllproyectoprogra dt ON (fp.id_ficha=dt.id_ficha) JOIN tbl_programacioncomite pc ON(dt.id_programacion=pc.id_programacion) WHERE pc.id_programacion = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idAprendiz` (IN `sp_idAprendiz` INT)  NO SQL
BEGIN
SELECT * FROM tbl_aprendiz   WHERE id_aprendiz = sp_idAprendiz;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idClientes` (IN `sp_idCliente` INT)  NO SQL
BEGIN

SELECT * FROM tbl_cliente WHERE id_cliente = sp_idCliente;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idEvaluar` (IN `ide` INT)  NO SQL
BEGIN
SELECT id_ficha, estado FROM tbl_fichaproyecto WHERE id_ficha= ide;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idFicha` (IN `sp_idFicha` INT)  NO SQL
BEGIN
SELECT * FROM tbl_fichagrupo WHERE id_fichaGrupo  = sp_idFicha;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idFichaProyecto` (IN `id` INT)  NO SQL
select * from tbl_fichaproyecto where  id_ficha=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_IdFichasPro` ()  NO SQL
BEGIN
SELECT id_ficha, titulo FROM tbl_fichaproyecto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idInstructores` (IN `sp_idInstructor` INT)  NO SQL
BEGIN
SELECT * FROM tbl_instructores WHERE id_instructor = sp_idInstructor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarAprendiz` (IN `nomb` VARCHAR(20), IN `apell` VARCHAR(20), IN `docu` VARCHAR(20), IN `correo` VARCHAR(20))  NO SQL
BEGIN
INSERT INTO tbl_aprendiz (id_aprendiz, nombre, apellido, documento, correo) VALUES (NULL, nomb, apell, docu, correo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarCliente` (IN `sp_nombreCliente` VARCHAR(20), IN `sp_apellidoCliente` VARCHAR(20), IN `sp_telefonoCliente` VARCHAR(10), IN `sp_correoCliente` VARCHAR(50))  NO SQL
BEGIN
INSERT INTO tbl_cliente (nombre, apellido, telefono, correo)
VALUES (sp_nombreCliente, sp_apellidoCliente, sp_telefonoCliente, sp_correoCliente);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarFichaGrupo` (IN `finl` DATE, IN `nficha` INT, IN `iniciol` DATE, IN `titular` INT)  NO SQL
BEGIN
INSERT INTO tbl_fichagrupo (id_fichaGrupo, numeroFicha, titularFicha, iniciolectiva, finlectiva) VALUES (NULL, nficha,titular, iniciol, finl);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarFichaproyecto` (IN `nomb` VARCHAR(20), IN `obje` VARCHAR(100), IN `url` VARCHAR(50), IN `version` VARCHAR(15), IN `id_cliente` INT, IN `estado` INT, IN `id_fichag` INT)  NO SQL
BEGIN
  INSERT INTO tbl_fichaproyecto (id_ficha, titulo, obj_general, Url, version, observacion, id_cliente, id_fichaGrupo, estado) VALUES (NULL, nomb, obje, url, version,'Prueba', id_cliente, id_fichag, estado);
 INSERT INTO tbl_dtllproyecto (id_dtllProyecto, Url,id_ficha) VALUES 
 (NULL,Url,(SELECT MAX(id_ficha) FROM tbl_fichaproyecto));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarInstructor` (IN `sp_nombre` VARCHAR(40), IN `sp_apellido` VARCHAR(40), IN `sp_documento` VARCHAR(12), IN `sp_correo` VARCHAR(50))  NO SQL
BEGIN

INSERT INTO tbl_instructores (nombre, apellido, documento, correo)
VALUES
(sp_nombre, sp_apellido, sp_documento, sp_correo);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_MostrarProgramacion` (IN `id_programacion` INT)  NO SQL
BEGIN
SELECT *FROM tbl_programacioncomite
WHERE tbl_programacioncomite.id_programacion=id_programacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtenerAprendices` (IN `id` INT)  NO SQL
BEGIN
SELECT a.id_aprendiz, a.nombre, a.apellido, a.documento, a.correo FROM tbl_aprendiz a join tbl_detallesaprendizgrupo dfg on dfg.id_aprendiz=a.id_aprendiz join tbl_fichagrupo fg on fg.id_fichaGrupo=dfg.id_fichaGrupo join tbl_fichaproyecto fp on fp.id_fichaGrupo=fg.id_fichaGrupo where fg.id_fichaGrupo= id  and a.estado= 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_regdetalleGrupo` (IN `idapre` INT, IN `idgrupo` INT)  NO SQL
BEGIN
INSERT INTO `tbl_detallesaprendizgrupo` (`id_detalle`, `id_aprendiz`, `id_fichaGrupo`) VALUES (null, idapre,idgrupo);
UPDATE tbl_aprendiz a set a.estado = 1 where a.id_aprendiz=idapre;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_regdetalleProyecto` (IN `idapren` INT, IN `idproyecto` INT)  NO SQL
BEGIN
INSERT INTO tbl_detallesaprendizproyecto (id_detalle, id_aprendiz, id_ficha) VALUES (null, idapren,idproyecto);
UPDATE tbl_aprendiz a set a.estado = 2 where a.id_aprendiz=idapren;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarProgramacion` (IN `sp_titulo` VARCHAR(40), IN `sp_fecha` DATE, IN `sp_hora` TIME, IN `sp_lugar` VARCHAR(40))  NO SQL
BEGIN
INSERT INTO tbl_programacioncomite(titulo,fecha,hora,lugar)
VALUES(sp_titulo,sp_fecha, sp_hora, sp_lugar);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_aprendiz`
--

CREATE TABLE `tbl_aprendiz` (
  `id_aprendiz` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `documento` varchar(12) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_aprendiz`
--

INSERT INTO `tbl_aprendiz` (`id_aprendiz`, `nombre`, `apellido`, `documento`, `correo`, `estado`) VALUES
(1, 'Juan Esteban', 'Pulgarin', '1216726372', 'jepulgarin@misena.ed', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cliente`
--

CREATE TABLE `tbl_cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `correo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_cliente`
--

INSERT INTO `tbl_cliente` (`id_cliente`, `nombre`, `apellido`, `telefono`, `correo`) VALUES
(1, 'SENNOVA', 'Antioquia', '4228979', 'sennova@misena.edu.co');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_comite`
--

CREATE TABLE `tbl_comite` (
  `id_comite` int(11) NOT NULL,
  `fk_programacion` int(11) NOT NULL,
  `fk_instructor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detallesaprendizgrupo`
--

CREATE TABLE `tbl_detallesaprendizgrupo` (
  `id_detalle` int(11) NOT NULL,
  `id_aprendiz` int(11) NOT NULL,
  `id_fichaGrupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detallesaprendizproyecto`
--

CREATE TABLE `tbl_detallesaprendizproyecto` (
  `id_detalle` int(11) NOT NULL,
  `id_aprendiz` int(11) NOT NULL,
  `id_ficha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_dtllproyecto`
--

CREATE TABLE `tbl_dtllproyecto` (
  `id_dtllProyecto` int(11) NOT NULL,
  `Url` varchar(50) NOT NULL,
  `id_ficha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_dtllproyectoprogra`
--

CREATE TABLE `tbl_dtllproyectoprogra` (
  `id_detalle` int(11) NOT NULL,
  `id_ficha` int(11) NOT NULL,
  `id_programacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_estados`
--

CREATE TABLE `tbl_estados` (
  `id_estado` int(11) NOT NULL,
  `nombreEstado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_estados`
--

INSERT INTO `tbl_estados` (`id_estado`, `nombreEstado`) VALUES
(1, 'Por evaluar'),
(2, 'Aprobado'),
(3, 'Por ajustar'),
(4, 'No aprobado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_fichagrupo`
--

CREATE TABLE `tbl_fichagrupo` (
  `id_fichaGrupo` int(11) NOT NULL,
  `numeroFicha` varchar(10) NOT NULL,
  `titularFicha` int(11) NOT NULL,
  `iniciolectiva` date NOT NULL,
  `finlectiva` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_fichagrupo`
--

INSERT INTO `tbl_fichagrupo` (`id_fichaGrupo`, `numeroFicha`, `titularFicha`, `iniciolectiva`, `finlectiva`) VALUES
(1, '11197295', 1, '0000-00-00', '0000-00-00'),
(2, '1261679', 4, '0000-00-00', '0000-00-00'),
(3, '1355169', 7, '0000-00-00', '0000-00-00'),
(4, '1355170', 5, '0000-00-00', '0000-00-00'),
(5, '1356897', 11, '0000-00-00', '0000-00-00'),
(6, '1319449', 12, '0000-00-00', '0000-00-00'),
(7, '1319451', 14, '0000-00-00', '0000-00-00'),
(8, '1197318', 3, '0000-00-00', '0000-00-00'),
(9, '1364839', 15, '0000-00-00', '0000-00-00'),
(10, '1364852', 18, '0000-00-00', '0000-00-00'),
(11, '1438032', 17, '0000-00-00', '0000-00-00'),
(12, '1348079', 9, '0000-00-00', '0000-00-00'),
(13, '1438080', 2, '0000-00-00', '0000-00-00'),
(14, '1348086', 21, '0000-00-00', '0000-00-00'),
(15, '1348017', 19, '0000-00-00', '0000-00-00'),
(16, '1364816', 16, '0000-00-00', '0000-00-00'),
(17, '1364827', 13, '0000-00-00', '0000-00-00'),
(18, '1438027', 20, '0000-00-00', '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_fichaproyecto`
--

CREATE TABLE `tbl_fichaproyecto` (
  `id_ficha` int(11) NOT NULL,
  `titulo` varchar(20) NOT NULL,
  `obj_general` varchar(500) NOT NULL,
  `Url` varchar(50) NOT NULL,
  `version` varchar(5) NOT NULL,
  `observacion` varchar(100) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_fichaGrupo` int(11) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_instructores`
--

CREATE TABLE `tbl_instructores` (
  `id_instructor` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `documento` varchar(12) NOT NULL,
  `correo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_instructores`
--

INSERT INTO `tbl_instructores` (`id_instructor`, `nombre`, `apellido`, `documento`, `correo`) VALUES
(1, 'Delia ', 'Herazo', '70812963', 'deliamarherazo@misena.edu.co'),
(2, 'Licet ', 'Vargas', '70812963', 'eliseth1719@misena.edu.co'),
(3, 'Alejandro ', 'Pérez', '70812963', 'alejandroperez0358@gmail.com'),
(4, 'Jhonnys ', 'Rodriguez', '70812963', 'honnysrodriguez@misena.edu.co'),
(5, 'Héctor ', 'Maya', '70812963', ' hdmaya@misena.edu.co'),
(6, 'Juan David ', 'Ramírez', '70812963', 'j.deiby@misena.edu.co'),
(7, 'Liliana ', 'Galeano', '70812963', 'lgaleano@misena.edu.co'),
(8, 'Edgardo ', 'Montaño', '70812963', ''),
(9, 'Lina ', 'Jaramillo', '70812963', 'linajate@gmail.com'),
(10, 'Héctor ', 'Maya', '70812963', 'hdmaya@misena.edu.co'),
(11, 'Doris ', 'Monsalve', '70812963', 'dmonsalve@misena.edu.co'),
(12, 'Luis Eduardo ', 'Cadavid', '70812963', 'luedca@misena.edu.co'),
(13, 'Marta Ester ', 'Gómez', '70812963', 'mega2808@misena.edu.co'),
(14, 'Edinson ', 'Martínez', '70812963', 'edinmartim@gmail.com'),
(15, 'Gisela ', 'Escobar', '70812963', 'gescobar9@misena.edu.co'),
(16, 'Cristian ', 'Arias', '70812963', 'crcaarti@misena.edu.co'),
(17, 'John Fredy ', 'sadder', '70812963', 'jsadder@sena.edu.co'),
(18, 'Yenifer ', 'Vanegas', '70812963', 'yenifer89@misena.edu.co'),
(19, 'Luis ', 'Villamizar', '70812963', 'lfvillamizar7@misena.edu.co'),
(20, 'Alber Dario ', 'Arango', '70812963', 'alberarango@misena.edu.co'),
(21, 'Juan David', 'Vahos', '7812000', 'jdvahos@misena.edu.co');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_programacioncomite`
--

CREATE TABLE `tbl_programacioncomite` (
  `id_programacion` int(11) NOT NULL,
  `titulo` varchar(30) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `lugar` varchar(40) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_aprendiz`
--
ALTER TABLE `tbl_aprendiz`
  ADD PRIMARY KEY (`id_aprendiz`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- Indices de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tbl_comite`
--
ALTER TABLE `tbl_comite`
  ADD PRIMARY KEY (`id_comite`),
  ADD KEY `fk_programacion` (`fk_programacion`),
  ADD KEY `fk_instructor` (`fk_instructor`);

--
-- Indices de la tabla `tbl_detallesaprendizgrupo`
--
ALTER TABLE `tbl_detallesaprendizgrupo`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `fk_apredizProyecto` (`id_aprendiz`),
  ADD KEY `fk_aprendizGrupo` (`id_fichaGrupo`);

--
-- Indices de la tabla `tbl_detallesaprendizproyecto`
--
ALTER TABLE `tbl_detallesaprendizproyecto`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `fk_aprendiz` (`id_aprendiz`),
  ADD KEY `fk_ficha` (`id_ficha`);

--
-- Indices de la tabla `tbl_dtllproyecto`
--
ALTER TABLE `tbl_dtllproyecto`
  ADD PRIMARY KEY (`id_dtllProyecto`),
  ADD KEY `id_ficha` (`id_ficha`);

--
-- Indices de la tabla `tbl_dtllproyectoprogra`
--
ALTER TABLE `tbl_dtllproyectoprogra`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_ficha` (`id_ficha`),
  ADD KEY `id_programacion` (`id_programacion`);

--
-- Indices de la tabla `tbl_estados`
--
ALTER TABLE `tbl_estados`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `tbl_fichagrupo`
--
ALTER TABLE `tbl_fichagrupo`
  ADD PRIMARY KEY (`id_fichaGrupo`),
  ADD KEY `tirularFicha` (`titularFicha`);

--
-- Indices de la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  ADD PRIMARY KEY (`id_ficha`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `estado` (`estado`),
  ADD KEY `id_fichaGrupo` (`id_fichaGrupo`);

--
-- Indices de la tabla `tbl_instructores`
--
ALTER TABLE `tbl_instructores`
  ADD PRIMARY KEY (`id_instructor`);

--
-- Indices de la tabla `tbl_programacioncomite`
--
ALTER TABLE `tbl_programacioncomite`
  ADD PRIMARY KEY (`id_programacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_aprendiz`
--
ALTER TABLE `tbl_aprendiz`
  MODIFY `id_aprendiz` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `tbl_comite`
--
ALTER TABLE `tbl_comite`
  MODIFY `id_comite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesaprendizgrupo`
--
ALTER TABLE `tbl_detallesaprendizgrupo`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesaprendizproyecto`
--
ALTER TABLE `tbl_detallesaprendizproyecto`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_dtllproyecto`
--
ALTER TABLE `tbl_dtllproyecto`
  MODIFY `id_dtllProyecto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_dtllproyectoprogra`
--
ALTER TABLE `tbl_dtllproyectoprogra`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT de la tabla `tbl_estados`
--
ALTER TABLE `tbl_estados`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tbl_fichagrupo`
--
ALTER TABLE `tbl_fichagrupo`
  MODIFY `id_fichaGrupo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT de la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  MODIFY `id_ficha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_instructores`
--
ALTER TABLE `tbl_instructores`
  MODIFY `id_instructor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT de la tabla `tbl_programacioncomite`
--
ALTER TABLE `tbl_programacioncomite`
  MODIFY `id_programacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_comite`
--
ALTER TABLE `tbl_comite`
  ADD CONSTRAINT `tbl_comite_ibfk_2` FOREIGN KEY (`fk_programacion`) REFERENCES `tbl_programacioncomite` (`id_programacion`),
  ADD CONSTRAINT `tbl_comite_ibfk_3` FOREIGN KEY (`fk_instructor`) REFERENCES `tbl_instructores` (`id_instructor`);

--
-- Filtros para la tabla `tbl_detallesaprendizgrupo`
--
ALTER TABLE `tbl_detallesaprendizgrupo`
  ADD CONSTRAINT `fk_apredizProyecto` FOREIGN KEY (`id_aprendiz`) REFERENCES `tbl_aprendiz` (`id_aprendiz`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_aprendizGrupo` FOREIGN KEY (`id_fichaGrupo`) REFERENCES `tbl_fichagrupo` (`id_fichaGrupo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_detallesaprendizproyecto`
--
ALTER TABLE `tbl_detallesaprendizproyecto`
  ADD CONSTRAINT `fk_aprendiz` FOREIGN KEY (`id_aprendiz`) REFERENCES `tbl_aprendiz` (`id_aprendiz`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ficha` FOREIGN KEY (`id_ficha`) REFERENCES `tbl_fichaproyecto` (`id_ficha`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_dtllproyecto`
--
ALTER TABLE `tbl_dtllproyecto`
  ADD CONSTRAINT `tbl_dtllproyecto_ibfk_1` FOREIGN KEY (`id_ficha`) REFERENCES `tbl_fichaproyecto` (`id_ficha`);

--
-- Filtros para la tabla `tbl_dtllproyectoprogra`
--
ALTER TABLE `tbl_dtllproyectoprogra`
  ADD CONSTRAINT `tbl_dtllproyectoprogra_ibfk_1` FOREIGN KEY (`id_ficha`) REFERENCES `tbl_fichaproyecto` (`id_ficha`),
  ADD CONSTRAINT `tbl_dtllproyectoprogra_ibfk_2` FOREIGN KEY (`id_programacion`) REFERENCES `tbl_programacioncomite` (`id_programacion`);

--
-- Filtros para la tabla `tbl_fichagrupo`
--
ALTER TABLE `tbl_fichagrupo`
  ADD CONSTRAINT `tbl_fichagrupo_ibfk_1` FOREIGN KEY (`titularFicha`) REFERENCES `tbl_instructores` (`id_instructor`);

--
-- Filtros para la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  ADD CONSTRAINT `tbl_fichaproyecto_ibfk_1` FOREIGN KEY (`estado`) REFERENCES `tbl_estados` (`id_estado`),
  ADD CONSTRAINT `tbl_fichaproyecto_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `tbl_cliente` (`id_cliente`),
  ADD CONSTRAINT `tbl_fichaproyecto_ibfk_3` FOREIGN KEY (`id_fichaGrupo`) REFERENCES `tbl_fichagrupo` (`id_fichaGrupo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
