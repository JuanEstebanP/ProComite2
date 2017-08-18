-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-08-2017 a las 23:00:49
-- Versión del servidor: 5.6.24
-- Versión de PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `gc`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarCliente`(IN `sp_idCliente` INT, IN `sp_nombreCliente` VARCHAR(20), IN `sp_apellidoCliente` VARCHAR(20), IN `sp_telefonoCliente` VARCHAR(10), IN `sp_correoCliente` VARCHAR(50))
    NO SQL
BEGIN

UPDATE tbl_cliente SET
nombre=sp_nombreCliente, apellido=sp_apellidoCliente, telefono=sp_telefonoCliente, correo=sp_correoCliente
WHERE id_cliente = sp_idCliente;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizarInstructor`(IN `sp_idInstructor` INT, IN `sp_nombre` VARCHAR(40), IN `sp_apellido` VARCHAR(40), IN `sp_documento` VARCHAR(12), IN `sp_correo` VARCHAR(50))
    NO SQL
BEGIN

update tbl_instructores SET
nombre=sp_nombre, apellido=sp_apellido, documento=sp_documento, correo=sp_correo
WHERE id_instructor = sp_idInstructor;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarAprendices`()
    NO SQL
BEGIN

SELECT * FROM tbl_aprendiz;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarClientes`()
    NO SQL
BEGIN

SELECT * FROM tbl_cliente;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarFichasArh`()
    NO SQL
BEGIN
SELECT fh.estado,fh.titulo, fh.obj_general, fh.id_ficha,fh.observacion , fh.Url,c.nombre,e.nombreEstado, e.id_estado FROM tbl_fichaproyecto fh 
join tbl_cliente c on(fh.id_cliente=c.id_cliente) 
JOIN tbl_estados e ON(fh.estado=e.id_estado) ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarFichasproyectos`()
    NO SQL
SELECT * from tbl_fichaproyecto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarInstructores`()
    NO SQL
BEGIN

SELECT * FROM tbl_instructores;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarProgramacion`()
    NO SQL
BEGIN
SELECT *FROM tbl_programacioncomite;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarAprendiz`(IN `id` INT, IN `nomb` VARCHAR(20), IN `apell` VARCHAR(20), IN `docu` VARCHAR(20), IN `correo` VARCHAR(45))
    NO SQL
BEGIN
UPDATE tbl_aprendiz SET nombre = nomb, apellido = apell, documento = docu, correo = correo WHERE id_aprendiz = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarFicha`(IN `id` INT, IN `num` INT, IN `titular` INT, IN `ilectiva` DATE, IN `flectiva` DATE)
    NO SQL
BEGIN 
UPDATE tbl_fichagrupo SET numeroFicha = num, tirularFicha = titular, iniciolectiva = ilectiva, finlectiva = flectiva WHERE id_fichaGrupo = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarFichaproyecto`(IN `id` INT, IN `nom` VARCHAR(50), IN `obje` VARCHAR(100), IN `version` VARCHAR(5), IN `urls` VARCHAR(50), IN `cliente` INT, IN `esta` INT)
    NO SQL
BEGIN
UPDATE tbl_fichaproyecto SET id_ficha = id, titulo = nom, obj_general = obje, version = version, Url=urls ,id_cliente = cliente, estado=esta WHERE id_ficha = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EditarProgramacion`(IN `sp_idprogramacion` INT, IN `sp_fecha` DATE, IN `sp_hora` TIME, IN `sp_lugar` VARCHAR(40))
    NO SQL
BEGIN
UPDATE tbl_programacioncomite SET tbl_programacioncomite.fecha=sp_fecha, tbl_programacioncomite.hora=sp_hora,
tbl_programacioncomite.lugar=sp_lugar
WHERE tbl_programacioncomite.id_programacion=sp_idprogramacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EvaluarFicha`(IN `idf` INT, IN `obs` VARCHAR(100), IN `ide` INT)
    NO SQL
BEGIN
UPDATE tbl_fichaproyecto SET estado = ide WHERE id_ficha = idf;
UPDATE tbl_fichaproyecto SET observacion = obs WHERE id_ficha = idf;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idAprendiz`(IN `sp_idAprendiz` INT)
    NO SQL
BEGIN
SELECT * FROM tbl_aprendiz   WHERE id_aprendiz = sp_idAprendiz;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idClientes`(IN `sp_idCliente` INT)
    NO SQL
BEGIN

SELECT * FROM tbl_cliente WHERE id_cliente = sp_idCliente;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idEvaluar`(IN `ide` INT)
    NO SQL
