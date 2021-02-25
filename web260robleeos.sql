-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2021 at 10:36 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `web260robleeos`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_to_cart` (IN `uid` CHAR(32), IN `pid` MEDIUMINT, IN `qty` TINYINT)  BEGIN
DECLARE cid INT;
SELECT id INTO cid FROM cart WHERE user_session_id=uid AND product_id=pid;
IF cid > 0 THEN
UPDATE cart SET quantity=quantity+qty, date_modified=NOW() WHERE id=cid;
ELSE 
INSERT INTO cart (user_session_id, product_id, quantity) VALUES (uid, pid, qty);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cart_contents` (IN `uid` CHAR(32))  BEGIN
SELECT p.id, c.quantity, cat.category, p.title, p.price, p.stock FROM cart AS c INNER JOIN product AS p ON c.product_id=p.id INNER JOIN categories AS cat ON cat.id=p.category WHERE c.user_session_id=uid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_from_cart` (IN `uid` CHAR(32), IN `pid` MEDIUMINT)  BEGIN
DELETE FROM cart WHERE user_session_id=uid AND product_id=pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_cart` (IN `uid` CHAR(32), IN `pid` MEDIUMINT, IN `qty` TINYINT)  BEGIN
IF qty > 0 THEN
UPDATE cart SET quantity=qty, date_modified=NOW() WHERE user_session_id=uid AND product_id=pid;
ELSEIF qty = 0 THEN
CALL remove_from_cart (uid, pid);
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_session_id` char(32) NOT NULL,
  `product_id` mediumint(8) UNSIGNED NOT NULL,
  `quantity` tinyint(3) UNSIGNED NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_session_id`, `product_id`, `quantity`, `date_created`, `date_modified`) VALUES
(21, '37895c15c64a693f6504ea04f29f2ec3', 5, 1, '2020-05-03 16:46:28', '2020-05-03 16:46:28'),
(22, '37895c15c64a693f6504ea04f29f2ec3', 2, 1, '2020-05-03 16:46:33', '2020-05-03 16:46:33'),
(27, 'eedb1ab390d4b67a5fa7ba6ad357b747', 32, 1, '2021-01-30 15:32:17', '2021-01-30 15:32:17'),
(28, 'eedb1ab390d4b67a5fa7ba6ad357b747', 13, 1, '2021-01-30 15:32:25', '2021-01-30 15:32:25'),
(29, 'eedb1ab390d4b67a5fa7ba6ad357b747', 20, 1, '2021-01-30 15:32:31', '2021-01-30 15:32:31'),
(30, 'eedb1ab390d4b67a5fa7ba6ad357b747', 34, 3, '2021-01-30 15:32:39', '2021-01-30 15:33:50'),
(31, 'eedb1ab390d4b67a5fa7ba6ad357b747', 15, 1, '2021-01-30 15:33:35', '2021-01-30 15:33:35'),
(32, 'eedb1ab390d4b67a5fa7ba6ad357b747', 18, 1, '2021-01-30 15:33:43', '2021-01-30 15:33:43');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `category` varchar(40) NOT NULL,
  `image` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `image`) VALUES
