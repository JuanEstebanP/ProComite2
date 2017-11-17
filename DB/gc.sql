-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-11-2017 a las 16:45:29
-- Versión del servidor: 10.1.26-MariaDB
-- Versión de PHP: 7.1.8

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
SELECT * FROM tbl_aprendiz WHERE estado = 0;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EvaluarFicha` (IN `idf` INT, IN `obs` LONGTEXT, IN `ide` INT)  NO SQL
BEGIN
UPDATE tbl_fichaproyecto SET estado = ide WHERE id_ficha = idf;
UPDATE tbl_fichaproyecto SET observacion = obs WHERE id_ficha = idf;
INSERT INTO tbl_dtllevaluacion (id_detalle,observacion,fecha,id_ficha) VALUES (null,obs,sysdate(),idf);
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarFichaproyecto` (IN `nomb` VARCHAR(20), IN `obje` VARCHAR(100), IN `url` VARCHAR(50), IN `version` VARCHAR(15), IN `id_cliente` INT, IN `id_fichag` INT)  NO SQL
BEGIN
  INSERT INTO tbl_fichaproyecto (id_ficha, titulo, obj_general, Url, version, id_cliente, id_fichaGrupo, estado) VALUES (NULL, nomb, obje, url, version, id_cliente, id_fichag, 1);
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
SELECT a.id_aprendiz, a.nombre, a.apellido, a.documento, a.correo FROM tbl_aprendiz a join tbl_detallesaprendizgrupo dfg on dfg.id_aprendiz=a.id_aprendiz join tbl_fichagrupo fg on fg.id_fichaGrupo=dfg.id_fichaGrupo join tbl_fichaproyecto fp on fp.id_fichaGrupo=fg.id_fichaGrupo where fg.id_fichaGrupo= id  and a.estado= 1 GROUP by a.id_aprendiz, a.nombre, a.apellido, a.documento, a.correo;
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
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(11) NOT NULL,
  `nombres_empleado` varchar(150) NOT NULL,
  `apellidos_empleado` varchar(150) NOT NULL,
  `dni_empleado` varchar(10) NOT NULL,
  `telefono_empleado` varchar(10) NOT NULL,
  `email_empleado` varchar(100) NOT NULL,
  `foto_empleado` varchar(255) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(664, 'MENDEZ RUEDA        ', 'JUAN DIEGO          ', '3133813589 -', 'dmendezrueda1122@gmail.com', 2),
