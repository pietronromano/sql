-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 02-08-2021 a las 15:09:18
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
-- Base de datos: `mcgrawhoteles`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `NIF` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `nombreCliente` varchar(25) COLLATE utf8_spanish2_ci NOT NULL,
  `apellidosCliente` varchar(35) COLLATE utf8_spanish2_ci NOT NULL,
  `poblacionCliente` varchar(35) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idCliente`, `NIF`, `nombreCliente`, `apellidosCliente`, `poblacionCliente`) VALUES
(1, '123456789A', 'Lionel', 'Messi', 'Barcelona'),
(2, '89121023T', 'Andrés', 'Iniesta', 'Albacete'),
(3, '123456780B', 'Pepe', 'González', 'Sueca'),
(4, '79123024X', 'Cristiano', 'Ronaldo', 'Madrid'),
(5, '89123123X', 'José Luis', 'Gayá', 'Valencia'),
(6, '12312333P', 'Carlos', 'Soler', 'Mislata'),
(7, '88333222K', 'Javi', 'Gracia', 'Alfafar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idEmp` int(11) NOT NULL,
  `nombreEmp` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `ApellidoEmp` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `oficioEmp` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `sueldoEmp` int(11) NOT NULL,
  `idHotel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmp`, `nombreEmp`, `ApellidoEmp`, `oficioEmp`, `sueldoEmp`, `idHotel`) VALUES
