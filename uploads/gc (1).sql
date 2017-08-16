-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-07-2017 a las 15:49:27
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultarInstructores` ()  NO SQL
BEGIN

SELECT * FROM tbl_instructores;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_idInstructores` (IN `sp_idInstructor` INT)  NO SQL
BEGIN
SELECT * FROM tbl_instructores WHERE id_instructor = sp_idInstructor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarInstructor` (IN `sp_nombre` VARCHAR(40), IN `sp_apellido` VARCHAR(40), IN `sp_documento` VARCHAR(12), IN `sp_correo` VARCHAR(50))  NO SQL
BEGIN

INSERT INTO tbl_instructores (nombre, apellido, documento, correo)
VALUES
(sp_nombre, sp_apellido, sp_documento, sp_correo);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_aprendiz`
--

CREATE TABLE `tbl_aprendiz` (
  `id_aprendiz` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apelliddo` varchar(20) NOT NULL,
  `documento` varchar(12) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `numeroFicha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_aprendiz`
--

INSERT INTO `tbl_aprendiz` (`id_aprendiz`, `nombre`, `apelliddo`, `documento`, `correo`, `numeroFicha`) VALUES
(1, 'juan', 'pulgarin acevedo', '123123213', 'sadsa@gmail.com', 12),
(2, 'Jose', 'acevedo', '12132132', 'sdsad@dsdj.com', 12);

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
(1, 'mario', 'marin', '213213', 'as@fdfds.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_comite`
--

CREATE TABLE `tbl_comite` (
  `id_comite` int(11) NOT NULL,
  `fk_programacion` int(11) NOT NULL,
  `fk_ficha` int(11) NOT NULL,
  `fk_instructor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `tbl_comite`
--

INSERT INTO `tbl_comite` (`id_comite`, `fk_programacion`, `fk_ficha`, `fk_instructor`) VALUES
(1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detallesaprendizgrupo`
--

CREATE TABLE `tbl_detallesaprendizgrupo` (
  `id_detalle` int(11) NOT NULL,
  `id_aprendiz` int(11) NOT NULL,
  `id_fichaGrupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_detallesaprendizgrupo`
--

INSERT INTO `tbl_detallesaprendizgrupo` (`id_detalle`, `id_aprendiz`, `id_fichaGrupo`) VALUES
(1, 1, 1),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detallesaprendizproyecto`
--

CREATE TABLE `tbl_detallesaprendizproyecto` (
  `id_detalle` int(11) NOT NULL,
  `id_aprendiz` int(11) NOT NULL,
  `id_ficha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_detallesaprendizproyecto`
--

INSERT INTO `tbl_detallesaprendizproyecto` (`id_detalle`, `id_aprendiz`, `id_ficha`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detallesfichascomite`
--

CREATE TABLE `tbl_detallesfichascomite` (
  `id_fichacomite` int(11) NOT NULL,
  `observacion` varchar(50) NOT NULL,
  `estado` int(11) NOT NULL,
  `fk_fichaproyecto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_detallesfichascomite`
--

INSERT INTO `tbl_detallesfichascomite` (`id_fichacomite`, `observacion`, `estado`, `fk_fichaproyecto`) VALUES
(1, 'todos son noobs', 1, 1),
(4, 'asdsada', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_estados`
--

CREATE TABLE `tbl_estados` (
  `id_estado` int(11) NOT NULL,
  `nombreEstado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_estados`
--

INSERT INTO `tbl_estados` (`id_estado`, `nombreEstado`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_fichagrupo`
--

CREATE TABLE `tbl_fichagrupo` (
  `id_fichaGrupo` int(11) NOT NULL,
  `numeroFicha` varchar(10) NOT NULL,
  `tirularFicha` int(11) NOT NULL,
  `iniciolectiva` date NOT NULL,
  `finlectiva` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_fichagrupo`
--

INSERT INTO `tbl_fichagrupo` (`id_fichaGrupo`, `numeroFicha`, `tirularFicha`, `iniciolectiva`, `finlectiva`) VALUES
(1, '12', 1, '2017-07-05', '2017-07-29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_fichaproyecto`
--

CREATE TABLE `tbl_fichaproyecto` (
  `id_ficha` int(11) NOT NULL,
  `titulo` varchar(20) NOT NULL,
  `obj_general` varchar(500) NOT NULL,
  `version` varchar(5) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_fichaproyecto`
--

INSERT INTO `tbl_fichaproyecto` (`id_ficha`, `titulo`, `obj_general`, `version`, `id_cliente`, `estado`) VALUES
(1, 'desarrollo', 'desarrollar ', '1', 1, 1),
(2, 'sdsad', 'asds', 'wqe', 1, 1);

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
(1, 'omar', 'perez', '123123', '132@fsdf.com'),
(2, 'awtgr', 'wwartgfawr', 'wratgwr', 'wrtgw'),
(3, 'Jhonatan', 'Gil', '1152269698', 'jagil@misena.edu.co'),
(4, 'Esteban', 'Vergara', '1152269698', 'estepillo@misena.edu.co'),
(5, 'Diego', 'Caremañola', '43207789', 'ejemplo@inix.com'),
(6, 'León ', 'Chancí', '1234567890', 'jdfbjd@sesge.com'),
(7, '', '', '', ''),
(8, '', '', '', ''),
(9, 'yesii', '', '', ''),
(10, 'Juan Pablo', 'Muñoz Romero', '1150236987', 'pepe@misena.edu.co'),
(11, '', '', '', ''),
(12, '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_programacioncomite`
--

CREATE TABLE `tbl_programacioncomite` (
  `id_programacion` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `lugar` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_programacioncomite`
--

INSERT INTO `tbl_programacioncomite` (`id_programacion`, `fecha`, `hora`, `lugar`) VALUES
(1, '2017-07-06', '06:28:00', 'Piso 8 torre norte ');

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
  ADD PRIMARY KEY (`id_comite`),
  ADD KEY `fk_programacion` (`fk_programacion`),
  ADD KEY `fk_ficha` (`fk_ficha`),
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
-- Indices de la tabla `tbl_detallesfichascomite`
--
ALTER TABLE `tbl_detallesfichascomite`
  ADD PRIMARY KEY (`id_fichacomite`),
  ADD KEY `fk_fichaproyecto` (`fk_fichaproyecto`);

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
  ADD KEY `tirularFicha` (`tirularFicha`);

--
-- Indices de la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  ADD PRIMARY KEY (`id_ficha`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `estado` (`estado`);

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
  MODIFY `id_aprendiz` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tbl_comite`
--
ALTER TABLE `tbl_comite`
  MODIFY `id_comite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesaprendizgrupo`
--
ALTER TABLE `tbl_detallesaprendizgrupo`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesaprendizproyecto`
--
ALTER TABLE `tbl_detallesaprendizproyecto`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesfichascomite`
--
ALTER TABLE `tbl_detallesfichascomite`
  MODIFY `id_fichacomite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tbl_estados`
--
ALTER TABLE `tbl_estados`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_fichagrupo`
--
ALTER TABLE `tbl_fichagrupo`
  MODIFY `id_fichaGrupo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  MODIFY `id_ficha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_instructores`
--
ALTER TABLE `tbl_instructores`
  MODIFY `id_instructor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `tbl_programacioncomite`
--
ALTER TABLE `tbl_programacioncomite`
  MODIFY `id_programacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_comite`
--
ALTER TABLE `tbl_comite`
  ADD CONSTRAINT `tbl_comite_ibfk_2` FOREIGN KEY (`fk_programacion`) REFERENCES `tbl_programacioncomite` (`id_programacion`),
  ADD CONSTRAINT `tbl_comite_ibfk_3` FOREIGN KEY (`fk_instructor`) REFERENCES `tbl_instructores` (`id_instructor`),
  ADD CONSTRAINT `tbl_comite_ibfk_4` FOREIGN KEY (`fk_ficha`) REFERENCES `tbl_detallesfichascomite` (`id_fichacomite`);

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
-- Filtros para la tabla `tbl_detallesfichascomite`
--
ALTER TABLE `tbl_detallesfichascomite`
  ADD CONSTRAINT `tbl_detallesfichascomite_ibfk_1` FOREIGN KEY (`fk_fichaproyecto`) REFERENCES `tbl_fichaproyecto` (`id_ficha`);

--
-- Filtros para la tabla `tbl_fichagrupo`
--
ALTER TABLE `tbl_fichagrupo`
  ADD CONSTRAINT `tbl_fichagrupo_ibfk_1` FOREIGN KEY (`tirularFicha`) REFERENCES `tbl_instructores` (`id_instructor`);

--
-- Filtros para la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  ADD CONSTRAINT `tbl_fichaproyecto_ibfk_1` FOREIGN KEY (`estado`) REFERENCES `tbl_estados` (`id_estado`),
  ADD CONSTRAINT `tbl_fichaproyecto_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `tbl_cliente` (`id_cliente`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
