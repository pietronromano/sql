-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 02-08-2021 a las 15:07:59
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
-- Base de datos: `mcgrawcines`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cine`
--

CREATE TABLE `cine` (
  `idCine` int(11) NOT NULL,
  `nombreCine` varchar(44) COLLATE utf8_spanish2_ci NOT NULL,
  `poblacionCine` varchar(33) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `cine`
--

INSERT INTO `cine` (`idCine`, `nombreCine`, `poblacionCine`) VALUES
(1, 'Colon', 'Alzira'),
(2, 'Cervantes', 'Cullera'),
(3, 'Salón Giner', 'Carlet'),
(4, 'Centro Cultural Enric Valor', 'Benifaió'),
(5, 'Centre Cultural', 'Almussafes'),
(6, 'ABC Saler', 'Valencia'),
(7, 'ABC Park', 'Valencia'),
(8, 'Autocine Star', 'Valencia'),
(9, 'Cines Babel', 'Valencia'),
(10, 'Cines Lys', 'Valencia'),
(11, 'Cinestudio d´Or', 'Valencia'),
(12, 'Filmoteca Valencia', 'Valencia'),
(13, 'Hemisfèric', 'Valencia'),
(14, 'Ocine Aqua', 'Valencia'),
(15, 'Yelmo Cines Mercado de Campanar', 'Valencia'),
(16, 'Teatre L\'Agricola', 'Alboraia/Alboraya'),
(17, 'Teatro de verano Terrassa Lumiere', 'Alboraia/Alboraya'),
(18, 'Cinesa Bonaire', 'Aldaia'),
(19, 'Cines MN4', 'Alfafar'),
(20, 'Kinépolis Alzira', 'Alzira'),
(21, 'Centre Cultural El Molí', 'Benetússer'),
(22, 'Cines Victoria', 'Cullera'),
(23, 'ABC Gandía', 'Gandia'),
(24, 'Cine de verano Tugar', 'Gandia'),
(25, 'Cines Axion Premium Gandia', 'Gandia'),
(26, 'Teatro Capitolio', 'Godella'),
(27, 'Cine La Unió', 'Llíria'),
(28, 'Cine de verano Terraza Charly', 'Miramar'),
(29, 'Centre Cultural Blasco Ibáñez', 'Moncada'),
(30, 'Cine Museros', 'Museros'),
(31, 'Cinema Olimpia', 'Oliva'),
(32, 'Cineapolis El Teler', 'Ontinyent'),
(33, 'Kinépolis Valencia', 'Paterna'),
(34, 'Casa de Cultura', 'Pobla de Vallbona, la'),
(35, 'Casa cultura', 'Puçol'),
(36, 'Auditori Molí de Vila', 'Quart de Poblet'),
(37, 'Auditori/Terraza de verano', 'Riba-roja de Túria'),
(38, 'Alucine', 'Sagunto'),
(39, 'Yelmo Cines VidaNova Parc', 'Sagunto'),
(40, 'Cine de verano', 'Serra'),
(41, 'Cine de verano Olimpo Cine Terraza', 'Tavernes de la Valldigna'),
(42, 'Cine CAM', 'Torrent'),
(43, 'Cines Axión Xativa', 'Xàtiva'),
(44, 'ABC Gran Turia', 'Xirivella');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sala`
--

CREATE TABLE `sala` (
  `idCine` int(11) NOT NULL,
  `idSala` int(11) NOT NULL,
  `butacasSala` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `sala`
--

INSERT INTO `sala` (`idCine`, `idSala`, `butacasSala`) VALUES
(1, 1, 100),
(1, 2, 120),
(1, 3, 111),
(2, 1, 188);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket`
--

CREATE TABLE `ticket` (
  `idTicket` int(11) NOT NULL,
  `idCine` int(11) NOT NULL,
  `idSala` int(11) NOT NULL,
  `dia` date NOT NULL,
  `hora` time NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `ticket`
--

INSERT INTO `ticket` (`idTicket`, `idCine`, `idSala`, `dia`, `hora`, `precio`) VALUES
(1, 1, 2, '2018-01-25', '18:00:00', 8);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cine`
--
ALTER TABLE `cine`
  ADD PRIMARY KEY (`idCine`);

--
-- Indices de la tabla `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`idCine`,`idSala`),
  ADD KEY `idCine` (`idCine`);

--
-- Indices de la tabla `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`idTicket`),
  ADD KEY `idCine` (`idCine`,`idSala`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cine`
--
ALTER TABLE `cine`
  MODIFY `idCine` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `ticket`
--
ALTER TABLE `ticket`
  MODIFY `idTicket` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `sala`
--
ALTER TABLE `sala`
  ADD CONSTRAINT `sala_ibfk_1` FOREIGN KEY (`idCine`) REFERENCES `cine` (`idCine`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`idCine`,`idSala`) REFERENCES `sala` (`idCine`, `idSala`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