(1, 'Brian', 'Wilson', 'Conserje', 1000, 1),
(2, 'Pete ', 'Townshend', 'Directivo', 850, 2),
(3, 'John', 'Lennon', 'Pintor', 900, 1),
(4, 'Paul ', 'McCartney', 'Directivo', 900, 2),
(5, 'Frank', 'Sinatra', 'Conserje', 800, 1),
(6, 'Johnny', 'Cash', 'Fontanero', 1000, 1),
(7, 'Joan', 'Báez', 'Conserje', 888, 2),
(8, 'Chuck', 'Norris', 'Pintor', 234, 4),
(9, 'Liz', 'Taylor', 'Pintor', 444, 4),
(10, 'Marta', 'Sánchez', 'Pintor', 900, 2),
(11, 'Bernardo', 'de Carlet', 'Fontanero', 654, 8),
(12, 'Bernardo', 'de Carlet', 'Fontanero', 654, 8),
(13, 'Bernardo', 'de Carlet', 'Fontanero', 654, 9),
(14, 'Bernardo', 'de Carlet', 'Fontanero', 654, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitacion`
--

CREATE TABLE `habitacion` (
  `idHotel` int(11) NOT NULL,
  `idHabitacion` int(11) NOT NULL,
  `m2` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `camas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `habitacion`
--

INSERT INTO `habitacion` (`idHotel`, `idHabitacion`, `m2`, `precio`, `camas`) VALUES
(1, 1, '31.25', '100.10', 0),
(1, 2, '40.00', '120.00', 3),
(1, 3, '120.25', '110.00', 3),
(1, 4, '40.00', '80.25', 1),
(1, 5, '41.50', '75.00', 1),
(2, 1, '51.25', '60.36', 1),
(2, 2, '15.50', '22.25', 2),
(2, 3, '34.75', '44.00', 2),
(2, 4, '33.00', '50.00', 2),
(2, 5, '25.25', '45.25', 2),
(2, 6, '50.25', '60.10', 1),
(2, 7, '32.00', '50.00', 3),
(2, 8, '28.00', '45.50', 1),
(3, 1, '31.00', '50.00', 2),
(3, 2, '33.25', '50.00', 1),
(3, 3, '34.65', '50.00', 1),
(3, 4, '44.65', '50.00', 2),
(4, 1, '110.25', '100.00', 3),
(4, 2, '80.00', '88.00', 2),
(4, 3, '120.00', '130.50', 2),
(4, 4, '111.25', '120.10', 1),
(5, 1, '60.33', '66.00', 3),
(5, 2, '62.00', '60.26', 2),
(5, 3, '38.00', '50.00', 2),
(6, 1, '51.50', '55.55', 1),
(6, 2, '83.25', '100.10', 3),
(6, 3, '61.15', '75.00', 2),
(6, 4, '100.00', '500.00', 5),
(6, 5, '40.00', '120.00', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hotel`
--

CREATE TABLE `hotel` (
  `idHotel` int(11) NOT NULL,
  `nombreHotel` varchar(25) COLLATE utf8_spanish2_ci NOT NULL,
  `direccionHotel` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `codigoPostalHotel` varchar(5) COLLATE utf8_spanish2_ci NOT NULL,
  `poblacionHotel` varchar(25) COLLATE utf8_spanish2_ci NOT NULL,
  `provinciaHotel` varchar(25) COLLATE utf8_spanish2_ci NOT NULL,
  `telefonoHotel` varchar(12) COLLATE utf8_spanish2_ci NOT NULL,
  `categoriaHotel` enum('1','2','3','4','5','6','7') COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `hotel`
--

INSERT INTO `hotel` (`idHotel`, `nombreHotel`, `direccionHotel`, `codigoPostalHotel`, `poblacionHotel`, `provinciaHotel`, `telefonoHotel`, `categoriaHotel`) VALUES
(1, 'Hotel Colón', 'Plaça Colón, 1', '46600', 'Alzira', 'Valencia', '962342343', '5'),
(2, 'Pensió Pepe', 'C/ La Mar 14', '46400', 'Cullera', 'Valencia', '961743204', '4'),
(3, 'Les Palmeres', 'C/ La Pau, 11', '46410', 'Sueca', 'Valencia', '97324234', '3'),
(4, 'Sicania', 'Avda. Les Palmeres, 88', '46666', 'Cullera', 'Valencia', '962020202', '4'),
(5, 'Pensió Fidel', 'C/ Major, 12', '46418', 'Fortaleny', 'Valencia', '961701199', '3'),
(6, 'Casa Lolita', 'C/ Nou, 14', '46410', 'Sueca', 'Valencia', '961702312', '5'),
(7, 'Hostal Vera', 'Carretera de la Creu Negra, 50', '46240', 'Carlet', 'Valencia', '962 53 00 94', '3'),
(8, 'Hostal Vera', 'Carretera de la Creu Negra, 50', '46240', 'Carlet', 'Valencia', '962 53 00 94', '1'),
(9, 'Hotel Vera', 'Carretera de la Creu Negra, 50', '46240', 'Carlet', 'Valencia', '962 53 00 94', '2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `idReserva` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idHotel` int(11) NOT NULL,
  `idHabitacion` int(11) NOT NULL,
  `inicioFecha` date NOT NULL,
  `finFecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `reserva`
--

INSERT INTO `reserva` (`idReserva`, `idCliente`, `idHotel`, `idHabitacion`, `inicioFecha`, `finFecha`) VALUES
(1, 1, 1, 1, '2021-02-28', '2021-03-10'),
(50, 1, 2, 1, '2021-02-28', '2021-03-10'),
(51, 2, 1, 2, '2021-03-28', '2021-03-10'),
(52, 2, 4, 2, '2021-04-28', '2021-03-10'),
(53, 3, 5, 1, '2021-05-28', '2021-03-10'),
(54, 3, 6, 1, '2021-06-28', '2021-03-10'),
(55, 4, 3, 4, '2021-02-11', '2021-03-11'),
(56, 4, 3, 3, '2021-04-12', '2021-04-22'),
(57, 4, 4, 2, '2021-02-28', '2021-03-10'),
(58, 5, 1, 1, '2021-02-28', '2021-03-10'),
(59, 5, 2, 3, '2021-02-28', '2021-03-10'),
(60, 5, 3, 1, '2021-02-28', '2021-03-10'),
(61, 5, 5, 1, '2021-02-28', '2021-03-10'),
(62, 6, 1, 1, '2021-02-28', '2021-03-10'),
(63, 6, 1, 2, '2021-02-28', '2021-03-10'),
(64, 6, 1, 3, '2021-02-28', '2021-03-10'),
(65, 6, 1, 4, '2021-02-28', '2021-03-10');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`),
  ADD UNIQUE KEY `nif` (`NIF`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idEmp`),
  ADD KEY `idHotel` (`idHotel`);

--
-- Indices de la tabla `habitacion`
--
ALTER TABLE `habitacion`
  ADD PRIMARY KEY (`idHotel`,`idHabitacion`),
  ADD KEY `idhotel` (`idHotel`);

--
-- Indices de la tabla `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`idHotel`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`idReserva`),
  ADD KEY `idclient` (`idCliente`),
  ADD KEY `idhotel` (`idHotel`),
  ADD KEY `idhabitacio` (`idHabitacion`),
  ADD KEY `idhotel_2` (`idHotel`,`idHabitacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idEmp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `hotel`
--
ALTER TABLE `hotel`
  MODIFY `idHotel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `idReserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `habitacion`
--
ALTER TABLE `habitacion`
  ADD CONSTRAINT `habitacion_ibfk_1` FOREIGN KEY (`idHotel`) REFERENCES `hotel` (`idHotel`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`idHotel`,`idHabitacion`) REFERENCES `habitacion` (`idHotel`, `idHabitacion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
