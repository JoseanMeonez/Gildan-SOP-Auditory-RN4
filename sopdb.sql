-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-10-2022 a las 05:57:00
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

INSERT INTO `auditorias` (`Id_Auditoria`, `Fecha`, `Semana`, `Mes`, `Area_ID`, `Pasa`, `Falla`, `Resultado`, `Status`) VALUES
(1, '2022-09-19 22:08:07', '1', '10', 1, 1, 0, 0.98, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditorias_tmp`
--

CREATE TABLE `auditorias_tmp` (
  `Id_Auditoria` int(11) NOT NULL,
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
  `Nro_Auditoria` int(11) NOT NULL,
  `Posicion_ID` int(11) DEFAULT NULL,
  `Supervisor` int(11) DEFAULT NULL,
  `Area_Auditada` int(11) DEFAULT NULL,
  `Punto_Auditado` int(11) DEFAULT NULL,
  `Estado` int(11) DEFAULT NULL,
  `Imagen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_auditoria`
--

INSERT INTO `detalle_auditoria` (`Detalle_ID`, `Nro_Auditoria`, `Posicion_ID`, `Supervisor`, `Area_Auditada`, `Punto_Auditado`, `Estado`, `Imagen`) VALUES
(1, 1, 1, 1, 0, 117, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_auditoria_tmp`
--

CREATE TABLE `detalle_auditoria_tmp` (
  `Detalle_id` int(11) NOT NULL,
  `Nro_auditoria` int(11) NOT NULL,
  `Posición_id` int(11) NOT NULL,
  `Supervisor` int(11) NOT NULL,
  `Area_Auditada` int(11) NOT NULL,
  `Punto_Auditado` int(11) NOT NULL,
  `Estado` int(11) NOT NULL,
  `Imagen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  ADD KEY `Status` (`Status`);

--
-- Indices de la tabla `auditorias_tmp`
--
ALTER TABLE `auditorias_tmp`
  ADD PRIMARY KEY (`Id_Auditoria`),
  ADD KEY `Area_ID` (`Area_ID`),
  ADD KEY `Status` (`Status`);

--
-- Indices de la tabla `detalle_auditoria`
--
ALTER TABLE `detalle_auditoria`
  ADD PRIMARY KEY (`Detalle_ID`),
  ADD KEY `Nro_Auditoria` (`Nro_Auditoria`);

--
-- Indices de la tabla `detalle_auditoria_tmp`
--
ALTER TABLE `detalle_auditoria_tmp`
  ADD PRIMARY KEY (`Detalle_id`),
  ADD KEY `Nro_auditoria` (`Nro_auditoria`),
  ADD KEY `Supervisor` (`Supervisor`);

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
  ADD CONSTRAINT `auditorias_tmp_ibfk_1` FOREIGN KEY (`Area_ID`) REFERENCES `area` (`Area_ID`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_auditoria`
--
ALTER TABLE `detalle_auditoria`
  ADD CONSTRAINT `Nro_Auditoria` FOREIGN KEY (`Nro_Auditoria`) REFERENCES `auditorias` (`Id_Auditoria`);

--
-- Filtros para la tabla `detalle_auditoria_tmp`
--
ALTER TABLE `detalle_auditoria_tmp`
  ADD CONSTRAINT `detalle_auditoria_tmp_ibfk_1` FOREIGN KEY (`Nro_auditoria`) REFERENCES `auditorias_tmp` (`Id_Auditoria`) ON UPDATE CASCADE;

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
