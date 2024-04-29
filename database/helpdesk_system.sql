-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 26 avr. 2024 à 11:55
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `helpdesk_system`
--

-- --------------------------------------------------------

--
-- Structure de la table `hd_departments`
--

CREATE TABLE `hd_departments` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `hd_departments`
--

INSERT INTO `hd_departments` (`id`, `name`, `status`) VALUES
(1, 'Finance', 1),
(2, 'IT', 1),
(3, 'Marketing', 0),
(4, 'Administration', 1),
(5, 'Supply Chain', 1),
(7, 'Human Resources', 1);

-- --------------------------------------------------------

--
-- Structure de la table `hd_tickets`
--

CREATE TABLE `hd_tickets` (
  `id` int(11) NOT NULL,
  `uniqid` varchar(20) NOT NULL,
  `user` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `init_msg` text NOT NULL,
  `department` int(11) NOT NULL,
  `date` varchar(250) NOT NULL,
  `last_reply` int(11) NOT NULL,
  `user_read` int(11) NOT NULL,
  `admin_read` int(11) NOT NULL,
  `resolved` int(11) NOT NULL,
  `requestor_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `hd_tickets`
--

INSERT INTO `hd_tickets` (`id`, `uniqid`, `user`, `title`, `init_msg`, `department`, `date`, `last_reply`, `user_read`, `admin_read`, `resolved`, `requestor_name`) VALUES
(5, '617c0a73661fd', 1, 'there are secirty glitches!!!', 'there are secirty glitches', 1, '1635519091', 1, 0, 1, 0, ''),
(6, '617c0ba6d462b', 2, 'there some issues', 'there some issues', 1, '1635519398', 2, 1, 0, 0, ''),
(7, '6620db4e5fa24', 2, 'nouveau incident', 'nouveau incident', 1, '1713429326', 1, 0, 1, 1, ''),
(8, '6620dd0b1f901', 6, 'probleme mot de passe de compte', 'probleme mot de passe de compte', 4, '1713429771', 5, 0, 1, 0, ''),
(9, '6620dd7a056be', 6, 'Installation desktop stagiaire', 'Installation desktop stagiaire', 4, '1713429882', 5, 0, 1, 0, ''),
(10, '6620df8bcfff9', 6, 'compte windows verouillé', 'compte windows verouillé', 7, '1713430411', 5, 0, 1, 0, ''),
(11, '6627739fbe840', 5, 'test after drop db', 'test after drop db', 5, '1713861535', 5, 0, 1, 0, ''),
(12, '66277eaa70f2b', 5, 'test requestor name', 'test requestor name', 2, '1713864362', 5, 0, 1, 0, ''),
(13, '6628c5659e2db', 5, '1', '1', 3, '1713948005', 5, 0, 0, 0, ''),
(14, '6628c572d51d0', 5, '2', '2', 1, '1713948018', 5, 0, 0, 0, ''),
(15, '6628c57f63f52', 5, '3', '3', 2, '1713948031', 5, 0, 0, 0, ''),
(16, '6628c58f7a26c', 5, '4', '4', 3, '1713948047', 5, 0, 0, 1, ''),
(17, '66292d310f666', 5, 'last test 42day', 'last test 42day', 1, '1713974577', 5, 0, 0, 0, ''),
(18, '662a16da92d7d', 5, 'first test of today', 'first test of today', 2, '1714034394', 5, 0, 0, 0, ''),
(19, '662a1da732cf8', 5, 'test pagination', 'test pagination', 1, '1714036135', 5, 0, 1, 0, ''),
(20, '662a1f9c845b4', 5, 'test2', 'test2', 1, '1714036636', 5, 0, 0, 0, ''),
(21, '662a205184411', 5, 'test3', 'test3', 1, '1714036817', 5, 0, 0, 0, ''),
(22, '662a22bcba9f5', 5, 'whyyy', 'whyyy', 1, '1714037436', 5, 0, 1, 0, ''),
(23, '662a2423eaf50', 5, 'test', 'test', 1, '1714037795', 5, 0, 0, 0, ''),
(24, '662a24acddbb8', 5, 'test 12 limit', 'test 12 limit', 1, '1714037932', 5, 0, 1, 0, ''),
(25, '662a253b8632e', 5, 'tring', 'tring', 1, '1714038075', 5, 0, 1, 1, ''),
(26, '662b741350a14', 5, 'test pagin again', 'test pagin again', 1, '1714123795', 5, 0, 0, 0, '');

-- --------------------------------------------------------

--
-- Structure de la table `hd_ticket_replies`
--

CREATE TABLE `hd_ticket_replies` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `text` text NOT NULL,
  `ticket_id` text NOT NULL,
  `date` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `hd_ticket_replies`
--

INSERT INTO `hd_ticket_replies` (`id`, `user`, `text`, `ticket_id`, `date`) VALUES
(1, 1, 'This is fixed', '1', '1634829030'),
(2, 1, 'Please check it.', '1', '1634829129'),
(3, 1, 'The issue is fixed, you can check at your end. Thanks', '2', '1634829404'),
(4, 2, 'fixed', '2', '1635515403'),
(5, 2, 'this is fixed!', '4', '1635517083'),
(6, 1, 'I am looking into this', '5', '1635519340'),
(7, 2, 'ewtewt', '6', '1635519418'),
(8, 2, 'bien fixé', '7', '1713429355'),
(9, 2, 'lorem ipsum', '7', '1713429400'),
(10, 1, 'bien fixé', '7', '1713429467'),
(11, 1, 'bien fixé\r\n', '7', '1713429542'),
(12, 5, 'je vais voir', '10', '1713431566'),
(13, 5, 'bien installé', '9', '1713431615'),
(14, 5, 'reinitialise le svp', '8', '1713431864'),
(15, 5, 'im salma\r\n', '12', '1713864395');

-- --------------------------------------------------------

--
-- Structure de la table `hd_users`
--

CREATE TABLE `hd_users` (
  `id` int(11) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `name` varchar(250) NOT NULL,
  `user_type` enum('admin','user') NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `hd_users`
--

INSERT INTO `hd_users` (`id`, `email`, `password`, `create_date`, `name`, `user_type`, `status`) VALUES
(5, 'salma@tdm.com', '202cb962ac59075b964b07152d234b70', '2024-04-18 09:40:09', 'salma', 'admin', 1),
(6, 'meryem@tdm.com', '202cb962ac59075b964b07152d234b70', '2024-04-18 09:40:50', 'meryem', 'user', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `hd_departments`
--
ALTER TABLE `hd_departments`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hd_tickets`
--
ALTER TABLE `hd_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hd_ticket_replies`
--
ALTER TABLE `hd_ticket_replies`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hd_users`
--
ALTER TABLE `hd_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `hd_departments`
--
ALTER TABLE `hd_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `hd_tickets`
--
ALTER TABLE `hd_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `hd_ticket_replies`
--
ALTER TABLE `hd_ticket_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `hd_users`
--
ALTER TABLE `hd_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
