-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 27 mai 2024 à 16:21
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
(7, 'Human Resources', 1),
(10, 'Technical', 1);

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
(7, '6620db4e5fa24', 2, 'nouveau incident', 'nouveau incident', 1, '1713429326', 1, 0, 1, 1, 'hamdan'),
(8, '6620dd0b1f901', 6, 'probleme mot de passe de compte', 'probleme mot de passe de compte', 4, '1713429771', 6, 1, 0, 0, ''),
(9, '6620dd7a056be', 6, 'Installation desktop stagiaire', 'Installation desktop stagiaire', 4, '1713429882', 5, 1, 1, 0, ''),
(10, '6620df8bcfff9', 6, 'compte windows verouillé', 'compte windows verouillé', 7, '1713430411', 5, 1, 1, 0, ''),
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
(26, '662b741350a14', 5, 'test pagin again', 'test pagin again', 1, '1714123795', 5, 0, 0, 1, ''),
(27, '662f5dbd96409', 5, 'test after', 'test after', 1, '1714380221', 5, 0, 0, 0, ''),
(28, '662fa49480740', 5, 'h', 'h', 1, '1714398356', 5, 0, 1, 0, ''),
(29, '6630abba29998', 5, 'new subject', 'Installation windows echouée', 4, '1714465722', 5, 0, 1, 1, ''),
(30, '6630ae14789cc', 5, 'New ticket', 'New ticket', 7, '1714466324', 5, 0, 1, 0, ''),
(31, '6630c4b13709d', 6, 'meryems subject', 'meryems subject', 4, '1714472113', 5, 1, 1, 0, ''),
(32, '6630c4dc3f510', 6, 'another mery s ticket', 'another mery s ticket', 1, '1714472156', 5, 1, 1, 1, ''),
(33, '663104c703615', 6, 'Installation windows stagiaire', 'Installation windows stagiaire', 5, '1714488519', 5, 0, 1, 1, ''),
(34, '66310f207c028', 6, 'New', 'New', 9, '1714491168', 5, 0, 1, 1, ''),
(35, '66311a6513856', 7, 'first ticket', 'first ticket', 3, '1714494053', 7, 0, 1, 1, ''),
(36, '663c8c7a44d3a', 5, 'Echec de connexion', 'Echec de connexion', 3, '1715244154', 5, 0, 0, 1, ''),
(37, '66423da67d471', 5, 'test asssigned', 'test asssigned', 3, '1715617190', 5, 0, 0, 0, ''),
(38, '66432416d33e9', 5, 'Probleme technique', 'Probleme technique', 5, '1715676182', 5, 0, 1, 0, ''),
(39, '664c58b70576b', 5, 'Sujet1', 'Sujet1', 3, '1716279479', 5, 0, 1, 0, ''),
(40, '66546d1d16dfc', 5, 'prob code', 'prob code', 2, '1716808989', 5, 0, 0, 0, ''),
(41, '66546da0f32b3', 5, 'req name ?', 'req name ?', 1, '1716809120', 5, 0, 0, 0, ''),
(42, '6654915b6fae1', 5, 'now', 'now', 1, '1716818267', 5, 0, 0, 0, 'now ?'),
(43, '665495752497b', 5, 'subject test', 'description test', 1, '1716819317', 5, 0, 0, 0, ''),
(44, '6654968ec6d13', 5, 'test again', 'test', 2, '1716819598', 5, 0, 0, 0, 'test'),
(45, '665496d012ff9', 5, 'problem tech', 'Samiha a rencontré un probleme technique grave', 1, '1716819664', 5, 0, 0, 0, 'samiha');

-- --------------------------------------------------------

--
-- Structure de la table `hd_ticket_replies`
--