(1, 'Marvel', 'marvel.png'),
(2, 'Star-Wars', 'starwars.png'),
(3, 'Uncategorized', 'uncategorized.png');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(80) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `address1` varchar(80) NOT NULL,
  `address2` varchar(80) DEFAULT NULL,
  `city` varchar(60) NOT NULL,
  `state` char(2) NOT NULL,
  `zip` mediumint(5) UNSIGNED ZEROFILL NOT NULL,
  `phone` int(10) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_contents`
--

CREATE TABLE `order_contents` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_type` enum('coffee','other','sale') DEFAULT NULL,
  `product_id` mediumint(8) UNSIGNED NOT NULL,
  `quantity` tinyint(3) UNSIGNED NOT NULL,
  `price_per` decimal(5,2) UNSIGNED NOT NULL,
  `ship_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `featured` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `title`, `description`, `price`, `category`, `stock`, `image`, `featured`) VALUES
(1, 'Ashe Pop', 'From Overwatch.\r\n6 inch bobble head figure.', '8.99', 3, 2, 'ashe.jpg', 1),
(2, 'Bastian Pop', 'From Overwatch.\r\n6 inch bobble head.', '9.99', 3, 1, 'bastian.jpg', 0),
(3, 'Groot Pop', 'From Marvel\'s Guardian\'s of the Galaxy.\r\n6 inch bobble head.', '8.99', 1, 1, 'groot.jpg', 1),
(4, 'Nebula Pop', 'From Marvel\'s Guardian\'s of the Galaxy.\r\n6 inch bobble head figure', '5.99', 1, 1, 'nebula.jpg', 0),
(5, 'Porg Pop', 'From Star Wars\r\n6 inch bobble head', '8.99', 2, 1, 'porg.jpg', 1),
(6, 'Wonder Woman Pop', 'From the DC Universe.\r\n6 inch bobble head.', '9.99', 3, 1, 'wonderW.jpg', 0),
(11, 'The Child Pop', 'From Star Wars\' hit new series, The Mandalorian. Standard 4 inch bobble head figure. Ships in original packaging.', '8.99', 2, 1, 'child.jpg', 1),
(12, 'Kuiil Pop', 'From Star Wars\' hit new series, The Mandalorian. Standard 4 inch bobble head figure. Ships in original packaging.', '8.99', 2, 1, 'kuiil.jpg', 0),
(13, 'Reinhardt (Glow) Pop', 'aka Coldhart Skin. New York Comic Con exclusive. From the hit game Overwatch. 6 inch sized figure. Ships in original packaging.', '10.99', 3, 2, 'coldhart.jpg', 0),
(14, 'Supreme Leader Kylo Ren Pop', 'From Star Wars. 6 inch sized bobble head figure. Ships in original packaging.', '10.99', 2, 3, 'leadren.jpg', 0),
(15, 'Ahsoka Tano (Glow) Pop', 'Hot Topic Exclusive. From Star Wars\' hit series, Rebels. 6 inch holographic bobble head. Ships in original packaging.', '10.99', 2, 4, 'HoloTano.jpg', 0),
(16, 'Dr. Evil Pop', 'From Austin Powers Movie collection. 4 inch figure. Ships in original packaging.', '8.99', 3, 5, 'evil.jpg', 0),
(17, 'Avengers Assemble Iron Man Pop', 'Amazon Exclusive. From Marvel\'s Avengers. 6 inch bobble head figure. Ships in original packaging. ', '10.99', 1, 4, 'aironman.jpg', 0),
(18, 'Pharah Pop', 'Amazon Exclusive. From the hit game Overwatch. 4 inch bobble head figure. Ships in original packaging.', '8.99', 3, 1, 'pharah.jpg', 0),
(19, 'Austin Powers Pop', 'From the Austin Powers movie collection. 4 inch figure. Ships in original packaging.', '8.99', 3, 1, 'powers.jpg', 0),
(20, 'Ahsoka Tano Pop', 'Hot Topic Exclusive. From Star Wars\' hit series, Rebels. 6 inch bobble head. Ships in original packaging.', '10.99', 2, 1, 'tano.jpg', 0),
(21, 'Darth Vader (Electrocuted) Pop', 'From the Star Wars movie collection. 4 inch bobble head figure. Ships in original packaging.', '8.99', 2, 5, 'evader.jpg', 0),
(22, 'Chewbacca Pop', 'From the Star Wars movie collection. 4 inch bobble head. Ships in original packaging.', '8.99', 2, 6, 'bacca.jpg', 0),
(23, 'Nova (Metallic) Pop', 'PX Previews exclusive. From the Marvel collection. 4 inch bobble head figure. Ships in original packaging.', '8.99', 1, 3, 'nova.jpg', 1),
(24, 'Iron Man (Gold Chrome) Pop', 'From the Marvel movie collection. 4 inch bobble head figure. Ships in original packaging.', '8.99', 1, 3, 'gironman.jpg', 0),
(25, 'Porg (Flocked) Pop', 'Hot Topic exclusive flocked edition. 4 inch bobble head figure. Ships in original packaging.', '10.99', 2, 2, 'porg.jpg', 0),
(26, 'Groot (Holiday) Pop', 'From the Marvel movie collection. 4 inch bobble head figure. Ships in original packaging.', '8.99', 1, 2, 'hgroot.jpg', 0),
(27, 'Gamora Pop', 'San Diego Comic Con exclusive. From the Marvel movie collection. 4 inch bobble head figure. Ships in original packaging.', '10.99', 1, 3, 'gamora.jpg', 0),
(28, 'Cara Dune Pop', 'From Star Wars\' hit new series, The Mandalorian. 4 inch bobble head figure. Ships in original packaging.', '8.99', 2, 5, 'dune.jpg', 0),
(29, 'Genji Pop', 'Blizzard exclusive. From the game Overwatch. 4 inch bobble head figure. Ships in original packaging.', '10.99', 3, 2, 'genji.jpg', 0),
(30, 'Kylo Ren (Masked) Pop', 'From the Star Wars movie collection. 4 inch bobble head figure. Does NOT ship in original packaging.', '4.99', 2, 3, 'mren.jpg', 0),
(31, 'Venomized Loki Pop', 'From the Marvel Collection. 4 inch bobble head figure. Ships in original packaging.', '8.99', 1, 2, 'vloki.jpg', 0),
(32, 'Greef Karga Pop', 'From Star Wars\' hit new series, The Mandalorian. 4 inch bobble head figure. Ships in original packaging.', '8.99', 2, 1, 'greefkarga.jpg', 0),
(33, 'The Armorer Pop', 'From Star Wars\' hit new series, The Mandalorian. 4 inch bobble head figure. Ships in original packaging.', '8.99', 2, 2, 'armorer.jpg', 0),
(34, 'Thor (Holiday) Pop', 'From the Marvel collection. 4 inch bobble head figure. Ships in original packaging.', '8.99', 1, 2, 'hthor.jpg', 0),
(35, 'Marty McFly Pop', 'From the Back to the Future movie collection. 4 inch figure. Ships in original packaging.', '8.99', 3, 1, 'mcfly.jpg', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `order_contents`
--
ALTER TABLE `order_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ship_date` (`ship_date`),
  ADD KEY `product_type` (`product_type`,`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_contents`
--
ALTER TABLE `order_contents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
