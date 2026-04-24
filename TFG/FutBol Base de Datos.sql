-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2026 at 08:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `futbol`
--

-- --------------------------------------------------------

--
-- Table structure for table `jugadores`
--

CREATE TABLE `jugadores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `posicion` varchar(50) DEFAULT NULL,
  `equipo` varchar(100) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `usuario_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jugadores`
--

INSERT INTO `jugadores` (`id`, `nombre`, `edad`, `posicion`, `equipo`, `foto`, `observaciones`, `creado_por`, `fecha_registro`, `usuario_id`, `rating`) VALUES
(1, 'Cristiano Ronaldo', 39, 'Delantero', 'Real Madrid', 'uploads/Cristiano Ronaldo.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 99),
(2, 'Karim Benzema', 36, 'Delantero', 'Real Madrid', 'uploads/Karim Benzema.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 80),
(3, 'Sergio Ramos', 38, 'Defensa', 'Real Madrid', 'uploads/Sergio Ramos.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 70),
(4, 'Luka Modric', 39, 'Centrocampista', 'Real Madrid', 'uploads/Luka Modric.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 85),
(5, 'Toni Kroos', 34, 'Centrocampista', 'Real Madrid', 'uploads/Toni Kroos.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 84),
(6, 'Iker Casillas', 43, 'Portero', 'Real Madrid', 'uploads/Iker Casillas.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 79),
(7, 'Roberto Carlos', 51, 'Defensa', 'Real Madrid', 'uploads/Roberto Carlos.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 95),
(8, 'Raúl González', 47, 'Delantero', 'Real Madrid', 'uploads/Raúl González.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 92),
(9, 'Vinícius Jr', 24, 'Delantero', 'Real Madrid', 'uploads/Vinícius Jr.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 89),
(10, 'Rodrygo Goes', 23, 'Delantero', 'Real Madrid', 'uploads/Rodrygo Goes.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 96),
(11, 'Dani Carvajal', 32, 'Defensa', 'Real Madrid', 'uploads/Dani Carvajal.png', NULL, NULL, '2026-04-18 18:03:10', NULL, 94),
(12, 'Thibaut Courtois', 32, 'Portero', 'Real Madrid', 'uploads/Thibaut Courtois.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 84),
(13, 'Federico Valverde', 25, 'Centrocampista', 'Real Madrid', 'uploads/Federico Valverde.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 97),
(14, 'Éder Militão', 26, 'Defensa', 'Real Madrid', 'uploads/Éder Militão.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 90),
(15, 'David Alaba', 32, 'Defensa', 'Real Madrid', 'uploads/David Alaba.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 89),
(16, 'Antonio Rüdiger', 31, 'Defensa', 'Real Madrid', 'uploads/Antonio Rüdiger.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 87),
(17, 'Aurélien Tchouaméni', 24, 'Centrocampista', 'Real Madrid', 'uploads/Aurélien Tchouaméni.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 92),
(18, 'Eduardo Camavinga', 22, 'Centrocampista', 'Real Madrid', 'uploads/camavinga.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 0),
(19, 'Joselu', 34, 'Delantero', 'Real Madrid', 'uploads/joselu.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 0),
(20, 'Brahim Díaz', 25, 'Delantero', 'Real Madrid', 'uploads/brahim.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 0),
(21, 'Arda Güler', 19, 'Centrocampista', 'Real Madrid', 'uploads/guler.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 0),
(22, 'Andriy Lunin', 25, 'Portero', 'Real Madrid', 'uploads/lunin.jpg', NULL, NULL, '2026-04-18 18:03:10', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mensajes`
--

INSERT INTO `mensajes` (`id`, `usuario_id`, `mensaje`, `fecha`) VALUES
(1, 1, 'Partido importante - Juan', '2026-04-15 05:56:02'),
(4, 2, 'Segundo entrenamiento ', '2026-04-15 05:59:00');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `user` varchar(50) DEFAULT NULL,
  `pass` varchar(50) DEFAULT NULL,
  `rol` int(11) NOT NULL DEFAULT 3 COMMENT '1:Admin, 2:Adminis, 3:Consulta',
  `ultima_conexion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estado` tinyint(4) DEFAULT 1,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `user`, `pass`, `rol`, `ultima_conexion`, `estado`, `fecha_registro`) VALUES
(1, 'admin', '1234', 1, '2026-04-15 08:32:55', 1, '2026-04-18 13:35:27'),
(2, 'madrid', '1234', 2, '2026-04-15 09:06:39', 1, '2026-04-18 13:35:27'),
(3, 'barcelona', '1234', 2, '2026-04-15 05:48:01', 1, '2026-04-18 13:35:27'),
(4, 'valencia', '1234', 2, '2026-04-15 05:48:01', 1, '2026-04-18 13:35:27'),
(5, 'sevilla', '1234', 2, '2026-04-15 05:48:01', 1, '2026-04-18 13:35:27'),
(6, 'zaragoza', '1234', 2, '2026-04-15 05:48:01', 1, '2026-04-18 13:35:27'),
(7, 'visitante', '1234', 3, '2026-04-15 06:22:49', 1, '2026-04-18 13:35:27'),
(8, 'Juanito', '1234', 3, '2026-04-15 06:37:38', 1, '2026-04-18 13:35:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jugadores`
--
ALTER TABLE `jugadores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indexes for table `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jugadores`
--
ALTER TABLE `jugadores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jugadores`
--
ALTER TABLE `jugadores`
  ADD CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