CREATE TABLE `hd_ticket_replies` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `text` text NOT NULL,
  `ticket_id` text NOT NULL,
  `date` varchar(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `hd_ticket_replies`
--

INSERT INTO `hd_ticket_replies` (`id`, `user`, `text`, `ticket_id`, `date`, `date_created`) VALUES
(1, 1, 'This is fixed', '1', '1634829030', '2024-04-30 12:20:12'),
(2, 1, 'Please check it.', '1', '1634829129', '2024-04-30 12:20:12'),
(3, 1, 'The issue is fixed, you can check at your end. Thanks', '2', '1634829404', '2024-04-30 12:20:12'),
(4, 2, 'fixed', '2', '1635515403', '2024-04-30 12:20:12'),
(5, 2, 'this is fixed!', '4', '1635517083', '2024-04-30 12:20:12'),
(6, 1, 'I am looking into this', '5', '1635519340', '2024-04-30 12:20:12'),
(7, 2, 'ewtewt', '6', '1635519418', '2024-04-30 12:20:12'),
(8, 2, 'bien fixé', '7', '1713429355', '2024-04-30 12:20:12'),
(9, 2, 'lorem ipsum', '7', '1713429400', '2024-04-30 12:20:12'),
(10, 1, 'bien fixé', '7', '1713429467', '2024-04-30 12:20:12'),
(11, 1, 'bien fixé\r\n', '7', '1713429542', '2024-04-30 12:20:12'),
(12, 5, 'je vais voir', '10', '1713431566', '2024-04-30 12:20:12'),
(13, 5, 'bien installé', '9', '1713431615', '2024-04-30 12:20:12'),
(14, 5, 'reinitialise le svp', '8', '1713431864', '2024-04-30 12:20:12'),
(15, 5, 'im salma\r\n', '12', '1713864395', '2024-04-30 12:20:12'),
(16, 5, 'message from salma', '29', '1714465805', '2024-04-30 12:20:12'),
(17, 5, 'try\r\n', '30', '1714468250', '2024-04-30 12:20:12'),
(18, 5, 'try\r\nagain', '30', '1714468260', '2024-04-30 12:20:12'),
(19, 5, 'ok\r\n', '30', '1714468299', '2024-04-30 12:20:12'),
(20, 5, 'great', '30', '1714468370', '2024-04-30 12:20:12'),
(21, 5, 'test', '30', '1714468406', '2024-04-30 12:20:12'),
(22, 5, 'ok', '30', '1714468456', '2024-04-30 12:20:12'),
(23, 6, 'mery : you received this ?', '32', '1714472173', '2024-04-30 12:20:12'),
(24, 6, 'ok', '8', '1714472203', '2024-04-30 12:20:12'),
(25, 5, 'sal : yes', '32', '1714474227', '2024-04-30 12:20:12'),
(26, 5, 'time ???', '32', '1714474261', '2024-04-30 12:20:12'),
(27, 5, '?\r\n', '32', '1714475144', '2024-04-30 12:20:12'),
(28, 5, 'aloha\r\n', '31', '1714486866', '0000-00-00 00:00:00'),
(29, 5, 'ok', '33', '1714489058', '0000-00-00 00:00:00'),
(30, 5, 'alright', '33', '1714489196', '0000-00-00 00:00:00'),
(31, 5, 'nope ?\r\n', '33', '1714489252', '0000-00-00 00:00:00'),
(32, 5, 'again ?\r\n', '33', '1714489285', '0000-00-00 00:00:00'),
(33, 5, 'nothing -', '33', '1714489951', '0000-00-00 00:00:00'),
(34, 6, 'New message here\r\n', '34', '1714491361', '0000-00-00 00:00:00'),
(35, 5, 'merci meryem\r\n', '34', '1715617234', '0000-00-00 00:00:00'),
(36, 5, 'salma : \r\n', '39', '1716538176', '0000-00-00 00:00:00'),
(37, 5, 'another reply from salma\r\n', '39', '1716538440', '0000-00-00 00:00:00');

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
(6, 'meryem@tdm.com', '202cb962ac59075b964b07152d234b70', '2024-04-18 09:40:50', 'meryem', 'user', 1),
(7, 'ayoub@tdm.com', '202cb962ac59075b964b07152d234b70', '2024-04-30 09:48:58', 'ayoub', 'user', 1),
(8, 'ilham@tdm.com', '202cb962ac59075b964b07152d234b70', '2024-05-20 14:17:07', 'ilham', 'user', 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `hd_tickets`
--
ALTER TABLE `hd_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT pour la table `hd_ticket_replies`
--
ALTER TABLE `hd_ticket_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT pour la table `hd_users`
--
ALTER TABLE `hd_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