BEGIN
SELECT id_ficha, estado FROM tbl_fichaproyecto WHERE id_ficha= ide;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idFicha`(IN `sp_idFicha` INT)
    NO SQL
BEGIN
SELECT * FROM tbl_fichagrupo WHERE id_fichaGrupo  = sp_idFicha;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idFichaProyecto`(IN `id` INT)
    NO SQL
select * from tbl_fichaproyecto where  id_ficha=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idInstructores`(IN `sp_idInstructor` INT)
    NO SQL
BEGIN
SELECT * FROM tbl_instructores WHERE id_instructor = sp_idInstructor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarAprendiz`(IN `nomb` VARCHAR(20), IN `apell` VARCHAR(20), IN `docu` VARCHAR(20), IN `correo` VARCHAR(20))
    NO SQL
BEGIN
INSERT INTO tbl_aprendiz (id_aprendiz, nombre, apellido, documento, correo) VALUES (NULL, nomb, apell, docu, correo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarCliente`(IN `sp_nombreCliente` VARCHAR(20), IN `sp_apellidoCliente` VARCHAR(20), IN `sp_telefonoCliente` VARCHAR(10), IN `sp_correoCliente` VARCHAR(50))
    NO SQL
BEGIN
INSERT INTO tbl_cliente (nombre, apellido, telefono, correo)
VALUES (sp_nombreCliente, sp_apellidoCliente, sp_telefonoCliente, sp_correoCliente);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarFichaGrupo`(IN `finl` DATE, IN `nficha` INT, IN `iniciol` DATE, IN `titular` INT)
    NO SQL
BEGIN
INSERT INTO tbl_fichagrupo (id_fichaGrupo, numeroFicha, titularFicha, iniciolectiva, finlectiva) VALUES (NULL, nficha,titular, iniciol, finl);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarFichaproyecto`(IN `nomb` VARCHAR(20), IN `obje` VARCHAR(100), IN `url` VARCHAR(50), IN `version` VARCHAR(15), IN `id_cliente` INT, IN `estado` INT, IN `id_fichag` INT)
    NO SQL
BEGIN
  INSERT INTO tbl_fichaproyecto (id_ficha, titulo, obj_general, Url, version, observacion, id_cliente, id_fichaGrupo, estado) VALUES (NULL, nomb, obje, url, version,'Prueba', id_cliente, id_fichag, estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarInstructor`(IN `sp_nombre` VARCHAR(40), IN `sp_apellido` VARCHAR(40), IN `sp_documento` VARCHAR(12), IN `sp_correo` VARCHAR(50))
    NO SQL
BEGIN

INSERT INTO tbl_instructores (nombre, apellido, documento, correo)
VALUES
(sp_nombre, sp_apellido, sp_documento, sp_correo);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_MostrarProgramacion`(IN `id_programacion` INT)
    NO SQL
BEGIN
SELECT *FROM tbl_programacioncomite
WHERE tbl_programacioncomite.id_programacion=id_programacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_RegistrarProgramacion`(IN `sp_fecha` DATE, IN `sp_hora` TIME, IN `sp_lugar` VARCHAR(40))
    NO SQL
BEGIN
INSERT INTO tbl_programacioncomite(fecha,hora,lugar)
VALUES(sp_fecha, sp_hora, sp_lugar);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_aprendiz`
--

CREATE TABLE IF NOT EXISTS `tbl_aprendiz` (
  `id_aprendiz` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `documento` varchar(12) NOT NULL,
  `correo` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_aprendiz`
--

INSERT INTO `tbl_aprendiz` (`id_aprendiz`, `nombre`, `apellido`, `documento`, `correo`) VALUES
(1, 'Juan Esteban', 'Pulgarin', '1152212965', 'pulga@misena.edu.co'),
(2, 'Jonathan', 'Alexander', '1152456789', 'jonas@misena.edu.co'),
(3, 'María', 'Uran', '70896777', 'ura@misena.edu.co'),
(4, 'Esteban', 'vergara', '1152369785', 'jevergara@misena.edu.co'),
(5, 'Alejandro', 'Perez', '70812698', 'pepe@misena.edu.co'),
(6, 'Julian', 'Ateaga', '1152478963', 'misena@misena.edu.co'),
(7, 'Adrian Alejandro', 'Perez', '70812698', 'pepe@misena.edu.co');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cliente`
--

CREATE TABLE IF NOT EXISTS `tbl_cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `correo` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_cliente`
--

INSERT INTO `tbl_cliente` (`id_cliente`, `nombre`, `apellido`, `telefono`, `correo`) VALUES
(1, 'Alberto', 'Porras', '4225896', 'po427@misena.edu.co'),
(2, 'a si ', 'qewqe', '4201525', 'jsjs@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_comite`
--

CREATE TABLE IF NOT EXISTS `tbl_comite` (
  `id_comite` int(11) NOT NULL,
  `fk_programacion` int(11) NOT NULL,
  `fk_ficha` int(11) NOT NULL,
  `fk_instructor` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `tbl_comite`
--

INSERT INTO `tbl_comite` (`id_comite`, `fk_programacion`, `fk_ficha`, `fk_instructor`) VALUES
(1, 10, 0, 3),
(3, 10, 2, 2),
(5, 10, 87, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detallesaprendizgrupo`
--

CREATE TABLE IF NOT EXISTS `tbl_detallesaprendizgrupo` (
  `id_detalle` int(11) NOT NULL,
  `id_aprendiz` int(11) NOT NULL,
  `id_fichaGrupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detallesaprendizproyecto`
--

CREATE TABLE IF NOT EXISTS `tbl_detallesaprendizproyecto` (
  `id_detalle` int(11) NOT NULL,
  `id_aprendiz` int(11) NOT NULL,
  `id_ficha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_dtllproyecto`
--

CREATE TABLE IF NOT EXISTS `tbl_dtllproyecto` (
  `id_dtllProyecto` int(11) NOT NULL,
  `Url` varchar(50) NOT NULL,
  `id_ficha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_estados`
--

CREATE TABLE IF NOT EXISTS `tbl_estados` (
  `id_estado` int(11) NOT NULL,
  `nombreEstado` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

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

CREATE TABLE IF NOT EXISTS `tbl_fichagrupo` (
  `id_fichaGrupo` int(11) NOT NULL,
  `numeroFicha` varchar(10) NOT NULL,
  `titularFicha` int(11) NOT NULL,
  `iniciolectiva` date NOT NULL,
  `finlectiva` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_fichagrupo`
--

INSERT INTO `tbl_fichagrupo` (`id_fichaGrupo`, `numeroFicha`, `titularFicha`, `iniciolectiva`, `finlectiva`) VALUES
(1, '1023473', 2, '2015-09-28', '2017-09-28'),
(2, '1126491', 1, '2017-08-01', '2017-08-31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_fichaproyecto`
--

CREATE TABLE IF NOT EXISTS `tbl_fichaproyecto` (
  `id_ficha` int(11) NOT NULL,
  `titulo` varchar(20) NOT NULL,
  `obj_general` varchar(500) NOT NULL,
  `Url` varchar(50) NOT NULL,
  `version` varchar(5) NOT NULL,
  `observacion` varchar(100) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_fichaGrupo` int(11) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_fichaproyecto`
--

INSERT INTO `tbl_fichaproyecto` (`id_ficha`, `titulo`, `obj_general`, `Url`, `version`, `observacion`, `id_cliente`, `id_fichaGrupo`, `estado`) VALUES
(10, 'Bueno', 'qweq', './uploads/', '1', 'qwewqe', 1, 1, 1),
(12, 'sdasd', 'asdasdsadas', 'wqe', '1', 'Prueba', 1, 1, 1),
(13, 'sam', 'dasdasdsa', './uploads/internet.jpg', '1', 'Prueba', 1, 1, 1),
(14, '2', '2131', './uploads/', '1', 'Prueba', 1, 1, 1),
(17, 'Prueba', 'PRUEBA', './uploads/a677e29d-f97e-4690-87ef-4276d5917f1c.jpg', '1', '', 1, 1, 1),
(18, 'asdasd', 'sadwqwq', './uploads/', '1', '', 1, 1, 1),
(19, '6546564', 'ghhj', './uploads/', '1', '', 1, 2, 1),
(20, 'sdw4wee32rd', 'rth4y5g5t5t54t', './uploads/serpentin.jpg', '1', '', 1, 2, 1),
(21, '11251564', 'weqwewqeq', './uploads/', '12', 'Prueba', 2, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_instructores`
--

CREATE TABLE IF NOT EXISTS `tbl_instructores` (
  `id_instructor` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `documento` varchar(12) NOT NULL,
  `correo` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_instructores`
--

INSERT INTO `tbl_instructores` (`id_instructor`, `nombre`, `apellido`, `documento`, `correo`) VALUES
(1, 'Carlos', 'Acevedo', '70896458', 'acevece@mise.edu.co'),
(2, 'Carlos', 'Marin', '43179856', 'acevece@mise.edu.co'),
(3, 'Alberto', 'Zuluaga', '43892654', 'azulu@misena.edu.co'),
(4, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(5, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(6, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(7, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(8, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(9, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(10, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(11, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(12, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(13, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com'),
(14, 'carlos ', 'qwewqe', '123123123', 'qwewqeqw@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_programacioncomite`
--

CREATE TABLE IF NOT EXISTS `tbl_programacioncomite` (
  `id_programacion` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `lugar` varchar(40) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_programacioncomite`
--

INSERT INTO `tbl_programacioncomite` (`id_programacion`, `fecha`, `hora`, `lugar`) VALUES
(1, '2017-08-24', '02:01:00', 'piso 5'),
(2, '2017-08-24', '02:01:00', 'piso 5'),
(3, '2017-08-04', '23:50:00', 'torre norte ambiente 501'),
(4, '2017-08-04', '23:50:00', 'torre norte ambiente 501'),
(5, '2017-08-30', '14:30:00', 'torre norte ambiente 706'),
(6, '2017-08-30', '14:30:00', 'torre norte ambiente 706'),
(7, '2017-08-04', '14:01:00', 'Torre Sur'),
(8, '2017-08-04', '14:01:00', 'Torre Sur'),
(9, '2017-08-23', '13:01:00', 'Ambiente 703 torre norte'),
(10, '2017-08-10', '12:00:00', 'torre norte ambiente 806');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_aprendiz`
--
ALTER TABLE `tbl_aprendiz`
  ADD PRIMARY KEY (`id_aprendiz`);

--
-- Indices de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tbl_comite`
--
ALTER TABLE `tbl_comite`
  ADD PRIMARY KEY (`id_comite`), ADD KEY `fk_programacion` (`fk_programacion`), ADD KEY `fk_ficha` (`fk_ficha`), ADD KEY `fk_instructor` (`fk_instructor`);

--
-- Indices de la tabla `tbl_detallesaprendizgrupo`
--
ALTER TABLE `tbl_detallesaprendizgrupo`
  ADD PRIMARY KEY (`id_detalle`), ADD KEY `fk_apredizProyecto` (`id_aprendiz`), ADD KEY `fk_aprendizGrupo` (`id_fichaGrupo`);

--
-- Indices de la tabla `tbl_detallesaprendizproyecto`
--
ALTER TABLE `tbl_detallesaprendizproyecto`
  ADD PRIMARY KEY (`id_detalle`), ADD KEY `fk_aprendiz` (`id_aprendiz`), ADD KEY `fk_ficha` (`id_ficha`);

--
-- Indices de la tabla `tbl_dtllproyecto`
--
ALTER TABLE `tbl_dtllproyecto`
  ADD PRIMARY KEY (`id_dtllProyecto`);

--
-- Indices de la tabla `tbl_estados`
--
ALTER TABLE `tbl_estados`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `tbl_fichagrupo`
--
ALTER TABLE `tbl_fichagrupo`
  ADD PRIMARY KEY (`id_fichaGrupo`), ADD KEY `tirularFicha` (`titularFicha`);

--
-- Indices de la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  ADD PRIMARY KEY (`id_ficha`), ADD KEY `id_cliente` (`id_cliente`), ADD KEY `estado` (`estado`), ADD KEY `id_fichaGrupo` (`id_fichaGrupo`);

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
  MODIFY `id_aprendiz` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_comite`
--
ALTER TABLE `tbl_comite`
  MODIFY `id_comite` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesaprendizgrupo`
--
ALTER TABLE `tbl_detallesaprendizgrupo`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesaprendizproyecto`
--
ALTER TABLE `tbl_detallesaprendizproyecto`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_dtllproyecto`
--
ALTER TABLE `tbl_dtllproyecto`
  MODIFY `id_dtllProyecto` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_estados`
--
ALTER TABLE `tbl_estados`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tbl_fichagrupo`
--
ALTER TABLE `tbl_fichagrupo`
  MODIFY `id_fichaGrupo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  MODIFY `id_ficha` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT de la tabla `tbl_instructores`
--
ALTER TABLE `tbl_instructores`
  MODIFY `id_instructor` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT de la tabla `tbl_programacioncomite`
--
ALTER TABLE `tbl_programacioncomite`
  MODIFY `id_programacion` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
