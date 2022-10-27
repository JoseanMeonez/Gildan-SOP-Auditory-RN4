-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-10-2022 a las 05:33:59
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sopdb`
--
CREATE DATABASE IF NOT EXISTS `sopdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sopdb`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_TMP_AUDIT_DETAIL` (`area` INT, `pos` INT, `sup` INT, `user` INT, `month` INT, `point_id` INT, `state_a` INT)  BEGIN
		DECLARE audit_id INT;
		DECLARE week INT;
		DECLARE fails INT;
		DECLARE passes INT;

		-- Setting variables
		SET audit_id = (SELECT Id_Auditoria FROM auditorias_tmp WHERE User_ID = user);
		SET week = (SELECT Semana FROM auditorias WHERE User_ID = user ORDER BY Id_Auditoria DESC LIMIT 1) + 1;


		IF audit_id > 0 THEN
			-- Inserting details
			INSERT INTO detalle_auditoria_tmp(Nro_auditoria, Posicion_id, Supervisor, User_ID, Punto_Auditado, Estado)
			VALUES(audit_id, pos, sup, user, point_id, state_a);

			-- Setting counting
			SET fails = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 0 AND User_ID = user);
			SET passes = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 1 AND User_ID = user);
			
			-- Updating audit table
			UPDATE auditorias_tmp a SET a.Pasa = passes, a.Falla = fails;
		ELSE
			-- Creating tmp audit
			INSERT INTO auditorias_tmp(Supervisor_ID, User_ID, Fecha, Semana, Mes, Area_ID, Pasa, Falla, Resultado, Status)
			VALUES (sup, user, NOW(), week, month, area,0,0,0,1);

			-- Updating audit id
			SET audit_id = (SELECT Id_Auditoria FROM auditorias_tmp WHERE User_ID = user);

			-- Inserting details
			INSERT INTO detalle_auditoria_tmp(Nro_auditoria, Posicion_id, Supervisor, User_ID, Punto_Auditado, Estado)
			VALUES(audit_id, pos, sup, user, point_id, state_a);

			-- Setting counting
			SET fails = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 0 AND User_ID = user);
			SET passes = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 1 AND User_ID = user);

			-- Updating audit table
			UPDATE auditorias_tmp a SET a.Pasa = passes, a.Falla = fails;
		END IF;

  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_TMP_IMAGE` (`image_name` VARCHAR(255), `user` INT, `area` INT)  BEGIN
		DECLARE audit_id INT;

		SET audit_id = (SELECT Id_Auditoria FROM auditorias_tmp WHERE User_ID = user AND Area_ID = area);

		IF audit_id > 0 THEN
			INSERT INTO images_tmp(Image_name, Audit_ID, User_ID) VALUES(image_name, audit_id, user);
			SELECT 1;
		ELSE
			SELECT 0;
		END IF;

  END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `Area_ID` int(11) NOT NULL,
  `Area_Nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`Area_ID`, `Area_Nombre`) VALUES
