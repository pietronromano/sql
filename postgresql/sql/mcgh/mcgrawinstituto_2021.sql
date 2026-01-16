-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 02-08-2021 a las 15:09:45
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mcgrawinstituto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnado`
--

CREATE TABLE `alumnado` (
  `NIA` int(11) NOT NULL,
  `nombreAlumnado` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `apellidosAlumnado` varchar(30) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `alumnado`
--

INSERT INTO `alumnado` (`NIA`, `nombreAlumnado`, `apellidosAlumnado`) VALUES
(103569, 'Ana', 'Martínez'),
(104578, 'Jose', 'García'),
(106574, 'Alejandro', 'Jiménez'),
(107896, 'María', 'Hernández');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciclo`
--

CREATE TABLE `ciclo` (
  `idCiclo` int(11) NOT NULL,
  `nombreCiclo` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `gradoCiclo` int(11) NOT NULL,
  `familiaCiclo` int(11) NOT NULL,
  `horasCiclo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `ciclo`
--

INSERT INTO `ciclo` (`idCiclo`, `nombreCiclo`, `gradoCiclo`, `familiaCiclo`, `horasCiclo`) VALUES
(1, 'Sistemas Informáticos y Redes', 2, 1, 2000),
(2, 'Administración de Sistemas Informáticos en Red', 3, 1, 2000),
(3, 'Desarrollo de Aplicaciones Multiplataforma', 3, 1, 2000),
(4, 'Desarrollo de Aplicaciones Web', 3, 1, 2000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familia`
--

CREATE TABLE `familia` (
  `idFamilia` int(11) NOT NULL,
  `nombreFamilia` varchar(40) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `familia`
--

INSERT INTO `familia` (`idFamilia`, `nombreFamilia`) VALUES
(1, 'Informática y Telecomunicaciones'),
(2, 'Hostelería y Turismo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado`
--

CREATE TABLE `grado` (
  `idGrado` int(11) NOT NULL,
  `nombreGrado` varchar(20) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `grado`
--

INSERT INTO `grado` (`idGrado`, `nombreGrado`) VALUES
(1, 'FP Básica'),
(2, 'Medio'),
(3, 'Superior');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula`
--

CREATE TABLE `matricula` (
  `NIA` int(11) NOT NULL,
  `idModulo` varchar(4) COLLATE utf8_spanish2_ci NOT NULL,
  `idCiclo` int(11) NOT NULL,
  `nota` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `matricula`
--

INSERT INTO `matricula` (`NIA`, `idModulo`, `idCiclo`, `nota`) VALUES
(103569, '0373', 4, NULL),
(103569, '0483', 4, NULL),
(103569, '0484', 4, NULL),
(103569, '0485', 4, NULL),
(103569, '0487', 4, NULL),
(103569, '0617', 4, NULL),
(106574, '0373', 3, NULL),
(106574, '0483', 3, NULL),
(106574, '0484', 3, NULL),
(106574, '0485', 3, NULL),
(106574, '0487', 3, NULL),
(106574, '0493', 3, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE `modulo` (
  `idModulo` varchar(4) COLLATE utf8_spanish2_ci NOT NULL,
  `codigoModulo` varchar(6) COLLATE utf8_spanish2_ci NOT NULL,
  `nombreModulo` varchar(60) COLLATE utf8_spanish2_ci NOT NULL,
  `cursoModulo` enum('1','2') COLLATE utf8_spanish2_ci NOT NULL,
  `horasModulo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`idModulo`, `codigoModulo`, `nombreModulo`, `cursoModulo`, `horasModulo`) VALUES
('0373', 'LMSGI', 'Lenguaje de Marcas y Sistemas de Gestión de la Información', '1', 96),
('0483', 'SI', 'Sistemas Informáticos', '1', 160),
('0484', 'BD', 'Bases de Datos', '1', 160),
('0485', 'PROG', 'Programación', '1', 256),
('0486', 'AD', 'Acceso a Datos', '2', 120),
('0487', 'ED', 'Entornos de Desarrollo', '1', 96),
('0488', 'DI', 'Desarrollo de Interfaces', '2', 120),
('0489', 'PMDM', 'Programación Multimedia y Dispositivos Móviles', '2', 100),
('0490', 'PSP', 'Programación de Servicios y Procesos', '2', 60),
('0491', 'SGE', 'Sistemas de Gestión Empresarial', '2', 100),
('0492', 'PDAM', 'Proyecto de Desarrollo de Aplicaciones Multiplataforma', '2', 40),
('0493', 'FOL', 'Formación y Orientación Laboral', '1', 96),
('0494', 'EIE', 'Empresa e Iniciativa Emprendedora', '2', 60),
('0495', 'FCT', 'Formación en Centros de Trabajo', '2', 400),
('0612', 'WC', 'Desarrollo Web en Entorno Cliente', '2', 140),
('0613', 'WS', 'Desarrollo Web en Entorno Servidor', '2', 160),
('0614', 'DAW', 'Despliegue de Aplicaciones Web', '2', 80),
('0615', 'DIW', 'Diseño de Interfaces Web', '2', 120),
('0616', 'PDAW', 'Proyecto de Desarrollo de Aplicaciones Web', '2', 40),
('0617', 'FOL', 'Formación y Orientación Laboral', '1', 96),
('0618', 'EIE', 'Empresa e Iniciativa Emprendedora', '2', 60),
('0619', 'FCT', 'Formación en Centros de Trabajo', '2', 400);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulociclo`
--

CREATE TABLE `modulociclo` (
  `idModulo` varchar(4) COLLATE utf8_spanish2_ci NOT NULL,
  `idCiclo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `modulociclo`
--

INSERT INTO `modulociclo` (`idModulo`, `idCiclo`) VALUES
('0373', 3),
('0373', 4),
('0483', 3),
('0483', 4),
('0484', 3),
('0484', 4),
('0485', 3),
('0485', 4),
('0486', 3),
('0487', 3),
('0487', 4),
('0488', 3),
('0489', 3),
('0490', 3),
('0491', 3),
('0492', 3),
('0493', 3),
('0494', 3),
('0495', 3),
('0612', 4),
('0613', 4),
('0614', 4),
('0615', 4),
('0616', 4),
('0617', 4),
('0618', 4),
('0619', 4);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnado`
--
ALTER TABLE `alumnado`
  ADD PRIMARY KEY (`NIA`);

--
-- Indices de la tabla `ciclo`
--
ALTER TABLE `ciclo`
  ADD PRIMARY KEY (`idCiclo`),
  ADD KEY `familiaCiclo` (`familiaCiclo`),
  ADD KEY `gradoCiclo` (`gradoCiclo`);

--
-- Indices de la tabla `familia`
--
ALTER TABLE `familia`
  ADD PRIMARY KEY (`idFamilia`);

--
-- Indices de la tabla `grado`
--
ALTER TABLE `grado`
  ADD PRIMARY KEY (`idGrado`);

--
-- Indices de la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD PRIMARY KEY (`NIA`,`idModulo`,`idCiclo`),
  ADD KEY `idCiclo` (`idCiclo`,`idModulo`);

--
-- Indices de la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD PRIMARY KEY (`idModulo`);

--
-- Indices de la tabla `modulociclo`
--
ALTER TABLE `modulociclo`
  ADD PRIMARY KEY (`idModulo`,`idCiclo`),
  ADD KEY `idCiclo` (`idCiclo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ciclo`
--
ALTER TABLE `ciclo`
  MODIFY `idCiclo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `familia`
--
ALTER TABLE `familia`
  MODIFY `idFamilia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `grado`
--
ALTER TABLE `grado`
  MODIFY `idGrado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ciclo`
--
ALTER TABLE `ciclo`
  ADD CONSTRAINT `ciclo_ibfk_1` FOREIGN KEY (`familiaCiclo`) REFERENCES `familia` (`idFamilia`) ON UPDATE CASCADE,
  ADD CONSTRAINT `ciclo_ibfk_2` FOREIGN KEY (`gradoCiclo`) REFERENCES `grado` (`idGrado`);

--
-- Filtros para la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD CONSTRAINT `matricula_ibfk_1` FOREIGN KEY (`NIA`) REFERENCES `alumnado` (`NIA`) ON UPDATE CASCADE,
  ADD CONSTRAINT `matricula_ibfk_2` FOREIGN KEY (`idCiclo`,`idModulo`) REFERENCES `modulociclo` (`idCiclo`, `idModulo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `modulociclo`
--
ALTER TABLE `modulociclo`
  ADD CONSTRAINT `modulociclo_ibfk_1` FOREIGN KEY (`idCiclo`) REFERENCES `ciclo` (`idCiclo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `modulociclo_ibfk_2` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