(665, 'VANEGAS DUITAMA     ', 'ELKIN MAURICIO      ', '3163531480', 'DGV19966@GMAIL.COM', 2),
(666, 'MANTILLA GALVIS     ', 'DIANA MARIA         ', '3174697605  ', 'dianimoon_127@hotmail.com', 2),
(667, 'MERLO ESTUPIÑAN     ', 'NATHALIA MELISSA    ', '3003565238-3', 'nathaliamelissa1991@hotmail.com', 2),
(668, 'CONTRERAS MARTINEZ  ', 'LEONARDO ANDRES     ', '3175946035  ', 'leonardocontreras802@gmail.com', 2),
(669, 'LOPEZ RAMIREZ       ', 'WALTER DUVERNEYTH   ', '3178908733', 'wlr7_1994@hotmail.com', 2),
(670, 'PICO ESCAÑO         ', 'ANGIE PAOLA         ', '3116244223  ', 'ANGIEPAOLAPICO19@GMAIL.COM', 2),
(671, 'GOMEZ MONROY        ', 'LEIDY JOHANNA       ', '5716383304  ', 'leidyjgomezm@gmail.com', 2),
(672, 'ARANGO OLARTE       ', 'SERGIO              ', '3202011558  ', 'SARANGO45@MISENA.EDU.CO', 0),
(673, 'RAMIREZ BRICEÑO     ', 'JHON JAIRO          ', '3124569995  ', 'jjramirez808@misena.edu.co', 0),
(674, 'ROA PINZON          ', 'CRISTHIAN ANDRES    ', '3106882416- ', 'caroa3@misena.edu.co; caroa1@misena.edu.co', 0),
(675, 'PINEDA PINTO        ', 'LEIDY ROCIO         ', '6312052     ', 'leidyrociopinedapinto@gmail.com', 0),
(676, 'DIAZ SARMIENTO      ', 'SALLY VANESSA       ', '3204923779  ', 'sallysarmiento25@hotmail.com', 0),
(677, 'GAONA AMAYA         ', 'JOHAN FERNEY        ', '3183110806  ', 'johan.fer199810@gmail.com', 0),
(678, 'ROJAS LAMILLA       ', 'JAIR STIVEN         ', '3022075088 -', 'JSROJAS364@MISENA.EDU.COM', 0),
(679, 'DIAZ RENOGA         ', 'MARIA HAYDEE        ', '3153619155  ', 'haydee901009@hotmail.com', 0),
(680, 'SUPELANO GUEVARA    ', 'BRAYAN ENRIQUE      ', '5716380720  ', 'brayanguevara.11@hotmail.com', 0),
(681, 'APONTI RIOS         ', 'ANDRES FELIPE       ', '5776435340  ', 'apontys27@hotmail.com', 0),
(682, 'CASTELLANOS BERNAL  ', 'BRAYAN ALBERTO      ', '3214371444  ', 'BRAYANCASTELLANOS24@OUTLOOK.COM', 0),
(683, 'VILLAMIZAR GELVEZ   ', 'NATHALIA            ', '3187712018  ', 'naty23villa@gmail.com', 0),
(684, 'ROJAS MARIN         ', 'JHON ARLEY          ', '3138341987  ', 'jhonarley1133527@gmail.com', 0),
(685, 'REYES RIOS          ', 'BEATRIZ HELENA      ', '3174835813  ', 'bettyr161@hotmail.com', 0),
(686, 'GARNICA CARVAJAL    ', 'DIEGO FERNANDO      ', '3224666842  ', 'diegogarnika22@gmail.com', 0),
(687, 'LLANES CODEZO       ', 'ANA MARIA           ', '573157920585', 'llanescodezzoa@gmail.com', 0),
(688, 'GUTIERREZ VASQUEZ   ', 'JHOAN SEBASTIAN     ', '3107943560  ', 'jsgutierrez466@misena.edu.co', 0),
(689, 'DURAN               ', 'JOSE LEONARDO       ', '577297295861', 'leonardo.you@hotmail.com', 0),
(690, 'REMOLINA DELGADO    ', 'KAREN MAYERLY       ', '7275126     ', 'kremolina@misena.edu.co', 0),
(691, 'MORENO ALARCON      ', 'FANNY MABEL         ', '3102998996  ', 'FMMORENO2@MISENA.EDU.CO', 0),
(692, 'RAMIREZ HIGUERA     ', 'LUZ LORENA          ', '3167924588  ', 'LOOREENNSSRAMI@GMAIL.COM', 0),
(693, 'CASTRO DUARTE       ', 'HEIDY PAOLA         ', '3114978753  ', 'forheidycita@hotmail.com', 0),
(694, 'GARCES LOPEZ        ', 'AURA CRISTINA       ', '3182535272  ', 'ACGARCES6@MISENA.EDU.CO', 0),
(695, 'GARCIA RIVERA       ', 'JESUS DAVID         ', '3182892610  ', 'jdgarcia8812@misena.edu.co', 0),
(696, 'RIVERA SANABRIA     ', 'MILANYELA           ', '3118379232-3', 'milymil91@hotmail.com', 0),
(697, 'AGUILAR CORDERO     ', 'YURLEY XIOMARA      ', '3132257998  ', 'YXAGUILAR@MISENA.EDU.CO', 2),
(698, 'FLOREZ BERMUDEZ     ', 'MAICKEL ANDRES      ', '3043811007-3', 'MAICKFLOREZ@GMAIL.COM', 2),
(699, 'NIETO DIAZ          ', 'ENAUDIS             ', '3186443353  ', 'ENAUDISNIETO@GMAIL.COM', 1),
(700, 'VANEGAS REALES      ', 'JORGE LUIS          ', '3166579386  ', 'CARMARTIN92@HOTMAIL.COM', 1),
(701, 'SARMIENTO ALVAREZ   ', 'LEYDI CAROLINA      ', '3213622388 -', 'LCSARMIENTO97@MISENA.EDU.CO', 1),
(702, 'ORTIZ VARGAS        ', 'CARLOS FERNANDO     ', '.', '', 1),
(703, 'GRIMALDOS RAMIREZ   ', 'ANY YOHANA          ', '3144272006  ', 'JUANDAVID211008@HOTMAIL.COM', 1),
(704, 'CARO CAMPO          ', 'LUZ GLEYDIS         ', '6732851     ', 'LUZG_23@HOTMAIL.COM', 1),
(705, 'RODRIGUEZ PADILLA   ', 'DAYAN STHEFANNY     ', '3172545422  ', 'SEBASCOR30@HOTMAIL.COM', 1),
(706, 'MARTINEZ TABORDA    ', 'SOR MARIA           ', '5776732644  ', 'sofiaysantiagohijos@hotmail.com', 1),
(707, 'ROJAS TORRES        ', 'MADENIS             ', '6005443     ', 'synedam-2@hotmail.com', 0),
(708, 'PABON PATIÑO        ', 'LAURA JULIANA       ', '3188194008  ', 'laurapabon26@hotmail.com', 0),
(709, 'SERRANO HERNANDEZ   ', 'KAREN DANIELA       ', '3166425137  ', 'DANISERRANO092898@GMAIL.COM', 0),
(710, 'FRANCO ALARCON      ', 'JULIANA             ', '3212389087', 'JULIANAFRANCO.A@HOTMAIL.COM', 0),
(711, 'OLIVEROS AVILA      ', 'LEMIS ENRIQUE       ', '3106886638  ', 'TECNO.OLIVEROS@HOTMAIL.COM', 0),
(712, 'SUAREZ RODRIGUEZ    ', 'OSCAR IVAN          ', '3042114392  ', 'OSCAR_SCORPION20@HOTMAIL.COM', 0),
(713, 'RINCON RODRIGUEZ    ', 'KEILER ENRIQUE      ', '3164656018  ', 'kerincon87@misena.edu.co', 0),
(714, 'DIAZ ARDILA         ', 'LUIS CARLOS         ', '  320 822 21', 'LCDIAZ332@MISENA.EDU.CO', 0),
(715, 'AGUDELO MONTIEL     ', 'ANDRES FELIPE       ', '3016210026  ', 'ANDRES_971018@HOTMAIL.COM', 0),
(716, 'BADILLO OBANDO      ', 'JUAN DANIEL         ', '5716021783  ', 'JUAN.TECNICO.1997@HOTMAIL.COM', 0),
(717, 'OLIVERO GRANADO     ', 'ROMARIO ENRIQUE     ', '3208664728  ', 'REOLIVERO@MISENA.EDU.CO', 0),
(718, 'BOHADA AVILA        ', 'GERSON MAURICIO     ', '3186436955  ', 'GMBOHADA7@MISENA.EDU.CO', 0),
(719, 'GARCIA VERA         ', 'JAIRO ANDRES        ', '576962690   ', 'andresgar_23@hotmail.com', 0),
(720, 'SAAVEDRA RODRIGUEZ  ', 'CARLOS ANDRES       ', '3174943220-3', 'CANDRES_0317@HOTMAIL.COM', 0),
(721, 'TORRES MIRANDA      ', 'MAYERLY PAOLA       ', '314 402 01 9', 'MAPAOMPTM@HOTMAIL.COM', 0),
(722, 'RAMIREZ PEREZ       ', 'YULY TATIANA        ', '3165340721  ', 'tatahkl@hotmail.com', 0),
(723, 'LEON AMAYA          ', 'LINA VANESA         ', '3157859856  ', 'LINALEON_1804@HOTMAIL.COM', 0),
(724, 'HERRERA VILLAMIZAR  ', 'ANDREA JOHANA       ', '3166767894  ', '26NOVEMBERRAIN@GMAIL.COM', 0),
(725, 'CRISTANCHO SIERRA   ', 'NIXON DUVAN         ', '3168955335 6', 'ndcristancho2@misena.edu.co', 0),
(726, 'MARTINEZ BLANCO     ', 'NYDIA DENISE        ', '3114994596  ', 'lunidanita@gmail.com', 0),
(727, 'CAMACHO PAVA        ', 'BELSY               ', '3172783401  ', 'ladagor06@hotmail.com', 0),
(728, 'AYALA DURAN         ', 'WILMAR LEANDRO      ', '3213028321  ', 'WILMARLEANDRO28@HOTMAIL.COM', 0),
(729, 'RODRIGUEZ BUENO     ', 'LEIDY KATHERINE     ', '6544054 -315', 'leidykate_97@hotmail.com', 0),
(730, 'MOLINA DIAZ         ', 'YURANY KATHERINE    ', '3209629658  ', 'YULIKATHE99@HOTMAIL.COM', 0),
(731, 'ALFONSO VALENCIA    ', 'MARYURI             ', '3102393675  ', 'MARAVAL_1@HOTMAIL.COM', 0),
(732, 'GOMEZ CRUZ          ', 'ALCIRA PATRICIA     ', '3017993816  ', 'PATRICIAG07@GMAIL.COM', 0),
(733, 'RODRIGUEZ CHAPARRO  ', 'JULIAN STEVEN       ', '3133985251  ', 'stevenchaparro2006@gmail.com', 0),
(734, 'GARCES BAYONA       ', 'LEIDY YAZMIN        ', '3156437799  ', 'leidysagitario_91@hotmail.com', 0),
(735, 'SANABRIA RODRIGUEZ  ', 'JULIAN ANDREE       ', '6441001.3174', 'JASANABRIA137@MISENA.EDU.CO', 0),
(736, 'VASQUEZ AGUDELO     ', 'MARIA DE LOS ANGELES', '3045885623  ', 'MARIAVASQUEZ664@GMAIL.COM', 0),
(737, 'MEJIA VILLAMIZAR    ', 'MAYRA ALEJANDRA     ', '5716981802  ', 'girlsbaby2008@live.com', 0),
(738, 'CORTES MENDEZ       ', 'JHON ALEXANDER      ', '6313037     ', 'JHONCORTES0627@GMAIL.COM', 0),
(739, 'POVEDA CARDENAS     ', 'KAREN JOHANA        ', '573017903504', 'poveda-johana14@hotmail.com', 0),
(740, 'BELTRAN DIAZ        ', 'ANGIE MELISSA       ', '311 761 2331', 'angiediaz172@gmail.com', 1),
(741, 'QUIÑONES GALVIS     ', 'ZOILA ROSA          ', '3183888726  ', 'MILENQUI28@GMAIL.COM', 0),
(742, 'MARTINEZ DUARTE     ', 'ANGIE PAOLA         ', '3133207036  ', 'ANGIEDUARTEPAOLA@OUTLOOK.ES', 0),
(743, 'RAMIREZ MOSQUERA    ', 'JHON FREDY          ', '573223783919', 'jhonramirez_97@hotmail.com', 0),
(744, 'NEIRA PINTO         ', 'LUIS FERNANDO       ', '3186430836  ', 'LFNEIRA0@MISENA.EDU.CO', 0),
(745, 'ARENAS MALDONADO    ', 'LUDY YESENIA        ', '3156337540  ', 'LUDYARENAS98@GMAIL.COM', 0),
(746, 'GARCIA MEZA         ', 'DIANA MARCELA       ', '3112445785  ', 'DJKM@MISENA.EDU.CO', 0);

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
(1, 'SENNOVA', 'Antioquia', '4228979', 'sennova@misena.edu.co'),
(2, 'HEXCASD', 'ASDAS', '123123123', 'asd@gmsad.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_comite`
--

CREATE TABLE `tbl_comite` (
  `id_comite` int(11) NOT NULL,
  `fk_programacion` int(11) NOT NULL,
  `fk_instructor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `tbl_comite`
--

INSERT INTO `tbl_comite` (`id_comite`, `fk_programacion`, `fk_instructor`) VALUES
(1, 14, 1),
(2, 14, 2),
(3, 14, 3),
(4, 14, 4),
(5, 15, 1),
(6, 15, 2),
(7, 16, 1),
(8, 16, 2),
(9, 16, 3),
(10, 98, 2),
(11, 98, 3);

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
(6, 1, 1),
(7, 5, 1),
(8, 6, 2),
(9, 7, 2),
(10, 8, 2),
(12, 9, 2),
(13, 664, 1),
(14, 665, 1),
(15, 666, 1),
(16, 667, 1),
(17, 668, 1),
(18, 669, 1),
(19, 664, 19),
(20, 665, 19),
(21, 666, 19),
(22, 697, 19),
(23, 698, 19),
(24, 699, 19),
(25, 700, 19),
(26, 701, 19),
(27, 702, 19),
(28, 703, 19),
(29, 704, 19),
(30, 705, 19),
(31, 706, 19),
(32, 740, 19),
(33, 667, 19),
(34, 668, 19),
(35, 669, 19),
(36, 670, 19),
(37, 671, 19);

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
(6, 1, 4),
(7, 5, 4),
(8, 6, 6),
(9, 7, 6),
(11, 8, 5),
(13, 664, 71),
(14, 665, 71),
(15, 666, 71),
(16, 667, 71),
(17, 668, 71),
(18, 669, 71),
(19, 670, 71),
(20, 671, 71),
(21, 697, 71),
(22, 698, 71);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_dtllevaluacion`
--

CREATE TABLE `tbl_dtllevaluacion` (
  `id_detalle` int(11) NOT NULL,
  `observacion` longtext NOT NULL,
  `fecha` date NOT NULL,
  `id_ficha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_dtllevaluacion`
--

INSERT INTO `tbl_dtllevaluacion` (`id_detalle`, `observacion`, `fecha`, `id_ficha`) VALUES
(1, 'la buena ', '2017-10-19', 4),
(2, 'la buena\n', '2017-10-19', 4),
(3, 'SI', '2017-10-19', 4),
(4, 'Errores fatales ', '2017-10-19', 4),
(5, 'funciono', '2017-10-19', 5),
(6, 'ajfsdfvsdfgsdhfsdfdfs', '2017-10-19', 4),
(7, 'cvcxcvc', '2017-10-19', 4),
(8, 'Faltan requisitos', '2017-11-02', 69),
(9, 'Perfecto!!!', '2017-11-10', 69),
(10, '¿Qué es Lorem Ipsum?\nLorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de t', '2017-11-10', 69),
(11, '¿Qué es Lorem Ipsum?\nLorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de t', '2017-11-10', 69),
(12, '¿Qué es Lorem Ipsum?\nLorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de t', '2017-11-10', 69),
(13, '¿Qué es Lorem Ipsum?\nLorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas \"Letraset\", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.\n\n¿Por qué lo usamos?\nEs un hecho establecido hace demasiado tiempo que un lector se distraerá con el contenido del texto de un sitio mientras que mira su diseño. El punto de usar Lorem Ipsum es que tiene una distribución más o menos normal de las letras, al contrario de usar textos como por ejemplo \"Contenido aquí, contenido aquí\". Estos textos hacen parecerlo un español que se puede leer. Muchos paquetes de autoedición y editores de páginas web usan el Lorem Ipsum como su texto por defecto, y al hacer una búsqueda de \"Lorem Ipsum\" va a dar por resultado muchos sitios web que usan este texto si se encuentran en estado de desarrollo. Muchas versiones han evolucionado a través de los años, algunas veces por accidente, otras veces a propósito (por ejemplo insertándole humor y cosas por el estilo).\n\n\n¿De dónde viene?\nAl contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo, haciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, \"consecteur\", en un pasaje de Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones 1.10.32 y 1.10.33 de \"de Finnibus Bonorum et Malorum\" (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", viene de una linea en la sección 1.10.32\n\nEl trozo de texto estándar de Lorem Ipsum usado desde el año 1500 es reproducido debajo para aquellos interesados. Las secciones 1.10.32 y 1.10.33 de \"de Finibus Bonorum et Malorum\" por Cicero son también reproducidas en su forma original exacta, acompañadas por versiones en Inglés de la traducción realizada en 1914 por H. Rackham.\n\n¿Dónde puedo conseguirlo?\nHay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem Ipsum, necesitás estar seguro de que no hay nada avergonzante escondido en el medio del texto. Todos los generadores de Lorem Ipsum que se encuentran en Internet tienden a repetir trozos predefinidos cuando sea necesario, haciendo a este el único generador verdadero (válido) en la Internet. Usa un diccionario de mas de 200 palabras provenientes del latín, combinadas con estructuras muy útiles de sentencias, para generar texto de Lorem Ipsum que parezca razonable. Este Lorem Ipsum generado siempre estará libre de repeticiones, humor agregado o palabras no características del lenguaje, etc.', '2017-11-10', 69),
(14, 'asdasd', '2017-11-10', 69);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_dtllproyecto`
--

CREATE TABLE `tbl_dtllproyecto` (
  `id_dtllProyecto` int(11) NOT NULL,
  `Url` varchar(50) NOT NULL,
  `id_ficha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_dtllproyecto`
--

INSERT INTO `tbl_dtllproyecto` (`id_dtllProyecto`, `Url`, `id_ficha`) VALUES
(44, './uploads/Libro1.xlsx', 69),
(45, './uploads/Lista Intructores.xlsx', 70),
(46, './uploads/Comit.pdf', 69),
(47, './uploads/contratos_sena (1).xlsx', 71),
(48, './uploads/', 71),
(49, './uploads/', 71),
(50, './uploads/', 71),
(51, './uploads/Artículo_SAM_CIENTECG (1) (1).docx', 71);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_dtllproyectoprogra`
--

CREATE TABLE `tbl_dtllproyectoprogra` (
  `id_detalle` int(11) NOT NULL,
  `id_ficha` int(11) NOT NULL,
  `id_programacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_dtllproyectoprogra`
--

INSERT INTO `tbl_dtllproyectoprogra` (`id_detalle`, `id_ficha`, `id_programacion`) VALUES
(26, 4, 14),
(27, 4, 15),
(28, 5, 15),
(29, 4, 16),
(30, 5, 16),
(31, 4, 17),
(32, 5, 17),
(33, 4, 18),
(34, 5, 18),
(35, 4, 19),
(36, 5, 19),
(37, 69, 20),
(38, 69, 21),
(39, 69, 28),
(40, 69, 39),
(41, 69, 40),
(42, 69, 41),
(43, 69, 42),
(44, 69, 48),
(45, 69, 49),
(46, 69, 51),
(47, 70, 52),
(48, 69, 63),
(49, 69, 64),
(50, 69, 65),
(51, 69, 66),
(52, 69, 67),
(53, 69, 72),
(54, 70, 76),
(55, 69, 76),
(56, 69, 76),
(57, 70, 76),
(58, 69, 76),
(59, 70, 76),
(60, 70, 77),
(61, 70, 78),
(62, 70, 79),
(63, 70, 80),
(64, 69, 81),
(65, 70, 81),
(66, 70, 82),
(67, 70, 83),
(68, 69, 85),
(69, 70, 85),
(70, 69, 85),
(71, 70, 85),
(72, 69, 86),
(73, 70, 86),
(74, 69, 87),
(75, 70, 87),
(76, 69, 89),
(77, 70, 89),
(78, 69, 89),
(79, 70, 89),
(80, 69, 94),
(81, 70, 94),
(82, 69, 95),
(83, 70, 95),
(84, 70, 96),
(85, 69, 97),
(86, 70, 97),
(87, 69, 98),
(88, 70, 98);

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
(19, '1231231', 3, '2018-01-02', '2020-01-02'),
(20, '23423432', 2, '2017-01-01', '2019-01-02'),
(21, '2147483647', 2, '2018-01-02', '2018-01-01');

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
  `observacion` longtext NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_fichaGrupo` int(11) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_fichaproyecto`
--

INSERT INTO `tbl_fichaproyecto` (`id_ficha`, `titulo`, `obj_general`, `Url`, `version`, `observacion`, `id_cliente`, `id_fichaGrupo`, `estado`) VALUES
(69, 'SAM', 'JFUDFSDJ', './uploads/Comit.pdf', '1', 'asdasd', 1, 17, 2),
(70, '22222222222222', 'aasdas', './uploads/Lista Intructores.xlsx', '1', '', 2, 16, 1),
(71, 'hopla', 'esdfsd', './uploads/Artículo_SAM_CIENTECG (1) (1).docx', '1', '', 1, 19, 1);

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
(2, 'werwer', 'werwer', '70812963', 'jepulgarin16@misena.edu.co'),
(3, 'Alejandro ', 'Pérez', '70812963', 'juanestebanpulgarin.a@gmail.com');

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
-- Volcado de datos para la tabla `tbl_programacioncomite`
--

INSERT INTO `tbl_programacioncomite` (`id_programacion`, `titulo`, `fecha`, `hora`, `lugar`, `estado`) VALUES
(77, 'sadasdasd', '2017-01-01', '00:00:00', 'dfdgdf', 0),
(78, 'sdfsdf', '2018-01-01', '00:00:00', 'fgfgd', 0),
(79, 'asdasd', '2017-01-01', '00:01:00', 'dsdsdsddssd', 0),
(80, 'dassdasd', '2018-01-01', '01:01:00', 'sdfsdfsdf', 0),
(81, 'dsfsdfdsf', '2017-01-01', '00:00:00', 'dfgdfgdfg', 0),
(82, 'prueba', '2017-01-01', '00:01:00', 'funciono', 0),
(83, 'xasdasd', '2017-01-01', '01:01:00', 'vvbcv', 0),
(84, 'asdasd', '2018-01-01', '03:01:00', 'dfsdfds', 0),
(85, 'asdasd', '2018-01-01', '03:01:00', 'dfsdfds', 0),
(86, 'sdasdsd', '2018-01-01', '01:00:00', 'gfdfgdf', 0),
(87, 'hgghjghj', '2018-01-01', '01:01:00', 'hggfhgfhgf', 0),
(88, 'asdasd', '2017-01-01', '02:01:00', 'asdasd', 0),
(89, 'asdasd', '2017-01-01', '02:01:00', 'asdasd', 0),
(90, 'ghgfhf', '2017-01-01', '02:02:00', 'dfgdfgdf', 0),
(91, 'tertret', '2017-01-01', '02:02:00', 'fthgfhgfhg', 0),
(92, 'hjkhjhj', '2017-01-01', '02:02:00', 'rerrete', 0),
(93, 'hjkhjhj', '2017-01-01', '02:02:00', 'rerrete', 0),
(94, 'sasdass', '2018-01-01', '01:01:00', 'fsfsfssd', 0),
(95, 'asdasd', '2018-01-01', '01:01:00', 'trty', 0),
(96, 'sadasdas', '2018-01-01', '00:01:00', 'lhkuhkhj', 0),
(97, 'sdfsdf', '2018-01-01', '01:00:00', 'sdfdfsd', 0),
(98, 'Prueba', '2018-03-02', '11:03:00', 'Torre norte', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `contrasena` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`id`, `usuario`, `contrasena`) VALUES
(1, 'prueba', '123'),
(2, 'practicante', '123456'),
(3, 'administrador', '123456');

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
-- Indices de la tabla `tbl_dtllevaluacion`
--
ALTER TABLE `tbl_dtllevaluacion`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_ficha` (`id_ficha`);

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
-- Indices de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_aprendiz`
--
ALTER TABLE `tbl_aprendiz`
  MODIFY `id_aprendiz` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=747;
--
-- AUTO_INCREMENT de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `tbl_comite`
--
ALTER TABLE `tbl_comite`
  MODIFY `id_comite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesaprendizgrupo`
--
ALTER TABLE `tbl_detallesaprendizgrupo`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT de la tabla `tbl_detallesaprendizproyecto`
--
ALTER TABLE `tbl_detallesaprendizproyecto`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT de la tabla `tbl_dtllevaluacion`
--
ALTER TABLE `tbl_dtllevaluacion`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT de la tabla `tbl_dtllproyecto`
--
ALTER TABLE `tbl_dtllproyecto`
  MODIFY `id_dtllProyecto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
--
-- AUTO_INCREMENT de la tabla `tbl_dtllproyectoprogra`
--
ALTER TABLE `tbl_dtllproyectoprogra`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;
--
-- AUTO_INCREMENT de la tabla `tbl_estados`
--
ALTER TABLE `tbl_estados`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tbl_fichagrupo`
--
ALTER TABLE `tbl_fichagrupo`
  MODIFY `id_fichaGrupo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT de la tabla `tbl_fichaproyecto`
--
ALTER TABLE `tbl_fichaproyecto`
  MODIFY `id_ficha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;
--
-- AUTO_INCREMENT de la tabla `tbl_instructores`
--
ALTER TABLE `tbl_instructores`
  MODIFY `id_instructor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tbl_programacioncomite`
--
ALTER TABLE `tbl_programacioncomite`
  MODIFY `id_programacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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
-- Filtros para la tabla `tbl_dtllevaluacion`
--
ALTER TABLE `tbl_dtllevaluacion`
  ADD CONSTRAINT `tbl_dtllevaluacion_ibfk_1` FOREIGN KEY (`id_ficha`) REFERENCES `tbl_fichaproyecto` (`id_ficha`);

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