(1, 'KNITTING'),
(2, 'BOARDING'),
(3, 'DYEING'),
(4, 'FADIS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditorias`
--

CREATE TABLE `auditorias` (
  `Id_Auditoria` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Fecha` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `Semana` varchar(50) DEFAULT NULL,
  `Mes` varchar(50) DEFAULT NULL,
  `Area_ID` int(11) NOT NULL,
  `Pasa` int(11) DEFAULT NULL,
  `Falla` int(11) DEFAULT NULL,
  `Resultado` double DEFAULT NULL,
  `Status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `auditorias`
--

INSERT INTO `auditorias` (`Id_Auditoria`, `User_ID`, `Fecha`, `Semana`, `Mes`, `Area_ID`, `Pasa`, `Falla`, `Resultado`, `Status`) VALUES
(1, 1, '2022-10-23 18:40:41', '2', '10', 1, 1, 0, 0.98, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditorias_tmp`
--

CREATE TABLE `auditorias_tmp` (
  `Id_Auditoria` int(11) NOT NULL,
  `Supervisor_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Fecha` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `Semana` varchar(50) DEFAULT NULL,
  `Mes` varchar(50) DEFAULT NULL,
  `Area_ID` int(11) NOT NULL,
  `Pasa` int(11) DEFAULT NULL,
  `Falla` int(11) DEFAULT NULL,
  `Resultado` double DEFAULT NULL,
  `Status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_auditoria`
--

CREATE TABLE `detalle_auditoria` (
  `Detalle_ID` int(11) NOT NULL,
  `Auditoria_ID` int(11) NOT NULL,
  `Posicion_ID` int(11) DEFAULT NULL,
  `Supervisor_ID` int(11) DEFAULT NULL,
  `Area_ID` int(11) DEFAULT NULL,
  `Punto_ID` int(11) DEFAULT NULL,
  `Estado` int(11) DEFAULT NULL,
  `Imagen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_auditoria`
--

INSERT INTO `detalle_auditoria` (`Detalle_ID`, `Auditoria_ID`, `Posicion_ID`, `Supervisor_ID`, `Area_ID`, `Punto_ID`, `Estado`, `Imagen`) VALUES
(1, 1, 1, 1, 2, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_auditoria_tmp`
--

CREATE TABLE `detalle_auditoria_tmp` (
  `Detalle_id` int(11) NOT NULL,
  `Nro_auditoria` int(11) NOT NULL,
  `Posicion_id` int(11) NOT NULL,
  `Supervisor` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Punto_Auditado` int(11) NOT NULL,
  `Estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `images_tmp`
--

CREATE TABLE `images_tmp` (
  `Image_ID` int(11) NOT NULL,
  `Image_name` varchar(255) NOT NULL,
  `Audit_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posiciones`
--

CREATE TABLE `posiciones` (
  `Posicion_ID` int(11) NOT NULL,
  `Area_ID` int(11) NOT NULL,
  `Posicion_Desc` varchar(80) NOT NULL,
  `Status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `posiciones`
--

INSERT INTO `posiciones` (`Posicion_ID`, `Area_ID`, `Posicion_Desc`, `Status`) VALUES
(1, 1, 'ASISTENTE DE PRODUCCION (ETECH)', 1),
(2, 1, 'BIOSEGURIDAD', 1),
(3, 1, 'CALIDAD', 1),
(4, 1, 'Cambiador de estilo', 1),
(5, 1, 'ENCONADOR DE LINEA ( CREELER)', 1),
(6, 1, 'Mantenimiento', 1),
(7, 1, 'OPERADOR DE DINEMA', 1),
(8, 1, 'OPERADOR DE TEJIDO', 1),
(9, 1, 'PINTRUCK', 1),
(10, 1, 'PRODUCCION GENERAL', 1),
(11, 1, 'Producto No Conforme', 1),
(12, 1, 'TECNICO DE TEJIDO', 1),
(13, 1, 'UTILITARIO DE TEJIDO', 1),
(14, 2, 'ÁREA DE PALLET FINAL', 1),
(15, 2, 'ASISTENTE DE OPERACIONES Y EQUIPO', 1),
(16, 2, 'ASISTENTE DE PRODUCCIÓN', 1),
(17, 2, 'BIOSEGURIDAD', 1),
(18, 2, 'Calidad', 1),
(19, 2, 'HOUSE KEEPING Y SEGURIDAD', 1),
(20, 2, 'MANTENIMIENTO', 1),
(21, 2, 'METALES', 1),
(22, 2, 'PLANNING', 1),
(23, 2, 'PROCESOS', 1),
(24, 2, 'Producto No Conforme', 1),
(25, 2, 'STICKER', 1),
(26, 2, 'SUPERVISOR DE PRODUCCIÓN', 1),
(27, 2, 'Trazabilidad - Escaneos Irregular / Scrap', 1),
(28, 3, 'Área de Químicos y Colorantes', 1),
(29, 3, 'Asistente de Aduanas  Dyeing - Planning', 1),
(30, 3, 'Asistente de Producción', 1),
(31, 3, 'BIOSEGURIDAD', 1),
(32, 3, 'CALIDAD', 1),
(33, 3, 'Mantenimiento', 1),
(34, 3, 'Operador de Flainox', 1),
(35, 3, 'Operador de Secadora de Flainox', 1),
(36, 3, 'Operador de Secadora de Túnel', 1),
(37, 3, 'Operador de Túnel', 1),
(38, 3, 'Proceso', 1),
(39, 3, 'Producto No Conforme', 1),
(40, 3, 'Seguridad', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntos`
--

CREATE TABLE `puntos` (
  `Punto_ID` int(11) NOT NULL,
  `Area_ID` int(11) NOT NULL,
  `Posicion_ID` int(11) NOT NULL,
  `No_punto` int(11) NOT NULL,
  `Descripcion` text NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `puntos`
--

INSERT INTO `puntos` (`Punto_ID`, `Area_ID`, `Posicion_ID`, `No_punto`, `Descripcion`, `status`) VALUES
(1, 1, 5, 1, 'Estan las filetas de las líneas abastecidas unicamente con la cantidad y tipo de hilazas que requiere el estilo en produccción de acuerdo a las especificaciones según el estilo en proceso ? ', 1),
(2, 1, 5, 2, 'Se realiza el amarre entre hilaza respetando 1/4 plg la cola del sobrante y haciendo el corte con el clip ?', 1),
(3, 1, 5, 3, 'Estan las filetas abastecidas de acuerdo a reglas de abastecimiento? Algodones con relevo. Poly-Nylon, Colocar relevo a 1 pulg de consumirse/finalizar el cono en proceso. Elasticos con relevo, a excepción del que trabaja en cierre de punta. Mezcla de lotes de hilaza', 1),
(4, 1, 5, 4, 'Están los pines ( Amarillos) de las filetas completos y en buen estado?', 1),
(5, 1, 5, 5, 'Están las filetas de la línea limpias y Ordenadas ?(libre de calcetines amarrados en pines, tubos o tapaderas de filetas, calcetines en el piso, hilazas y/o conos vacíos en piso, otros objetos, hilazas libres de acumulación de tamo) ', 1),
(6, 1, 5, 6, 'Está el enconador realizando el proceso de descole de hilaza? Tamaño de la cola, debe ser del largo de grosor del cono, como punto maximo la orilla del cono de hilaza.', 1),
(7, 1, 5, 7, 'Está el Enconador utilizando el equipo de protección personal?', 1),
(8, 1, 5, 8, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador? (Subirse en filetas realizar el abastecimiento de hilaza, sobrecarga troco (más de 60 conos).', 1),
(9, 1, 5, 9, 'Se esta colocando el cono de hilaza con la nariz hacia la parte interna del pin del troco de hilaza?', 1),
(10, 1, 8, 10, 'Tiene el operador de Tejido su Porta Herramienta Completo (Pinza, Clip, Enhebrador, Lápiz, Indicador de defectos, luz UV)?', 1),
(11, 1, 8, 11, 'Está colocado el ticket de producción en los slings con la información correcta y completa del estilo en proceso?', 1),
(12, 1, 8, 12, 'Se encuentra el codigo de barra del operador pegado en el ticket de produccion ?', 1),
(13, 1, 8, 13, 'Está el Operador realizando correctamente la secuencia de ronda del metodo operativo? (Secuencia lineal y atendiendo paros de 8 máquinas a la redonda).', 1),
(14, 1, 8, 14, 'Está el Operador revisando la cantidad de piezas definida por maquina (7 piezas), según método operativo?', 1),
(15, 1, 8, 15, 'Están las máquinas limpias (libre de acumulación de tamo en sensores, tubos de los guia hilos, platillos tensionadores, ceramicas).Se observa que se realiza con la frecuencia establecida la ronda de sopleteo.', 1),
(16, 1, 8, 16, 'Esta el Operador de Tejido cumpliendo con la ronda de medición en máquina y utilizando el método de medición correcto?', 1),
(17, 1, 8, 17, 'Está el Operador de Tejido cumpliendo con la ronda de medición en horma Nahm?', 1),
(18, 1, 8, 18, 'Está la bolsa de irregulares con producción clasificada correctamente?', 1),
(19, 1, 8, 19, 'Se encuentra el sling libre de calcetas en su depósito para la hoja de ruta o en la base del sling? Base del sling libre de objetos y libre de calcetines amarrados en tubos.', 1),
(20, 1, 8, 20, 'Está la máquina enhebrada de la  forma correcta? Devanadores, Sensores, yoyo, Grupo Recuperahilo, Guía Hilos de los alimentadores, Motor elástico, tapaderas del motor elástico están cerradas, Hilo del logo?', 1),
(21, 1, 8, 21, 'Permanece el tubo de succión limpio y libre de objetos?', 1),
(22, 1, 8, 22, 'Está el operador utilizando el equipo de protección personal?', 1),
(23, 1, 8, 23, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador?', 1),
(24, 1, 8, 24, '¿Está el Operador realizando el uso correcto de banderines?', 1),
(25, 1, 13, 25, 'Está el nivel de aceite adecuado según proceso? Mínimo: -2 Máximo: +3', 1),
(26, 1, 13, 26, 'Están las bombas para aceite selladas con sus tapones?', 1),
(27, 1, 13, 27, 'Están las máquinas limpias? Plato porta sensores, Guardas plásticos , Carter, Bomba de aceite, Tanque de aceite Devanadores, tubo de vacío, libre de derrame de aceite en piso?', 1),
(28, 1, 13, 28, 'Esta el interior de la máquina limpio y libre de objetos?', 1),
(29, 1, 13, 29, 'Se encuentra el Sling de Producción con estilos 100% Poly, cubiertos con su bolsa plástica?', 1),
(30, 1, 13, 30, 'Se encuentran slings con información fuera del set? (Identificados con su respectivo ticket de producción).', 1),
(31, 1, 13, 31, 'Se verifica que el ticket de producción corresponda al producto que contiene el saco?', 1),
(32, 1, 13, 32, 'Esta el Utilitario llenando el ticket de producción con la información correcta? (Código de Utilitario,# de Sling, el Peso correcto del lote)', 1),
(33, 1, 13, 33, 'Están los slings fuera del set, dentro del área delimitada?', 1),
(34, 1, 13, 34, 'Están los sling de producción en la estación de E-Tech con su debido ticket de producción?', 1),
(35, 1, 13, 35, 'Se está pesando correctamente los lotes de producción? (Colocación de la tara correcta, verificacion del peso completo del sling)', 1),
(36, 1, 13, 36, 'Se esta respetando el layout establecido para el producto en proceso de auditoria en el area de E-tech?', 1),
(37, 1, 13, 37, 'Están todos los trocos en el set debidamente tarados y en buen estado, llantas limpias libres de acumulacón de tamo?', 1),
(38, 1, 13, 38, 'Se encuentra la cantidad y tipo de sling correcto, segun el tipo de maquina ubicada en el set?', 1),
(39, 1, 13, 39, 'El utilitario arma los sling según procedimiento? (Cáñamo de 187 plg, Argollas de metal en la parte inferior y superior del sling, Extiende la tela roja o azul, inserta bolsa plástica al sling  en caso de poliéster y que este el sling que corresponde a la maquina.', 1),
(40, 1, 13, 40, 'Está el utilitario de tejido utilizando el equipo de protección personal?', 1),
(41, 1, 13, 41, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador? (Llevar mas de dos trocos con produccion o más de cuatro trocos vacíos).', 1),
(42, 1, 9, 42, 'Estan cubiertos los pallets de hilaza en área de abastecimiento, para garantizar la preservación de la hilaza? (Cada pallet debe tener su respectiva tapadera plástica/cartón)', 1),
(43, 1, 9, 43, 'Está el Pintruck utilizando el equipo de protección personal?', 1),
(44, 1, 9, 44, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del Operador?', 1),
(45, 1, 9, 45, 'Esta el pintruck colocando los materiales reciclados para Fadis, en las locaciones delimitadas en andenes?', 1),
(46, 1, 9, 46, 'Se encuentra el área de abastecimiento limpia y ordenada? (Libre de calcetines en el suelo, hilaza, conos vacíos, bolsas, cartones, etc, en el piso, báscula y pasillo)', 1),
(47, 1, 9, 47, 'Se encuentran los Traypacks, cartones colocados en el área delimitada en andenes  según el tipo y se respeta el nivel máximo para estibar?', 1),
(48, 1, 12, 48, 'Está el set cubierto, en los tiempos de receso del operador de tejido? (Revision de 2 pz y atención de luces)', 1),
(49, 1, 12, 49, 'Están activos los devanadores?  (Que funcione correctamente)', 1),
(50, 1, 12, 50, 'Está el freno del devanador en buen estado y en su posición correcta?', 1),
(51, 1, 12, 51, 'Se encuentra el envarillado y los devanadores de las maquinas en su posición correcta?', 1),
(52, 1, 12, 52, 'Los devanadores tienen en buen estado los plástico tensionador y  la cerámica en su parte inferior?', 1),
(53, 1, 12, 53, 'Están  Calibrados y activados los disparos de protección y abre lenguetas?', 1),
(54, 1, 12, 54, 'Las maquinas en paro se encuentra con su respectivo formato de Maquina en Paro, y llenado correctamente?', 1),
(55, 1, 12, 55, 'Están los sensores completos y  funcionando  correctamente (Cerámica del sensor, sensor de armadura de hilos en maquina G, platillos tensionadores y magnéticos) ? ', 1),
(56, 1, 12, 56, 'Se encuentran los rodos de elástico libres de acumulación de hilo y tamo?', 1),
(57, 1, 12, 57, 'Permanece la máquina con su pipa de succión y la manguera en buen estado, libre de fugas de vacio?', 1),
(58, 1, 12, 58, 'Se encuentra la maquina sin fugas de aire comprimido?', 1),
(59, 1, 12, 59, 'Se encuentra la manguera de sopleteo y pistola en buenas condiciones?', 1),
(60, 1, 12, 60, 'Se encuentran fugas del sistema de vacío en las campanas y sus tuberias?', 1),
(61, 1, 12, 61, 'Se encuentra la tubería (Envarillado) con sus respectivas cerámicas y en buen estado?', 1),
(62, 1, 12, 62, 'Están los guía Hilos con sus respectivas cerámicas y sus platillos tensionadores en buen estado?', 1),
(63, 1, 12, 63, 'Se encuentra instalado el atrapa hilo en la maquina de tejido?', 1),
(64, 1, 12, 64, 'Están los valores del alza cilindro de acuerdo a estándar?', 1),
(65, 1, 12, 65, 'Esta el set libre de metales? (Metales en el suelo, carrito del técnico, máquina, bases de los slings)', 1),
(66, 1, 12, 66, 'Se encuentran la máquinas con sus cables en buenas condiciones y empalmes respectivamente cubiertos?', 1),
(67, 1, 12, 67, 'Está el tecnico utilizando el equipo de protección personal?', 1),
(68, 1, 12, 68, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador? ', 1),
(69, 1, 12, 69, 'Se encuentran maquinas trabajando en F5 o F6, sin autorización de administración.', 1),
(70, 1, 12, 70, 'Las maquinas en F1, se encuentran con su respectivo codigo de paro ingresado en maquina?', 1),
(71, 1, 12, 71, 'Se encuentra la máquina con su respectivo foco conectado de alerta de paro?', 1),
(72, 1, 12, 72, 'Se esta cumpliendo con el matenimiento preventivo mensual en el set?', 1),
(73, 1, 12, 73, '¿Cuenta la máquina de Tejido cono los protectores de las partes en movimiento (Protector de cremayera, protector acrílico de motor elástico cerrado y en buen estado, protector de rifazador)', 1),
(74, 1, 12, 74, '¿Cuenta la máquina de Tejido con las guardas plásticas completas y en buen estado?', 1),
(75, 1, 12, 75, '¿Se encuentran los botones de emergencia, botones de encendido y apagado, botones de inicio y paro de máquina en buen estado?', 1),
(76, 1, 12, 76, '¿Se encuentran las ventiladoras de la máquina en buen estado? (Revisar flujo de aire)', 1),
(77, 1, 12, 77, '¿Se encuentran los sensores de las barreras de detección en buen estado? (Máquinas SXS)', 1),
(78, 1, 12, 78, '¿Se encuentra el Técnico de Tejido utilizando guantes cuando extrae del imán los metales recolectados?', 1),
(79, 1, 12, 79, '¿Se encuentra la máquina con su tensionador normal y tensionador neumático instalado en el alimentador extra (color)?', 1),
(80, 1, 3, 80, 'Se esta realizando dos rondas de recolección  de scrap en Tejido RN4?', 1),
(81, 1, 3, 81, 'Está el recolector de scrap utilizando el equipo de protección personal?', 1),
(82, 1, 3, 82, 'Está el recolector de scrap pesando el scrap por sku, y se asegura de registrar todo el scrap que encuentre en set o en piso de producción?', 1),
(83, 1, 3, 83, 'La Hoja de Alerta de Calidad se esta llenando correctamente (los datos generales del lote, el defecto, la maquinaria que genero el defecto y las firmas del departamento que genero el defecto, técnico y la firma del auditor).', 1),
(84, 1, 3, 84, 'La Hoja de Control de Rechazos se esta llenando correctamente (numero de lote, numero de hoja de alerta, estilo, color, fecha, con las respectivas firmas y la maquina que genero el defecto).', 1),
(85, 1, 3, 85, 'El Auditor de Calidad para Cambios de Estilo se asegura de validar que las máquinas de Cambios de Estilo se entreguen con el nivel de Calidad requerido.', 1),
(86, 1, 7, 86, 'Esta el Operador de Dinema corrigiendo la medida del cross stretch con el cable de la máquina?', 1),
(87, 1, 7, 87, 'Está el operador de dinema utilizando el equipo de protección personal?', 1),
(88, 1, 7, 88, 'Esta llenando correctamente el formato de registro de medidas?', 1),
(89, 1, 7, 89, 'Se está cumpliendo con el método de medición de máquinas? (Secuencia zig-zag, medición con regla y fit en Nahm de la última máquina por estilo del set)', 1),
(90, 1, 7, 90, 'Está el operador de dinema almacenando las medidas en la usb?', 1),
(91, 1, 7, 91, 'Se están imprimiendo las hojas de ruta según el color asignado por talla/programa?', 1),
(92, 1, 1, 92, 'Se esta asignando la hoja de ruta al sling por enviar (Frente al elevador) al momento del escaneo?', 1),
(93, 1, 1, 93, 'Se está cumpliendo con el orden y limpieza del area (Acumulación de lotes <Antiguedad mayor a 12 horas>, calcetines en el suelo, básculas despejadas)', 1),
(94, 1, 1, 94, 'Estan los lotes enviados a Seaming, en la locacion correspondiente ', 1),
(95, 1, 1, 95, 'Está el Asistente de producción verificando que los slings cumplan las condiciones operativas correctas? (Argolla correcta, cáñamo en buen estado, slings en buen estado, orejeras completas)', 1),
(96, 1, 1, 96, 'Se está revisando que la produccion en físico del sling coincida con la información del ticket de producción?', 1),
(97, 1, 6, 97, 'Están las bombas para aceite selladas con sus tapones?', 1),
(98, 1, 10, 98, 'Se están imprimiendo los tickets de producción según el color asignado por talla/programa?', 1),
(99, 1, 10, 99, 'Se encuentra el set de hormas Nahm para ronda de medición, en su lugar asignado en cada set del piso de producción?', 1),
(100, 1, 10, 100, 'Se encuentran cajas en los pasillos, sets y alrededores de tejido?', 1),
(101, 1, 10, 101, 'Estan cuadrando los kg de scrap reportados por calidad vrs. Lo que se ingresa en contenedor?', 1),
(102, 1, 10, 102, 'En el reporte de cuadraje de scrap, no se encuentra scrap de otras área sin identificar? ', 1),
(103, 1, 10, 103, 'Se encuentran lámparas en mal estado en el área de tejido?', 1),
(104, 1, 10, 104, '¿Está el acceso a los extintores y paneles eléctricos despejado?', 1),
(105, 1, 10, 105, 'El Supervisor de Producción esta realizando las rondas de verificación de House Keeping (cero derrames, orden y limpieza, otros )', 1),
(106, 1, 4, 106, 'Las maquinas que tuvieron cambios de estilo, fueron registradas y aprobadas por el auditor de calidad?', 1),
(107, 1, 4, 107, 'Se esta haciendo uso del checklist de cambio de estilo?', 1),
(108, 1, 4, 108, 'Los cambiadores de estilo entregan las máquinas con buena eficiencia y Calidad una vez que terminan de realizar el cambio', 1),
(109, 1, 11, 109, '¿Existe fisicamente el lote rechazado?', 1),
(110, 1, 11, 110, '¿Se encuentra el lote en la ubicacion establecida (area de rechazos)?', 1),
(111, 1, 11, 111, '¿Coincide el #Sling de la hoja de rechazo con el #Sling del lote en fisico?', 1),
(112, 1, 11, 112, '¿Coincide el estilo de la hoja de rechazo con el estilo del lote en fisico?', 1),
(113, 1, 11, 113, '¿Los lotes rechazados cumplen el periodo de tiempo establecido para su ubicacion en el area? (Duración máxima fuera del set: 4 dias de turno, a excepción de los lotes rechazados el ultimo dia de turno)', 1),
(114, 1, 11, 114, 'Permanece las puertas de los contenedores de scrap cerradas?', 1),
(115, 1, 11, 115, 'Estan las bolsas de scrap debidamente rotuladas?', 1),
(116, 1, 2, 116, 'Esta el operador utilizando la mascarilla de manera correcta?', 1),
(117, 1, 2, 117, 'Esta abastecido el kit de bioseguridad en la estacion?', 1),
(118, 1, 2, 118, 'Se esta cumpliendo con el metodo de limpieza en la estacion de trabajo ?', 1),
(119, 1, 2, 119, 'Se esta respetando el distanciamiento en las mesas ?', 1),
(120, 1, 2, 120, 'Se esta sanitizando el area de cafeteria despues de cada receso ?', 1),
(121, 2, 16, 1, '¿Está el asistente de producción devolviendo los materiales a bodega en la forma correcta? (No deben de existir materiales mezclados y el producto interno debe de coincidir con lo que dice la caja)', 1),
(122, 2, 16, 2, '¿El lote que se está procesando fue asignado a esa máquina por parte de Planning y corresponde a la orden asignada?', 1),
(123, 2, 16, 3, '¿El asistente está entregando las hojas de ruta correspondientes a los sling que se encuentran en físico?', 1),
(124, 2, 16, 4, '¿Se están colocando las hojas de ruta de manera ordenada y siguiendo la secuencia en la pizarra de trazabilidad ?', 1),
(125, 2, 16, 5, '¿Todas las hojas de ruta que se encuentran en la maquina cuentan con sus respectivos stickers de trazabilidad?', 1),
(126, 2, 16, 6, '¿Esta el asistente de produccion actualizando el # de sling / buggie /mini hooper en las hojas de ruta al momento de descargar lotes?', 1),
(127, 2, 16, 7, '¿Está el área de descarga libre de calcetines en el piso y la parte superior de la estructura de descarga?', 1),
(128, 2, 16, 8, '¿Se encuentran los gabinetes de hormas ordenados por tamaño o talla? (Tecnopea, Ghibli Sport, Ghibli HS, Ghibli 56)', 1),
(129, 2, 16, 9, '¿Está el asistente de producción empujando o halando los minihoppers y slings de acuerdo al instructivo de trabajo ?', 1),
(130, 2, 22, 10, '¿El DC Link esta validando que las hojas de ruta corresponden a los sling que recibe en físico?', 1),
(131, 2, 22, 11, '¿Se está colocando la hoja de ruta con su número de maquina en el estante de trazabilidad ubicado en la torre de E-Tech?', 1),
(132, 2, 22, 12, '¿Está el E-Tech generando la requisa en tiempo y forma para cada lote enviado a máquina? En caso que aplique, ¿Las requisas se están consolidando?', 1),
(133, 2, 22, 13, '¿Están firmados en tiempo y forma los paros que corresponden al área de Planeación?', 1),
(134, 2, 22, 14, '¿Esta el operador de bodega de trims colocando la fecha correcta a requisa electrónica según sticker de UPC/RFD', 1),
(135, 2, 22, 15, '¿Esta el operador de bodega de trims rebajando de formato de requisa electrónica la cantidad de materiales entregados a producción?', 1),
(136, 2, 23, 16, '¿Está el operador de planchado cumpliendo con su método operativo? Centrando los calcetines con las dos manos (punta con mano izquierda y talón con mano derecha) e inspeccionando la parte frontal de la calceta ?', 1),
(137, 2, 23, 17, '¿Está el operador de planchado clasificando correctamente el scrap e irregular y no se encuentran calcetas de primera en los clasificadores?', 1),
(138, 2, 23, 18, '¿El planchador se asegura de apagar el vapor al salir a receso (G56/ GSPORT)  / detener la maquina (Boarder) ?', 1),
(139, 2, 23, 19, '¿Hay calcetas caídas atrás de las bandejas de las maquinas?', 1),
(140, 2, 23, 20, '¿Está la estación de trabajo libre de calcetines en el piso?', 1),
(141, 2, 23, 21, '¿Están realizando el cambio de hormas de manera segura? (Deben realizarlo con guantes).', 1),
(142, 2, 23, 22, '¿El operador de doblado tiene la muestra y la ayuda visual del estilo que se está procesando?', 1),
(143, 2, 23, 23, '¿Está libre el operador de doblado de acumulación de calcetines planchados en su área?', 1),
(144, 2, 23, 24, '¿Está el operador de doblado clasificando correctamente el scrap e irregular y no se encuentran calcetas de primera en los clasificadores?', 1),
(145, 2, 23, 25, '¿El operador de doblado está realizando correctamente el método de doblado e inspección según especificación de estilo ?', 1),
(146, 2, 23, 26, '¿Esta el operador de banda revisando que los materiales son los correctos al estilo que se está produciendo?', 1),
(147, 2, 23, 27, '¿Está el operador de banda cumpliendo con su método operativo? (Colocación correcta del sticker, inspección de logos y verificando apariencia del paquete)', 1),
(148, 2, 23, 28, '¿Está el operador de banda retirando las irregulares y scrap de cada lote?', 1),
(149, 2, 23, 29, '¿Está el operador  colocando los stickers de trazabilidad en las bolsas de irregulares y scrap, así como en la hoja de producción de cada uno de los lotes procesados?', 1),
(150, 2, 23, 30, '¿Está el operador de banda colocando los materiales del estilo saliente en el lugar indicado? Entrada y salida de materiales', 1),
(151, 2, 23, 31, '¿Está el operador colocando el sticker de devolución de materiales a cada caja?', 1),
(152, 2, 23, 32, '¿Está el operador de pistola revisando que los materiales son los correctos al estilo que se está produciendo?', 1),
(153, 2, 23, 33, '¿Está el operador de pistola cumpliendo con su método operativo? Colocación de gancho, Hantag, Bala y verificando apariencia del paquete', 1),
(154, 2, 23, 34, '¿Esta el operador utilizando el acrílico protector de la pistola al realizar la operación?  ', 1),
(155, 2, 23, 35, '¿El operador de pistola coloca los paquetes en la banda del conveyor de la forma correcta? (El innerpack debe doblado y colocado en el centro de la banda).', 1),
(156, 2, 23, 36, '¿Está el operador de pistola actualizando la Pizarra MEASLES CHART y colocando el paquete de muestra?', 1),
(157, 2, 23, 37, '¿Esta el operador de pistola colocando el protector de agujas cuando no está en uso?', 1),
(158, 2, 23, 38, '¿Está el operador de empaque revisando que los materiales son los correctos al estilo que se está produciendo?', 1),
(159, 2, 23, 39, '¿Tiene el operador de empaque las viñetas del estilo que se está procesando en su máquina?', 1),
(160, 2, 23, 40, '¿Tiene el operador de empaque, el paquete de muestra del estilo que se está procesando en su máquinas?', 1),
(161, 2, 23, 41, '¿Está el operador de empaque colocando el número de máquina, código y turno en cada una de las cajas procesadas y revisando que la información de la viñeta coincida con el producto de la caja?', 1),
(162, 2, 23, 42, '¿Se encuentran actualizadas las pizarras de la estación de empaque con la información del estilo que se está procesando?', 1),
(163, 2, 23, 43, '¿Está la estación de trabajo libre de paquetes acumulados en su aréa? (Doblado, Banda, Pistola, Empaque)', 1),
(164, 2, 23, 44, '¿Esta el operador de empaque colocando el numero de viñeta de cada caja en el reporte diario?', 1),
(165, 2, 23, 45, '¿Se encuentra ordenada la estación de empaque y libre de materiales mal utilizados o en el suelo?', 1),
(166, 2, 23, 46, '¿Se encuentran los lotes en la locación correcta en sistema según corresponda (FNLT - BPWIP-REBP)?', 1),
(167, 2, 20, 47, '¿Está la maquina trabajando con los pares/hora según el ciclo que está corriendo y la tolerancia de +- 30 pares?', 1),
(168, 2, 20, 48, '¿Está la banda de la Boarding machine apilando ordenadamente los calcetines?', 1),
(169, 2, 20, 49, '¿Está el detector de metales funcionando correctamente?', 1),
(170, 2, 20, 50, '¿Todos los paros de emergencia de la maquina y conveyor están funcionando correctamente? (Botón de Stop - Cuerda de Emergencia)', 1),
(171, 2, 20, 51, '¿Están las maquinas en mantenimiento preventivo o correctivo con su respectivo enclavamiento de seguridad? (Cono, señalización, tarjeta Lockout/Tagout)', 1),
(172, 2, 20, 52, '¿La pistola de la estación de trabajo cuenta con su respectivo acrílico protector y está en buen estado?', 1),
(173, 2, 20, 53, '¿Se están utilizando correctamente las mangueras de aire comprimido, y no se presentan fugas en ella? (Solo para el funcionamiento en maquina y pistola) ', 1),
(174, 2, 20, 54, '¿Se encuentran las maquinas Steam (Ghibli Sport, Ghibli HS y Ghibli 56) libre de derrames de agua o fugas de agua en el suelo?', 1),
(175, 2, 20, 55, '¿Están firmados en tiempo y forma los paros que corresponden al área de Mantenimiento?', 1),
(176, 2, 20, 56, '¿Se encuentran los clasificadores metálicos en buen estado? (No se encuentran bordos filosos, ni en ninguna condición que represente un riesgo)', 1),
(177, 2, 20, 57, '¿Los cables eléctricos de las estaciones de trabajo se encuentran en buenas condiciones?', 1),
(178, 2, 20, 58, '¿Los hoppers / minihoppers se encuentran en buen estado? (no se presentan bordes filosos)', 1),
(179, 2, 20, 59, '¿Funcionan correctamente los paros de emergencia de la maquina Lantech? (Tanto el botón de stop como el brazo de disparo)', 1),
(180, 2, 20, 60, '¿La cuchilla de la selladora de cajas cuenta con el protector metálico? ', 1),
(181, 2, 20, 61, '¿Las Guardas de la estacion de empaque se encuentran en buen estado? (no se presentan bordes filosos)', 1),
(182, 2, 14, 62, '¿Está el paletizador estibando correctamente cada una de las cajas que componen  el mismo y colocando el slip sheet correctamente según como lo indica el instructivo de trabajo?', 1),
(183, 2, 14, 63, '¿Esta el paletizador completando los pallet máximo de dos máquinas por turno?', 1),
(184, 2, 14, 64, '¿Está el palletizador respetando la delimitación en el área?', 1),
(185, 2, 14, 65, '¿Está el palletizador respetando la altura máxima de estibamiento en slip sheet y tarimas? (Altura Maxima : 1.4m)', 1),
(186, 2, 14, 66, '¿Las tarimas se encuentran en buenas condiciones?', 1),
(187, 2, 25, 67, '¿Esta el asistente de impresion de etiquetas revisando que la calidad del sticker cumpla con los estandares y se encuentre legible?', 1),
(188, 2, 25, 68, '¿Esta el asistente de impresión de etiquetas colocando la cantidad entregada en formato de requisa?', 1),
(189, 2, 25, 69, '¿Esta el asistente de impresión de etiquetas revisando el inventario de sticker antes de imprimir nueva solicitud de sticker por producción?', 1),
(190, 2, 19, 70, '¿Está la estación de trabajo limpia y ordenada? (Debe de estar libre de hormas, libre de cajas mal utilizadas, basureros en su lugar y sin materiales de empaque en el suelo)', 1),
(191, 2, 19, 71, '¿Está el área de la detectora de metales, libre de paquetes en el piso?', 1),
(192, 2, 19, 72, '¿Están libre las áreas de condiciones o acciones inseguras que pongan en riesgo la integridad del operador?', 1),
(193, 2, 19, 73, '¿Cuenta los operadores con su alfombra ergonómica y se encuentran en un buen estado? ', 1),
(194, 2, 19, 74, '¿Las ramplas metálicas utilizadas en la estación de trabajo están en un buen estado? ', 1),
(195, 2, 19, 75, '¿Las ramplas metálicas que no estan en uso se encuentran en el lugar que corresponde segun delimitación? ', 1),
(196, 2, 21, 76, '¿Está la zona del detector de metales libres de metales? (Herramientas, metales en el suelo)', 1),
(197, 2, 21, 77, '¿Se encuentra el clip sujeto a él porta-clip en la máquina?', 1),
(198, 2, 21, 78, '¿Hay teléfonos celulares o reproductores de música en la estación? (El operador no debe de utilizar audífonos)', 1),
(199, 2, 21, 79, '¿Está la estación de empaque libre de metales? (Metales en el suelo, operadores sin aritos, pulseras, relojes, etc.)', 1),
(200, 2, 27, 80, '¿Se está colocando el Packing List en todos los lotes de Scrap?', 1),
(201, 2, 27, 81, '¿Esta el auditor auditando todos los lotes de Scrap?', 1),
(202, 2, 27, 82, '¿Se encuentra ingresado a trazabilidad la información de IRR/Scrap para los lotes producidos en maquina?', 1),
(203, 2, 27, 83, '¿Todos los lotes procesados tienen escaneados kg de defectos en maximo de tres horas?', 1),
(204, 2, 15, 84, '¿Está el asistente de operaciones y equipo retirando las viñetas de los estilos que ya no están corriendo en el piso de producción?', 1),
(205, 2, 15, 85, '¿Esta el Lantech utilizando el Pallet Jack de forma correcta según Instructivo deTrabajo?', 1),
(206, 2, 15, 86, '¿Está el asistente de operaciones y equipo actualizando cada cambio de estilo que se da en las maquinas?  ', 1),
(207, 2, 15, 87, '¿Está el asistente de operaciones y equipo entregando los pallet escaneados al area de Shipping?', 1),
(208, 2, 26, 88, '¿Está correcta la configuración de los equipos de acuerdo a matriz de metas?', 1),
(209, 2, 26, 89, '¿Está la maquina trabajando con el ciclo correcto (según silueta y talla del calcetín)?', 1),
(210, 2, 26, 90, '¿El supervisor está verificando los cambios de estilo según la especificación?', 1),
(211, 2, 26, 91, '¿Están firmados en tiempo y forma los paros que corresponden al área de Producción?', 1),
(212, 2, 26, 92, '¿El supervisor de produccion esta realizando las rondas de verificacion de house keeping y SOP en el piso de producción?', 1),
(213, 2, 18, 93, '¿Se encuentra la hoja de rechazo en el lote con la información completa?', 1),
(214, 2, 18, 94, '¿Se encuentran todos los lotes rechazados en el registro físico del auditor de calidad?', 1),
(215, 2, 18, 95, '¿Se encuentran todos los lotes rechazados con su respectiva bolsa de muestras?', 1),
(216, 2, 18, 96, '¿Están los cajones de los detectores de metales, libres de acumulación de paquetes rechazados?', 1),
(217, 2, 18, 97, '¿Están firmados en tiempo y forma los paros que corresponden al área de Calidad?', 1),
(218, 2, 18, 98, '¿Esta el auditor de calidad validando los cambios de estilo (firma en especificacion)?', 1),
(219, 2, 24, 99, '¿Existe físicamente el lote rechazado?', 1),
(220, 2, 24, 100, '¿Se encuentra el lote reparado con la Paleta ID, hoja de rechazo y formato de trims?', 1),
(221, 2, 24, 101, '¿Se encuentra el lote en la ubicación establecida (área de rechazos)?', 1),
(222, 2, 24, 102, '¿Se encuentran todos los lotes rechazados con su correcto estatus JDE REBP 01?', 1),
(223, 2, 17, 103, 'Esta el operador utilizando la mascarilla de manera correcta?', 1),
(224, 2, 17, 104, 'Esta abastecido el kit de bioseguridad en la estacion?', 1),
(225, 2, 17, 105, 'Se esta cumpliendo con el metodo de limpieza en la estacion de trabajo ?', 1),
(226, 2, 17, 106, 'Se esta respetando el distanciamiento en las mesas ?', 1),
(227, 2, 17, 107, 'Se esta sanitizando el area de cafeteria despues de cada receso ?', 1),
(228, 3, 30, 1, '¿Verifica que el ticket de producción coincida con la Producción en el saco?', 1),
(229, 3, 30, 2, '¿Recibe los  Lotes con su respectiva Knitting Traveler?  ', 1),
(230, 3, 30, 3, '¿El inventario de E-tech coincide con lo físico? ', 1),
(231, 3, 30, 4, '¿Están las estaciones de escaneo en funcionamiento y en buen estado? ', 1),
(232, 3, 30, 5, '¿Se encuentra limpia y ordenada el área de Storage & E-tech Dyeing? ', 1),
(233, 3, 30, 6, '¿Esta realizando la correcta asignacion de locacion de los lotes que recibe de tejido?', 1),
(234, 3, 30, 7, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador? ', 1),
(235, 3, 30, 8, '¿Se esta llenando la información básica de la hoja de ruta? ( nombre, código, turno, No. de sling, No. de buggie,  No. de maquina  teñidura / túnel,  No. De maquina secadora )', 1),
(236, 3, 37, 9, '¿Se encuentra la receta acorde con el programa que se encuentre procesando en el túnel?', 1),
(237, 3, 37, 10, '¿Esta el registro de titulación con los valores de pH del baño dentro del rango estándar? ', 1),
(238, 3, 37, 11, '¿Esta el registro de titulación con los valores de pH del peróxido de hidrogeno (H202) dentro del rango estándar? ', 1),
(239, 3, 37, 12, '¿Esta el registro de titulación con los valores de pH de la soda caustica (NAOH) dentro del rango estándar?', 1),
(240, 3, 37, 13, '¿Se encuentra el pH metro correctamente calibrado? ', 1),
(241, 3, 37, 14, '¿Está el pH final (Ultima recamara, pH de prensa) conforme al rango de especificación? ', 1),
(242, 3, 37, 15, '¿Se realiza la descarga de la maquina teniendo un lote en cola? ', 1),
(243, 3, 37, 16, '¿Está la mesa de pruebas/titulaciones con todos sus instrumentos de medición y en buen estado? (pH metro, ácido clorhídrico, permanganato de potasio, ácido sulfúrico) ', 1),
(244, 3, 37, 17, '¿Se encuentra el área de túnel limpia y ordenada? ', 1),
(245, 3, 37, 18, '¿Está el operador de túnel portando su equipo de protección personal? ', 1),
(246, 3, 37, 19, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador? ', 1),
(247, 3, 37, 20, '¿Se esta llenando la información básica de la hoja de ruta? ( nombre, código, turno, No. de sling, No. de maquina  teñidura / túnel,  No. De maquina secadora )', 1),
(248, 3, 36, 21, '¿Está el tiempo de secado de acuerdo al programa? ', 1),
(249, 3, 36, 22, '¿Se hace la prueba de  tonalidad después de cada ciclo, cada lote? (Deberá de estar en el reporte de producción) ', 1),
(250, 3, 36, 23, '¿El operador de secadora de túnel coloca el número de sling en la hoja de ruta? ', 1),
(251, 3, 36, 25, '¿Se encuentran limpia y ordenada el área de  secadora del túnel? ', 1),
(252, 3, 36, 26, '¿Se encuentran las bandas transportadoras de la secadora del tunel limpias, libres de calcetines atrapados entre las bandas transportadoras o calcetines en el suelo? ', 1),
(253, 3, 36, 27, '¿El operador de secadora de túnel coloca el sticker de calidad en la calceta? ', 1),
(254, 3, 36, 28, '¿Está el operador de secadora de túnel portando su equipo de protección personal?  ', 1),
(255, 3, 36, 29, '¿El operador de secadora realizando la asignacion correcta de locacion en el sistema JDE de todos los lotes que envia por el sistema de riel?', 1),
(256, 3, 36, 30, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador?  ', 1),
(257, 3, 36, 31, '¿Se esta llenando la información básica de la hoja de ruta? ( nombre, código, turno, No. de sling, No. de maquina  teñidura / túnel,  No. De maquina secadora ) ', 1),
(258, 3, 34, 32, '¿Tiene la maquina el programa adecuado para procesar el lote según color? ', 1),
(259, 3, 34, 33, '¿Se revisa el pH, colorante, y peróxido residual en colores claros y lo registrara en hoja de control de proceso?  ', 1),
(260, 3, 34, 34, '¿Se realiza la limpieza de filtros según procedimiento?', 1),
(261, 3, 34, 35, '¿Se encuentra el pH metro correctamente calibrado? ', 1),
(262, 3, 34, 36, '¿Se realiza la descarga de la maquina teniendo un lote en cola? ', 1),
(263, 3, 34, 37, '¿Está la mesa de pruebas con todos sus instrumentos de medición y en buen estado? (pH metro, probetas, hidrómetros o salometros, beaker) ', 1),
(264, 3, 34, 38, '¿Existen desperdicios de sal en las Flainox? ', 1),
(265, 3, 34, 39, '¿Está el tridente de descarga colocado en la posición correcta? ', 1),
(266, 3, 34, 40, '¿Se encuentra el área de Flainox limpia? (Bolsas de producción, calcetines dentro o alrededor de las máquinas, papeles en el suelo o alrededor, bolsas de sal) ', 1),
(267, 3, 34, 41, '¿Se encuentran limpias las vasijas y el tanque de reserva de las Flainox? ', 1),
(268, 3, 34, 42, '¿El operador de Flainox apunta el numero de maquina en el sticker de calidad?', 1),
(269, 3, 34, 43, '¿Está el operador de Flainox portando su equipo de protección personal? ', 1),
(270, 3, 34, 44, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador?', 1),
(271, 3, 34, 45, '¿Se esta llenando la información básica de la hoja de ruta? ( nombre, código, turno, No. de sling, No. de maquina  teñidura / túnel,  No. De maquina secadora ) ', 1),
(272, 3, 34, 46, 'El operador de flainox cuenta con la cuchilla para apertura de sacos en buenas condiciones (protector quebrado, cuchilla dañada, agarradera en mal estado)?', 1),
(273, 3, 34, 47, 'El operador de flainox se está asegurando que la introducción de los químicos se este llevando a cabo de forma correcta (revisión en máquina por 5 min)?', 1),
(274, 3, 35, 48, '¿Coincide el lote secado con la hoja de ruta?', 1),
(275, 3, 35, 49, '¿Tienen su respectiva hoja de ruta los lotes en espera para ser secados? ', 1),
(276, 3, 35, 50, '¿Se encuentra los lotes en el área delimitada para secado? ', 1),
(277, 3, 35, 51, '¿Se cumple con el requerimiento de no existir estilos mezclados en secadoras? ', 1),
(278, 3, 35, 52, '¿El operador de secadora de Flainox coloca el número de sling en la hoja de ruta? ', 1),
(279, 3, 35, 53, '¿Está el color conforme a estándar? ', 1),
(280, 3, 35, 54, '¿Se encuentra el área de secadoras de Flainox limpia y ordenada? ', 1),
(281, 3, 35, 55, '¿Se encuentran las bandas transportadoras de la secadora del tunel limpias, libres de calcetines atrapados entre las bandas transportadoras o calcetines en el suelo?', 1),
(282, 3, 35, 56, '¿El operador de secadora de Flainox coloca el sticker de calidad en la calceta? ', 1),
(283, 3, 35, 57, '¿Está el operador de Flainox portando su equipo de protección personal? ', 1),
(284, 3, 35, 58, '¿El operador de secadora realizando la asignacion correcta de locacion en el sistema JDE de todos los lotes que envia por el sistema de riel?', 1),
(285, 3, 35, 59, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador? ', 1),
(286, 3, 35, 60, '¿Se esta llenando la información básica de la hoja de ruta? ( nombre, código, turno, No. de sling, No. de maquina  teñidura / túnel,  No. De maquina secadora ) ', 1),
(287, 3, 33, 61, '¿Se encuentra el recubrimiento aislante de las tuberías de vapor en buen estado? ', 1),
(288, 3, 33, 62, '¿Están las maquinas en mantenimiento preventivo o correctivo con su respectivo enclavamiento de seguridad? ', 1),
(289, 3, 33, 63, '¿Están las perillas y botoneras de las maquinas en buen estado? ', 1),
(290, 3, 33, 64, '¿Está completa la tornillería de la maquina? ', 1),
(291, 3, 33, 65, '¿Se encuentran los paneles de las maquinas cerrados? ', 1),
(292, 3, 33, 66, '¿Están las canaletas de la maquina completas y en buen estado? ', 1),
(293, 3, 33, 67, '¿Están los manómetros de la maquina en buen estado? ', 1),
(294, 3, 33, 68, '¿Están los buggies en buen estado? ', 1),
(295, 3, 33, 69, '¿Están las tapaderas de drenaje completas y en buen estado? ', 1),
(296, 3, 33, 70, '¿Se cumple con el calendario de mantenimiento preventivo del área? ', 1),
(297, 3, 33, 71, '¿Mantenimiento hace entrega al supervisor de la maquina en preventivo?', 1),
(298, 3, 33, 72, '¿La caja de luces está en correctas condiciones y en buen estado? ', 1),
(299, 3, 33, 73, '¿El dispensador de químicos trabaja adecuadamente? ', 1),
(300, 3, 33, 74, '¿Está el tridente de descarga en perfectas condiciones? ', 1),
(301, 3, 33, 75, '¿Se encuentra personal de mantenimiento trabajando ordenadamente en el área? ', 1),
(302, 3, 33, 76, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador?', 1),
(303, 3, 28, 77, '¿Se trabaja con receta según estilo y color a procesar? ', 1),
(304, 3, 28, 78, '¿Se está pesando adecuadamente el colorante?', 1),
(305, 3, 28, 79, ' ¿Está funcionando el dispensador de QQ Softrol?', 1),
(306, 3, 28, 80, '¿Se están transportando las cubetas de químicos/colorantes en el troco asignado?', 1),
(307, 3, 28, 81, '¿Se están utilizando las cubetas de acuerdo a la especificación técnica de códigos de colores según químico? ', 1),
(308, 3, 28, 82, '¿Se encuentran dosificando las cantidades de químicos correctamente? (Calibración) ', 1),
(309, 3, 28, 83, '¿Está el área de químicos y colorantes limpia y ordenada? ', 1),
(310, 3, 28, 84, '¿Está usando el equipo de protección personal la persona que transporta los químicos? personal, delantal, careta, gafas selladas, guantes, mascarilla) ', 1),
(311, 3, 28, 85, '¿Está el personal del área de químicos y colorantes portando su equipo de protección? personal, delantal, careta, gafas selladas, guantes, mascarilla)', 1),
(312, 3, 28, 86, '¿Está libre el área de condiciones o acciones inseguras  que pongan en riesgo la integridad del operador?', 1),
(313, 3, 28, 87, 'El operador de quimicos esta utilizando un sola cubeta por quimico?', 1),
(314, 3, 28, 88, 'El operador de quimicos esta estibando de forma correcta las cubetas en el troco (quimicos peligrosos deberan colocarse en el primer nivel: hidrosulfito, peroxido  y soda caustica?) aplica para cubetas vacias', 1),
(315, 3, 28, 89, 'El operador de quimicos esta pesando la cantidad de kg permitidos por cada cubeta, máximo: 15 Kg por cubeta, aplica para todos los quimicos.', 1),
(316, 3, 28, 90, 'El operador de quimicos esta estibando las cubetas limpias en un nivel maximo de 1.35 m (10 cubetas) en el área asignada?', 1),
(317, 3, 28, 91, 'Se encuentra los químicos/colorantes con su respectiva tapadera o debidamente cerrados?', 1),
(318, 3, 28, 92, 'Se está rotulando el pesaje Soda ASH realizado en el área de químicos y colorantes?', 1),
(319, 3, 28, 93, 'El operador de colorantes esta colocando el numero de lote en el pesaje de los químicos a ingresar?', 1),
(320, 3, 28, 94, 'Verificar si las basculas de las áreas de pesado en químicos y colorantes se encuentra nivelada y en condiciones óptimas?', 1),
(321, 3, 40, 95, '¿Se encuentran en condiciones óptimas y despejadas la ducha de seguridad en caso de emergencia? ', 1),
(322, 3, 40, 96, '¿Está el hidro sulfito en un armario libre de humedad? ', 1),
(323, 3, 40, 97, '¿Se encuentran las salidas de emergencia señalizadas de forma visible en el área?', 1),
(324, 3, 40, 98, '¿Están los extintores, paneles eléctricos, alarmas y lava ojos despejados y en perfectas condiciones?', 1),
(325, 3, 40, 99, '¿Está el personal de teñido haciendo uso de teléfonos celulares/reproductores de música?  ', 1),
(326, 3, 40, 100, '¿Las tuberías se encuentran libres de fugas de vapor? ', 1),
(327, 3, 40, 101, ' ¿Se encuentra en condiciones optimas el paro de emergencias del volcador?  ', 1),
(328, 3, 40, 102, ' ¿Se encuentra en buen estado el sensor fotoelectrico del transportador de descarga? ', 1),
(329, 3, 40, 103, ' ¿Se encuentra en condiciones óptimas el sensor de paro por movimiento del transportador de descarga, al momento de ingresar  el área del volcador? ', 1),
(330, 3, 40, 104, '¿Se está realizando verficacion operativa del paro de emergencia en la maquina Flainox? (Evaluar en el mantto preventivo)', 1),
(331, 3, 40, 105, '¿Esta en buen estado el paro de emergencia en la maquina Secadora? (Evaluar en el mantto preventivo)', 1),
(332, 3, 40, 106, '¿El asistente de aduanas Dyeing esta tomando los calcetines de muestra de forma correcta del sling (utilizacion de pinza)?', 1),
(333, 3, 40, 107, '¿El auditor de Calidad en Dyeing esta tomando los calcetines de muestra de forma correcta del sling (utilizacion de pinza)?', 1),
(334, 3, 40, 108, '¿El operador de secadora se esta asegurando del correcto armado del sling y reportando los slings rotos o en mal estado?', 1),
(335, 3, 40, 109, '¿El asistente de aduanas se esta asegurando que los slings transportados por el rail vayan centrados al momento de que se envian al storage de Boarding?', 1),
(336, 3, 40, 110, '¿El supervisor de produccion esta realizando las rondas de verificacion de house keeping en el piso de producción (Cero derrame de agua en el piso?', 1),
(337, 3, 40, 111, '¿Se encuentra en buen estado el clip que utilizan los operadores para abriri los sacos de sal & soda?', 1),
(338, 3, 38, 112, '¿El supervisor está confirmando los paros que aparecen en el sistema? ', 1),
(339, 3, 38, 113, '¿Se encuentra el estándar del estilo en proceso en físico ( Colores)? ', 1),
(340, 3, 39, 114, '¿Existe fisicamente el lote rechazado? ', 1),
(341, 3, 39, 115, '¿Se encuentra el lote en la ubicacion establecida (area de rechazos)? ', 1),
(342, 3, 39, 116, '¿Se cumple el proceso de asignacion de la WK para los lotes rechazados? ', 1),
(343, 3, 39, 117, '¿Hormas ubicadas en el área de estacion de calidad se encuentra en buenas condiciones?', 1),
(344, 3, 32, 118, '¿Se encuentran todos los lotes rechazados con su correcto estatus JDE HOLD? ', 1),
(345, 3, 32, 119, '¿Se encuentra la hoja de rechazo en el lote con la informacion completa? ', 1),
(346, 3, 32, 120, 'Se encuentran las hojas de ruta de los lotes auditados por calidad con su respectivo sello de Aprobado / Rechzado segun corresponda? ', 1),
(347, 3, 29, 121, '¿El asistente de aduanas esta revisando si la informacion de la hoja de ruta coincide con el producto en fisico? ', 1),
(348, 3, 29, 122, '¿El asistente de aduanas coloca el sticker de calidad en la bolsa plastica antes de retirar la hoja de ruta?', 1),
(349, 3, 29, 123, '¿El asistente de aduanas esta realizando la asignacion correcta de locacion en el sistema JDE de todos los lotes que envia por el sistema de riel por piso de produccion?', 1),
(350, 3, 29, 124, '¿Se esta llenando la información básica de la hoja de ruta? ( nombre, código, turno, No. de sling, No. de maquina  teñidura / túnel,  No. De maquina secadora )', 1),
(351, 3, 31, 125, '¿Esta el operador utilizando la mascarilla de manera correcta? ', 1),
(352, 3, 31, 126, '¿Esta libre de alhajas? ', 1),
(353, 3, 31, 127, '¿Se esta cumpliendo con el distanciamiento social en el area ?', 1),
(354, 3, 31, 128, '¿Esta abastecido el kit de bioseguridad en la estacion? ', 1),
(355, 3, 31, 129, '¿El rociador corresponde a la estacion asignada ? ', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `statusinfo`
--

CREATE TABLE `statusinfo` (
  `st_id` int(11) NOT NULL,
  `st_name` varchar(50) NOT NULL,
  `st_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `statusinfo`
--

INSERT INTO `statusinfo` (`st_id`, `st_name`, `st_description`) VALUES
(1, 'Activo', ''),
(2, 'Inactivo', ''),
(3, 'Eliminado', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supervisores`
--

CREATE TABLE `supervisores` (
  `Supervisor_ID` int(11) NOT NULL,
  `Area_ID` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `supervisores`
--

INSERT INTO `supervisores` (`Supervisor_ID`, `Area_ID`, `Nombre`, `Status`) VALUES
(1, 2, 'Ivonne Espinal', 1),
(2, 2, 'Javier Cabrera', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpermissions`
--

CREATE TABLE `tblpermissions` (
  `per_id` int(11) NOT NULL,
  `per_role` int(11) NOT NULL,
  `per_module` int(11) NOT NULL,
  `per_r` int(11) NOT NULL,
  `per_w` int(11) NOT NULL,
  `per_u` int(11) NOT NULL,
  `per_d` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblroles`
--

CREATE TABLE `tblroles` (
  `rol_id` int(11) NOT NULL,
  `rol_name` varchar(50) NOT NULL,
  `rol_description` text NOT NULL,
  `rol_ucreated` int(11) NOT NULL,
  `rol_dcreated` datetime NOT NULL DEFAULT current_timestamp(),
  `rol_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblroles`
--

INSERT INTO `tblroles` (`rol_id`, `rol_name`, `rol_description`, `rol_ucreated`, `rol_dcreated`, `rol_status`) VALUES
(1, 'Developer', 'Desarrollador de la aplicación', 1, '2022-04-23 00:46:32', 1),
(2, 'Administrador', '', 1, '2022-04-30 12:44:09', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblusers`
--

CREATE TABLE `tblusers` (
  `usr_id` int(11) NOT NULL,
  `usr_cname` varchar(250) NOT NULL,
  `usr_role` int(11) NOT NULL,
  `usr_email` varchar(250) NOT NULL,
  `usr_uname` varchar(20) NOT NULL,
  `usr_upass` varchar(250) NOT NULL,
  `usr_ucreated` int(11) NOT NULL,
  `usr_dcreated` datetime NOT NULL DEFAULT current_timestamp(),
  `usr_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblusers`
--

INSERT INTO `tblusers` (`usr_id`, `usr_cname`, `usr_role`, `usr_email`, `usr_uname`, `usr_upass`, `usr_ucreated`, `usr_dcreated`, `usr_status`) VALUES
(1, 'Andrés Meoñez', 1, 'jameonez@gildan.com', 'jameonez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, '2022-04-27 01:06:24', 1),
(2, 'Obed Garcia', 1, 'ojgarcia@gildan.com', 'ojgarcia', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, '2022-04-30 12:44:41', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`Area_ID`);

--
-- Indices de la tabla `auditorias`
--
ALTER TABLE `auditorias`
  ADD PRIMARY KEY (`Id_Auditoria`),
  ADD KEY `Area_ID` (`Area_ID`),
  ADD KEY `Status` (`Status`),
  ADD KEY `User_ID` (`User_ID`);

--
-- Indices de la tabla `auditorias_tmp`
--
ALTER TABLE `auditorias_tmp`
  ADD PRIMARY KEY (`Id_Auditoria`),
  ADD KEY `Area_ID` (`Area_ID`),
  ADD KEY `Status` (`Status`),
  ADD KEY `Supervisor_ID` (`Supervisor_ID`),
  ADD KEY `User_ID` (`User_ID`);

--
-- Indices de la tabla `detalle_auditoria`
--
ALTER TABLE `detalle_auditoria`
  ADD PRIMARY KEY (`Detalle_ID`),
  ADD KEY `Nro_Auditoria` (`Auditoria_ID`),
  ADD KEY `Posicion_ID` (`Posicion_ID`),
  ADD KEY `Supervisor_ID` (`Supervisor_ID`),
  ADD KEY `Punto_Auditado` (`Punto_ID`),
  ADD KEY `Area_Auditada` (`Area_ID`),
  ADD KEY `Area_ID` (`Area_ID`);

--
-- Indices de la tabla `detalle_auditoria_tmp`
--
ALTER TABLE `detalle_auditoria_tmp`
  ADD PRIMARY KEY (`Detalle_id`),
  ADD KEY `Nro_auditoria` (`Nro_auditoria`),
  ADD KEY `Supervisor` (`Supervisor`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Posicion_id` (`Posicion_id`),
  ADD KEY `Punto_Auditado` (`Punto_Auditado`);

--
-- Indices de la tabla `images_tmp`
--
ALTER TABLE `images_tmp`
  ADD PRIMARY KEY (`Image_ID`),
  ADD KEY `Audit_ID` (`Audit_ID`),
  ADD KEY `User_ID` (`User_ID`);

--
-- Indices de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  ADD PRIMARY KEY (`Posicion_ID`),
  ADD KEY `Area_ID` (`Area_ID`),
  ADD KEY `Status` (`Status`);

--
-- Indices de la tabla `puntos`
--
ALTER TABLE `puntos`
  ADD PRIMARY KEY (`Punto_ID`),
  ADD KEY `Area_ID` (`Area_ID`),
  ADD KEY `Posicion_ID` (`Posicion_ID`);

--
-- Indices de la tabla `statusinfo`
--
ALTER TABLE `statusinfo`
  ADD PRIMARY KEY (`st_id`);

--
-- Indices de la tabla `supervisores`
--
ALTER TABLE `supervisores`
  ADD PRIMARY KEY (`Supervisor_ID`),
  ADD KEY `Area_ID` (`Area_ID`),
  ADD KEY `Status` (`Status`);

--
-- Indices de la tabla `tblpermissions`
--
ALTER TABLE `tblpermissions`
  ADD PRIMARY KEY (`per_id`),
  ADD KEY `per_role` (`per_role`);

--
-- Indices de la tabla `tblroles`
--
ALTER TABLE `tblroles`
  ADD PRIMARY KEY (`rol_id`),
  ADD KEY `usuarios` (`rol_ucreated`),
  ADD KEY `estados` (`rol_status`);

--
-- Indices de la tabla `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`usr_id`),
  ADD KEY `usr_role` (`usr_role`),
  ADD KEY `usr_status` (`usr_status`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `area`
--
ALTER TABLE `area`
  MODIFY `Area_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `auditorias`
--
ALTER TABLE `auditorias`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `auditorias_tmp`
--
ALTER TABLE `auditorias_tmp`
  MODIFY `Id_Auditoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_auditoria`
--
ALTER TABLE `detalle_auditoria`
  MODIFY `Detalle_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_auditoria_tmp`
--
ALTER TABLE `detalle_auditoria_tmp`
  MODIFY `Detalle_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `images_tmp`
--
ALTER TABLE `images_tmp`
  MODIFY `Image_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  MODIFY `Posicion_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `puntos`
--
ALTER TABLE `puntos`
  MODIFY `Punto_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=356;

--
-- AUTO_INCREMENT de la tabla `statusinfo`
--
ALTER TABLE `statusinfo`
  MODIFY `st_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `supervisores`
--
ALTER TABLE `supervisores`
  MODIFY `Supervisor_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tblpermissions`
--
ALTER TABLE `tblpermissions`
  MODIFY `per_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblroles`
--
ALTER TABLE `tblroles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `usr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auditorias`
--
ALTER TABLE `auditorias`
  ADD CONSTRAINT `Area_ID` FOREIGN KEY (`Area_ID`) REFERENCES `area` (`Area_ID`),
  ADD CONSTRAINT `auditorias_ibfk_1` FOREIGN KEY (`Status`) REFERENCES `statusinfo` (`st_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `auditorias_tmp`
--
ALTER TABLE `auditorias_tmp`
  ADD CONSTRAINT `auditorias_tmp_ibfk_1` FOREIGN KEY (`Area_ID`) REFERENCES `area` (`Area_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `auditorias_tmp_ibfk_2` FOREIGN KEY (`Supervisor_ID`) REFERENCES `supervisores` (`Supervisor_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `auditorias_tmp_ibfk_3` FOREIGN KEY (`User_ID`) REFERENCES `tblusers` (`usr_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `auditorias_tmp_ibfk_4` FOREIGN KEY (`Status`) REFERENCES `statusinfo` (`st_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_auditoria`
--
ALTER TABLE `detalle_auditoria`
  ADD CONSTRAINT `Nro_Auditoria` FOREIGN KEY (`Auditoria_ID`) REFERENCES `auditorias` (`Id_Auditoria`),
  ADD CONSTRAINT `detalle_auditoria_ibfk_1` FOREIGN KEY (`Posicion_ID`) REFERENCES `posiciones` (`Posicion_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_auditoria_ibfk_2` FOREIGN KEY (`Supervisor_ID`) REFERENCES `supervisores` (`Supervisor_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_auditoria_ibfk_3` FOREIGN KEY (`Area_ID`) REFERENCES `area` (`Area_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_auditoria_ibfk_4` FOREIGN KEY (`Punto_ID`) REFERENCES `puntos` (`Punto_ID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_auditoria_tmp`
--
ALTER TABLE `detalle_auditoria_tmp`
  ADD CONSTRAINT `detalle_auditoria_tmp_ibfk_1` FOREIGN KEY (`Nro_auditoria`) REFERENCES `auditorias_tmp` (`Id_Auditoria`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_auditoria_tmp_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `tblusers` (`usr_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_auditoria_tmp_ibfk_3` FOREIGN KEY (`Posicion_id`) REFERENCES `posiciones` (`Posicion_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_auditoria_tmp_ibfk_4` FOREIGN KEY (`Supervisor`) REFERENCES `supervisores` (`Supervisor_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_auditoria_tmp_ibfk_5` FOREIGN KEY (`Punto_Auditado`) REFERENCES `puntos` (`Punto_ID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `images_tmp`
--
ALTER TABLE `images_tmp`
  ADD CONSTRAINT `images_tmp_ibfk_1` FOREIGN KEY (`Audit_ID`) REFERENCES `auditorias_tmp` (`Id_Auditoria`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `images_tmp_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `tblusers` (`usr_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `posiciones`
--
ALTER TABLE `posiciones`
  ADD CONSTRAINT `posiciones_ibfk_1` FOREIGN KEY (`Status`) REFERENCES `statusinfo` (`st_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `posiciones_ibfk_2` FOREIGN KEY (`Area_ID`) REFERENCES `area` (`Area_ID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `puntos`
--
ALTER TABLE `puntos`
  ADD CONSTRAINT `puntos_ibfk_1` FOREIGN KEY (`Area_ID`) REFERENCES `area` (`Area_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `puntos_ibfk_2` FOREIGN KEY (`Posicion_ID`) REFERENCES `posiciones` (`Posicion_ID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `supervisores`
--
ALTER TABLE `supervisores`
  ADD CONSTRAINT `supervisores_ibfk_1` FOREIGN KEY (`Status`) REFERENCES `statusinfo` (`st_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `supervisores_ibfk_2` FOREIGN KEY (`Area_ID`) REFERENCES `area` (`Area_ID`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `tblpermissions`
--
ALTER TABLE `tblpermissions`
  ADD CONSTRAINT `tblpermissions_ibfk_1` FOREIGN KEY (`per_role`) REFERENCES `tblroles` (`rol_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tblroles`
--
ALTER TABLE `tblroles`
  ADD CONSTRAINT `tblroles_ibfk_1` FOREIGN KEY (`rol_ucreated`) REFERENCES `tblusers` (`usr_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tblroles_ibfk_2` FOREIGN KEY (`rol_status`) REFERENCES `statusinfo` (`st_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tblusers`
--
ALTER TABLE `tblusers`
  ADD CONSTRAINT `tblusers_ibfk_1` FOREIGN KEY (`usr_role`) REFERENCES `tblroles` (`rol_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tblusers_ibfk_2` FOREIGN KEY (`usr_status`) REFERENCES `statusinfo` (`st_id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
