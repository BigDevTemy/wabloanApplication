-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 15, 2022 at 01:21 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bilfg`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
CREATE TABLE IF NOT EXISTS `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) NOT NULL,
  `request` varchar(20) NOT NULL,
  `type` enum('approve','reject','') NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `comment` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `request` (`request`)
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=utf8 COMMENT='Store approve and reject requests';

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
CREATE TABLE IF NOT EXISTS `booking` (
  `id` varchar(20) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL,
  `warehousecode` varchar(3) NOT NULL,
  `customerid` int(11) NOT NULL,
  `date_needed` varchar(11) CHARACTER SET utf8 NOT NULL,
  `date` varchar(11) CHARACTER SET utf8 NOT NULL,
  `approved_date` varchar(11) DEFAULT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `booking_details`
--

DROP TABLE IF EXISTS `booking_details`;
CREATE TABLE IF NOT EXISTS `booking_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_id` varchar(20) CHARACTER SET utf8 NOT NULL,
  `productid` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `status` varchar(11) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_accounts`
--

DROP TABLE IF EXISTS `bpl_accounts`;
CREATE TABLE IF NOT EXISTS `bpl_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(50) CHARACTER SET utf8 NOT NULL,
  `beneficiary` int(11) NOT NULL,
  `intermediary` int(11) DEFAULT NULL,
  `correspondent` int(11) DEFAULT NULL,
  `further_acc` varchar(100) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`beneficiary`,`currency_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_banks`
--

DROP TABLE IF EXISTS `bpl_banks`;
CREATE TABLE IF NOT EXISTS `bpl_banks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `number` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `sortcode` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `swiftcode` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `address` text CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `account` (`name`,`number`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_bill_of_lading`
--

DROP TABLE IF EXISTS `bpl_bill_of_lading`;
CREATE TABLE IF NOT EXISTS `bpl_bill_of_lading` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `packing_id` int(11) NOT NULL,
  `number` varchar(100) NOT NULL,
  `issued_date` varchar(11) NOT NULL,
  `shipped_date` varchar(11) NOT NULL,
  `arrival_date` varchar(11) DEFAULT NULL,
  `doc` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`packing_id`),
  UNIQUE KEY `ladingNumber` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_customers`
--

DROP TABLE IF EXISTS `bpl_customers`;
CREATE TABLE IF NOT EXISTS `bpl_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  `customername` varchar(255) CHARACTER SET utf8 NOT NULL,
  `customerlabel` varchar(20) CHARACTER SET utf8 NOT NULL,
  `customercountry` varchar(50) CHARACTER SET utf8 NOT NULL,
  `customeraddress` text CHARACTER SET utf8 NOT NULL,
  `customertelephone` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `port` varchar(100) CHARACTER SET utf8 NOT NULL,
  `fax` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `products` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`products`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customername` (`customername`),
  UNIQUE KEY `customerlabel` (`customerlabel`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bpl_customers`
--

INSERT INTO `bpl_customers` (`id`, `type`, `customername`, `customerlabel`, `customercountry`, `customeraddress`, `customertelephone`, `port`, `fax`, `email`, `products`, `created_at`, `deleted_at`) VALUES
(1, 'Export', 'S.I.C.I.E LDA Luanda Angola ', 'S.I.C.I.E.', 'Angola', 'Estrada de Viana, KM 14 Sector 4, Quarteiroes A, Casa No: 985, Bairro Vila Nova Luanda - Angola', '+22494383795', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(2, 'Export', 'Societe Jean Azar', 'SJA', 'BENIN', '71 Avenue Delorme - BP 2517 - Cotonou - Benin', '+22921314729', 'Cotonou', '', 'rcheid.tohme@azarjeangroup.com', '[]', '2020-03-25 16:28:01', NULL),
(3, 'Export', 'Henri Et Freres Sarl', 'HENRI & FRERES', 'Cameroon', 'Yaounde - Cameroun - BP:31026', '+23722238009', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(4, 'Export', 'Mbosafi Et Compagnie', 'MBOSAFI', 'CAMEROON', 'Bassa Douala - BP:15348 - Cameroon', '+237671634523', '', '', 'mbosafi.et@ymail.com', '[]', '2020-03-25 16:28:01', NULL),
(5, 'Export', 'Sitracel', 'SITRACEL', 'CAMEROON', 'Yaounde - BP: 6813 Carrefour Obobogo - Cameroon', '+23799819722', 'Douala', '', 'info@sitracel.com', '[]', '2020-03-25 16:28:01', NULL),
(6, 'Export', 'Acipac', 'ACIPAC', 'COTE D\'IVOIRE', 'Zone Industrielle - Yopougon - Abidjan - Cote D\'ivoire', '+22523466321', '', '', 'acipac@acipac.ci', '[\"922\"]', '2020-03-25 16:28:01', NULL),
(7, 'Export', 'ETS ATCHOUM', 'ETS', 'COTE D\'IVOIRE', '05 BP 2200 Abidjan 05', '+25507891122', 'Abidjan', '', 'serap@ae.co.za', '[]', '2020-03-25 16:28:01', NULL),
(8, 'Export', 'Satoci', 'SATOCI', 'Ivory Coast', 'Youpougon - Zone Industrielle - Abidjan - Cote D\'ivoire', '+22523535840', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(9, 'Export', 'Sopatga', 'SOPATGA', 'Gabon', 'Societe Papyrus de Transformation de l\'Ouate de cellulose au Gabon BP: 16212 Libreville', '+24107515156', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(10, 'Export', 'Benon Associates', 'BENON', 'GAMBIA', 'Christ Church Business Complex - Serrekunda - BANJUL - GAMBIA', '+2207079882', 'Banjul', '', 'benon@gmail.com', '[]', '2020-03-25 16:28:01', NULL),
(11, 'Export', 'Delta Paper Mill Ghana', 'Delta Paper Mill', 'GHANA', 'Community 12, Motor Light Industrial Area - Tema - GHANA', '+233507315615', 'Tema', '', 'dany.skaf@deltapapermill.com', '[\"7\", \"8\", \"14\"]', '2020-03-25 16:28:01', NULL),
(12, 'Export', 'Everpack Ltd', 'EVERPACK', 'GHANA', 'Ring Road W.S. Industrial Area\nP.O Box - 4216 Accra, Ghana', '+233244328328', 'ACCRA', '', 'everpack@hotmail.com', '[\"498\"]', '2020-03-25 16:28:01', NULL),
(13, 'Export', 'Fon Limited', 'FON', 'GHANA', 'PO BOX 10254 - Accra North - GHANA', '+233302235053', 'TEMA', '', 'william@thefongroup.com', '[]', '2020-03-25 16:28:01', NULL),
(14, 'Export', 'J T Industries Alpha', 'JT Industries', 'Ghana', 'PO BOX 1007 - Accra North - GHANA', '+233303964778', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(15, 'Export', 'Ikemary-Mac Ltd', 'Ikemary-Mac', 'Ghana', 'Opposite Valley View University - Oyibi - Accra - GHANA', '+233542346670', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(16, 'Export', 'Freenex', 'Freenex', 'Lebanon', 'Panorama Building, Ground Floor - Aramoun - Mount Lebanon - Lebanon', '+96178888756', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(17, 'Local', 'Belimpex Limited', 'BEL Impex Ltd.', 'Nigeria', 'Plot 10, Block-D Acme Road, Ogba Industrial Estate, Ikeja, Lagos , Nigeria.', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(18, 'Export', 'Paper Industry(Global Stock)', 'Paper Industry', 'Senegal', 'KM 10 BCCF - Dakkar - SENEGAL', '+221776374145', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(19, 'Export', 'Saft-Societe Africaine De Fabrication Et De Tran', 'SAFT', 'SENEGAL', 'Rue 1 Angle Q - Dekre - Dakkar - SENEGAL', '+2218243175', 'Dakkar', '', 'saft@arc.sn', '[]', '2020-03-25 16:28:01', NULL),
(20, 'Export', 'Transpaps', 'TRANSPAPS', 'Senegal', 'KM 5 Route de Rufisque -  Dakkar - SENEGAL', '+221338326944', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(21, 'Local', 'Rotech Osun', 'ROTECH', 'Nigeria', 'Federal Republic of Nigeria', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(22, 'Local', 'Gugel', 'GUGEL', 'Nigeria', 'Federal Republic of Nigeria', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(23, 'Local', 'Banrut', 'BANRUT', 'Nigeria', 'Federal Republic of Nigeria', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(24, 'Local', 'Local Customer', 'LOCAL CUSTOMER', 'Nigeria', 'Federal Republic of Nigeria', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(25, 'Export', 'Alpha High', 'ALPHA HIGH', 'Ghana', 'GHANA', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(26, 'Local', 'Low Stock', 'LOW STOCK', 'Nigeria', 'Local Customer', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(27, 'Local', 'Food Max', 'FOOD MAX', 'Nigeria', 'Federal Republic of Nigeria', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(28, 'Local', 'A & H', 'A & H', 'NIGERIA', 'Federal Republic of Nigeria', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(29, 'Export', 'Pure Ouate de Cellulose', 'PURE OUATE', 'Ivory Coast', 'ZI de Yopougon, 21 BP 4806 Abidjan 21, Ivory Coast', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(30, 'Export', 'Care Roll And Tissue Company', 'CARE ROLL', 'GHANA', 'Battis Office House 2 . Opposite KPOGAS FURNITURE\nSPINTEX ROAD\nPO BOX CT 1412\nACCRA GHANA', '+233249676042', '', '', 'prosper@battisgroup.com.gh', '[]', '2020-03-25 16:28:01', NULL),
(31, 'Local', 'Wemy Industries Ltd', 'WEMY', 'Nigeria', '110-113 Demurin St, Oba-Nle-Aro Bus Stop, Alapere Road, Ketu, Lagos', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(32, 'Export', 'Societe D Emballage duSenegal', 'SES SARL', 'Senegal', '02, Rue Vincens x Faidherbe, Dakar, Senegal', '+221781777777', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(33, 'Export', 'PURITEX Enterprise', 'PURITEX', 'Ghana', 'DS 411, Dansoman Estates, Accra, Ghana ', '+2332446443137', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(34, 'Export', 'MAKO INDUSTRIES SA', 'MAKO', 'Cameroon', 'BP 10197, YAOUNDE, CAMEROUN', '+237680625137', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(35, 'Export', 'NANO', 'NANO', 'Ivory Coast', 'ZI DE YOPOUGON, 21 BP 4806 ABIDJAN 21, IVORY COAST', '+22559015000', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(36, NULL, 'FINA', 'FINA', 'Nigeria', 'Federal Republic of Nigeria', '+2348182055447', '', '', 'fina@yahoo.com', '[]', '2020-03-25 16:28:01', NULL),
(37, NULL, 'FC Morning Star', 'FC MORNING STAR', 'Nigeria', 'Federal Republic of Nigeria', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(38, 'Export', 'PK GROUP', 'PK GROUP GHANA ', 'Ghana', 'PK GROUP GHANA LTD Near Yoo Super Market Adenta Frafra, off Dodowa Road Accra - Ghana', '+233543701600', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(39, 'Export', 'KABACHA ', 'KABACHA ', 'Ghana', 'KABACHA SERVICES HOUSE NUMBER: AH 1/85 WESTERN REGION , TARKWA, AHWETIESO , GHANA', NULL, '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(40, 'Export', 'VITCO', 'ETS VITCO', 'Nicaragua', 'Ets Vitalys Congo ( VITCO ) 13 eme rue Limete Industrial Num 3 Kinshasa Gombe DRC ', '+243998692299', '', '', 'contact@belimpex.ng', NULL, '2020-03-25 16:28:01', NULL),
(41, 'Export', 'LEXTA', 'LEXTA GHANA LTD', 'Ghana', 'LEXTA Ghana LTD LEXTA SQUARE , Olusegun Obasanjour Road Ebony Crescent, Accra, GHANA', '+233243632803', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(42, 'Export', 'Societe Africaine De Papier', 'SAP', 'Mali', 'SAP ( Societe Africaine de Papier) Zone Industrielle - Route de Sotuba Porte 3709 , BP E2709 Bamako , Mali', '+22320213939', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(43, 'Export', 'BATTIS', 'BATTIS ', 'Ghana', 'BATTIS OFFICE HOUSE 2 - OPPOSITE KPOGAS FURNITURE SPINTEX ROAD PO BOX CT 1412 ACCRA - GHANA', '+233249676042', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(44, 'Export', 'PRO-AXE CAMEROUN', 'PRO AXE', 'Cameroon', 'Pro - Axe Cameroun,Douala-Cameroun-BP 12536', '+237233438733', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(45, 'Export', 'Kingdom Books And Stationery', 'KINGDOM', 'GHANA', 'OSU AKU ADJEI\n\nOpposite Swan Clinic. La-Accra Road\n\nAccra-Ghana', '+233244341970', 'Accra', '', 'alfred.gyateng@kingdomgh.com', '[]', '2020-03-25 16:28:01', NULL),
(49, 'Export', 'TECHNIPLAST', 'TECHNIPLAST', 'Togo', 'Harbor Zone , Ramatou Cross Lome , Togo', '+22822711040', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(50, 'Export', 'IFOOD', 'IFOOD', 'Senegal', 'KM9 ROUTE DE RUFSIQUE, DAKAR, SENEGAL', '+221338344215', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(52, 'Export', 'LESDY COMPANY LIMITED', 'LESDY', 'Ghana', 'C20/1 ADAMA AVENUE,ADABRAKA,ACCRA,GHANA', '+233 244601721', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(53, 'Export', 'TAPRIMA', 'TAPRIMA', 'Cameroon', 'Douala Cameroon', '+23775405582', '', NULL, NULL, NULL, '2020-03-25 16:28:01', NULL),
(54, 'Export', 'Flamingo Paper Ltd.', 'FLAMINGO PAPER', 'GHANA', 'Cocoa Village EFFIA INDUSTRIAL AREA P.O BOX AX 1589 TAKORADI', '+233312020250', '', '', 'md@flamingopaper.org', '[\"84\", \"415\", \"525\"]', '2020-03-25 16:28:01', NULL),
(55, 'Export', 'ACC', 'ACC', 'GUINEA', 'Domino, Coleah, Guinea Conakry ', '+224660635663', '', '', 'ali.chehab@hotmail.fr', '[\"906\", \"907\"]', '2020-04-04 13:46:50', NULL),
(56, 'Export', 'PRAK Industries Ltd.', 'PRK', 'GHANA', 'Prak Building, N 15-18 Ofaako\nKasoa Bawdjiase Road, Kasoa Central Region,  Ghana.', '+233303972284', 'ACCRA', '', 'r.oansah@prakgroup.com', '[]', '2020-06-05 13:50:56', NULL),
(57, 'Export', 'Ghana Rubber Products Limited', 'GHANA RUBBER', 'GHANA', '7, Adjuma Crescent, Ring Road South Industrial Area, Accra, Ghana.', '+233302221771', 'Accra', '+233-302-220185', 'info@ghanarubber.com', '[]', '2020-07-20 14:06:38', NULL),
(58, 'Export', 'ALPHA LINK INVESTMENTS', 'ALINK', 'GHANA', 'ALPHA LINK INVESTMENTS\nP.O. BOX BT 276\nCOMMUNITY 2. TEMA. GHANA', '+233544461800', 'Tema', '', 'fadjeimensah@yahoo.com', '[]', '2020-07-24 07:38:31', NULL),
(59, 'Export', 'TEMITUNJI TRADING STORE', 'TEMITUNJI', 'BENIN', 'COTONOU, BENIN', '', 'COTONOU', '', '', '[\"3564\"]', '2021-01-12 09:21:53', NULL),
(61, 'Local', 'Temiloluwa Odewumi', '012', 'ANGOLA', 'Ibadan', '0803', '1004', '', 'hademylola@gmail.com', '[\"5\"]', '2021-11-11 08:21:13', '2021-11-11 08:21:19'),
(63, 'Local', 'Vincent Odewumi', '1001', '', '', '', '', '', '', '[]', '2021-11-11 08:55:15', '2021-11-11 08:57:51'),
(64, 'Export', 'Geoffery Odewumi', '20001', 'ARGENTINA', 'No 5, Olaoluwa,VI ', '+2348033376687', '2001', '2001', 'hademylola@gmail.com', '[\"6\"]', '2021-11-11 08:57:33', '2021-11-11 08:57:51'),
(65, 'Local', 'jhv', 'jhb', 'NIGERIA', '', '', '', '', '', '[]', '2021-11-11 10:36:46', NULL),
(66, 'Local', 'Rahi Fletcher', '102', '', '', '', '', '', '', '[]', '2021-11-11 10:40:53', '2021-11-11 10:41:02'),
(67, 'Local', 'Ademilola ODewumi', '2001', '', '', '+2347060934005', '2001', '', '', '[]', '2021-11-11 14:13:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bpl_delivery`
--

DROP TABLE IF EXISTS `bpl_delivery`;
CREATE TABLE IF NOT EXISTS `bpl_delivery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `vechile_number` varchar(255) DEFAULT NULL,
  `loader` varchar(255) DEFAULT NULL,
  `driver` varchar(255) DEFAULT NULL,
  `truck_weight` varchar(255) DEFAULT NULL,
  `container_number` varchar(255) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_delivery`
--

INSERT INTO `bpl_delivery` (`id`, `customer_name`, `date`, `vechile_number`, `loader`, `driver`, `truck_weight`, `container_number`, `created_at`, `updated_at`) VALUES
(4, 'A & H', '2021/09/24', 'sddf-444', 'james', 'fgu', '1500', '145254fgf', '2021-09-24T14:34:58.502Z', '2021-09-24T14:34:58.502Z'),
(8, 'ACC', '2021/10/20', 'sddf-444', 'james', 'fgu', '3000', '1500', '2021-10-20T10:12:24.257Z', '2021-10-20T10:12:24.257Z'),
(9, 'A & H', '2021/10/20', 'sddf-444', 'james', 'fgu', '5000', '3500', '2021-10-20T10:17:16.660Z', '2021-10-20T10:17:16.660Z');

-- --------------------------------------------------------

--
-- Table structure for table `bpl_delivery_barcode`
--

DROP TABLE IF EXISTS `bpl_delivery_barcode`;
CREATE TABLE IF NOT EXISTS `bpl_delivery_barcode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_barcode` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `deleted_at` varchar(255) NOT NULL,
  `created_at` varchar(255) NOT NULL,
  `updated_at` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `full_weight` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_delivery_barcode`
--

INSERT INTO `bpl_delivery_barcode` (`id`, `delivery_barcode`, `status`, `deleted_at`, `created_at`, `updated_at`, `date`, `full_weight`) VALUES
(8, '20-10-21-BPD-001', 'pending', '', '2021/10/20', '21-10-20', '21-10-20', '0'),
(4, '24-09-21-BPD-001', 'completed', '', '2021/09/24', '21-09-24', '21-09-24', '1557'),
(9, '20-10-21-BPD-009', 'completed', '', '2021/10/20', '21-10-20', '21-10-20', '16000');

-- --------------------------------------------------------

--
-- Table structure for table `bpl_delivery_details`
--

DROP TABLE IF EXISTS `bpl_delivery_details`;
CREATE TABLE IF NOT EXISTS `bpl_delivery_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bpl_delivery_id` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `delivery_barcode` varchar(255) NOT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_delivery_details`
--

INSERT INTO `bpl_delivery_details` (`id`, `bpl_delivery_id`, `barcode`, `product_id`, `delivery_barcode`, `created_at`, `updated_at`) VALUES
(18, '9', '21-09-21-M2-004', '42', '20-10-21-BPD-009', '21-10-20', '21-10-20'),
(17, '9', '21-09-21-M2-003', '1649', '20-10-21-BPD-009', '21-10-20', '21-10-20'),
(16, '9', '21-09-21-M2-002', '156', '20-10-21-BPD-009', '21-10-20', '21-10-20'),
(19, '9', '21-09-21-M3-001', '3586', '20-10-21-BPD-009', '21-10-20', '21-10-20'),
(20, '9', '21-09-21-M3-002', '103', '20-10-21-BPD-009', '21-10-20', '21-10-20');

-- --------------------------------------------------------

--
-- Table structure for table `bpl_factoryexit`
--

DROP TABLE IF EXISTS `bpl_factoryexit`;
CREATE TABLE IF NOT EXISTS `bpl_factoryexit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `barcode` varchar(20) CHARACTER SET utf8 NOT NULL,
  `location_id` tinyint(4) NOT NULL,
  `date` varchar(20) CHARACTER SET utf8 NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_factoryexit`
--

INSERT INTO `bpl_factoryexit` (`id`, `user`, `barcode`, `location_id`, `date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 'admin', '21-11-30-M2-001', 1, '2021/12/01', NULL, '2021-12-01 15:03:23', NULL, NULL),
(4, 'admin', '21-11-29-M3-001', 2, '2021/12/01', NULL, '2021-12-01 15:04:01', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bpl_grades`
--

DROP TABLE IF EXISTS `bpl_grades`;
CREATE TABLE IF NOT EXISTS `bpl_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gradename` tinytext CHARACTER SET utf8 NOT NULL,
  `type` varchar(15) CHARACTER SET utf8 NOT NULL,
  `grade` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gradetype` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_grades`
--

INSERT INTO `bpl_grades` (`id`, `gradename`, `type`, `grade`, `deleted_at`) VALUES
(1, 'Economy Bathroom Tissue', 'EBT', 'Economy', NULL),
(2, 'Economy Table Napkin', 'ETN', 'Economy', NULL),
(3, 'Premium Bathroom Tissue', 'PBT', 'Premium', NULL),
(4, 'Premium Bathroom Tissue', 'PBTB', 'Premium', NULL),
(5, 'Premium Bathroom Tissue', 'PBTP', 'Premium', NULL),
(6, 'Premium Bathroom Tissue', 'PBTS', 'Premium', NULL),
(7, 'Premium Facial Tissue', 'PFT', 'Premium', NULL),
(8, 'Premium Kitchen Towel', 'PKT', 'Premium', NULL),
(9, 'Premium Table Napkin', 'PTN', 'Premium', NULL),
(10, 'Premium Wrap Tissue', 'PWT', 'Premium', NULL),
(11, 'Regular Bathroom tissue', 'RBT', NULL, NULL),
(12, 'Special Bathroom Tissue', 'SBT', 'Economy', NULL),
(13, 'Special Facial Tissue', 'SFT', 'Economy', NULL),
(14, 'Special Kitchen Towel', 'SKT', 'Economy', NULL),
(15, 'Special Table Napkin', 'STN', 'Economy', NULL),
(16, 'Special Wrap Tissue', 'SWT', 'Economy', NULL),
(17, 'Unbleached Bathroom Tissue', 'UBT', NULL, NULL),
(18, 'Unbleached Kitchen Towel', 'UKT', NULL, NULL),
(19, 'Value Bathroom Tissue', 'VBT', NULL, NULL),
(20, 'Premium Bathroom Tissue +', 'PBT+', 'Premium', NULL),
(22, 'Unbleached Table Napkin', 'UTN', 'Unbleached', NULL),
(23, 'Premium Table Napkin Peach', 'PTN(PEACH)', 'Premium', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bpl_invoice_payments`
--

DROP TABLE IF EXISTS `bpl_invoice_payments`;
CREATE TABLE IF NOT EXISTS `bpl_invoice_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `packing_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `date` varchar(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `packing_id` (`packing_id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_packing_list`
--

DROP TABLE IF EXISTS `bpl_packing_list`;
CREATE TABLE IF NOT EXISTS `bpl_packing_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `number` varchar(100) NOT NULL,
  `containers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`containers`)),
  `date` varchar(11) NOT NULL,
  `split` set('0','1') NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDENTIFIER` (`number`) USING BTREE,
  UNIQUE KEY `UNIQUE` (`order_id`,`number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_payment_terms`
--

DROP TABLE IF EXISTS `bpl_payment_terms`;
CREATE TABLE IF NOT EXISTS `bpl_payment_terms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_terms` varchar(150) NOT NULL,
  `days` int(4) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `terms` (`payment_terms`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_production`
--

DROP TABLE IF EXISTS `bpl_production`;
CREATE TABLE IF NOT EXISTS `bpl_production` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `papermachine` varchar(50) NOT NULL,
  `product_id` int(11) NOT NULL,
  `hardrollnumber` varchar(50) NOT NULL,
  `barcode` varchar(20) CHARACTER SET utf8 NOT NULL,
  `brightness` float NOT NULL,
  `corediameter` float DEFAULT NULL,
  `joints` int(11) NOT NULL,
  `paperweight` float NOT NULL,
  `weight` float NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `hold` varchar(30) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `dateofmanufacture` varchar(20) NOT NULL,
  `shift` set('Day','Night') CHARACTER SET utf8 NOT NULL DEFAULT 'Day',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `hardrollnumber` (`hardrollnumber`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_production`
--

INSERT INTO `bpl_production` (`id`, `username`, `customer_id`, `papermachine`, `product_id`, `hardrollnumber`, `barcode`, `brightness`, `corediameter`, `joints`, `paperweight`, `weight`, `status`, `hold`, `comments`, `dateofmanufacture`, `shift`, `deleted_at`, `timestamp`) VALUES
(1, 'clinton', 1, 'PM2', 1, 'M2211129-1A', '21-11-29-M2-001', 75, 185, 0, 386.11, 1000, NULL, NULL, '', '2021/11/29', 'Day', NULL, '2021-11-29 14:10:37'),
(2, 'vincent', 1, 'PM3', 1, 'M3211129-1A', '21-11-29-M3-001', 75, 185, 0, 579.17, 1500, 'Exited', NULL, '', '2021/11/29', 'Day', NULL, '2021-11-29 14:13:13'),
(3, 'vincent', 2, 'PM2', 1, 'M2211129-2A', '21-11-29-M2-002', 75, 185, 0, 772.23, 2000, NULL, NULL, '', '2021/11/29', 'Day', NULL, '2021-11-29 14:14:59'),
(4, 'vincent', 3, 'PM3', 895, 'M3211129-2A', '21-11-29-M3-002', 55, 200, 0, 3858.78, 1400, 'Exited', NULL, '', '2021/11/29', 'Day', NULL, '2021-11-29 14:15:34'),
(5, 'vincent', 1, 'PM2', 2, 'M2211130-3A', '21-11-30-M2-001', 75, 500, 0, 5936.59, 1500, 'Exited', NULL, '', '2021/11/30', 'Day', NULL, '2021-11-30 13:31:44'),
(6, 'vincent', 17, 'PM3', 2, 'M3211130-3A', '21-11-30-M3-001', 75, 900, 0, 4141.13, 500, 'Exited', NULL, '', '2021/11/30', 'Day', NULL, '2021-11-30 13:32:07'),
(7, 'clinton', 3, 'PM2', 887, 'M2211130-4A', '21-11-30-M2-002', 67, 180, 0, 2024.51, 1500, NULL, NULL, '', '2021/11/30', 'Day', NULL, '2021-11-30 14:34:04'),
(8, 'clinton', 3, 'PM3', 875, 'M3211130-4A', '21-11-30-M3-002', 86, 200, 0, 133.48, 1800, NULL, NULL, '', '2021/11/30', 'Day', NULL, '2021-11-30 14:34:35'),
(9, 'clinton', 5, 'PM2', 120, 'M2211130-5A', '21-11-30-M2-003', 75, 200, 0, 391.5, 2000, NULL, NULL, '', '2021/11/30', 'Day', NULL, '2021-11-30 14:34:59'),
(10, 'clinton', 5, 'PM3', 32, 'M3211130-5A', '21-11-30-M3-003', 72, 200, 0, 5626.45, 1700, NULL, NULL, '', '2021/11/30', 'Day', NULL, '2021-11-30 14:35:24'),
(11, 'clinton', 66, 'PM2', 2432, 'M2211130-6A', '21-11-30-M2-004', 87, 200, 0, 442.86, 1500, NULL, NULL, '', '2021/11/30', 'Day', NULL, '2021-11-30 14:37:04');

-- --------------------------------------------------------

--
-- Table structure for table `bpl_products`
--

DROP TABLE IF EXISTS `bpl_products`;
CREATE TABLE IF NOT EXISTS `bpl_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `old` varchar(200) DEFAULT NULL,
  `productname` varchar(200) NOT NULL,
  `gradetype` varchar(20) NOT NULL,
  `brightness` float DEFAULT NULL,
  `gsm` float NOT NULL,
  `ply` int(11) NOT NULL,
  `width` float NOT NULL,
  `diameter` float NOT NULL,
  `slice` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productname` (`productname`)
) ENGINE=InnoDB AUTO_INCREMENT=3588 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_products`
--

INSERT INTO `bpl_products` (`id`, `old`, `productname`, `gradetype`, `brightness`, `gsm`, `ply`, `width`, `diameter`, `slice`, `deleted_at`) VALUES
(1, 'EBT 15.0 1P 256', 'EBT 15.0gsm 1p 256w 115d 1s', 'EBT', 75, 15, 1, 256, 115, 1, NULL),
(2, 'EBT 15.0 1P 30', 'EBT 15.0gsm 1p 30w 115d 4s', 'EBT', 75, 15, 1, 30, 115, 4, NULL),
(3, 'EBT 15.0 2P 130', 'EBT 15.0gsm 2p 130w 115d 1s', 'EBT', 73, 15, 2, 130, 115, 1, NULL),
(4, 'EBT 15.0 2P 30', 'EBT 15.0gsm 2p 30w 110d 4s', 'EBT', 75, 15, 2, 30, 110, 4, NULL),
(5, 'EBT 15.0 2P 30', 'EBT 15.0gsm 2p 30w 115d 4s', 'EBT', 75, 15, 2, 30, 115, 4, NULL),
(6, 'EBT 15.0 2P 30', 'EBT 15.0gsm 2p 30w 115d 5s', 'EBT', 75, 15, 2, 30, 115, 5, NULL),
(7, 'EBT 15.0 3P 130', 'EBT 15.0gsm 3p 130w 115d 1s', 'EBT', 72, 15, 3, 130, 115, 1, NULL),
(8, 'EBT 15.0 3P 254', 'EBT 15.0gsm 3p 254w 115d 1s', 'EBT', 73, 15, 3, 254, 115, 1, NULL),
(9, 'EBT 15.5 2P 25', 'EBT 15.5gsm 2p 25w 115d 3s', 'EBT', 73, 15.5, 2, 25, 115, 3, NULL),
(10, 'EBT 15.5 2P 25', 'EBT 15.5gsm 2p 25w 115d 4s', 'EBT', 73, 15.5, 2, 25, 115, 4, NULL),
(11, 'EBT 15.5 2P 25', 'EBT 15.5gsm 2p 25w 115d 5s', 'EBT', 73, 15.5, 2, 25, 115, 5, NULL),
(12, 'EBT 15.5 2P 25', 'EBT 15.5gsm 2p 25w 115d 6s', 'EBT', 73, 15.5, 2, 25, 115, 6, NULL),
(13, 'EBT 15.5 2P 256', 'EBT 15.5gsm 2p 256w 105d 1s', 'EBT', 73, 15.5, 2, 256, 105, 1, NULL),
(14, 'EBT 15.5 2P 256', 'EBT 15.5gsm 2p 256w 115d 1s', 'EBT', 73, 15.5, 2, 256, 115, 1, NULL),
(15, 'EBT 15.5 2P 262', 'EBT 15.5gsm 2p 262w 105d 1s', 'EBT', 73, 15.5, 2, 262, 105, 1, NULL),
(16, 'EBT 15.5 2P 262', 'EBT 15.5gsm 2p 262w 110d 1s', 'EBT', 73, 15.5, 2, 262, 110, 1, NULL),
(17, 'EBT 15.5 2P 262', 'EBT 15.5gsm 2p 262w 115d 1s', 'EBT', 73, 15.5, 2, 262, 115, 1, NULL),
(18, 'EBT 15.5 3P 130', 'EBT 15.5gsm 3p 130w 108d 1s', 'EBT', 72, 15.5, 3, 130, 108, 1, NULL),
(19, 'EBT 15.5 3P 130', 'EBT 15.5gsm 3p 130w 110d 1s', 'EBT', 72, 15.5, 3, 130, 110, 1, NULL),
(20, 'EBT 15.5 3P 130', 'EBT 15.5gsm 3p 130w 115d 1s', 'EBT', 72, 15.5, 3, 130, 115, 1, NULL),
(21, 'EBT 15.5 3P 130', 'EBT 15.5gsm 3p 130w 115d 4s', 'EBT', 72, 15.5, 3, 130, 115, 4, NULL),
(22, 'EBT 15.5 3P 25', 'EBT 15.5gsm 3p 25w 115d 5s', 'EBT', 72, 15.5, 3, 25, 115, 5, NULL),
(23, 'EBT 15.5 3P 25', 'EBT 15.5gsm 3p 25w 115d 6s', 'EBT', 72, 15.5, 3, 25, 115, 6, NULL),
(24, 'EBT 15.5 3P 25', 'EBT 15.5gsm 3p 25w 115d 7s', 'EBT', 72, 15.5, 3, 25, 115, 7, NULL),
(25, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 104d 1s', 'EBT', 73, 15.5, 3, 254, 104, 1, NULL),
(26, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 105d 1s', 'EBT', 73, 15.5, 3, 254, 105, 1, NULL),
(27, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 106d 1s', 'EBT', 73, 15.5, 3, 254, 106, 1, NULL),
(28, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 110d 1s', 'EBT', 73, 15.5, 3, 254, 110, 1, NULL),
(29, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 110d 4s', 'EBT', 73, 15.5, 3, 254, 110, 4, NULL),
(30, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 115d 1s', 'EBT', 73, 15.5, 3, 254, 115, 1, NULL),
(31, 'EBT 15.5 3P 30', 'EBT 15.5gsm 3p 30w 110d 4s', 'EBT', 72, 15.5, 3, 30, 110, 4, NULL),
(32, 'EBT 15.5 3P 30', 'EBT 15.5gsm 3p 30w 115d 2s', 'EBT', 72, 15.5, 3, 30, 115, 2, NULL),
(33, 'EBT 15.5 3P 30', 'EBT 15.5gsm 3p 30w 115d 3s', 'EBT', 72, 15.5, 3, 30, 115, 3, NULL),
(34, 'EBT 15.5 3P 30', 'EBT 15.5gsm 3p 30w 115d 4s', 'EBT', 72, 15.5, 3, 30, 115, 4, NULL),
(35, 'EBT 15.5 3P 30', 'EBT 15.5gsm 3p 30w 115d 5s', 'EBT', 72, 15.5, 3, 30, 115, 5, NULL),
(36, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 150d 1s', 'EBT', 73, 16.5, 1, 288, 150, 1, NULL),
(37, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 11d 1s', 'EBT', 73, 16.5, 2, 120, 11, 1, NULL),
(38, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 90d 1s', 'EBT', 73, 16.5, 2, 120, 90, 1, NULL),
(39, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 98d 1s', 'EBT', 73, 16.5, 2, 120, 98, 1, NULL),
(40, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 100d 1s', 'EBT', 73, 16.5, 2, 120, 100, 1, NULL),
(41, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 105d 1s', 'EBT', 73, 16.5, 2, 120, 105, 1, NULL),
(42, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 110d 1s', 'EBT', 73, 16.5, 2, 120, 110, 1, NULL),
(43, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 120d 1s', 'EBT', 73, 16.5, 2, 120, 120, 1, NULL),
(44, 'EBT 16.5 2P 135', 'EBT 16.5gsm 2p 135w 110d 1s', 'EBT', 73, 16.5, 2, 135, 110, 1, NULL),
(45, 'EBT 16.5 2P 137', 'EBT 16.5gsm 2p 137w 110d 1s', 'EBT', 73, 16.5, 2, 137, 110, 1, NULL),
(46, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 1d 1s', 'EBT', 73, 16.5, 2, 140, 1, 1, NULL),
(47, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 90d 1s', 'EBT', 73, 16.5, 2, 140, 90, 1, NULL),
(48, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 95d 1s', 'EBT', 73, 16.5, 2, 140, 95, 1, NULL),
(49, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 100d 1s', 'EBT', 73, 16.5, 2, 140, 100, 1, NULL),
(50, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 103d 1s', 'EBT', 73, 16.5, 2, 140, 103, 1, NULL),
(51, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 105d 1s', 'EBT', 73, 16.5, 2, 140, 105, 1, NULL),
(52, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 107d 1s', 'EBT', 73, 16.5, 2, 140, 107, 1, NULL),
(53, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 108d 1s', 'EBT', 73, 16.5, 2, 140, 108, 1, NULL),
(54, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 110d 1s', 'EBT', 73, 16.5, 2, 140, 110, 1, NULL),
(55, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 115d 1s', 'EBT', 73, 16.5, 2, 140, 115, 1, NULL),
(56, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 120d 1s', 'EBT', 73, 16.5, 2, 140, 120, 1, NULL),
(57, 'EBT 16.5 2P 144', 'EBT 16.5gsm 2p 144w 110d 2s', 'EBT', 75, 16.5, 2, 144, 110, 2, NULL),
(58, 'EBT 16.5 2P 144', 'EBT 16.5gsm 2p 144w 115d 1s', 'EBT', 75, 16.5, 2, 144, 115, 1, NULL),
(59, 'EBT 16.5 2P 144', 'EBT 16.5gsm 2p 144w 115d 2s', 'EBT', 75, 16.5, 2, 144, 115, 2, NULL),
(60, 'EBT 16.5 2P 160', 'EBT 16.5gsm 2p 160w 110d 1s', 'EBT', 75, 16.5, 2, 160, 110, 1, NULL),
(61, 'EBT 16.5 2P 160', 'EBT 16.5gsm 2p 160w 110d 2s', 'EBT', 75, 16.5, 2, 160, 110, 2, NULL),
(62, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 90d 1s', 'EBT', 73, 16.5, 2, 164, 90, 1, NULL),
(63, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 98d 1s', 'EBT', 73, 16.5, 2, 164, 98, 1, NULL),
(64, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 100d 1s', 'EBT', 73, 16.5, 2, 164, 100, 1, NULL),
(65, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 104d 1s', 'EBT', 73, 16.5, 2, 164, 104, 1, NULL),
(66, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 105d 1s', 'EBT', 73, 16.5, 2, 164, 105, 1, NULL),
(67, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 110d 1s', 'EBT', 73, 16.5, 2, 164, 110, 1, NULL),
(68, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 120d 1s', 'EBT', 73, 16.5, 2, 164, 120, 1, NULL),
(69, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 150d 1s', 'EBT', 73, 16.5, 2, 164, 150, 1, NULL),
(70, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 122d 1s', 'EBT', 73, 16.5, 2, 275, 122, 1, NULL),
(71, 'EBT 16.5 2P 285', 'EBT 16.5gsm 2p 285w 112d 1s', 'EBT', 73, 16.5, 2, 285, 112, 1, NULL),
(72, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 114d 1s', 'EBT', 73, 16.5, 2, 288, 114, 1, NULL),
(73, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 120d 1s', 'EBT', 73, 16.5, 2, 288, 120, 1, NULL),
(74, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 127d 1s', 'EBT', 73, 16.5, 2, 288, 127, 1, NULL),
(75, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 135d 1s', 'EBT', 73, 16.5, 2, 288, 135, 1, NULL),
(76, 'EBT 17.0 1P 279', 'EBT 17.0gsm 1p 279w 150d 1s', 'EBT', 75, 17, 1, 279, 150, 1, NULL),
(77, 'EBT 17.0 1P 279', 'EBT 17.0gsm 1p 279w 170d 1s', 'EBT', 75, 17, 1, 279, 170, 1, NULL),
(78, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 112d 1s', 'EBT', 75, 17, 1, 288, 112, 1, NULL),
(79, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 186d 1s', 'EBT', 75, 17, 1, 288, 186, 1, NULL),
(80, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 230d 1s', 'EBT', 75, 17, 1, 288, 230, 1, NULL),
(81, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 240d 1s', 'EBT', 75, 17, 1, 288, 240, 1, NULL),
(82, 'EBT 17.0 2P 140', 'EBT 17.0gsm 2p 140w 110d 1s', 'EBT', 73, 17, 2, 140, 110, 1, NULL),
(83, 'EBT 17.0 2P 143', 'EBT 17.0gsm 2p 143w 110d 1s', 'EBT', 75, 17, 2, 143, 110, 1, NULL),
(84, 'EBT 17.0 2P 143', 'EBT 17.0gsm 2p 143w 115d 1s', 'EBT', 75, 17, 2, 143, 115, 1, NULL),
(85, 'EBT 17.0 2P 276', 'EBT 17.0gsm 2p 276w 120d 1s', 'EBT', 75, 17, 2, 276, 120, 1, NULL),
(86, 'EBT 17.0 2P 276', 'EBT 17.0gsm 2p 276w 150d 1s', 'EBT', 75, 17, 2, 276, 150, 1, NULL),
(87, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 90d 1s', 'EBT', 75, 17, 2, 279, 90, 1, NULL),
(88, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 95d 1s', 'EBT', 75, 17, 2, 279, 95, 1, NULL),
(89, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 100d 1s', 'EBT', 75, 17, 2, 279, 100, 1, NULL),
(90, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 103d 1s', 'EBT', 75, 17, 2, 279, 103, 1, NULL),
(91, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 107d 1s', 'EBT', 75, 17, 2, 279, 107, 1, NULL),
(92, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 108d 1s', 'EBT', 75, 17, 2, 279, 108, 1, NULL),
(93, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 110d 1s', 'EBT', 75, 17, 2, 279, 110, 1, NULL),
(94, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 112d 1s', 'EBT', 75, 17, 2, 279, 112, 1, NULL),
(95, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 115d 1s', 'EBT', 75, 17, 2, 279, 115, 1, NULL),
(96, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 117d 1s', 'EBT', 75, 17, 2, 279, 117, 1, NULL),
(97, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 120d 1s', 'EBT', 75, 17, 2, 279, 120, 1, NULL),
(98, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 122d 1s', 'EBT', 75, 17, 2, 279, 122, 1, NULL),
(99, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 123d 1s', 'EBT', 75, 17, 2, 279, 123, 1, NULL),
(100, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 125d 1s', 'EBT', 75, 17, 2, 279, 125, 1, NULL),
(101, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 127d 1s', 'EBT', 75, 17, 2, 279, 127, 1, NULL),
(102, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 128d 1s', 'EBT', 75, 17, 2, 279, 128, 1, NULL),
(103, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 130d 1s', 'EBT', 75, 17, 2, 279, 130, 1, NULL),
(104, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 132d 1s', 'EBT', 75, 17, 2, 279, 132, 1, NULL),
(105, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 133d 1s', 'EBT', 75, 17, 2, 279, 133, 1, NULL),
(106, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 134d 1s', 'EBT', 75, 17, 2, 279, 134, 1, NULL),
(107, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 135d 1s', 'EBT', 75, 17, 2, 279, 135, 1, NULL),
(108, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 137d 1s', 'EBT', 75, 17, 2, 279, 137, 1, NULL),
(109, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 138d 1s', 'EBT', 75, 17, 2, 279, 138, 1, NULL),
(110, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 139d 1s', 'EBT', 75, 17, 2, 279, 139, 1, NULL),
(111, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 140d 1s', 'EBT', 75, 17, 2, 279, 140, 1, NULL),
(112, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 142d 1s', 'EBT', 75, 17, 2, 279, 142, 1, NULL),
(113, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 143d 1s', 'EBT', 75, 17, 2, 279, 143, 1, NULL),
(114, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 144d 1s', 'EBT', 75, 17, 2, 279, 144, 1, NULL),
(115, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 145d 1s', 'EBT', 75, 17, 2, 279, 145, 1, NULL),
(116, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 147d 1s', 'EBT', 75, 17, 2, 279, 147, 1, NULL),
(117, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 150d 1s', 'EBT', 75, 17, 2, 279, 150, 1, NULL),
(118, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 151d 1s', 'EBT', 75, 17, 2, 279, 151, 1, NULL),
(119, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 153d 1s', 'EBT', 75, 17, 2, 279, 153, 1, NULL),
(120, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 154d 1s', 'EBT', 75, 17, 2, 279, 154, 1, NULL),
(121, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 155d 1s', 'EBT', 75, 17, 2, 279, 155, 1, NULL),
(122, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 105d 1s', 'EBT', 75, 17, 2, 288, 105, 1, NULL),
(123, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 110d 1s', 'EBT', 75, 17, 2, 288, 110, 1, NULL),
(124, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 115d 1s', 'EBT', 75, 17, 2, 288, 115, 1, NULL),
(125, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 120d 1s', 'EBT', 75, 17, 2, 288, 120, 1, NULL),
(126, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 125d 1s', 'EBT', 75, 17, 2, 288, 125, 1, NULL),
(127, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 130d 1s', 'EBT', 75, 17, 2, 288, 130, 1, NULL),
(128, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 140d 1s', 'EBT', 75, 17, 2, 288, 140, 1, NULL),
(129, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 145d 1s', 'EBT', 75, 17, 2, 288, 145, 1, NULL),
(130, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 150d 1s', 'EBT', 75, 17, 2, 288, 150, 1, NULL),
(131, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 155d 1s', 'EBT', 75, 17, 2, 288, 155, 1, NULL),
(132, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 180d 1s', 'EBT', 75, 17, 2, 288, 180, 1, NULL),
(133, 'EBT 17.0 2P 289', 'EBT 17.0gsm 2p 289w 120d 1s', 'EBT', 73, 17, 2, 289, 120, 1, NULL),
(134, 'EBT 17.0 2P 289', 'EBT 17.0gsm 2p 289w 125d 1s', 'EBT', 73, 17, 2, 289, 125, 1, NULL),
(135, 'EBT 17.0 2P 289', 'EBT 17.0gsm 2p 289w 150d 1s', 'EBT', 73, 17, 2, 289, 150, 1, NULL),
(136, 'EBT 17.0 3P 143', 'EBT 17.0gsm 3p 143w 115d 1s', 'EBT', 75, 17, 3, 143, 115, 1, NULL),
(137, 'EBT 18.0 2P 140', 'EBT 18.0gsm 2p 140w 100d 1s', 'EBT', 73, 18, 2, 140, 100, 1, NULL),
(138, 'EBT 18.0 2P 140', 'EBT 18.0gsm 2p 140w 110d 1s', 'EBT', 73, 18, 2, 140, 110, 1, NULL),
(139, 'EBT 19.0 2P 255', 'EBT 19.0gsm 2p 255w 107d 1s', 'EBT', 76, 19, 2, 255, 107, 1, NULL),
(140, 'EBT 19.0 2P 255', 'EBT 19.0gsm 2p 255w 110d 1s', 'EBT', 76, 19, 2, 255, 110, 1, NULL),
(142, 'EKT 21.0 2P 143', 'EKT 21.0gsm 2p 143w 115d 1s', 'EKT', 74, 21, 2, 143, 115, 1, NULL),
(143, 'MBT 17.5 2P 165', 'MBT 17.5gsm 2p 165w 104d 1s', 'MBT', 89, 17.5, 2, 165, 104, 1, NULL),
(144, 'MBT 17.5 2P 165', 'MBT 17.5gsm 2p 165w 105d 1s', 'MBT', 89, 17.5, 2, 165, 105, 1, NULL),
(145, 'MBT 17.5 2P 165', 'MBT 17.5gsm 2p 165w 110d 1s', 'MBT', 89, 17.5, 2, 165, 110, 1, NULL),
(146, 'MBT 17.5 2P 165', 'MBT 17.5gsm 2p 165w 115d 1s', 'MBT', 89, 17.5, 2, 165, 115, 1, NULL),
(147, 'MBT 17.5 2P 95', 'MBT 17.5gsm 2p 95w 105d 1s', 'MBT', 89, 17.5, 2, 95, 105, 1, NULL),
(148, 'MBT 17.5 2P 95', 'MBT 17.5gsm 2p 95w 110d 1s', 'MBT', 89, 17.5, 2, 95, 110, 1, NULL),
(149, 'MBT 17.5 2P 95', 'MBT 17.5gsm 2p 95w 115d 1s', 'MBT', 89, 17.5, 2, 95, 115, 1, NULL),
(150, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 80d 1s', 'PBT', 87, 16.5, 2, 140, 80, 1, NULL),
(151, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 100d 1s', 'PBT', 87, 16.5, 2, 140, 100, 1, NULL),
(152, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 110d 1s', 'PBT', 87, 16.5, 2, 140, 110, 1, NULL),
(153, 'PBT 16.5 2P 144', 'PBT 16.5gsm 2p 144w 115d 1s', 'PBT', 87, 16.5, 2, 144, 115, 1, NULL),
(154, 'PBT 16.5 2P 275', 'PBT 16.5gsm 2p 275w 105d 1s', 'PBT', 73, 16.5, 2, 275, 105, 1, NULL),
(155, 'PBT 16.5 2P 275', 'PBT 16.5gsm 2p 275w 113d 1s', 'PBT', 73, 16.5, 2, 275, 113, 1, NULL),
(156, 'PBT 16.5 2P 275', 'PBT 16.5gsm 2p 275w 117d 1s', 'PBT', 73, 16.5, 2, 275, 117, 1, NULL),
(157, 'PBT 16.5 2P 275', 'PBT 16.5gsm 2p 275w 122d 1s', 'PBT', 73, 16.5, 2, 275, 122, 1, NULL),
(158, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 100d 1s', 'PBT', 87, 16.5, 2, 288, 100, 1, NULL),
(159, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 110d 1s', 'PBT', 87, 16.5, 2, 288, 110, 1, NULL),
(160, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 120d 1s', 'PBT', 87, 16.5, 2, 288, 120, 1, NULL),
(161, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 130d 1s', 'PBT', 87, 16.5, 2, 288, 130, 1, NULL),
(162, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 140d 1s', 'PBT', 87, 16.5, 2, 288, 140, 1, NULL),
(163, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 150d 1s', 'PBT', 87, 16.5, 2, 288, 150, 1, NULL),
(164, 'PBT 17.0 2P 143', 'PBT 17.0gsm 2p 143w 112d 1s', 'PBT', 87, 17, 2, 143, 112, 1, NULL),
(165, 'PBT 17.0 2P 143', 'PBT 17.0gsm 2p 143w 115d 1s', 'PBT', 87, 17, 2, 143, 115, 1, NULL),
(166, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 115d 1s', 'PBT', 87, 17, 2, 288, 115, 1, NULL),
(167, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 117d 1s', 'PBT', 87, 17, 2, 288, 117, 1, NULL),
(168, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 120d 1s', 'PBT', 87, 17, 2, 288, 120, 1, NULL),
(169, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 125d 1s', 'PBT', 87, 17, 2, 288, 125, 1, NULL),
(170, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 130d 1s', 'PBT', 87, 17, 2, 288, 130, 1, NULL),
(171, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 140d 1s', 'PBT', 87, 17, 2, 288, 140, 1, NULL),
(172, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 145d 1s', 'PBT', 87, 17, 2, 288, 145, 1, NULL),
(173, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 150d 1s', 'PBT', 87, 17, 2, 288, 150, 1, NULL),
(174, 'PBT 18.0 2P 142', 'PBT 18.0gsm 2p 142w 110d 1s', 'PBT', 87, 18, 2, 142, 110, 1, NULL),
(175, 'PBT+ 15.0 1P 288', 'PBT+ 15.0gsm 1p 288w 240d 1s', 'PBT+', 88, 15, 1, 288, 240, 1, NULL),
(176, 'PBT+ 15.0 2P 288', 'PBT+ 15.0gsm 2p 288w 120d 1s', 'PBT+', 88, 15, 2, 288, 120, 1, NULL),
(177, 'PBT+ 15.0 2P 288', 'PBT+ 15.0gsm 2p 288w 150d 1s', 'PBT+', 88, 15, 2, 288, 150, 1, NULL),
(178, 'PBT+ 15.0 2P 288', 'PBT+ 15.0gsm 2p 288w 160d 1s', 'PBT+', 88, 15, 2, 288, 160, 1, NULL),
(179, 'PBT+ 15.0 2P 288', 'PBT+ 15.0gsm 2p 288w 180d 1s', 'PBT+', 88, 15, 2, 288, 180, 1, NULL),
(180, 'PBTb 15.5 1P 288', 'PBTb 15.5gsm 1p 288w 150d 1s', 'PBTb', 87, 15.5, 1, 288, 150, 1, NULL),
(181, 'PBTB 16.5 1P 288', 'PBTB 16.5gsm 1p 288w 150d 1s', 'PBTB', 84, 16.5, 1, 288, 150, 1, NULL),
(182, 'PBTB 16.5 2P 285', 'PBTB 16.5gsm 2p 285w 112d 1s', 'PBTB', 87, 16.5, 2, 285, 112, 1, NULL),
(183, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 115d 1s', 'PBTB', 87, 16.5, 2, 288, 115, 1, NULL),
(184, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 120d 1s', 'PBTB', 87, 16.5, 2, 288, 120, 1, NULL),
(185, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 130d 1s', 'PBTB', 87, 16.5, 2, 288, 130, 1, NULL),
(186, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 135d 1s', 'PBTB', 87, 16.5, 2, 288, 135, 1, NULL),
(187, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 140d 1s', 'PBTB', 87, 16.5, 2, 288, 140, 1, NULL),
(188, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 150d 1s', 'PBTB', 87, 16.5, 2, 288, 150, 1, NULL),
(189, 'PBTs 15.5 1P 288', 'PBTs 15.5gsm 1p 288w 240d 1s', 'PBTs', 87, 15.5, 1, 288, 240, 1, NULL),
(190, 'PBTs 15.5 2P 288', 'PBTs 15.5gsm 2p 288w 150d 1s', 'PBTs', 87, 15.5, 2, 288, 150, 1, NULL),
(191, 'PBTS 16.5 1P 288', 'PBTS 16.5gsm 1p 288w 150d 1s', 'PBTS', 86, 16.5, 1, 288, 150, 1, NULL),
(192, 'PBTS 16.5 1P 288', 'PBTS 16.5gsm 1p 288w 230d 1s', 'PBTS', 86, 16.5, 1, 288, 230, 1, NULL),
(193, 'PBTS 16.5 1P 288', 'PBTS 16.5gsm 1p 288w 240d 1s', 'PBTS', 86, 16.5, 1, 288, 240, 1, NULL),
(194, 'PBTS 16.5 1P 288', 'PBTS 16.5gsm 1p 288w 250d 1s', 'PBTS', 86, 16.5, 1, 288, 250, 1, NULL),
(195, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 240d 1s', 'PBTS', 84, 17, 1, 288, 240, 1, NULL),
(196, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 90d 2s', 'PFT', 87, 14, 2, 100, 90, 2, NULL),
(197, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 105d 2s', 'PFT', 87, 14, 2, 100, 105, 2, NULL),
(198, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 110d 2s', 'PFT', 87, 14, 2, 100, 110, 2, NULL),
(199, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 113d 2s', 'PFT', 87, 14, 2, 100, 113, 2, NULL),
(200, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 115d 1s', 'PFT', 87, 14, 2, 100, 115, 1, NULL),
(201, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 115d 2s', 'PFT', 87, 14, 2, 100, 115, 2, NULL),
(202, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 120d 2s', 'PFT', 87, 14, 2, 100, 120, 2, NULL),
(203, 'PFT 14.0 2P 20', 'PFT 14.0gsm 2p 20w 115d 3s', 'PFT', 86, 14, 2, 20, 115, 3, NULL),
(204, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 110d 3s', 'PFT', 87, 14, 2, 40, 110, 3, NULL),
(205, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 115d 3s', 'PFT', 87, 14, 2, 40, 115, 3, NULL),
(206, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 115d 4s', 'PFT', 87, 14, 2, 40, 115, 4, NULL),
(207, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 90d 2s', 'PFT', 87, 14, 2, 80, 90, 2, NULL),
(208, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 110d 2s', 'PFT', 87, 14, 2, 80, 110, 2, NULL),
(209, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 115d 1s', 'PFT', 87, 14, 2, 80, 115, 1, NULL),
(210, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 115d 2s', 'PFT', 87, 14, 2, 80, 115, 2, NULL),
(211, 'PFT 14.5 2P 100', 'PFT 14.5gsm 2p 100w 115d 2s', 'PFT', 87, 14.5, 2, 100, 115, 2, NULL),
(212, 'PFT 14.5 2P 42', 'PFT 14.5gsm 2p 42w 110d 3s', 'PFT', 87, 14.5, 2, 42, 110, 3, NULL),
(213, 'PFT 14.5 2P 80', 'PFT 14.5gsm 2p 80w 110d 3s', 'PFT', 87, 14.5, 2, 80, 110, 3, NULL),
(214, 'PFT 14.5 2P 80', 'PFT 14.5gsm 2p 80w 115d 1s', 'PFT', 87, 14.5, 2, 80, 115, 1, NULL),
(215, 'PFT 14.5 2P 80', 'PFT 14.5gsm 2p 80w 115d 3s', 'PFT', 87, 14.5, 2, 80, 115, 3, NULL),
(216, 'PFT 15.0 2P 80', 'PFT 15.0gsm 2p 80w 115d 2s', 'PFT', 86, 15, 2, 80, 115, 2, NULL),
(217, 'PFT 15.0 2P 80', 'PFT 15.0gsm 2p 80w 115d 3s', 'PFT', 86, 15, 2, 80, 115, 3, NULL),
(218, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 80d 6s', 'PFT', 87, 15, 3, 21, 80, 6, NULL),
(219, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 115d 6s', 'PFT', 87, 15, 3, 21, 115, 6, NULL),
(220, 'PFT 15.0 3P 86', 'PFT 15.0gsm 3p 86w 115d 1s', 'PFT', 87, 15, 3, 86, 115, 1, NULL),
(221, 'PFT 15.3 2P 84', 'PFT 15.3gsm 2p 84w 115d 3s', 'PFT', 87, 15.3, 2, 84, 115, 3, NULL),
(222, 'PFT 15.3 2P 84', 'PFT 15.3gsm 2p 84w 115d 4s', 'PFT', 87, 15.3, 2, 84, 115, 4, NULL),
(223, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 105d 4s', 'PFT', 87, 15.3, 3, 21, 105, 4, NULL),
(224, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 105d 6s', 'PFT', 87, 15.3, 3, 21, 105, 6, NULL),
(225, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 110d 6s', 'PFT', 87, 15.3, 3, 21, 110, 6, NULL),
(226, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 115d 5s', 'PFT', 87, 15.3, 3, 21, 115, 5, NULL),
(227, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 115d 6s', 'PFT', 87, 15.3, 3, 21, 115, 6, NULL),
(228, 'PKT 23.0 2P 288', 'PKT 23.0gsm 2p 288w 126d 1s', 'PKT', 86, 23, 2, 288, 126, 1, NULL),
(229, 'PKT 23.0 2P 288', 'PKT 23.0gsm 2p 288w 180d 1s', 'PKT', 86, 23, 2, 288, 180, 1, NULL),
(230, 'PKT 24.0 1P 288', 'PKT 24.0gsm 1p 288w 150d 1s', 'PKT', 86, 24, 1, 288, 150, 1, NULL),
(231, 'PKT 25.0 1P 288', 'PKT 25.0gsm 1p 288w 150d 1s', 'PKT', 86, 25, 1, 288, 150, 1, NULL),
(232, 'PKT+ 21.0 1P 288', 'PKT+ 21.0gsm 1p 288w 150d 1s', 'PKT+', 86, 21, 1, 288, 150, 1, NULL),
(233, 'PTN 15.0 3P 22', 'PTN 15.0gsm 3p 22w 115d 4s', 'PTN', 87, 15, 3, 22, 115, 4, NULL),
(234, 'PTN 15.0 3P 22', 'PTN 15.0gsm 3p 22w 115d 5s', 'PTN', 87, 15, 3, 22, 115, 5, NULL),
(235, 'PTN 15.0 3P 22', 'PTN 15.0gsm 3p 22w 115d 6s', 'PTN', 87, 15, 3, 22, 115, 6, NULL),
(236, 'PTN 15.0 3P 33', 'PTN 15.0gsm 3p 33w 105d 5s', 'PTN', 87, 15, 3, 33, 105, 5, NULL),
(237, 'PTN 15.0 3P 33', 'PTN 15.0gsm 3p 33w 113d 4s', 'PTN', 87, 15, 3, 33, 113, 4, NULL),
(238, 'PTN 15.0 3P 33', 'PTN 15.0gsm 3p 33w 115d 3s', 'PTN', 87, 15, 3, 33, 115, 3, NULL),
(239, 'PTN 15.0 3P 33', 'PTN 15.0gsm 3p 33w 115d 4s', 'PTN', 87, 15, 3, 33, 115, 4, NULL),
(240, 'PTN 15.0 3P 38', 'PTN 15.0gsm 3p 38w 105d 3s', 'PTN', 87, 15, 3, 38, 105, 3, NULL),
(241, 'PTN 15.0 3P 38', 'PTN 15.0gsm 3p 38w 110d 3s', 'PTN', 87, 15, 3, 38, 110, 3, NULL),
(242, 'PTN 15.0 3P 38', 'PTN 15.0gsm 3p 38w 113d 4s', 'PTN', 87, 15, 3, 38, 113, 4, NULL),
(243, 'PTN 15.0 3P 38', 'PTN 15.0gsm 3p 38w 115d 3s', 'PTN', 87, 15, 3, 38, 115, 3, NULL),
(244, 'PTN 15.0 3P 38', 'PTN 15.0gsm 3p 38w 115d 4s', 'PTN', 87, 15, 3, 38, 115, 4, NULL),
(245, 'PTN 17.0 1P 25', 'PTN 17.0gsm 1p 25w 115d 4s', 'PTN', 86, 17, 1, 25, 115, 4, NULL),
(246, 'PTN 17.0 1P 25', 'PTN 17.0gsm 1p 25w 115d 5s', 'PTN', 86, 17, 1, 25, 115, 5, NULL),
(247, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 100d 4s', 'PTN', 86, 17, 1, 29, 100, 4, NULL),
(248, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 100d 5s', 'PTN', 86, 17, 1, 29, 100, 5, NULL),
(249, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 105d 4s', 'PTN', 86, 17, 1, 29, 105, 4, NULL),
(250, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 105d 5s', 'PTN', 86, 17, 1, 29, 105, 5, NULL),
(251, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 110d 4s', 'PTN', 86, 17, 1, 29, 110, 4, NULL),
(252, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 110d 5s', 'PTN', 86, 17, 1, 29, 110, 5, NULL),
(253, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 115d 4s', 'PTN', 86, 17, 1, 29, 115, 4, NULL),
(254, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 115d 5s', 'PTN', 86, 17, 1, 29, 115, 5, NULL),
(255, 'PTN 17.0 1P 29', 'PTN 17.0gsm 1p 29w 115d 6s', 'PTN', 86, 17, 1, 29, 115, 6, NULL),
(256, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 4s', 'PTN', 87, 17, 1, 31.5, 115, 4, NULL),
(257, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 5s', 'PTN', 87, 17, 1, 31.5, 115, 5, NULL),
(258, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 80d 4s', 'PTN', 87, 18, 1, 30, 80, 4, NULL),
(259, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 110d 4s', 'PTN', 87, 18, 1, 30, 110, 4, NULL),
(260, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 115d 4s', 'PTN', 87, 18, 1, 30, 115, 4, NULL),
(261, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 115d 5s', 'PTN', 87, 18, 1, 30, 115, 5, NULL),
(262, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 85d 4s', 'PTN', 87, 18, 1, 31.5, 85, 4, NULL),
(263, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 85d 5s', 'PTN', 87, 18, 1, 31.5, 85, 5, NULL),
(264, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 90d 4s', 'PTN', 87, 18, 1, 31.5, 90, 4, NULL),
(265, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 90d 5s', 'PTN', 87, 18, 1, 31.5, 90, 5, NULL),
(266, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 100d 4s', 'PTN', 87, 18, 1, 31.5, 100, 4, NULL),
(267, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 100d 5s', 'PTN', 87, 18, 1, 31.5, 100, 5, NULL),
(268, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 105d 3s', 'PTN', 87, 18, 1, 31.5, 105, 3, NULL),
(269, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 105d 4s', 'PTN', 87, 18, 1, 31.5, 105, 4, NULL),
(270, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 105d 5s', 'PTN', 87, 18, 1, 31.5, 105, 5, NULL),
(271, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 107d 4s', 'PTN', 87, 18, 1, 31.5, 107, 4, NULL),
(272, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 107d 5s', 'PTN', 87, 18, 1, 31.5, 107, 5, NULL),
(273, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 108d 4s', 'PTN', 87, 18, 1, 31.5, 108, 4, NULL),
(274, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 108d 5s', 'PTN', 87, 18, 1, 31.5, 108, 5, NULL),
(275, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 110d 4s', 'PTN', 87, 18, 1, 31.5, 110, 4, NULL),
(276, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 110d 5s', 'PTN', 87, 18, 1, 31.5, 110, 5, NULL),
(277, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 110d 6s', 'PTN', 87, 18, 1, 31.5, 110, 6, NULL),
(278, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 1s', 'PTN', 87, 18, 1, 31.5, 115, 1, NULL),
(279, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 2s', 'PTN', 87, 18, 1, 31.5, 115, 2, NULL),
(280, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 3s', 'PTN', 87, 18, 1, 31.5, 115, 3, NULL),
(281, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 4s', 'PTN', 87, 18, 1, 31.5, 115, 4, NULL),
(282, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 5s', 'PTN', 87, 18, 1, 31.5, 115, 5, NULL),
(283, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 9s', 'PTN', 87, 18, 1, 31.5, 115, 9, NULL),
(284, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 117d 4s', 'PTN', 87, 18, 1, 31.5, 117, 4, NULL),
(285, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 117d 5s', 'PTN', 87, 18, 1, 31.5, 117, 5, NULL),
(286, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 118d 4s', 'PTN', 87, 18, 1, 31.5, 118, 4, NULL),
(287, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 118d 5s', 'PTN', 87, 18, 1, 31.5, 118, 5, NULL),
(288, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 120d 4s', 'PTN', 87, 18, 1, 31.5, 120, 4, NULL),
(289, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 120d 5s', 'PTN', 87, 18, 1, 31.5, 120, 5, NULL),
(290, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 120d 9s', 'PTN', 87, 18, 1, 31.5, 120, 9, NULL),
(291, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 80d 5s', 'PTN', 82, 18, 1, 33, 80, 5, NULL),
(292, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 90d 4s', 'PTN', 82, 18, 1, 33, 90, 4, NULL),
(293, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 100d 5s', 'PTN', 82, 18, 1, 33, 100, 5, NULL),
(294, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 110d 4s', 'PTN', 82, 18, 1, 33, 110, 4, NULL),
(295, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 112d 4s', 'PTN', 82, 18, 1, 33, 112, 4, NULL),
(296, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 113d 4s', 'PTN', 82, 18, 1, 33, 113, 4, NULL),
(297, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 115d 4s', 'PTN', 82, 18, 1, 33, 115, 4, NULL),
(298, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 120d 4s', 'PTN', 82, 18, 1, 33, 120, 4, NULL),
(299, 'PTN 19.0 1P 29', 'PTN 19.0gsm 1p 29w 115d 5s', 'PTN', 88, 19, 1, 29, 115, 5, NULL),
(300, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 86d 4s', 'PTN', 87, 19, 1, 30, 86, 4, NULL),
(301, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 115d 1s', 'PTN', 87, 19, 1, 30, 115, 1, NULL),
(302, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 115d 3s', 'PTN', 87, 19, 1, 30, 115, 3, NULL),
(303, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 115d 4s', 'PTN', 87, 19, 1, 30, 115, 4, NULL),
(304, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 115d 5s', 'PTN', 87, 19, 1, 30, 115, 5, NULL),
(305, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 90d 4s', 'PTN', 86, 19, 1, 31.5, 90, 4, NULL),
(306, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 90d 5s', 'PTN', 86, 19, 1, 31.5, 90, 5, NULL),
(307, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 110d 4s', 'PTN', 86, 19, 1, 31.5, 110, 4, NULL),
(308, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 110d 5s', 'PTN', 86, 19, 1, 31.5, 110, 5, NULL),
(309, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 113d 4s', 'PTN', 86, 19, 1, 31.5, 113, 4, NULL),
(310, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 113d 5s', 'PTN', 86, 19, 1, 31.5, 113, 5, NULL),
(311, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 115d 4s', 'PTN', 86, 19, 1, 31.5, 115, 4, NULL),
(312, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 115d 5s', 'PTN', 86, 19, 1, 31.5, 115, 5, NULL),
(313, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 116d 4s', 'PTN', 86, 19, 1, 31.5, 116, 4, NULL),
(314, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 116d 5s', 'PTN', 86, 19, 1, 31.5, 116, 5, NULL),
(315, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 117d 4s', 'PTN', 86, 19, 1, 31.5, 117, 4, NULL),
(316, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 117d 5s', 'PTN', 86, 19, 1, 31.5, 117, 5, NULL),
(317, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 118d 4s', 'PTN', 86, 19, 1, 31.5, 118, 4, NULL),
(318, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 118d 5s', 'PTN', 86, 19, 1, 31.5, 118, 5, NULL),
(319, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 120d 4s', 'PTN', 86, 19, 1, 31.5, 120, 4, NULL),
(320, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 120d 5s', 'PTN', 86, 19, 1, 31.5, 120, 5, NULL),
(321, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 106d 4s', 'PTN', 87, 19, 1, 32.5, 106, 4, NULL),
(322, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 115d 4s', 'PTN', 87, 19, 1, 32.5, 115, 4, NULL),
(323, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 115d 5s', 'PTN', 87, 19, 1, 32.5, 115, 5, NULL),
(324, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 86d 2s', 'PTN', 87, 19, 1, 33, 86, 2, NULL),
(325, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 115d 4s', 'PTN', 87, 19, 1, 33, 115, 4, NULL),
(326, 'SBT 14.5 2P 40', 'SBT 14.5gsm 2p 40w 110d 4s', 'SBT', 84, 14.5, 2, 40, 110, 4, NULL),
(327, 'SBT 14.5 2P 40', 'SBT 14.5gsm 2p 40w 115d 1s', 'SBT', 84, 14.5, 2, 40, 115, 1, NULL),
(328, 'SBT 14.5 2P 40', 'SBT 14.5gsm 2p 40w 115d 3s', 'SBT', 84, 14.5, 2, 40, 115, 3, NULL),
(329, 'SBT 14.5 2P 40', 'SBT 14.5gsm 2p 40w 115d 4s', 'SBT', 84, 14.5, 2, 40, 115, 4, NULL),
(330, 'SBT 14.5 2P 40', 'SBT 14.5gsm 2p 40w 117d 3s', 'SBT', 84, 14.5, 2, 40, 117, 3, NULL),
(331, 'SBT 14.5 2P 40', 'SBT 14.5gsm 2p 40w 117d 4s', 'SBT', 84, 14.5, 2, 40, 117, 4, NULL),
(332, 'SBT 14.5 3P 182', 'SBT 14.5gsm 3p 182w 115d 1s', 'SBT', 86, 14.5, 3, 182, 115, 1, NULL),
(333, 'SBT 15.5 2P 25', 'SBT 15.5gsm 2p 25w 115d 4s', 'SBT', 86, 15.5, 2, 25, 115, 4, NULL),
(334, 'SBT 15.5 2P 25', 'SBT 15.5gsm 2p 25w 115d 5s', 'SBT', 86, 15.5, 2, 25, 115, 5, NULL),
(335, 'SBT 15.5 2P 25', 'SBT 15.5gsm 2p 25w 115d 6s', 'SBT', 86, 15.5, 2, 25, 115, 6, NULL),
(336, 'SBT 15.5 2P 256', 'SBT 15.5gsm 2p 256w 110d 1s', 'SBT', 86, 15.5, 2, 256, 110, 1, NULL),
(337, 'SBT 15.5 2P 256', 'SBT 15.5gsm 2p 256w 115d 1s', 'SBT', 86, 15.5, 2, 256, 115, 1, NULL),
(338, 'SBT 15.5 2P 262', 'SBT 15.5gsm 2p 262w 105d 1s', 'SBT', 86, 15.5, 2, 262, 105, 1, NULL),
(339, 'SBT 15.5 2P 262', 'SBT 15.5gsm 2p 262w 108d 1s', 'SBT', 86, 15.5, 2, 262, 108, 1, NULL),
(340, 'SBT 15.5 2P 262', 'SBT 15.5gsm 2p 262w 110d 1s', 'SBT', 86, 15.5, 2, 262, 110, 1, NULL),
(341, 'SBT 15.5 2P 262', 'SBT 15.5gsm 2p 262w 115d 1s', 'SBT', 86, 15.5, 2, 262, 115, 1, NULL),
(342, 'SBT 15.5 2P 262', 'SBT 15.5gsm 2p 262w 117d 1s', 'SBT', 86, 15.5, 2, 262, 117, 1, NULL),
(343, 'SBT 15.5 2P 30', 'SBT 15.5gsm 2p 30w 115d 3s', 'SBT', 86, 15.5, 2, 30, 115, 3, NULL),
(344, 'SBT 15.5 2P 30', 'SBT 15.5gsm 2p 30w 115d 4s', 'SBT', 86, 15.5, 2, 30, 115, 4, NULL),
(345, 'SBT 15.5 2P 30', 'SBT 15.5gsm 2p 30w 115d 5s', 'SBT', 86, 15.5, 2, 30, 115, 5, NULL),
(346, 'SBT 15.5 3P 140', 'SBT 15.5gsm 3p 140w 115d 1s', 'SBT', 84, 15.5, 3, 140, 115, 1, NULL),
(347, 'SBT 16.0 2P 288', 'SBT 16.0gsm 2p 288w 180d 1s', 'SBT', 84, 16, 2, 288, 180, 1, NULL),
(348, 'SBT 16.0 3P 140', 'SBT 16.0gsm 3p 140w 105d 1s', 'SBT', 86, 16, 3, 140, 105, 1, NULL),
(349, 'SBT 16.0 3P 140', 'SBT 16.0gsm 3p 140w 110d 1s', 'SBT', 86, 16, 3, 140, 110, 1, NULL),
(350, 'SBT 16.0 3P 140', 'SBT 16.0gsm 3p 140w 115d 1s', 'SBT', 86, 16, 3, 140, 115, 1, NULL),
(351, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 150d 1s', 'SBT', 86, 16.5, 1, 288, 150, 1, NULL),
(352, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 250d 1s', 'SBT', 86, 16.5, 1, 288, 250, 1, NULL),
(353, 'SBT 16.5 2P 100', 'SBT 16.5gsm 2p 100w 110d 2s', 'SBT', 84, 16.5, 2, 100, 110, 2, NULL),
(354, 'SBT 16.5 2P 109', 'SBT 16.5gsm 2p 109w 100d 1s', 'SBT', 86, 16.5, 2, 109, 100, 1, NULL),
(355, 'SBT 16.5 2P 110', 'SBT 16.5gsm 2p 110w 110d 1s', 'SBT', 83, 16.5, 2, 110, 110, 1, NULL),
(356, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 60d 1s', 'SBT', 84, 16.5, 2, 120, 60, 1, NULL),
(357, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 80d 1s', 'SBT', 84, 16.5, 2, 120, 80, 1, NULL),
(358, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 90d 1s', 'SBT', 84, 16.5, 2, 120, 90, 1, NULL),
(359, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 90d 2s', 'SBT', 84, 16.5, 2, 120, 90, 2, NULL),
(360, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 100d 1s', 'SBT', 84, 16.5, 2, 120, 100, 1, NULL),
(361, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 110d 1s', 'SBT', 84, 16.5, 2, 120, 110, 1, NULL),
(362, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 110d 2s', 'SBT', 84, 16.5, 2, 120, 110, 2, NULL),
(363, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 115d 1s', 'SBT', 84, 16.5, 2, 120, 115, 1, NULL),
(364, 'SBT 16.5 2P 137', 'SBT 16.5gsm 2p 137w 105d 1s', 'SBT', 84, 16.5, 2, 137, 105, 1, NULL),
(365, 'SBT 16.5 2P 137', 'SBT 16.5gsm 2p 137w 110d 1s', 'SBT', 84, 16.5, 2, 137, 110, 1, NULL),
(366, 'SBT 16.5 2P 137', 'SBT 16.5gsm 2p 137w 115d 1s', 'SBT', 84, 16.5, 2, 137, 115, 1, NULL),
(367, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 1d 1s', 'SBT', 86, 16.5, 2, 140, 1, 1, NULL),
(368, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 72d 1s', 'SBT', 86, 16.5, 2, 140, 72, 1, NULL),
(369, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 90d 1s', 'SBT', 86, 16.5, 2, 140, 90, 1, NULL),
(370, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 92d 1s', 'SBT', 86, 16.5, 2, 140, 92, 1, NULL),
(371, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 100d 1s', 'SBT', 86, 16.5, 2, 140, 100, 1, NULL),
(372, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 101d 1s', 'SBT', 86, 16.5, 2, 140, 101, 1, NULL),
(373, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 105d 1s', 'SBT', 86, 16.5, 2, 140, 105, 1, NULL),
(374, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 110d 1s', 'SBT', 86, 16.5, 2, 140, 110, 1, NULL),
(375, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 112d 1s', 'SBT', 86, 16.5, 2, 140, 112, 1, NULL),
(376, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 115d 1s', 'SBT', 86, 16.5, 2, 140, 115, 1, NULL),
(377, 'SBT 16.5 2P 147', 'SBT 16.5gsm 2p 147w 105d 1s', 'SBT', 86, 16.5, 2, 147, 105, 1, NULL),
(378, 'SBT 16.5 2P 147', 'SBT 16.5gsm 2p 147w 110d 1s', 'SBT', 86, 16.5, 2, 147, 110, 1, NULL),
(379, 'SBT 16.5 2P 147', 'SBT 16.5gsm 2p 147w 115d 1s', 'SBT', 86, 16.5, 2, 147, 115, 1, NULL),
(380, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 60d 1s', 'SBT', 84, 16.5, 2, 164, 60, 1, NULL),
(381, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 80d 1s', 'SBT', 84, 16.5, 2, 164, 80, 1, NULL),
(382, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 90d 1s', 'SBT', 84, 16.5, 2, 164, 90, 1, NULL),
(383, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 100d 1s', 'SBT', 84, 16.5, 2, 164, 100, 1, NULL),
(384, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 110d 1s', 'SBT', 84, 16.5, 2, 164, 110, 1, NULL),
(385, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 110d 2s', 'SBT', 84, 16.5, 2, 164, 110, 2, NULL),
(386, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 115d 1s', 'SBT', 84, 16.5, 2, 164, 115, 1, NULL),
(387, 'SBT 16.5 2P 175', 'SBT 16.5gsm 2p 175w 115d 1s', 'SBT', 86, 16.5, 2, 175, 115, 1, NULL),
(388, 'SBT 16.5 2P 25', 'SBT 16.5gsm 2p 25w 110d 4s', 'SBT', 84, 16.5, 2, 25, 110, 4, NULL),
(389, 'SBT 16.5 2P 25', 'SBT 16.5gsm 2p 25w 115d 3s', 'SBT', 84, 16.5, 2, 25, 115, 3, NULL),
(390, 'SBT 16.5 2P 25', 'SBT 16.5gsm 2p 25w 115d 4s', 'SBT', 84, 16.5, 2, 25, 115, 4, NULL),
(391, 'SBT 16.5 2P 25', 'SBT 16.5gsm 2p 25w 115d 5s', 'SBT', 84, 16.5, 2, 25, 115, 5, NULL),
(392, 'SBT 16.5 2P 25', 'SBT 16.5gsm 2p 25w 115d 6s', 'SBT', 84, 16.5, 2, 25, 115, 6, NULL),
(393, 'SBT 16.5 2P 25', 'SBT 16.5gsm 2p 25w 115d 7s', 'SBT', 84, 16.5, 2, 25, 115, 7, NULL),
(394, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 115d 1s', 'SBT', 86, 16.5, 2, 288, 115, 1, NULL),
(395, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 120d 1s', 'SBT', 86, 16.5, 2, 288, 120, 1, NULL),
(396, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 180d 1s', 'SBT', 86, 16.5, 2, 288, 180, 1, NULL),
(397, 'SBT 16.5 2P 40', 'SBT 16.5gsm 2p 40w 110d 2s', 'SBT', 86, 16.5, 2, 40, 110, 2, NULL),
(398, 'SBT 16.5 2P 40', 'SBT 16.5gsm 2p 40w 110d 3s', 'SBT', 86, 16.5, 2, 40, 110, 3, NULL),
(399, 'SBT 16.5 2P 40', 'SBT 16.5gsm 2p 40w 115d 3s', 'SBT', 86, 16.5, 2, 40, 115, 3, NULL),
(400, 'SBT 16.5 2P 40', 'SBT 16.5gsm 2p 40w 115d 4s', 'SBT', 86, 16.5, 2, 40, 115, 4, NULL),
(401, 'SBT 16.5 2P 80', 'SBT 16.5gsm 2p 80w 110d 2s', 'SBT', 84, 16.5, 2, 80, 110, 2, NULL),
(402, 'SBT 16.5 3P 25', 'SBT 16.5gsm 3p 25w 115d 3s', 'SBT', 84, 16.5, 3, 25, 115, 3, NULL),
(403, 'SBT 16.5 3P 25', 'SBT 16.5gsm 3p 25w 115d 6s', 'SBT', 84, 16.5, 3, 25, 115, 6, NULL),
(404, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 115d 1s', 'SBT', 84, 17, 1, 288, 115, 1, NULL),
(405, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 150d 1s', 'SBT', 84, 17, 1, 288, 150, 1, NULL),
(406, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 160d 1s', 'SBT', 84, 17, 1, 288, 160, 1, NULL),
(407, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 240d 1s', 'SBT', 84, 17, 1, 288, 240, 1, NULL),
(408, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 106d 1s', 'SBT', 84, 17, 2, 130, 106, 1, NULL),
(409, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 110d 1s', 'SBT', 84, 17, 2, 130, 110, 1, NULL),
(410, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 115d 1s', 'SBT', 84, 17, 2, 130, 115, 1, NULL),
(411, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 115d 3s', 'SBT', 84, 17, 2, 130, 115, 3, NULL),
(412, 'SBT 17.0 2P 140', 'SBT 17.0gsm 2p 140w 110d 1s', 'SBT', 84, 17, 2, 140, 110, 1, NULL),
(413, 'SBT 17.0 2P 140', 'SBT 17.0gsm 2p 140w 115d 1s', 'SBT', 84, 17, 2, 140, 115, 1, NULL),
(414, 'SBT 17.0 2P 143', 'SBT 17.0gsm 2p 143w 115d 1s', 'SBT', 86, 17, 2, 143, 115, 1, NULL),
(415, 'SBT 17.0 2P 175', 'SBT 17.0gsm 2p 175w 115d 1s', 'SBT', 84, 17, 2, 175, 115, 1, NULL),
(416, 'SBT 17.0 2P 23', 'SBT 17.0gsm 2p 23w 115d 2s', 'SBT', 84, 17, 2, 23, 115, 2, NULL),
(417, 'SBT 17.0 2P 23', 'SBT 17.0gsm 2p 23w 115d 3s', 'SBT', 84, 17, 2, 23, 115, 3, NULL),
(418, 'SBT 17.0 2P 25', 'SBT 17.0gsm 2p 25w 110d 5s', 'SBT', 84, 17, 2, 25, 110, 5, NULL),
(419, 'SBT 17.0 2P 25', 'SBT 17.0gsm 2p 25w 110d 6s', 'SBT', 84, 17, 2, 25, 110, 6, NULL),
(420, 'SBT 17.0 2P 25', 'SBT 17.0gsm 2p 25w 115d 2s', 'SBT', 84, 17, 2, 25, 115, 2, NULL),
(421, 'SBT 17.0 2P 25', 'SBT 17.0gsm 2p 25w 115d 3s', 'SBT', 84, 17, 2, 25, 115, 3, NULL),
(422, 'SBT 17.0 2P 25', 'SBT 17.0gsm 2p 25w 115d 5s', 'SBT', 84, 17, 2, 25, 115, 5, NULL),
(423, 'SBT 17.0 2P 25', 'SBT 17.0gsm 2p 25w 115d 6s', 'SBT', 84, 17, 2, 25, 115, 6, NULL),
(424, 'SBT 17.0 2P 275', 'SBT 17.0gsm 2p 275w 120d 1s', 'SBT', 82, 17, 2, 275, 120, 1, NULL),
(425, 'SBT 17.0 2P 279', 'SBT 17.0gsm 2p 279w 115d 1s', 'SBT', 82, 17, 2, 279, 115, 1, NULL),
(426, 'SBT 17.0 2P 279', 'SBT 17.0gsm 2p 279w 150d 1s', 'SBT', 82, 17, 2, 279, 150, 1, NULL),
(427, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 100d 1s', 'SBT', 84, 17, 2, 288, 100, 1, NULL),
(428, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 105d 1s', 'SBT', 84, 17, 2, 288, 105, 1, NULL),
(429, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 110d 1s', 'SBT', 84, 17, 2, 288, 110, 1, NULL),
(430, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 115d 1s', 'SBT', 84, 17, 2, 288, 115, 1, NULL),
(431, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 120d 1s', 'SBT', 84, 17, 2, 288, 120, 1, NULL),
(432, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 130d 1s', 'SBT', 84, 17, 2, 288, 130, 1, NULL),
(433, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 135d 1s', 'SBT', 84, 17, 2, 288, 135, 1, NULL),
(434, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 140d 1s', 'SBT', 84, 17, 2, 288, 140, 1, NULL),
(435, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 145d 1s', 'SBT', 84, 17, 2, 288, 145, 1, NULL),
(436, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 147d 1s', 'SBT', 84, 17, 2, 288, 147, 1, NULL),
(437, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 150d 1s', 'SBT', 84, 17, 2, 288, 150, 1, NULL),
(438, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 155d 1s', 'SBT', 84, 17, 2, 288, 155, 1, NULL),
(439, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 160d 1s', 'SBT', 84, 17, 2, 288, 160, 1, NULL),
(440, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 165d 1s', 'SBT', 84, 17, 2, 288, 165, 1, NULL),
(441, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 168d 1s', 'SBT', 84, 17, 2, 288, 168, 1, NULL),
(442, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 170d 1s', 'SBT', 84, 17, 2, 288, 170, 1, NULL),
(443, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 180d 1s', 'SBT', 84, 17, 2, 288, 180, 1, NULL),
(444, 'SBT 17.0 2P 29', 'SBT 17.0gsm 2p 29w 115d 2s', 'SBT', 84, 17, 2, 29, 115, 2, NULL),
(445, 'SBT 17.0 2P 29', 'SBT 17.0gsm 2p 29w 115d 3s', 'SBT', 84, 17, 2, 29, 115, 3, NULL),
(446, 'SBT 17.0 2P 30', 'SBT 17.0gsm 2p 30w 115d 2s', 'SBT', 86, 17, 2, 30, 115, 2, NULL),
(447, 'SBT 17.0 2P 30', 'SBT 17.0gsm 2p 30w 115d 3s', 'SBT', 86, 17, 2, 30, 115, 3, NULL),
(448, 'SBT 17.0 2P 30', 'SBT 17.0gsm 2p 30w 150d 3s', 'SBT', 86, 17, 2, 30, 150, 3, NULL),
(449, 'SBT 17.0 3P 143', 'SBT 17.0gsm 3p 143w 115d 1s', 'SBT', 86, 17, 3, 143, 115, 1, NULL),
(450, 'SBT 17.0 3P 288', 'SBT 17.0gsm 3p 288w 180d 1s', 'SBT', 84, 17, 3, 288, 180, 1, NULL),
(451, 'SBT 17.5 2P 165', 'SBT 17.5gsm 2p 165w 115d 1s', 'SBT', 86, 17.5, 2, 165, 115, 1, NULL),
(452, 'SBT 17.5 2P 25', 'SBT 17.5gsm 2p 25w 115d 3s', 'SBT', 86, 17.5, 2, 25, 115, 3, NULL),
(453, 'SBT 17.5 2P 25', 'SBT 17.5gsm 2p 25w 115d 4s', 'SBT', 86, 17.5, 2, 25, 115, 4, NULL),
(454, 'SBT 17.5 2P 25', 'SBT 17.5gsm 2p 25w 115d 5s', 'SBT', 86, 17.5, 2, 25, 115, 5, NULL),
(455, 'SBT 17.5 2P 95', 'SBT 17.5gsm 2p 95w 115d 1s', 'SBT', 86, 17.5, 2, 95, 115, 1, NULL),
(456, 'SBT 18.0 2P 140', 'SBT 18.0gsm 2p 140w 100d 1s', 'SBT', 86, 18, 2, 140, 100, 1, NULL),
(457, 'SBT 18.0 2P 140', 'SBT 18.0gsm 2p 140w 105d 1s', 'SBT', 86, 18, 2, 140, 105, 1, NULL),
(458, 'SBT 18.0 2P 140', 'SBT 18.0gsm 2p 140w 110d 1s', 'SBT', 86, 18, 2, 140, 110, 1, NULL),
(459, 'SBT 18.0 2P 140', 'SBT 18.0gsm 2p 140w 115d 1s', 'SBT', 86, 18, 2, 140, 115, 1, NULL),
(460, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 11d 1s', 'SBT', 84, 18, 2, 142, 11, 1, NULL),
(461, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 100d 1s', 'SBT', 84, 18, 2, 142, 100, 1, NULL),
(462, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 105d 1s', 'SBT', 84, 18, 2, 142, 105, 1, NULL),
(463, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 106d 1s', 'SBT', 84, 18, 2, 142, 106, 1, NULL),
(464, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 110d 1s', 'SBT', 84, 18, 2, 142, 110, 1, NULL),
(465, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 110d 2s', 'SBT', 84, 18, 2, 142, 110, 2, NULL),
(466, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 111d 1s', 'SBT', 84, 18, 2, 142, 111, 1, NULL),
(467, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 115d 1s', 'SBT', 84, 18, 2, 142, 115, 1, NULL),
(468, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 115d 2s', 'SBT', 84, 18, 2, 142, 115, 2, NULL),
(469, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 142d 1s', 'SBT', 84, 18, 2, 142, 142, 1, NULL),
(470, 'SBT 19.0 2P 142', 'SBT 19.0gsm 2p 142w 110d 1s', 'SBT', 85, 19, 2, 142, 110, 1, NULL),
(471, 'SBT 19.0 2P 142', 'SBT 19.0gsm 2p 142w 115d 1s', 'SBT', 85, 19, 2, 142, 115, 1, NULL),
(472, 'SBT 19.0 2P 25', 'SBT 19.0gsm 2p 25w 115d 6s', 'SBT', 84, 19, 2, 25, 115, 6, NULL),
(473, 'SBT 22.0 2P 130', 'SBT 22.0gsm 2p 130w 105d 1s', 'SBT', 86, 22, 2, 130, 105, 1, NULL),
(474, 'SBT 22.0 2P 130', 'SBT 22.0gsm 2p 130w 115d 1s', 'SBT', 86, 22, 2, 130, 115, 1, NULL),
(475, 'SFT 15.0 2P 100', 'SFT 15.0gsm 2p 100w 110d 2s', 'SFT', 84, 15, 2, 100, 110, 2, NULL),
(476, 'SFT 15.0 2P 100', 'SFT 15.0gsm 2p 100w 115d 2s', 'SFT', 84, 15, 2, 100, 115, 2, NULL),
(477, 'SFT 15.0 2P 100', 'SFT 15.0gsm 2p 100w 115d 3s', 'SFT', 84, 15, 2, 100, 115, 3, NULL),
(478, 'SFT 15.0 2P 80', 'SFT 15.0gsm 2p 80w 110d 1s', 'SFT', 84, 15, 2, 80, 110, 1, NULL),
(479, 'SFT 15.0 2P 80', 'SFT 15.0gsm 2p 80w 110d 2s', 'SFT', 84, 15, 2, 80, 110, 2, NULL),
(480, 'SFT 15.0 2P 80', 'SFT 15.0gsm 2p 80w 115d 2s', 'SFT', 84, 15, 2, 80, 115, 2, NULL),
(481, 'SFT 15.5 2P 40', 'SFT 15.5gsm 2p 40w 115d 3s', 'SFT', 84, 15.5, 2, 40, 115, 3, NULL),
(482, 'SFT 15.5 2P 40', 'SFT 15.5gsm 2p 40w 115d 4s', 'SFT', 84, 15.5, 2, 40, 115, 4, NULL),
(483, 'SFT 15.5 2P 82', 'SFT 15.5gsm 2p 82w 115d 1s', 'SFT', 84, 15.5, 2, 82, 115, 1, NULL),
(484, 'SFT 15.5 2P 82', 'SFT 15.5gsm 2p 82w 115d 2s', 'SFT', 84, 15.5, 2, 82, 115, 2, NULL),
(485, 'SFT 15.5 2P 82', 'SFT 15.5gsm 2p 82w 115d 3s', 'SFT', 84, 15.5, 2, 82, 115, 3, NULL),
(486, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 75d 2s', 'SFT', 86, 15.5, 2, 90, 75, 2, NULL),
(487, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 75d 3s', 'SFT', 86, 15.5, 2, 90, 75, 3, NULL),
(488, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 110d 2s', 'SFT', 86, 15.5, 2, 90, 110, 2, NULL),
(489, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 115d 1s', 'SFT', 86, 15.5, 2, 90, 115, 1, NULL),
(490, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 115d 2s', 'SFT', 86, 15.5, 2, 90, 115, 2, NULL),
(491, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 110d 1s', 'SKT', 86, 21, 2, 100, 110, 1, NULL),
(492, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 110d 2s', 'SKT', 86, 21, 2, 100, 110, 2, NULL),
(493, 'SKT 21.0 2P 143', 'SKT 21.0gsm 2p 143w 115d 1s', 'SKT', 86, 21, 2, 143, 115, 1, NULL),
(494, 'SKT 21.0 2P 143', 'SKT 21.0gsm 2p 143w 115d 2s', 'SKT', 86, 21, 2, 143, 115, 2, NULL),
(495, 'SKT 21.0 2P 75', 'SKT 21.0gsm 2p 75w 120d 2s', 'SKT', 86, 21, 2, 75, 120, 2, NULL),
(496, 'SKT 21.0 2P 80', 'SKT 21.0gsm 2p 80w 110d 2s', 'SKT', 86, 21, 2, 80, 110, 2, NULL),
(497, 'SKT 23.0 1P 288', 'SKT 23.0gsm 1p 288w 150d 1s', 'SKT', 86, 23, 1, 288, 150, 1, NULL),
(498, 'SKT 24.0 1P 128', 'SKT 24.0gsm 1p 128w 110d 1s', 'SKT', 86, 24, 1, 128, 110, 1, NULL),
(499, 'SKT 24.0 1P 128', 'SKT 24.0gsm 1p 128w 115d 1s', 'SKT', 86, 24, 1, 128, 115, 1, NULL),
(500, 'SKT 24.0 1P 288', 'SKT 24.0gsm 1p 288w 105d 1s', 'SKT', 86, 24, 1, 288, 105, 1, NULL),
(501, 'SKT 24.0 1P 288', 'SKT 24.0gsm 1p 288w 120d 1s', 'SKT', 86, 24, 1, 288, 120, 1, NULL),
(502, 'SKT 24.0 1P 288', 'SKT 24.0gsm 1p 288w 150d 1s', 'SKT', 86, 24, 1, 288, 150, 1, NULL),
(503, 'SKT 24.0 1P 288', 'SKT 24.0gsm 1p 288w 240d 1s', 'SKT', 86, 24, 1, 288, 240, 1, NULL),
(504, 'SKT 24.0 1P 30', 'SKT 24.0gsm 1p 30w 115d 1s', 'SKT', 86, 24, 1, 30, 115, 1, NULL),
(505, 'SKT 24.0 1P 30', 'SKT 24.0gsm 1p 30w 115d 4s', 'SKT', 86, 24, 1, 30, 115, 4, NULL),
(506, 'SKT 24.0 1P 30', 'SKT 24.0gsm 1p 30w 115d 5s', 'SKT', 86, 24, 1, 30, 115, 5, NULL),
(507, 'SKT 24.0 2P 140', 'SKT 24.0gsm 2p 140w 100d 1s', 'SKT', 84, 24, 2, 140, 100, 1, NULL),
(508, 'SKT 24.0 2P 140', 'SKT 24.0gsm 2p 140w 105d 1s', 'SKT', 84, 24, 2, 140, 105, 1, NULL),
(509, 'SKT 24.0 2P 140', 'SKT 24.0gsm 2p 140w 110d 1s', 'SKT', 84, 24, 2, 140, 110, 1, NULL),
(510, 'SKT 24.0 2P 140', 'SKT 24.0gsm 2p 140w 115d 1s', 'SKT', 84, 24, 2, 140, 115, 1, NULL),
(511, 'SKT 24.0 2P 144', 'SKT 24.0gsm 2p 144w 115d 1s', 'SKT', 86, 24, 2, 144, 115, 1, NULL),
(512, 'SKT 25.0 1P 288', 'SKT 25.0gsm 1p 288w 150d 1s', 'SKT', 86, 25, 1, 288, 150, 1, NULL),
(513, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 100d 2s', 'SKT', 86, 40, 1, 100, 100, 2, NULL),
(514, 'SKT 40.0 1P 140', 'SKT 40.0gsm 1p 140w 115d 1s', 'SKT', 86, 40, 1, 140, 115, 1, NULL),
(515, 'SKT 40.0 1P 279', 'SKT 40.0gsm 1p 279w 120d 1s', 'SKT', 86, 40, 1, 279, 120, 1, NULL),
(516, 'SKT 40.0 1P 289', 'SKT 40.0gsm 1p 289w 120d 1s', 'SKT', 86, 40, 1, 289, 120, 1, NULL),
(517, 'SKT 40.0 1P 75', 'SKT 40.0gsm 1p 75w 85d 1s', 'SKT', 86, 40, 1, 75, 85, 1, NULL),
(518, 'SKT 40.0 1P 75', 'SKT 40.0gsm 1p 75w 105d 1s', 'SKT', 86, 40, 1, 75, 105, 1, NULL),
(519, 'SKT 40.0 1P 80', 'SKT 40.0gsm 1p 80w 100d 1s', 'SKT', 86, 40, 1, 80, 100, 1, NULL),
(520, 'SKT 42.0 1P 100', 'SKT 42.0gsm 1p 100w 85d 2s', 'SKT', 84, 42, 1, 100, 85, 2, NULL),
(521, 'SKT 42.0 1P 100', 'SKT 42.0gsm 1p 100w 105d 2s', 'SKT', 84, 42, 1, 100, 105, 2, NULL),
(522, 'SKT 42.0 1P 100', 'SKT 42.0gsm 1p 100w 120d 2s', 'SKT', 84, 42, 1, 100, 120, 2, NULL),
(523, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 108d 4s', 'STN', 86, 17, 1, 29, 108, 4, NULL),
(524, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 109d 4s', 'STN', 86, 17, 1, 29, 109, 4, NULL),
(525, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 110d 4s', 'STN', 86, 17, 1, 29, 110, 4, NULL),
(526, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 110d 5s', 'STN', 86, 17, 1, 29, 110, 5, NULL),
(527, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 115d 4s', 'STN', 86, 17, 1, 29, 115, 4, NULL),
(528, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 115d 5s', 'STN', 86, 17, 1, 29, 115, 5, NULL),
(529, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 2s', 'STN', 86, 17, 1, 30, 115, 2, NULL),
(530, 'STN 17.0 1P 31.5', 'STN 17.0gsm 1p 31.5w 105d 4s', 'STN', 86, 17, 1, 31.5, 105, 4, NULL),
(531, 'STN 17.0 1P 31.5', 'STN 17.0gsm 1p 31.5w 105d 5s', 'STN', 86, 17, 1, 31.5, 105, 5, NULL),
(532, 'STN 17.0 1P 31.5', 'STN 17.0gsm 1p 31.5w 115d 4s', 'STN', 86, 17, 1, 31.5, 115, 4, NULL),
(533, 'STN 17.0 1P 31.5', 'STN 17.0gsm 1p 31.5w 115d 5s', 'STN', 86, 17, 1, 31.5, 115, 5, NULL),
(534, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 105d 3s', 'STN', 86, 17, 1, 33, 105, 3, NULL),
(535, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 105d 4s', 'STN', 86, 17, 1, 33, 105, 4, NULL),
(536, 'STN 17.0 1P 66', 'STN 17.0gsm 1p 66w 100d 2s', 'STN', 86, 17, 1, 66, 100, 2, NULL),
(537, 'STN 17.0 1P 66', 'STN 17.0gsm 1p 66w 108d 2s', 'STN', 86, 17, 1, 66, 108, 2, NULL),
(538, 'STN 17.0 1P 66', 'STN 17.0gsm 1p 66w 110d 2s', 'STN', 86, 17, 1, 66, 110, 2, NULL),
(539, 'STN 17.0 1P 66', 'STN 17.0gsm 1p 66w 115d 1s', 'STN', 86, 17, 1, 66, 115, 1, NULL),
(540, 'STN 17.0 1P 66', 'STN 17.0gsm 1p 66w 115d 2s', 'STN', 86, 17, 1, 66, 115, 2, NULL),
(541, 'STN 17.0 2P 31.5', 'STN 17.0gsm 2p 31.5w 115d 4s', 'STN', 86, 17, 2, 31.5, 115, 4, NULL),
(542, 'STN 18.0 1P 29.5', 'STN 18.0gsm 1p 29.5w 115d 4s', 'STN', 86, 18, 1, 29.5, 115, 4, NULL),
(543, 'STN 18.0 1P 29.5', 'STN 18.0gsm 1p 29.5w 115d 5s', 'STN', 86, 18, 1, 29.5, 115, 5, NULL);
INSERT INTO `bpl_products` (`id`, `old`, `productname`, `gradetype`, `brightness`, `gsm`, `ply`, `width`, `diameter`, `slice`, `deleted_at`) VALUES
(544, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 88d 4s', 'STN', 86, 18, 1, 30, 88, 4, NULL),
(545, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 90d 5s', 'STN', 86, 18, 1, 30, 90, 5, NULL),
(546, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 95d 6s', 'STN', 86, 18, 1, 30, 95, 6, NULL),
(547, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 98d 6s', 'STN', 86, 18, 1, 30, 98, 6, NULL),
(548, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 100d 4s', 'STN', 86, 18, 1, 30, 100, 4, NULL),
(549, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 100d 5s', 'STN', 86, 18, 1, 30, 100, 5, NULL),
(550, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 100d 6s', 'STN', 86, 18, 1, 30, 100, 6, NULL),
(551, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 102d 3s', 'STN', 86, 18, 1, 30, 102, 3, NULL),
(552, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 102d 5s', 'STN', 86, 18, 1, 30, 102, 5, NULL),
(553, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 102d 6s', 'STN', 86, 18, 1, 30, 102, 6, NULL),
(554, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 105d 4s', 'STN', 86, 18, 1, 30, 105, 4, NULL),
(555, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 105d 5s', 'STN', 86, 18, 1, 30, 105, 5, NULL),
(556, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 105d 6s', 'STN', 86, 18, 1, 30, 105, 6, NULL),
(557, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 108d 5s', 'STN', 86, 18, 1, 30, 108, 5, NULL),
(558, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 110d 3s', 'STN', 86, 18, 1, 30, 110, 3, NULL),
(559, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 110d 4s', 'STN', 86, 18, 1, 30, 110, 4, NULL),
(560, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 110d 5s', 'STN', 86, 18, 1, 30, 110, 5, NULL),
(561, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 110d 6s', 'STN', 86, 18, 1, 30, 110, 6, NULL),
(562, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 112d 5s', 'STN', 86, 18, 1, 30, 112, 5, NULL),
(563, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 113d 5s', 'STN', 86, 18, 1, 30, 113, 5, NULL),
(564, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 113d 6s', 'STN', 86, 18, 1, 30, 113, 6, NULL),
(565, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 115d 2s', 'STN', 86, 18, 1, 30, 115, 2, NULL),
(566, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 115d 3s', 'STN', 86, 18, 1, 30, 115, 3, NULL),
(567, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 115d 4s', 'STN', 86, 18, 1, 30, 115, 4, NULL),
(568, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 115d 5s', 'STN', 86, 18, 1, 30, 115, 5, NULL),
(569, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 115d 6s', 'STN', 86, 18, 1, 30, 115, 6, NULL),
(570, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 116d 4s', 'STN', 86, 18, 1, 30, 116, 4, NULL),
(571, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 117d 4s', 'STN', 86, 18, 1, 30, 117, 4, NULL),
(572, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 117d 5s', 'STN', 86, 18, 1, 30, 117, 5, NULL),
(573, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 120d 3s', 'STN', 86, 18, 1, 30, 120, 3, NULL),
(574, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 120d 4s', 'STN', 86, 18, 1, 30, 120, 4, NULL),
(575, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 120d 5s', 'STN', 86, 18, 1, 30, 120, 5, NULL),
(576, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 120d 6s', 'STN', 86, 18, 1, 30, 120, 6, NULL),
(577, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 90d 5s', 'STN', 82, 18, 1, 31.5, 90, 5, NULL),
(578, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 100d 4s', 'STN', 82, 18, 1, 31.5, 100, 4, NULL),
(579, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 100d 5s', 'STN', 82, 18, 1, 31.5, 100, 5, NULL),
(580, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 105d 4s', 'STN', 82, 18, 1, 31.5, 105, 4, NULL),
(581, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 105d 5s', 'STN', 82, 18, 1, 31.5, 105, 5, NULL),
(582, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 110d 4s', 'STN', 82, 18, 1, 31.5, 110, 4, NULL),
(583, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 110d 5s', 'STN', 82, 18, 1, 31.5, 110, 5, NULL),
(584, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 115d 1s', 'STN', 82, 18, 1, 31.5, 115, 1, NULL),
(585, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 115d 3s', 'STN', 82, 18, 1, 31.5, 115, 3, NULL),
(586, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 115d 4s', 'STN', 82, 18, 1, 31.5, 115, 4, NULL),
(587, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 115d 5s', 'STN', 82, 18, 1, 31.5, 115, 5, NULL),
(588, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 120d 4s', 'STN', 82, 18, 1, 31.5, 120, 4, NULL),
(589, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 120d 5s', 'STN', 82, 18, 1, 31.5, 120, 5, NULL),
(590, 'STN 18.0 1P 32', 'STN 18.0gsm 1p 32w 115d 4s', 'STN', 86, 18, 1, 32, 115, 4, NULL),
(591, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 70d 5s', 'STN', 86, 18, 1, 33, 70, 5, NULL),
(592, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 88d 3s', 'STN', 86, 18, 1, 33, 88, 3, NULL),
(593, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 90d 3s', 'STN', 86, 18, 1, 33, 90, 3, NULL),
(594, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 95d 3s', 'STN', 86, 18, 1, 33, 95, 3, NULL),
(595, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 98d 3s', 'STN', 86, 18, 1, 33, 98, 3, NULL),
(596, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 100d 3s', 'STN', 86, 18, 1, 33, 100, 3, NULL),
(597, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 100d 4s', 'STN', 86, 18, 1, 33, 100, 4, NULL),
(598, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 100d 5s', 'STN', 86, 18, 1, 33, 100, 5, NULL),
(599, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 102d 3s', 'STN', 86, 18, 1, 33, 102, 3, NULL),
(600, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 102d 4s', 'STN', 86, 18, 1, 33, 102, 4, NULL),
(601, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 105d 3s', 'STN', 86, 18, 1, 33, 105, 3, NULL),
(602, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 108d 4s', 'STN', 86, 18, 1, 33, 108, 4, NULL),
(603, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 110d 3s', 'STN', 86, 18, 1, 33, 110, 3, NULL),
(604, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 110d 4s', 'STN', 86, 18, 1, 33, 110, 4, NULL),
(605, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 110d 5s', 'STN', 86, 18, 1, 33, 110, 5, NULL),
(606, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 112d 4s', 'STN', 86, 18, 1, 33, 112, 4, NULL),
(607, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 113d 2s', 'STN', 86, 18, 1, 33, 113, 2, NULL),
(608, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 113d 3s', 'STN', 86, 18, 1, 33, 113, 3, NULL),
(609, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 113d 4s', 'STN', 86, 18, 1, 33, 113, 4, NULL),
(610, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 113d 5s', 'STN', 86, 18, 1, 33, 113, 5, NULL),
(611, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 115d 1s', 'STN', 86, 18, 1, 33, 115, 1, NULL),
(612, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 115d 2s', 'STN', 86, 18, 1, 33, 115, 2, NULL),
(613, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 115d 3s', 'STN', 86, 18, 1, 33, 115, 3, NULL),
(614, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 115d 4s', 'STN', 86, 18, 1, 33, 115, 4, NULL),
(615, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 115d 5s', 'STN', 86, 18, 1, 33, 115, 5, NULL),
(616, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 117d 4s', 'STN', 86, 18, 1, 33, 117, 4, NULL),
(617, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 120d 3s', 'STN', 86, 18, 1, 33, 120, 3, NULL),
(618, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 120d 4s', 'STN', 86, 18, 1, 33, 120, 4, NULL),
(619, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 120d 5s', 'STN', 86, 18, 1, 33, 120, 5, NULL),
(620, 'STN 18.0 2P 33', 'STN 18.0gsm 2p 33w 110d 4s', 'STN', 84, 18, 2, 33, 110, 4, NULL),
(621, 'STN 19.0 1P 24', 'STN 19.0gsm 1p 24w 115d 4s', 'STN', 86, 19, 1, 24, 115, 4, NULL),
(622, 'STN 19.0 1P 24', 'STN 19.0gsm 1p 24w 115d 5s', 'STN', 86, 19, 1, 24, 115, 5, NULL),
(623, 'STN 19.0 1P 24', 'STN 19.0gsm 1p 24w 115d 6s', 'STN', 86, 19, 1, 24, 115, 6, NULL),
(624, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 110d 4s', 'STN', 87, 19, 1, 30, 110, 4, NULL),
(625, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 110d 5s', 'STN', 87, 19, 1, 30, 110, 5, NULL),
(626, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 115d 4s', 'STN', 87, 19, 1, 30, 115, 4, NULL),
(627, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 115d 5s', 'STN', 87, 19, 1, 30, 115, 5, NULL),
(628, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 110d 4s', 'STN', 86, 19, 1, 32.5, 110, 4, NULL),
(629, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 115d 2s', 'STN', 86, 19, 1, 32.5, 115, 2, NULL),
(630, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 115d 4s', 'STN', 86, 19, 1, 32.5, 115, 4, NULL),
(631, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 110d 4s', 'STN', 86, 19, 1, 33, 110, 4, NULL),
(632, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 115d 4s', 'STN', 86, 19, 1, 33, 115, 4, NULL),
(633, 'STN 19.0 2P 33', 'STN 19.0gsm 2p 33w 115d 1s', 'STN', 85, 19, 2, 33, 115, 1, NULL),
(634, 'STN 21.0 1P 66', 'STN 21.0gsm 1p 66w 115d 2s', 'STN', 86, 21, 1, 66, 115, 2, NULL),
(635, 'SWT 19 1P 60', 'SWT 19gsm 1p 60w 50d 3s', 'SWT', 86, 19, 1, 60, 50, 3, NULL),
(636, 'SWT 23.0 1P 19', 'SWT 23.0gsm 1p 19w 60d 4s', 'SWT', 86, 23, 1, 19, 60, 4, NULL),
(637, 'SWT 23.0 1P 19', 'SWT 23.0gsm 1p 19w 60d 6s', 'SWT', 86, 23, 1, 19, 60, 6, NULL),
(638, 'SWT 23.0 1P 60', 'SWT 23.0gsm 1p 60w 60d 2s', 'SWT', 86, 23, 1, 60, 60, 2, NULL),
(639, 'SWT 23.0 1P 60', 'SWT 23.0gsm 1p 60w 60d 3s', 'SWT', 86, 23, 1, 60, 60, 3, NULL),
(642, 'PFT 14.0 2P 64.5', 'PFT 14.0gsm 2p 64.5w 110d 1s', 'PFT', 87, 14, 2, 64.5, 110, 1, NULL),
(643, 'PFT 14.2 3P 74', 'PFT 14.2gsm 3p 74w 115d 1s', 'PFT', 87, 14.2, 3, 74, 115, 1, NULL),
(644, 'PFT 14.2 3P 86', 'PFT 14.2gsm 3p 86w 115d 1s', 'PFT', 87, 14.2, 3, 86, 115, 1, NULL),
(645, 'PFT 15.0 2P 86', 'PFT 15.0gsm 2p 86w 115d 1s', 'PFT', 87, 15, 2, 86, 115, 1, NULL),
(646, 'PTN 17.0 3P 22', 'PTN 17.0gsm 3p 22w 120d 4s', 'PTN', 87, 17, 3, 22, 120, 4, NULL),
(647, 'PTN 17.0 3P 38', 'PTN 17.0gsm 3p 38w 120d 4s', 'PTN', 87, 17, 3, 38, 120, 4, NULL),
(648, 'EBT 17.0 2P 142', 'EBT 17.0gsm 2p 142w 115d 1s', 'EBT', 75, 17, 2, 142, 115, 1, NULL),
(649, 'EBT 17.0 2P 254', 'EBT 17.0gsm 2p 254w 115d 1s', 'EBT', 73, 17, 2, 254, 115, 1, NULL),
(650, 'EBT 17.5 2P 95', 'EBT 17.5gsm 2p 95w 115d 1s', 'EBT', 75, 17.5, 2, 95, 115, 1, NULL),
(651, 'EBT 18.0 2P 120', 'EBT 18.0gsm 2p 120w 100d 1s', 'EBT', 73, 18, 2, 120, 100, 1, NULL),
(652, 'PBT 16.5 1P 288', 'PBT 16.5gsm 1p 288w 120d 1s', 'PBT', 87, 16.5, 1, 288, 120, 1, NULL),
(653, 'PBT 16.5 1P 288', 'PBT 16.5gsm 1p 288w 150d 1s', 'PBT', 87, 16.5, 1, 288, 150, 1, NULL),
(654, 'PBT 17.0 1P 288', 'PBT 17.0gsm 1p 288w 150d 1s', 'PBT', 84, 17, 1, 288, 150, 1, NULL),
(655, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 120d 6s', 'PFT', 87, 14, 3, 20, 120, 6, NULL),
(659, 'PBT+ 15.0 3P 288', 'PBT+ 15.0gsm 3p 288w 180d 1s', 'PBT+', 89, 15, 3, 288, 180, 1, NULL),
(660, 'PFT(PEACH) 15.3 2P 100', 'PFT(PEACH) 15.3gsm 2p 100w 115d 2s', 'PFT(PEACH)', 42, 15.3, 2, 100, 115, 2, NULL),
(661, 'PFT(PEACH) 15.3 2P 80', 'PFT(PEACH) 15.3gsm 2p 80w 115d 2s', 'PFT(PEACH)', 42, 15.3, 2, 80, 115, 2, NULL),
(662, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 105d 4s', 'PTN', 87, 21, 1, 31.5, 105, 4, NULL),
(663, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 105d 5s', 'PTN', 87, 21, 1, 31.5, 105, 5, NULL),
(664, 'PTN 21.0 1P 31.5', 'PTN 21.0 1P 31.5', 'PTN', 87, 21, 1, 31.5, 115, 4, NULL),
(665, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 120d 5s', 'PTN', 87, 21, 1, 31.5, 120, 5, NULL),
(666, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 150d 5s', 'PTN', 87, 21, 1, 31.5, 150, 5, NULL),
(667, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 254w 105d 1s', 'EBT', 75, 15, 2, 254, 105, 1, NULL),
(668, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 254w 108d 1s', 'EBT', 75, 15, 2, 254, 108, 1, NULL),
(669, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 254w 110d 1s', 'EBT', 75, 15, 2, 254, 110, 1, NULL),
(670, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 254w 111d 1s', 'EBT', 75, 15, 2, 254, 111, 1, NULL),
(671, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 254w 115d 1s', 'EBT', 75, 15, 2, 254, 115, 1, NULL),
(672, 'EBT 15.5 3P 256', 'EBT 15.5gsm 3p 256w 115d 1s', 'EBT', 73, 15.5, 3, 256, 115, 1, NULL),
(673, 'EBT 15.5 3P 256', 'EBT 15.5gsm 3p 256w 115d 2s', 'EBT', 73, 15.5, 3, 256, 115, 2, NULL),
(674, 'EBT 16.5 2P 130', 'EBT 16.5gsm 2p 130w 90d 1s', 'EBT', 73, 16.5, 2, 130, 90, 1, NULL),
(675, 'EBT 16.5 2P 130', 'EBT 16.5gsm 2p 130w 110d 1s', 'EBT', 73, 16.5, 2, 130, 110, 1, NULL),
(676, 'EBT 16.5 2P 130', 'EBT 16.5gsm 2p 130w 115d 1s', 'EBT', 73, 16.5, 2, 130, 115, 1, NULL),
(677, 'EBT 16.5 2P 257', 'EBT 16.5gsm 2p 257w 115d 1s', 'EBT', 73, 16.5, 2, 257, 115, 1, NULL),
(678, 'EBT 16.5 2P 257', 'EBT 16.5gsm 2p 257w 150d 1s', 'EBT', 73, 16.5, 2, 257, 150, 1, NULL),
(679, 'EBT 17.0 1P 282', 'EBT 17.0gsm 1p 282w 150d 1s', 'EBT', 73, 17, 1, 282, 150, 1, NULL),
(680, 'EBT 17.0 1P 282', 'EBT 17.0gsm 1p 282w 155d 1s', 'EBT', 73, 17, 1, 282, 155, 1, NULL),
(681, 'EBT 17.0 1P 282', 'EBT 17.0gsm 1p 282w 170d 1s', 'EBT', 73, 17, 1, 282, 170, 1, NULL),
(682, 'EBT 17.0 1P 282', 'EBT 17.0gsm 1p 282w 242d 1s', 'EBT', 73, 17, 1, 282, 242, 1, NULL),
(683, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 130w 65d 1s', 'EBT', 73, 17, 2, 130, 65, 1, NULL),
(684, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 130w 110d 1s', 'EBT', 73, 17, 2, 130, 110, 1, NULL),
(685, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 130w 115d 1s', 'EBT', 73, 17, 2, 130, 115, 1, NULL),
(686, 'EBT 17.0 2P 282', 'EBT 17.0gsm 2p 282w 145d 1s', 'EBT', 73, 17, 2, 282, 145, 1, NULL),
(687, 'EBT 17.0 2P 282', 'EBT 17.0gsm 2p 282w 150d 1s', 'EBT', 73, 17, 2, 282, 150, 1, NULL),
(688, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 114d 4s', 'ETN', 74, 17, 1, 28, 114, 4, NULL),
(689, 'PBT 15.0 3P 254', 'PBT 15.0gsm 3p 254w 115d 1s', 'PBT', 87, 15, 3, 254, 115, 1, NULL),
(690, 'PBT 15.5 2P 110', 'PBT 15.5gsm 2p 110w 100d 1s', 'PBT', 87, 15.5, 2, 110, 100, 1, NULL),
(691, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 128d 1s', 'PBT', 85, 15.5, 2, 288, 128, 1, NULL),
(692, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 140d 1s', 'PBT', 85, 15.5, 2, 288, 140, 1, NULL),
(693, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 180d 1s', 'PBT', 85, 15.5, 2, 288, 180, 1, NULL),
(694, 'PBT 16.5 2P 142', 'PBT 16.5gsm 2p 142w 100d 1s', 'PBT', 86, 16.5, 2, 142, 100, 1, NULL),
(695, 'PBT 16.5 2P 40', 'PBT 16.5gsm 2p 40w 115d 1s', 'PBT', 86, 16.5, 2, 40, 115, 1, NULL),
(696, 'PBT 16.5 2P 40', 'PBT 16.5gsm 2p 40w 115d 3s', 'PBT', 86, 16.5, 2, 40, 115, 3, NULL),
(697, 'PBT 16.5 2P 40', 'PBT 16.5gsm 2p 40w 115d 4s', 'PBT', 86, 16.5, 2, 40, 115, 4, NULL),
(698, 'PBT 17.0 2P 256', 'PBT 17.0gsm 2p 256w 110d 1s', 'PBT', 87, 17, 2, 256, 110, 1, NULL),
(699, 'PBT 17.0 3P 288', 'PBT 17.0gsm 3p 288w 120d 1s', 'PBT', 87, 17, 3, 288, 120, 1, NULL),
(700, 'PBT 17.0 3P 288', 'PBT 17.0gsm 3p 288w 140d 1s', 'PBT', 87, 17, 3, 288, 140, 1, NULL),
(701, 'PBT 18.5 2P 144', 'PBT 18.5gsm 2p 144w 115d 1s', 'PBT', 87, 18.5, 2, 144, 115, 1, NULL),
(702, 'PBT 19.0 2P 255', 'PBT 19.0gsm 2p 255w 110d 1s', 'PBT', 87, 19, 2, 255, 110, 1, NULL),
(703, 'PFT 13.5 3P 19', 'PFT 13.5gsm 3p 19w 112d 7s', 'PFT', 85, 13.5, 3, 19, 112, 7, NULL),
(704, 'PFT 13.5 3P 19', 'PFT 13.5gsm 3p 19w 115d 5s', 'PFT', 85, 13.5, 3, 19, 115, 5, NULL),
(705, 'PFT 13.5 4P 19', 'PFT 13.5gsm 4p 19w 112d 6s', 'PFT', 85, 13.5, 4, 19, 112, 6, NULL),
(706, 'PFT 14 2P 126', 'PFT 14gsm 2p 126w 110d 1s', 'PFT', 87, 14, 2, 126, 110, 1, NULL),
(707, 'PFT 14 2P 126', 'PFT 14gsm 2p 126w 115d 2s', 'PFT', 87, 14, 2, 126, 115, 2, NULL),
(708, 'PFT 14.0 2P 108', 'PFT 14.0gsm 2p 108w 115d 2s', 'PFT', 87, 14, 2, 108, 115, 2, NULL),
(709, 'PFT 14.0 2P 126', 'PFT 14.0gsm 2p 126w 115d 1s', 'PFT', 86, 14, 2, 126, 115, 1, NULL),
(710, 'PFT 14.0 2P 126', 'PFT 14.0gsm 2p 126w 115d 2s', 'PFT', 86, 14, 2, 126, 115, 2, NULL),
(711, 'PFT 14.0 2P 42', 'PFT 14.0gsm 2p 42w 115d 1s', 'PFT', 87, 14, 2, 42, 115, 1, NULL),
(712, 'PFT 14.0 2P 42', 'PFT 14.0gsm 2p 42w 115d 3s', 'PFT', 87, 14, 2, 42, 115, 3, NULL),
(713, 'PFT 14.0 3P 100', 'PFT 14.0gsm 3p 100w 100d 2s', 'PFT', 84, 14, 3, 100, 100, 2, NULL),
(714, 'PFT 14.0 3P 100', 'PFT 14.0gsm 3p 100w 110d 2s', 'PFT', 84, 14, 3, 100, 110, 2, NULL),
(715, 'PFT 14.0 3P 100', 'PFT 14.0gsm 3p 100w 115d 2s', 'PFT', 84, 14, 3, 100, 115, 2, NULL),
(716, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 90d 1s', 'PFT', 87, 14.5, 2, 57, 90, 1, NULL),
(717, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 100d 1s', 'PFT', 87, 14.5, 2, 57, 100, 1, NULL),
(718, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 105d 2s', 'PFT', 87, 14.5, 2, 57, 105, 2, NULL),
(719, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 112d 2s', 'PFT', 87, 14.5, 2, 57, 112, 2, NULL),
(720, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 115d 1s', 'PFT', 87, 14.5, 2, 57, 115, 1, NULL),
(721, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 115d 2s', 'PFT', 87, 14.5, 2, 57, 115, 2, NULL),
(722, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 85d 1s', 'PFT', 87, 14.5, 2, 76, 85, 1, NULL),
(723, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 105d 3s', 'PFT', 87, 14.5, 2, 76, 105, 3, NULL),
(724, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 110d 1s', 'PFT', 87, 14.5, 2, 76, 110, 1, NULL),
(725, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 110d 2s', 'PFT', 87, 14.5, 2, 76, 110, 2, NULL),
(726, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 112d 2s', 'PFT', 87, 14.5, 2, 76, 112, 2, NULL),
(727, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 115d 2s', 'PFT', 87, 14.5, 2, 76, 115, 2, NULL),
(728, 'PFT 14.5 3P 19', 'PFT 14.5gsm 3p 19w 102d 7s', 'PFT', 85, 14.5, 3, 19, 102, 7, NULL),
(729, 'PFT 14.5 3P 19', 'PFT 14.5gsm 3p 19w 112d 4s', 'PFT', 85, 14.5, 3, 19, 112, 4, NULL),
(730, 'PFT 14.5 3P 19', 'PFT 14.5gsm 3p 19w 112d 5s', 'PFT', 85, 14.5, 3, 19, 112, 5, NULL),
(731, 'PFT 14.5 3P 19', 'PFT 14.5gsm 3p 19w 112d 7s', 'PFT', 85, 14.5, 3, 19, 112, 7, NULL),
(732, 'PFT 14.5 3P 22', 'PFT 14.5gsm 3p 22w 115d 4s', 'PFT', 85, 14.5, 3, 22, 115, 4, NULL),
(733, 'PFT 14.5 3P 38', 'PFT 14.5gsm 3p 38w 115d 2s', 'PFT', 87, 14.5, 3, 38, 115, 2, NULL),
(734, 'PFT 15.0 2P 126', 'PFT 15.0gsm 2p 126w 110d 1s', 'PFT', 85, 15, 2, 126, 110, 1, NULL),
(735, 'PFT 15.5 2P 82', 'PFT 15.5gsm 2p 82w 115d 2s', 'PFT', 85, 15.5, 2, 82, 115, 2, NULL),
(736, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 90w 110d 1s', 'PFT', 87, 15.5, 2, 90, 110, 1, NULL),
(737, 'PFT 15.5 3P 43', 'PFT 15.5gsm 3p 43w 117d 1s', 'PFT', 87, 15.5, 3, 43, 117, 1, NULL),
(738, 'PFT 15.5 3P 43', 'PFT 15.5gsm 3p 43w 117d 2s', 'PFT', 87, 15.5, 3, 43, 117, 2, NULL),
(739, 'PFT 15.5 3P 43', 'PFT 15.5gsm 3p 43w 117d 3s', 'PFT', 87, 15.5, 3, 43, 117, 3, NULL),
(740, 'PFT 15.5 3P 43', 'PFT 15.5gsm 3p 43w 117d 5s', 'PFT', 87, 15.5, 3, 43, 117, 5, NULL),
(741, 'PFT 15.5 3P 43', 'PFT 15.5gsm 3p 43w 117d 6s', 'PFT', 87, 15.5, 3, 43, 117, 6, NULL),
(742, 'PKT 22.0 2P 140', 'PKT 22.0gsm 2p 140w 90d 1s', 'PKT', 87, 22, 2, 140, 90, 1, NULL),
(743, 'PKT 22.0 2P 140', 'PKT 22.0gsm 2p 140w 98d 1s', 'PKT', 87, 22, 2, 140, 98, 1, NULL),
(744, 'PKT 22.0 2P 140', 'PKT 22.0gsm 2p 140w 100d 1s', 'PKT', 87, 22, 2, 140, 100, 1, NULL),
(745, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 135d 1s', 'PKT', 87, 22, 2, 288, 135, 1, NULL),
(746, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 150d 1s', 'PKT', 87, 22, 2, 288, 150, 1, NULL),
(747, 'PKT 23.0 1P 288', 'PKT 23.0gsm 1p 288w 80d 1s', 'PKT', 87, 23, 1, 288, 80, 1, NULL),
(748, 'PKT 23.0 1P 288', 'PKT 23.0gsm 1p 288w 110d 1s', 'PKT', 87, 23, 1, 288, 110, 1, NULL),
(749, 'PKT 23.0 1P 288', 'PKT 23.0gsm 1p 288w 150d 1s', 'PKT', 87, 23, 1, 288, 150, 1, NULL),
(750, 'PKT 23.0 2P 140', 'PKT 23.0gsm 2p 140w 110d 1s', 'PKT', 87, 23, 2, 140, 110, 1, NULL),
(751, 'PKT 24.0 2P 255', 'PKT 24.0gsm 2p 255w 110d 1s', 'PKT', 87, 24, 2, 255, 110, 1, NULL),
(752, 'PKT 24.0 2P 30', 'PKT 24.0gsm 2p 30w 115d 1s', 'PKT', 86, 24, 2, 30, 115, 1, NULL),
(753, 'PKT 25.0 2P 275', 'PKT 25.0gsm 2p 275w 122d 1s', 'PKT', 87, 25, 2, 275, 122, 1, NULL),
(754, 'PTN 16.5 2P 33', 'PTN 16.5gsm 2p 33w 90d 3s', 'PTN', 88, 16.5, 2, 33, 90, 3, NULL),
(755, 'PTN 16.5 2P 33', 'PTN 16.5gsm 2p 33w 95d 4s', 'PTN', 88, 16.5, 2, 33, 95, 4, NULL),
(756, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 75d 5s', 'PTN', 87, 17, 1, 30, 75, 5, NULL),
(757, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 110d 3s', 'PTN', 87, 17, 1, 30, 110, 3, NULL),
(758, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 112d 1s', 'PTN', 87, 17, 1, 30, 112, 1, NULL),
(759, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 115d 2s', 'PTN', 87, 17, 1, 30, 115, 2, NULL),
(760, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 80d 3s', 'PTN', 87, 17, 1, 33, 80, 3, NULL),
(761, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 100d 4s', 'PTN', 87, 17, 1, 33, 100, 4, NULL),
(762, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 115d 2s', 'PTN', 87, 17, 1, 33, 115, 2, NULL),
(763, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 115d 3s', 'PTN', 87, 17, 1, 33, 115, 3, NULL),
(764, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 115d 4s', 'PTN', 87, 17, 1, 33, 115, 4, NULL),
(765, 'PTN 17.0 1P 66', 'PTN 17.0gsm 1p 66w 115d 2s', 'PTN', 85, 17, 1, 66, 115, 2, NULL),
(766, 'PTN 17.0 3P 33', 'PTN 17.0gsm 3p 33w 100d 4s', 'PTN', 87, 17, 3, 33, 100, 4, NULL),
(767, 'PTN 17.0 3P 33', 'PTN 17.0gsm 3p 33w 115d 5s', 'PTN', 87, 17, 3, 33, 115, 5, NULL),
(768, 'PTN 17.0 3P 33', 'PTN 17.0gsm 3p 33w 120d 1s', 'PTN', 87, 17, 3, 33, 120, 1, NULL),
(769, 'PTN 17.0 3P 33', 'PTN 17.0gsm 3p 33w 120d 3s', 'PTN', 87, 17, 3, 33, 120, 3, NULL),
(770, 'PTN 17.0 3P 33', 'PTN 17.0gsm 3p 33w 120d 4s', 'PTN', 87, 17, 3, 33, 120, 4, NULL),
(771, 'PTN 17.0 3P 33', 'PTN 17.0gsm 3p 33w 150d 4s', 'PTN', 87, 17, 3, 33, 150, 4, NULL),
(772, 'PTN 18.0 1P 29', 'PTN 18.0gsm 1p 29w 115d 2s', 'PTN', 86, 18, 1, 29, 115, 2, NULL),
(773, 'PTN 18.0 1P 29', 'PTN 18.0gsm 1p 29w 115d 4s', 'PTN', 86, 18, 1, 29, 115, 4, NULL),
(774, 'PTN 20.0 1P 30', 'PTN 20.0gsm 1p 30w 115d 4s', 'PTN', 88, 20, 1, 30, 115, 4, NULL),
(775, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 110d 4s', 'PTN', 86, 20, 1, 33, 110, 4, NULL),
(776, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 115d 4s', 'PTN', 86, 20, 1, 33, 115, 4, NULL),
(777, 'SBT 14.5 3P 102', 'SBT 14.5gsm 3p 102w 112d 2s', 'SBT', 86, 14.5, 3, 102, 112, 2, NULL),
(778, 'SBT 15.5 2P 100', 'SBT 15.5gsm 2p 100w 115d 1s', 'SBT', 86, 15.5, 2, 100, 115, 1, NULL),
(779, 'SBT 15.5 2P 100', 'SBT 15.5gsm 2p 100w 115d 2s', 'SBT', 86, 15.5, 2, 100, 115, 2, NULL),
(780, 'SBT 15.5 2P 80', 'SBT 15.5gsm 2p 80w 84d 1s', 'SBT', 86, 15.5, 2, 80, 84, 1, NULL),
(781, 'SBT 15.5 2P 80', 'SBT 15.5gsm 2p 80w 100d 1s', 'SBT', 86, 15.5, 2, 80, 100, 1, NULL),
(782, 'SBT 15.5 2P 80', 'SBT 15.5gsm 2p 80w 115d 1s', 'SBT', 86, 15.5, 2, 80, 115, 1, NULL),
(783, 'SBT 15.5 2P 80', 'SBT 15.5gsm 2p 80w 115d 2s', 'SBT', 86, 15.5, 2, 80, 115, 2, NULL),
(784, 'SBT 16.5 2P 130', 'SBT 16.5gsm 2p 130w 115d 1s', 'SBT', 86, 16.5, 2, 130, 115, 1, NULL),
(785, 'SBT 16.5 2P 170', 'SBT 16.5gsm 2p 170w 110d 1s', 'SBT', 83, 16.5, 2, 170, 110, 1, NULL),
(786, 'SBT 16.5 3P 132', 'SBT 16.5gsm 3p 132w 110d 1s', 'SBT', 86, 16.5, 3, 132, 110, 1, NULL),
(787, 'SBT 16.5 3P 132', 'SBT 16.5gsm 3p 132w 115d 1s', 'SBT', 86, 16.5, 3, 132, 115, 1, NULL),
(788, 'SBT 17.0 1P 279', 'SBT 17.0gsm 1p 279w 120d 1s', 'SBT', 82, 17, 1, 279, 120, 1, NULL),
(789, 'SBT 17.0 1P 279', 'SBT 17.0gsm 1p 279w 140d 1s', 'SBT', 82, 17, 1, 279, 140, 1, NULL),
(790, 'SBT 17.0 1P 279', 'SBT 17.0gsm 1p 279w 145d 1s', 'SBT', 82, 17, 1, 279, 145, 1, NULL),
(791, 'SBT 17.0 1P 279', 'SBT 17.0gsm 1p 279w 150d 1s', 'SBT', 82, 17, 1, 279, 150, 1, NULL),
(792, 'SBT 17.0 1P 279', 'SBT 17.0gsm 1p 279w 155d 1s', 'SBT', 82, 17, 1, 279, 155, 1, NULL),
(793, 'SBT 17.0 2P 142', 'SBT 17.0gsm 2p 142w 100d 1s', 'SBT', 87, 17, 2, 142, 100, 1, NULL),
(794, 'SBT 17.0 2P 254', 'SBT 17.0gsm 2p 254w 115d 1s', 'SBT', 86, 17, 2, 254, 115, 1, NULL),
(795, 'SBT 17.0 2P 254', 'SBT 17.0gsm 2p 254w 170d 1s', 'SBT', 86, 17, 2, 254, 170, 1, NULL),
(796, 'SBT 17.0 2P 255', 'SBT 17.0gsm 2p 255w 115d 1s', 'SBT', 84, 17, 2, 255, 115, 1, NULL),
(797, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 110d 1s', 'SBT', 86, 17, 2, 256, 110, 1, NULL),
(798, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 115d 1s', 'SBT', 86, 17, 2, 256, 115, 1, NULL),
(799, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 170d 1s', 'SBT', 86, 17, 2, 256, 170, 1, NULL),
(800, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 120d 1s', 'SBT', 82, 17, 2, 282, 120, 1, NULL),
(801, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 125d 1s', 'SBT', 82, 17, 2, 282, 125, 1, NULL),
(802, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 130d 1s', 'SBT', 82, 17, 2, 282, 130, 1, NULL),
(803, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 135d 1s', 'SBT', 82, 17, 2, 282, 135, 1, NULL),
(804, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 140d 1s', 'SBT', 82, 17, 2, 282, 140, 1, NULL),
(805, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 147d 1s', 'SBT', 82, 17, 2, 282, 147, 1, NULL),
(806, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 148d 1s', 'SBT', 82, 17, 2, 282, 148, 1, NULL),
(807, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 150d 1s', 'SBT', 82, 17, 2, 282, 150, 1, NULL),
(808, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 155d 1s', 'SBT', 82, 17, 2, 282, 155, 1, NULL),
(809, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 157d 1s', 'SBT', 82, 17, 2, 282, 157, 1, NULL),
(810, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 165d 1s', 'SBT', 82, 17, 2, 282, 165, 1, NULL),
(811, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 282w 170d 1s', 'SBT', 82, 17, 2, 282, 170, 1, NULL),
(812, 'SBT 17.5 2P 130', 'SBT 17.5gsm 2p 130w 115d 1s', 'SBT', 86, 17.5, 2, 130, 115, 1, NULL),
(813, 'SBT 17.5 2P 282', 'SBT 17.5gsm 2p 282w 120d 1s', 'SBT', 82, 17.5, 2, 282, 120, 1, NULL),
(814, 'SBT 17.5 2P 282', 'SBT 17.5gsm 2p 282w 140d 1s', 'SBT', 82, 17.5, 2, 282, 140, 1, NULL),
(815, 'SBT 17.5 2P 282', 'SBT 17.5gsm 2p 282w 150d 1s', 'SBT', 82, 17.5, 2, 282, 150, 1, NULL),
(816, 'SBT 17.5 2P 282', 'SBT 17.5gsm 2p 282w 165d 1s', 'SBT', 82, 17.5, 2, 282, 165, 1, NULL),
(817, 'SBT 17.5 2P 282', 'SBT 17.5gsm 2p 282w 170d 1s', 'SBT', 82, 17.5, 2, 282, 170, 1, NULL),
(818, 'SBT 17.5 2P 65', 'SBT 17.5gsm 2p 65w 60d 1s', 'SBT', 89, 17.5, 2, 65, 60, 1, NULL),
(819, 'SBT 17.5 2P 65', 'SBT 17.5gsm 2p 65w 115d 1s', 'SBT', 89, 17.5, 2, 65, 115, 1, NULL),
(820, 'SBT 18.0 2P 132', 'SBT 18.0gsm 2p 132w 115d 1s', 'SBT', 86, 18, 2, 132, 115, 1, NULL),
(821, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 256w 110d 1s', 'SBT', 86, 18, 2, 256, 110, 1, NULL),
(822, 'SBT 19.0 2P 255', 'SBT 19.0gsm 2p 255w 110d 1s', 'SBT', 86, 19, 2, 255, 110, 1, NULL),
(823, 'SBT 20.0 2P 132', 'SBT 20.0gsm 2p 132w 78d 1s', 'SBT', 86, 20, 2, 132, 78, 1, NULL),
(824, 'SFT 14.5 2P 100', 'SFT 14.5gsm 2p 100w 100d 2s', 'SFT', 86, 14.5, 2, 100, 100, 2, NULL),
(825, 'SFT 14.5 2P 100', 'SFT 14.5gsm 2p 100w 115d 1s', 'SFT', 86, 14.5, 2, 100, 115, 1, NULL),
(826, 'SFT 14.5 2P 100', 'SFT 14.5gsm 2p 100w 115d 2s', 'SFT', 86, 14.5, 2, 100, 115, 2, NULL),
(827, 'SFT 14.5 2P 100', 'SFT 14.5gsm 2p 100w 115d 3s', 'SFT', 86, 14.5, 2, 100, 115, 3, NULL),
(828, 'SFT 14.5 2P 120', 'SFT 14.5gsm 2p 120w 115d 1s', 'SFT', 84, 14.5, 2, 120, 115, 1, NULL),
(829, 'SFT 14.5 2P 80', 'SFT 14.5gsm 2p 80w 115d 1s', 'SFT', 86, 14.5, 2, 80, 115, 1, NULL),
(830, 'SFT 14.5 2P 80', 'SFT 14.5gsm 2p 80w 115d 2s', 'SFT', 86, 14.5, 2, 80, 115, 2, NULL),
(831, 'SFT 14.5 2P 80', 'SFT 14.5gsm 2p 80w 115d 3s', 'SFT', 86, 14.5, 2, 80, 115, 3, NULL),
(832, 'SKT 19.0 2P 260', 'SKT 19.0gsm 2p 260w 115d 1s', 'SKT', 86, 19, 2, 260, 115, 1, NULL),
(833, 'SKT 20.0 2P 100', 'SKT 20.0gsm 2p 100w 110d 1s', 'SKT', 86, 20, 2, 100, 110, 1, NULL),
(834, 'SKT 20.0 2P 132', 'SKT 20.0gsm 2p 132w 110d 1s', 'SKT', 84, 20, 2, 132, 110, 1, NULL),
(835, 'SKT 20.0 2P 132', 'SKT 20.0gsm 2p 132w 115d 1s', 'SKT', 84, 20, 2, 132, 115, 1, NULL),
(836, 'SKT 20.0 2P 140', 'SKT 20.0gsm 2p 140w 100d 1s', 'SKT', 84, 20, 2, 140, 100, 1, NULL),
(837, 'SKT 20.0 2P 186', 'SKT 20.0 2P 186', 'SKT', 84, 20, 2, 186, 110, 1, NULL),
(838, 'SKT 20.0 2P 288', 'SKT 20.0gsm 2p 288w 94d 1s', 'SKT', 86, 20, 2, 288, 94, 1, NULL),
(839, 'SKT 20.0 2P 288', 'SKT 20.0 2P 288', 'SKT', 84, 20, 2, 288, 110, 1, NULL),
(840, 'SKT 20.0 2P 288', 'SKT 20.0gsm 2p 288w 120d 1s', 'SKT', 86, 20, 2, 288, 120, 1, NULL),
(841, 'SKT 20.0 2P 288', 'SKT 20.0gsm 2p 288w 140d 1s', 'SKT', 86, 20, 2, 288, 140, 1, NULL),
(842, 'SKT 21.0 1P 100', 'SKT 21.0gsm 1p 100w 110d 1s', 'SKT', 87, 21, 1, 100, 110, 1, NULL),
(843, 'SKT 21.0 1P 166', 'SKT 21.0gsm 1p 166w 115d 1s', 'SKT', 87, 21, 1, 166, 115, 1, NULL),
(844, 'SKT 21.0 2P 132', 'SKT 21.0gsm 2p 132w 110d 1s', 'SKT', 86, 21, 2, 132, 110, 1, NULL),
(845, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 90d 1s', 'SKT', 86, 22, 1, 288, 90, 1, NULL),
(846, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 100d 1s', 'SKT', 86, 22, 1, 288, 100, 1, NULL),
(847, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 115d 1s', 'SKT', 86, 22, 1, 288, 115, 1, NULL),
(848, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 120d 1s', 'SKT', 86, 22, 1, 288, 120, 1, NULL),
(849, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 130d 1s', 'SKT', 86, 22, 1, 288, 130, 1, NULL),
(850, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 148d 1s', 'SKT', 86, 22, 1, 288, 148, 1, NULL),
(851, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 150d 1s', 'SKT', 86, 22, 1, 288, 150, 1, NULL),
(852, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 240d 1s', 'SKT', 86, 22, 1, 288, 240, 1, NULL),
(853, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 245d 1s', 'SKT', 86, 22, 1, 288, 245, 1, NULL),
(854, 'SKT 22.0 1P 288', 'SKT 22.0gsm 1p 288w 250d 1s', 'SKT', 86, 22, 1, 288, 250, 1, NULL),
(855, 'SKT 22.0 1P 80', 'SKT 22.0gsm 1p 80w 100d 1s', 'SKT', 87, 22, 1, 80, 100, 1, NULL),
(856, 'SKT 22.0 2P 132', 'SKT 22.0gsm 2p 132w 115d 1s', 'SKT', 86, 22, 2, 132, 115, 1, NULL),
(857, 'SKT 22.0 2P 140', 'SKT 22.0gsm 2p 140w 100d 1s', 'SKT', 86, 22, 2, 140, 100, 1, NULL),
(858, 'SKT 23.0 1P 100', 'SKT 23.0gsm 1p 100w 110d 1s', 'SKT', 87, 23, 1, 100, 110, 1, NULL),
(859, 'SKT 23.0 1P 80', 'SKT 23.0gsm 1p 80w 120d 1s', 'SKT', 87, 23, 1, 80, 120, 1, NULL),
(860, 'SKT 23.0 2P 140', 'SKT 23.0gsm 2p 140w 240d 1s', 'SKT', 86, 23, 2, 140, 240, 1, NULL),
(861, 'SKT 23.0 2P 288', 'SKT 23.0gsm 2p 288w 150d 1s', 'SKT', 86, 23, 2, 288, 150, 1, NULL),
(862, 'SKT 25.0 2P 275', 'SKT 25.0gsm 2p 275w 115d 1s', 'SKT', 86, 25, 2, 275, 115, 1, NULL),
(863, 'SKT 34.0 1P 86', 'SKT 34.0gsm 1p 86w 115d 2s', 'SKT', 84, 34, 1, 86, 115, 2, NULL),
(864, 'SKT 40.0 1P 250', 'SKT 40.0gsm 1p 250w 120d 1s', 'SKT', 84, 40, 1, 250, 120, 1, NULL),
(865, 'SKT 40.0 1P 282', 'SKT 40.0gsm 1p 282w 110d 1s', 'SKT', 84, 40, 1, 282, 110, 1, NULL),
(866, 'SKT 40.0 1P 282', 'SKT 40.0gsm 1p 282w 115d 1s', 'SKT', 84, 40, 1, 282, 115, 1, NULL),
(867, 'SKT 40.0 1P 282', 'SKT 40.0gsm 1p 282w 120d 1s', 'SKT', 84, 40, 1, 282, 120, 1, NULL),
(868, 'SKT 40.0 1P 282', 'SKT 40.0gsm 1p 282w 150d 1s', 'SKT', 84, 40, 1, 282, 150, 1, NULL),
(869, 'SKT 40.0 1P 288', 'SKT 40.0gsm 1p 288w 110d 1s', 'SKT', 86, 40, 1, 288, 110, 1, NULL),
(870, 'SKT 40.0 1P 288', 'SKT 40.0gsm 1p 288w 120d 1s', 'SKT', 86, 40, 1, 288, 120, 1, NULL),
(871, 'SKT 40.0 1P 288', 'SKT 40.0gsm 1p 288w 125d 1s', 'SKT', 86, 40, 1, 288, 125, 1, NULL),
(872, 'SKT 40.0 1P 288', 'SKT 40.0gsm 1p 288w 130d 1s', 'SKT', 86, 40, 1, 288, 130, 1, NULL),
(873, 'SKT 40.0 1P 288', 'SKT 40.0gsm 1p 288w 180d 1s', 'SKT', 86, 40, 1, 288, 180, 1, NULL),
(874, 'SKT 40.0 1P 288', 'SKT 40.0gsm 1p 288w 200d 1s', 'SKT', 86, 40, 1, 288, 200, 1, NULL),
(875, 'SKT 40.0 1P 288', 'SKT 40.0gsm 1p 288w 245d 1s', 'SKT', 86, 40, 1, 288, 245, 1, NULL),
(876, 'SKT 40.0 1P 30', 'SKT 40.0gsm 1p 30w 115d 1s', 'SKT', 84, 40, 1, 30, 115, 1, NULL),
(877, 'SKT 42.0 1P 80', 'SKT 42.0gsm 1p 80w 100d 1s', 'SKT', 84, 42, 1, 80, 100, 1, NULL),
(878, 'SKT 42.0 1P 80', 'SKT 42.0gsm 1p 80w 100d 2s', 'SKT', 84, 42, 1, 80, 100, 2, NULL),
(879, 'SKT 42.0 1P 80', 'SKT 42.0gsm 1p 80w 100d 3s', 'SKT', 84, 42, 1, 80, 100, 3, NULL),
(880, 'SKT 42.0 1P 80', 'SKT 42.0gsm 1p 80w 115d 1s', 'SKT', 84, 42, 1, 80, 115, 1, NULL),
(881, 'SKT+ 21.0 2P 288', 'SKT+ 21.0gsm 2p 288w 110d 1s', 'SKT+', 86, 21, 2, 288, 110, 1, NULL),
(882, 'SKT+ 21.0 2P 288', 'SKT+ 21.0gsm 2p 288w 150d 1s', 'SKT+', 86, 21, 2, 288, 150, 1, NULL),
(883, 'STN 17.0 2P 30', 'STN 17.0gsm 2p 30w 60d 3s', 'STN', 86, 17, 2, 30, 60, 3, NULL),
(884, 'STN 17.0 2P 30', 'STN 17.0gsm 2p 30w 115d 4s', 'STN', 86, 17, 2, 30, 115, 4, NULL),
(885, 'STN 18.0 1P 29', 'STN 18.0gsm 1p 29w 115d 4s', 'STN', 85, 18, 1, 29, 115, 4, NULL),
(886, 'STN 22.0 2P 140', 'STN 22.0gsm 2p 140w 115d 1s', 'STN', 86, 22, 2, 140, 115, 1, NULL),
(887, 'UBT 16.7 2P 288', 'UBT 16.7gsm 2p 288w 60d 1s', 'UBT', 67, 16.7, 2, 288, 60, 1, NULL),
(888, 'UBT 16.7 2P 288', 'UBT 16.7gsm 2p 288w 150d 1s', 'UBT', 67, 16.7, 2, 288, 150, 1, NULL),
(889, 'UKT 20.0 3P 288', 'UKT 20.0gsm 3p 288w 114d 1s', 'UKT', 56, 20, 3, 288, 114, 1, NULL),
(890, 'UKT 20.0 3P 288', 'UKT 20.0gsm 3p 288w 120d 1s', 'UKT', 56, 20, 3, 288, 120, 1, NULL),
(891, 'UKT 40.0 1P 288', 'UKT 40.0gsm 1p 288w 120d 1s', 'UKT', 87, 40, 1, 288, 120, 1, NULL),
(892, 'UKT 40.0 1P 288', 'UKT 40.0gsm 1p 288w 150d 1s', 'UKT', 87, 40, 1, 288, 150, 1, NULL),
(893, 'UKT 45.0 1P 288', 'UKT 45.0gsm 1p 288w 108d 1s', 'UKT', 56, 45, 1, 288, 108, 1, NULL),
(894, 'UKT 45.0 1P 288', 'UKT 45.0gsm 1p 288w 112d 1s', 'UKT', 56, 45, 1, 288, 112, 1, NULL),
(895, 'UTN 16.0 3P 33', 'UTN 16.0gsm 3p 33w 120d 4s', 'UTN', 55, 16, 3, 33, 120, 4, NULL),
(896, 'UTN 16.0 3P 38', 'UTN 16.0gsm 3p 38w 120d 4s', 'UTN', 55, 16, 3, 38, 120, 4, NULL),
(897, 'UTN 17.0 1P 66', 'UTN 17.0gsm 1p 66w 100d 2s', 'UTN', 55, 17, 1, 66, 100, 2, NULL),
(898, 'PFT(PEACH) 15.3 2P 84', 'PFT(PEACH) 15.3gsm 2p 84w 115d 3s', 'PFT(PEACH)', 42, 15.3, 2, 84, 115, 3, NULL),
(899, 'PFT(PEACH) 15.5 2P 84', 'PFT(PEACH) 15.5gsm 2p 84w 115d 3s', 'PFT(PEACH)', 85, 15.5, 2, 84, 115, 3, NULL),
(900, 'SBT 17.0 2P 165', 'SBT 17.0gsm 2p 165w 115d 1s', 'SBT', 84, 17, 2, 165, 115, 1, NULL),
(901, 'SBT 17.0 2P 95', 'SBT 17.0gsm 2p 95w 115d 1s', 'SBT', 84, 17, 2, 95, 115, 1, NULL),
(902, 'PTN 21.0 1P 33', 'PTN 21.0gsm 1p 33w 115d 4s', 'PTN', 87, 21, 1, 33, 115, 4, NULL),
(903, 'PTN 22.0 1P 33', 'PTN 22.0gsm 1p 33w 115d 4s', 'PTN', 87, 22, 1, 33, 115, 4, NULL),
(904, 'SFT 15.0 2P 38', 'SFT 15.0gsm 2p 38w 110d 3s', 'SFT', 84, 15, 2, 38, 110, 3, NULL),
(905, 'SFT 15.0 2P 38', 'SFT 15.0gsm 2p 38w 110d 4s', 'SFT', 84, 15, 2, 38, 110, 4, NULL),
(906, 'SFT 15.0 2P 38', 'SFT 15.0gsm 2p 38w 115d 3s', 'SFT', 84, 15, 2, 38, 115, 3, NULL),
(907, 'SFT 15.0 2P 38', 'SFT 15.0gsm 2p 38w 115d 4s', 'SFT', 84, 15, 2, 38, 115, 4, NULL),
(908, 'SFT 15.0 2P 90', 'SFT 15.0gsm 2p 90w 75d 2s', 'SFT', 86, 15, 2, 90, 75, 2, NULL),
(909, 'SFT 15.0 2P 90', 'SFT 15.0gsm 2p 90w 100d 2s', 'SFT', 86, 15, 2, 90, 100, 2, NULL),
(910, 'PTN(PEACH) 15.0 3P 22', 'PTN(PEACH) 15.0gsm 3p 22w 115d 4s', 'PTN(PEACH)', 84, 15, 3, 22, 115, 4, NULL),
(911, 'PTN(YELLOW) 15.0 3P 22', 'PTN(YELLOW) 15.0gsm 3p 22w 115d 4s', 'PTN(YELLOW)', 84, 15, 3, 22, 115, 4, NULL),
(912, 'SFT 14.5 2P 76', 'SFT 14.5gsm 2p 76w 110d 2s', 'SFT', 87, 14.5, 2, 76, 110, 2, NULL),
(913, 'SKT 43.0 1P 100', 'SKT 43.0gsm 1p 100w 100d 2s', 'SKT', 86, 43, 1, 100, 100, 2, NULL),
(914, 'SKT 43.0 1P 100', 'SKT 43.0gsm 1p 100w 115d 2s', 'SKT', 86, 43, 1, 100, 115, 2, NULL),
(915, 'SKT 43.0 1P 100', 'SKT 43.0gsm 1p 100w 120d 2s', 'SKT', 86, 43, 1, 100, 120, 2, NULL),
(916, 'SKT 43.0 1P 100', 'SKT 43.0gsm 1p 100w 150d 2s', 'SKT', 86, 43, 1, 100, 150, 2, NULL),
(917, 'SKT 43.0 1P 75', 'SKT 43.0gsm 1p 75w 100d 2s', 'SKT', 86, 43, 1, 75, 100, 2, NULL),
(918, 'SKT 43.0 1P 75', 'SKT 43.0gsm 1p 75w 115d 2s', 'SKT', 86, 43, 1, 75, 115, 2, NULL),
(919, 'SKT 43.0 1P 75', 'SKT 43.0gsm 1p 75w 120d 2s', 'SKT', 86, 43, 1, 75, 120, 2, NULL),
(920, 'EBT 16.5 2P 147', 'EBT 16.5gsm 2p 147w 100d 1s', 'EBT', 73, 16.5, 2, 147, 100, 1, NULL),
(921, 'EBT 16.5 2P 147', 'EBT 16.5gsm 2p 147w 115d 1s', 'EBT', 73, 16.5, 2, 147, 115, 1, NULL),
(922, 'EBT 17.0 2P 256', 'EBT 17.0gsm 2p 256w 110d 1s', 'EBT', 75, 17, 2, 256, 110, 1, NULL),
(923, 'EBT 17.0 2P 30', 'EBT 17.0gsm 2p 30w 110d 4s', 'EBT', 75, 17, 2, 30, 110, 4, NULL),
(924, 'EBT 15.0 2P 256', 'EBT 15.0gsm 2p 256w 115d 1s', 'EBT', 75, 15, 2, 256, 115, 1, NULL),
(925, 'EBT 15.0 3P 25', 'EBT 15.0gsm 3p 25w 115d 4s', 'EBT', 72, 15, 3, 25, 115, 4, NULL),
(926, 'EBT 15.0 3P 25', 'EBT 15.0gsm 3p 25w 115d 5s', 'EBT', 72, 15, 3, 25, 115, 5, NULL),
(927, 'EBT 15.0 3P 25', 'EBT 15.0gsm 3p 25w 115d 6s', 'EBT', 72, 15, 3, 25, 115, 6, NULL),
(930, 'SKT 20.0 1P 250', 'SKT 20.0gsm 1p 250w 115d 1s', 'SKT', 84, 20, 1, 250, 115, 1, NULL),
(931, 'PBT 17.0 2P 142', 'PBT 17.0gsm 2p 142w 85d 1s', 'PBT', 87, 17, 2, 142, 115, 1, NULL),
(932, 'PFT 15.0 3P 20', 'PFT 15.0gsm 3p 20w 110d 2s', 'PFT', 87, 15, 3, 20, 110, 2, NULL),
(933, 'PKT 22.0 2P 135', 'PKT 22.0gsm 2p 135w 107d 1s', 'PKT', 87, 22, 2, 135, 107, 1, NULL),
(935, 'SFT 14.5 2P 57', 'SFT 14.5gsm 2p 57w 115d 2s', 'SFT', 86, 14.5, 2, 57, 115, 2, NULL),
(936, 'PKT 22.0 2P 135', 'PKT 22.0gsm 2p 135w 89d 1s', 'PKT', 87, 22, 2, 135, 89, 1, NULL),
(937, NULL, 'SKT 20.0 2P 256', 'SKT', 84, 20, 2, 256, 115, 1, NULL),
(946, NULL, 'SKT 20.0 2P 30', 'SKT', 84, 20, 2, 30, 115, 4, NULL),
(950, NULL, 'PTN 19.0 115P 33', 'PTN', 85, 19, 115, 33, 115, 2, NULL),
(958, NULL, 'STN 18.0 1P 30', 'STN', 84, 18, 1, 30, 80, 3, NULL),
(963, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 115d 5s', 'PTN', 87, 21, 1, 31.5, 115, 5, NULL),
(964, 'PBTS 16.5 2P 188', 'PBTS 16.5gsm 2p 288w 180d 1s', 'PBTs', 87, 16.5, 2, 288, 180, 1, NULL),
(965, NULL, 'EBT 15.0gsm 3p 30w 115d 5s', 'EBT', 73, 15, 3, 30, 115, 5, NULL),
(974, NULL, 'ETN 17.0gsm 2p 165w 115d 1s', 'ETN', 84, 17, 2, 165, 115, 1, '2020-04-16 09:04:21'),
(975, NULL, 'UKT 45.0gsm 1p 100w 115d 2s', 'UKT', 55, 45, 1, 100, 115, 2, NULL),
(976, NULL, 'UKT 45.0gsm 1p 75w 115d 2s', 'UKT', 55, 45, 1, 75, 115, 2, NULL),
(977, NULL, 'UTN 15.0gsm 3p 33w 115d 4s', 'UTN', 55, 15, 3, 33, 115, 4, NULL),
(978, NULL, 'UTN 15.0gsm 3p 38w 115d 4s', 'UTN', 55, 15, 3, 38, 115, 4, NULL),
(979, NULL, 'SBT 16.5gsm 2p 288w 150d 1s', 'SBT', 84, 16.5, 2, 288, 150, 1, NULL),
(981, 'SFT 14.5 2P 80', 'SFT 15.0gsm 2p 20w 115d 5s', 'SFT', 86, 15, 2, 20, 115, 5, NULL),
(982, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 80w 73d 1s', 'SBT', 86, 16.5, 2, 80, 73, 1, NULL),
(983, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 135w 78d 1s', 'SBT', 86, 16.5, 2, 135, 78, 1, NULL),
(984, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 80d 1s', 'PTN', 87, 17, 1, 30, 80, 1, NULL),
(985, 'PFT 14.5 2P 80', 'PFT 14.0gsm 2p 60w 115d 1s', 'PFT', 87, 14, 2, 60, 115, 1, NULL),
(986, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 40w 60d 2s', 'PBT', 87, 16.5, 2, 40, 60, 2, NULL),
(987, 'SKT 40.0 1P 100', 'SKT 40.0gsm 2p 100w 120d 1s', 'SKT', 86, 40, 2, 100, 120, 1, NULL),
(988, 'PTN 17.0 3P 38', 'PTN 15.0gsm 2p 38w 120d 4s', 'PTN', 87, 15, 2, 38, 120, 4, NULL),
(989, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 80w 110d 1s', 'SKT', 86, 21, 2, 80, 110, 1, NULL),
(990, 'PTN 21.0 1P 33', 'PTN 22.0gsm 1p 25w 115d 4s', 'PTN', 87, 22, 1, 25, 115, 4, NULL),
(991, 'PFT 15.5 3P 43', 'PFT 15.5gsm 3p 43w 110d 3s', 'PFT', 87, 15.5, 3, 43, 110, 3, NULL),
(992, 'SKT 22.0 2P 140', 'SKT 22.0gsm 2p 140w 85d 1s', 'SKT', 86, 22, 2, 140, 85, 1, NULL),
(993, 'SKT 20.0 2P 140', 'SKT 20.0gsm 2p 90w 74d 1s', 'SKT', 84, 20, 2, 90, 74, 1, NULL),
(994, 'EBT 15.5 3P 256', 'EBT 15.5gsm 3p 110w 102d 1s', 'EBT', 72, 15.5, 3, 110, 102, 1, NULL),
(995, 'EBT 17.0 2P 140', 'EBT 17.0gsm 2p 110w 100d 1s', 'EBT', 73, 17, 2, 110, 100, 1, NULL),
(996, 'SKT 20.0 2P 100', 'SKT 20.0gsm 2p 100w 102d 1s', 'SKT', 86, 20, 2, 100, 102, 1, NULL),
(997, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 105d 1s', 'SKT', 86, 21, 2, 100, 105, 1, NULL),
(998, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 131w 65d 1s', 'EBT', 73, 17, 2, 131, 65, 1, NULL),
(999, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 80w 85d 1s', 'PBT', 73, 16.5, 2, 80, 85, 1, NULL),
(1000, 'PFT 14.0 2P 20', 'PFT 14.0gsm 2p 20w 115d 6s', 'PFT', 86, 14, 2, 20, 115, 6, NULL),
(1001, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 58w 115d 1s', 'SBT', 84, 17, 2, 58, 115, 1, NULL),
(1002, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 279w 155d 1s', 'SBT', 82, 17, 2, 279, 155, 1, NULL),
(1003, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 279w 130d 1s', 'SBT', 82, 17, 2, 279, 130, 1, NULL),
(1004, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 279w 140d 1s', 'SBT', 82, 17, 2, 279, 140, 1, NULL),
(1005, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 120d 1s', 'SKT', 86, 21, 2, 100, 120, 1, NULL),
(1006, 'SKT 40.0 1P 100', 'SKT 23.0gsm 1p 100w 103d 1s', 'SKT', 87, 23, 1, 100, 103, 1, NULL),
(1007, 'UKT 40.0 1P 288', 'UKT 45.0gsm 1p 288w 120d 1s', 'UKT', 56, 45, 1, 288, 120, 1, NULL),
(1008, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 85d 2s', 'STN', 86, 18, 1, 30, 85, 2, NULL),
(1009, 'SKT 40.0 1P 75', 'SKT 40.0gsm 1p 75w 120d 2s', 'SKT', 86, 40, 1, 75, 120, 2, NULL),
(1010, 'SBT 15.5 2P 80', 'SBT 15.0gsm 2p 80w 115d 1s', 'SBT', 84, 15, 2, 80, 115, 1, NULL),
(1011, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 90w 66d 1s', 'EBT', 73, 16.5, 2, 90, 66, 1, NULL),
(1012, 'EBT 17.5 2P 95', 'EBT 17.5gsm 3p 100w 115d 1s', 'EBT', 75, 17.5, 3, 100, 115, 1, NULL),
(1013, 'PFT 14.2 3P 86', 'PFT 14.2gsm 3p 38w 115d 4s', 'PFT', 87, 14.2, 3, 38, 115, 4, NULL),
(1014, 'PKT 24.0 2P 30', 'PKT 24.0gsm 2p 85w 115d 1s', 'PKT', 86, 24, 2, 85, 115, 1, NULL),
(1015, 'SKT 21.0 2P 80', 'SKT 21.0gsm 2p 60w 115d 1s', 'SKT', 86, 21, 2, 60, 115, 1, NULL),
(1016, 'SKT 21.0 2P 75', 'SKT 21.0gsm 1p 77w 85d 1s', 'SKT', 86, 21, 1, 77, 85, 1, NULL),
(1017, 'PBT 16.5 2P 40', 'PBT 16.5gsm 2p 41w 115d 3s', 'PBT', 86, 16.5, 2, 41, 115, 3, NULL),
(1018, 'PFT 14.5 2P 42', 'PFT 14.5gsm 2p 42w 110d 2s', 'PFT', 87, 14.5, 2, 42, 110, 2, NULL),
(1019, 'PFT 15.0 3P 21', 'PFT 15.0gsm 2p 21w 80d 2s', 'PFT', 87, 15, 2, 21, 80, 2, NULL),
(1020, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 279w 170d 1s', 'SBT', 82, 17, 2, 279, 170, 1, NULL),
(1021, 'SBT 17.0 2P 279', 'SBT 17.0gsm 2p 279w 142d 1s', 'SBT', 82, 17, 2, 279, 142, 1, NULL),
(1022, 'SBT 17.0 2P 279', 'SBT 17.0gsm 2p 279w 120d 1s', 'SBT', 82, 17, 2, 279, 120, 1, NULL),
(1023, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 87w 70d 1s', 'EBT', 73, 16.5, 2, 87, 70, 1, NULL),
(1024, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 80w 68d 1s', 'EBT', 73, 16.5, 2, 80, 68, 1, NULL),
(1025, 'EBT 17.0 1P 282', 'EBT 17.0gsm 1p 279w 155d 1s', 'EBT', 73, 17, 1, 279, 155, 1, NULL),
(1026, 'SKT 40.0 1P 75', 'SKT 40.0gsm 1p 75w 120d 1s', 'SKT', 86, 40, 1, 75, 120, 1, NULL),
(1027, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 110d 1s', 'PFT', 87, 14, 2, 100, 110, 1, NULL),
(1028, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 68d 1s', 'PBT', 87, 16.5, 2, 140, 68, 1, NULL),
(1029, 'SKT 23.0 1P 288', 'SKT 23.0gsm 1p 288w 100d 1s', 'SKT', 86, 23, 1, 288, 100, 1, NULL),
(1030, 'EBT 17.0 1P 279', 'EBT 17.0gsm 1p 279w 175d 1s', 'EBT', 75, 17, 1, 279, 175, 1, NULL),
(1031, 'EBT 17.0 1P 279', 'EBT 17.0gsm 1p 279w 178d 1s', 'EBT', 75, 17, 1, 279, 178, 1, NULL),
(1032, 'EBT 17.0 1P 279', 'EBT 17.0gsm 1p 279w 160d 1s', 'EBT', 75, 17, 1, 279, 160, 1, NULL),
(1033, 'EBT 17.0 1P 279', 'EBT 17.0gsm 1p 279w 180d 1s', 'EBT', 75, 17, 1, 279, 180, 1, NULL),
(1034, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 1s', 'PTN', 87, 17, 1, 31.5, 115, 1, NULL),
(1035, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 110d 1s', 'PFT', 87, 14, 2, 80, 110, 1, NULL),
(1036, 'PFT 14.5 2P 42', 'PFT 14.5gsm 2p 42w 110d 1s', 'PFT', 87, 14.5, 2, 42, 110, 1, NULL),
(1037, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 115d 1s', 'PFT', 87, 14, 2, 40, 115, 1, NULL),
(1038, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 120d 1s', 'SKT', 86, 40, 1, 100, 120, 1, NULL),
(1039, 'SKT 21.0 2P 80', 'SKT 21.0gsm 2p 80w 115d 1s', 'SKT', 86, 21, 2, 80, 115, 1, NULL),
(1040, 'PTN 17.0 3P 22', 'PTN 15.0gsm 3p 22w 120d 6s', 'PTN', 87, 15, 3, 22, 120, 6, NULL),
(1041, 'PTN 17.0 3P 38', 'PTN 15.0gsm 3p 38w 120d 3s', 'PTN', 87, 15, 3, 38, 120, 3, NULL),
(1042, 'PFT 15.0 2P 80', 'PFT 15.0gsm 2p 80w 115d 1s', 'PFT', 86, 15, 2, 80, 115, 1, NULL),
(1043, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 115d 2s', 'PTN', 86, 19, 1, 31.5, 115, 2, NULL),
(1044, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 102d 1s', 'SKT', 86, 40, 1, 100, 102, 1, NULL),
(1045, 'SKT 40.0 1P 75', 'SKT 40.0gsm 1p 75w 102d 1s', 'SKT', 86, 40, 1, 75, 102, 1, NULL),
(1046, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 90d 4s', 'STN', 86, 18, 1, 31.5, 90, 4, NULL),
(1047, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 115d 4s', 'PTN', 87, 21, 1, 31.5, 115, 4, NULL),
(1048, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 110d 5s', 'PTN', 87, 21, 1, 31.5, 110, 5, NULL),
(1049, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 110d 4s', 'PTN', 87, 21, 1, 31.5, 110, 4, NULL),
(1050, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 1140d 1s', 'EBT', 75, 17, 2, 279, 1140, 1, NULL),
(1051, 'PBT+ 15.0 2P 288', 'PBT+ 15.0gsm 2p 288w 140d 1s', 'PBT+', 88, 15, 2, 288, 140, 1, NULL),
(1052, 'PBTS 16.5 1P 288', 'PBTS 17.0gsm 2p 288w 240d 1s', 'PBTS', 75, 17, 2, 288, 240, 1, NULL),
(1053, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 117d 5s', 'STN', 86, 18, 1, 31.5, 117, 5, NULL),
(1054, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 117d 4s', 'STN', 86, 18, 1, 31.5, 117, 4, NULL),
(1055, 'PBT 16.5 2P 288', 'PBT 16.0gsm 2p 288w 180d 1s', 'PBT', 84, 16, 2, 288, 180, 1, NULL),
(1056, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 115d 1s', 'PTN', 87, 21, 1, 31.5, 115, 1, NULL),
(1057, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 120d 4s', 'PTN', 87, 21, 1, 31.5, 120, 4, NULL),
(1058, 'PBT 17.0 2P 142', 'PBT 17.0gsm 2p 85w 115d 1s', 'PBT', 87, 17, 2, 85, 115, 1, NULL),
(1059, 'PFT 15.0 3P 20', 'PFT 15.0gsm 3p 38w 110d 2s', 'PFT', 87, 15, 3, 38, 110, 2, NULL),
(1060, 'PKT 22.0 2P 135', 'PKT 22.0gsm 2p 130w 107d 1s', 'PKT', 87, 22, 2, 130, 107, 1, NULL),
(1061, 'PKT 22.0 2P 135', 'PKT 24.0gsm 2p 135w 89d 1s', 'PKT', 87, 24, 2, 135, 89, 1, NULL),
(1062, 'SKT 40.0 1P 288', 'SKT 42.0gsm 1p 80w 110d 1s', 'SKT', 86, 42, 1, 80, 110, 1, NULL),
(1063, NULL, 'PTN 17.0gsm 1p 32.5w 115d 4s', 'PTN', 87, 17, 1, 32.5, 115, 4, NULL),
(1064, NULL, 'PFT 14.0gsm 3p 80w 115d 2s', 'PFT', 87, 14, 3, 80, 115, 2, NULL),
(1065, NULL, 'PTN 17.0gsm 1p 30w 115d 4s', 'PTN', 87, 17, 1, 30, 115, 4, NULL),
(1066, NULL, 'PTN 17.0gsm 1p 30w 115d 5s', 'PTN', 87, 17, 1, 30, 115, 5, NULL),
(1067, NULL, 'SFT 15.0gsm 2p 19w 115d 7s', 'SFT', 84, 15, 2, 19, 115, 7, NULL),
(1069, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 220d 1s', 'EBT', 73, 16.5, 1, 288, 220, 1, NULL),
(1070, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 140d 1s', 'EBT', 73, 16.5, 2, 288, 140, 1, NULL),
(1071, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 230d 1s', 'EBT', 73, 16.5, 1, 288, 230, 1, NULL),
(1072, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 236d 1s', 'EBT', 73, 16.5, 1, 288, 236, 1, NULL),
(1073, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 227d 1s', 'EBT', 73, 16.5, 1, 288, 227, 1, NULL),
(1074, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 86d 1s', 'EBT', 73, 16.5, 2, 140, 86, 1, NULL),
(1075, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 234d 1s', 'EBT', 73, 16.5, 1, 288, 234, 1, NULL),
(1076, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 120d 1s', 'EBT', 73, 16.5, 1, 288, 120, 1, NULL),
(1077, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 240w 120d 1s', 'EBT', 73, 16.5, 2, 240, 120, 1, NULL),
(1078, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 235d 1s', 'EBT', 73, 16.5, 1, 288, 235, 1, NULL),
(1079, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 279w 150d 1s', 'EBT', 73, 16.5, 2, 279, 150, 1, NULL),
(1080, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 279w 140d 1s', 'EBT', 73, 16.5, 2, 279, 140, 1, NULL),
(1081, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 233d 1s', 'EBT', 73, 16.5, 1, 288, 233, 1, NULL),
(1082, 'EBT 16.5 2P 137', 'EBT 16.5gsm 2p 137w 100d 1s', 'EBT', 73, 16.5, 2, 137, 100, 1, NULL),
(1083, 'EBT 16.5 2P 257', 'EBT 16.5gsm 2p 279w 115d 1s', 'EBT', 73, 16.5, 2, 279, 115, 1, NULL),
(1084, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 150d 1s', 'EBT', 73, 16.5, 2, 288, 150, 1, NULL),
(1085, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 122d 1s', 'EBT', 73, 16.5, 2, 288, 122, 1, NULL),
(1086, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 160d 1s', 'EBT', 73, 16.5, 1, 288, 160, 1, NULL),
(1087, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 145d 1s', 'SBT', 86, 16.5, 2, 140, 145, 1, NULL),
(1088, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 5s', 'STN', 86, 17, 1, 30, 115, 5, NULL),
(1089, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 4s', 'STN', 86, 17, 1, 30, 115, 4, NULL),
(1090, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 107d 4s', 'STN', 86, 17, 1, 30, 107, 4, NULL),
(1091, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 107d 5s', 'STN', 86, 17, 1, 30, 107, 5, NULL),
(1092, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 95d 4s', 'STN', 86, 17, 1, 30, 95, 4, NULL),
(1093, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 110d 4s', 'STN', 86, 17, 1, 30, 110, 4, NULL),
(1094, 'EBT 17.0 2P 140', 'EBT 17.0gsm 2p 140w 100d 1s', 'EBT', 73, 17, 2, 140, 100, 1, NULL),
(1095, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 180d 1s', 'PBTS', 87, 16.5, 1, 288, 180, 1, NULL),
(1096, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 25w 115d 5s', 'PTN', 87, 19, 1, 25, 115, 5, NULL),
(1097, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 200d 1s', 'PBTS', 87, 16.5, 1, 288, 200, 1, NULL),
(1098, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 210d 1s', 'PBTS', 87, 16.5, 1, 288, 210, 1, NULL),
(1099, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 90d 4s', 'STN', 87, 19, 1, 30, 90, 4, NULL),
(1100, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 120d 1s', 'EBT', 73, 16.5, 2, 275, 120, 1, NULL),
(1101, 'EBT 17.0 2P 140', 'EBT 17.0gsm 2p 140w 115d 1s', 'EBT', 73, 17, 2, 140, 115, 1, NULL),
(1102, 'EBT 16.5 2P 140', 'EBT 16.5gsm 0p 140w 100d 1s', 'EBT', 73, 16.5, 0, 140, 100, 1, NULL),
(1103, 'EBT 16.5 2P 140', 'EBT 0.0gsm 2p 140w 100d 1s', 'EBT', 73, 0, 2, 140, 100, 1, NULL),
(1104, 'PTN 19.0 1P 32.5', 'PTN 17.0gsm 1p 32.5w 115d 5s', 'PTN', 87, 17, 1, 32.5, 115, 5, NULL),
(1105, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 100d 5s', 'PTN', 87, 17, 1, 31.5, 100, 5, NULL),
(1106, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 100d 4s', 'PTN', 87, 17, 1, 31.5, 100, 4, NULL),
(1107, 'PTN 17.0 1P 33', 'PTN 17.0gsm 0p 33w 115d 4s', 'PTN', 87, 17, 0, 33, 115, 4, NULL),
(1108, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 93d 1s', 'EBT', 73, 16.5, 2, 140, 93, 1, NULL),
(1109, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 96d 1s', 'EBT', 73, 16.5, 2, 140, 96, 1, NULL),
(1110, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 95d 1s', 'EBT', 73, 16.5, 2, 164, 95, 1, NULL),
(1111, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 94d 1s', 'EBT', 73, 16.5, 2, 164, 94, 1, NULL),
(1112, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 94d 1s', 'EBT', 73, 16.5, 2, 120, 94, 1, NULL),
(1113, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 130d 1s', 'PKT', 87, 22, 2, 288, 130, 1, NULL),
(1114, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 143d 1s', 'PKT', 87, 22, 2, 288, 143, 1, NULL),
(1115, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 125d 1s', 'PKT', 87, 22, 2, 288, 125, 1, NULL),
(1116, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 150d 1s', 'PBT', 87, 15.5, 2, 288, 150, 1, NULL),
(1117, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 110d 1s', 'EBT', 73, 16.5, 2, 275, 110, 1, NULL),
(1118, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 230d 1s', 'SBT', 86, 16.5, 1, 288, 230, 1, NULL),
(1119, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 235d 1s', 'SBT', 86, 16.5, 1, 288, 235, 1, NULL),
(1120, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 220d 1s', 'SBT', 86, 16.5, 1, 288, 220, 1, NULL),
(1121, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 233d 1s', 'SBT', 86, 16.5, 1, 288, 233, 1, NULL),
(1122, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 160d 1s', 'PBTS', 87, 16.5, 1, 288, 160, 1, NULL),
(1123, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 217d 1s', 'SBT', 86, 16.5, 1, 288, 217, 1, NULL),
(1124, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 3s', 'STN', 86, 17, 1, 30, 115, 3, NULL),
(1125, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 103d 5s', 'STN', 86, 17, 1, 30, 103, 5, NULL),
(1126, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 103d 4s', 'STN', 86, 17, 1, 30, 103, 4, NULL),
(1127, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 105d 5s', 'STN', 86, 17, 1, 30, 105, 5, NULL),
(1128, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 100d 5s', 'STN', 86, 17, 1, 30, 100, 5, NULL),
(1129, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 100d 3s', 'STN', 86, 17, 1, 30, 100, 3, NULL);
INSERT INTO `bpl_products` (`id`, `old`, `productname`, `gradetype`, `brightness`, `gsm`, `ply`, `width`, `diameter`, `slice`, `deleted_at`) VALUES
(1130, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 110d 5s', 'STN', 86, 17, 1, 30, 110, 5, NULL),
(1131, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 102d 5s', 'STN', 86, 17, 1, 30, 102, 5, NULL),
(1132, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 102d 4s', 'STN', 86, 17, 1, 30, 102, 4, NULL),
(1133, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 100d 4s', 'STN', 86, 17, 1, 30, 100, 4, NULL),
(1134, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 70d 5s', 'PTN', 87, 19, 1, 30, 70, 5, NULL),
(1135, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 70d 4s', 'PTN', 87, 19, 1, 30, 70, 4, NULL),
(1136, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 160d 1s', 'SBT', 86, 16.5, 2, 288, 160, 1, NULL),
(1137, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 106d 1s', 'SBT', 86, 16.5, 2, 140, 106, 1, NULL),
(1138, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 140w 100d 1s', 'SBT', 86, 16.5, 1, 140, 100, 1, NULL),
(1139, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 115d 1s', 'STN', 86, 17, 1, 33, 115, 1, NULL),
(1140, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 106d 1s', 'SBT', 86, 18, 2, 140, 106, 1, NULL),
(1141, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 104d 1s', 'SBT', 86, 18, 2, 140, 104, 1, NULL),
(1142, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 102d 3s', 'PTN', 87, 17, 1, 30, 102, 3, NULL),
(1143, 'PTN 17.0 1P 33', 'PTN 17.0gsm 2p 33w 115d 1s', 'PTN', 87, 17, 2, 33, 115, 1, NULL),
(1144, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 115d 1s', 'PTN', 87, 17, 1, 33, 115, 1, NULL),
(1145, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 86d 1s', 'SBT', 86, 18, 2, 140, 86, 1, NULL),
(1146, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 106d 3s', 'STN', 86, 17, 1, 30, 106, 3, NULL),
(1147, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 95d 1s', 'SBT', 86, 16.5, 2, 140, 95, 1, NULL),
(1148, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 72d 3s', 'PTN', 87, 17, 1, 33, 72, 3, NULL),
(1149, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 72d 3s', 'PTN', 87, 17, 1, 30, 72, 3, NULL),
(1150, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 72d 4s', 'PTN', 87, 19, 1, 30, 72, 4, NULL),
(1151, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 75d 4s', 'PTN', 87, 19, 1, 30, 75, 4, NULL),
(1152, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 75d 5s', 'PTN', 87, 19, 1, 30, 75, 5, NULL),
(1153, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 142w 115d 1s', 'SBT', 86, 16.5, 2, 142, 115, 1, NULL),
(1154, 'SBT 16.5 2P 140', 'SBT 18.5gsm 2p 142w 115d 1s', 'SBT', 86, 18.5, 2, 142, 115, 1, NULL),
(1155, 'EBT 17.0 2P 288', 'EBT 17.0gsm 3p 288w 140d 1s', 'EBT', 87, 17, 3, 288, 140, 1, NULL),
(1156, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 130w 81d 1s', 'EBT', 73, 16.5, 2, 130, 81, 1, NULL),
(1157, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 92d 1s', 'EBT', 73, 16.5, 2, 140, 92, 1, NULL),
(1158, 'PBT 17.0 2P 256', 'PBT 18.0gsm 2p 255w 110d 1s', 'PBT', 87, 18, 2, 255, 110, 1, NULL),
(1159, 'PBT 17.0 2P 256', 'PBT 18.0gsm 2p 30w 110d 4s', 'PBT', 87, 18, 2, 30, 110, 4, NULL),
(1160, 'PBT 17.0 2P 256', 'PBT 16.5gsm 2p 30w 110d 4s', 'PBT', 87, 16.5, 2, 30, 110, 4, NULL),
(1161, 'PBT 17.0 2P 256', 'PBT 18.0gsm 2p 25w 110d 1s', 'PBT', 87, 18, 2, 25, 110, 1, NULL),
(1162, 'PBT 17.0 3P 288', 'PBT 18.0gsm 2p 288w 110d 1s', 'PBT', 87, 18, 2, 288, 110, 1, NULL),
(1163, 'PBT 17.0 2P 256', 'PBT 18.0gsm 2p 30w 110d 3s', 'PBT', 87, 18, 2, 30, 110, 3, NULL),
(1164, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 131d 1s', 'EBT', 73, 16.5, 2, 279, 131, 1, NULL),
(1165, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 255w 115d 1s', 'SBT', 86, 18, 2, 255, 115, 1, NULL),
(1166, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 30w 115d 4s', 'SBT', 86, 18, 2, 30, 115, 4, NULL),
(1167, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 255w 110d 1s', 'SBT', 86, 18, 2, 255, 110, 1, NULL),
(1168, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 30w 110d 4s', 'SBT', 86, 18, 2, 30, 110, 4, NULL),
(1169, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 2565w 110d 1s', 'SBT', 86, 18, 2, 2565, 110, 1, NULL),
(1170, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 30w 110d 3s', 'SBT', 86, 18, 2, 30, 110, 3, NULL),
(1171, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 225d 1s', 'SBT', 86, 16.5, 1, 288, 225, 1, NULL),
(1172, 'SBT 15.5 2P 100', 'SBT 15.5gsm 2p 100w 110d 2s', 'SBT', 86, 15.5, 2, 100, 110, 2, NULL),
(1173, 'SBT 15.5 2P 80', 'SBT 15.5gsm 2p 80w 110d 2s', 'SBT', 86, 15.5, 2, 80, 110, 2, NULL),
(1174, 'SBT 15.5 2P 100', 'SBT 15.5gsm 2p 100w 112d 2s', 'SBT', 86, 15.5, 2, 100, 112, 2, NULL),
(1175, 'SBT 15.5 2P 80', 'SBT 15.5gsm 2p 80w 110d 1s', 'SBT', 86, 15.5, 2, 80, 110, 1, NULL),
(1176, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 130d 1s', 'SBT', 86, 16.5, 2, 288, 130, 1, NULL),
(1177, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 135d 1s', 'SBT', 86, 16.5, 2, 288, 135, 1, NULL),
(1178, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 123w 110d 1s', 'EBT', 73, 15.5, 3, 123, 110, 1, NULL),
(1179, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 123w 109d 1s', 'EBT', 73, 15.5, 3, 123, 109, 1, NULL),
(1180, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 256w 106d 1s', 'EBT', 73, 15.5, 3, 256, 106, 1, NULL),
(1181, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 128w 110d 1s', 'EBT', 73, 15.5, 3, 128, 110, 1, NULL),
(1182, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 216d 1s', 'EBT', 73, 16.5, 1, 288, 216, 1, NULL),
(1183, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 237d 1s', 'EBT', 73, 16.5, 1, 288, 237, 1, NULL),
(1184, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 240d 1s', 'EBT', 73, 16.5, 1, 288, 240, 1, NULL),
(1185, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 232d 1s', 'EBT', 73, 16.5, 1, 288, 232, 1, NULL),
(1186, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 125w 105d 1s', 'EBT', 73, 15.5, 3, 125, 105, 1, NULL),
(1187, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 30w 115d 1s', 'EBT', 73, 15.5, 3, 30, 115, 1, NULL),
(1188, 'EBT 16.5 2P 257', 'EBT 16.5gsm 3p 256w 110d 1s', 'EBT', 73, 16.5, 3, 256, 110, 1, NULL),
(1189, 'EBT 16.5 2P 140', 'EBT 16.5gsm 3p 256w 115d 4s', 'EBT', 73, 16.5, 3, 256, 115, 4, NULL),
(1190, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 256w 115d 4s', 'EBT', 73, 15.5, 3, 256, 115, 4, NULL),
(1191, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 288w 125d 1s', 'EBT', 73, 16.5, 2, 288, 125, 1, NULL),
(1192, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 130w 115d 5s', 'EBT', 73, 15.5, 3, 130, 115, 5, NULL),
(1193, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 142w 115d 1s', 'EBT', 73, 15.5, 3, 142, 115, 1, NULL),
(1194, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 25w 115d 4s', 'EBT', 73, 15.5, 3, 25, 115, 4, NULL),
(1195, 'EBT 16.5 1P 288', 'EBT 16.5gsm 2p 275w 137d 1s', 'EBT', 73, 16.5, 2, 275, 137, 1, NULL),
(1196, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 145d 1s', 'EBT', 73, 16.5, 2, 288, 145, 1, NULL),
(1197, 'EBT 16.5 2P 140', 'EBT 16.5gsm 3p 123w 110d 1s', 'EBT', 73, 16.5, 3, 123, 110, 1, NULL),
(1198, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 130w 103d 1s', 'EBT', 73, 15.5, 3, 130, 103, 1, NULL),
(1199, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 231d 1s', 'EBT', 73, 16.5, 1, 288, 231, 1, NULL),
(1200, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 245d 1s', 'EBT', 73, 16.5, 1, 288, 245, 1, NULL),
(1201, 'PTN 17.0 1P 30', 'PTN 18.0gsm 1p 30w 115d 3s', 'PTN', 87, 18, 1, 30, 115, 3, NULL),
(1202, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 91d 1s', 'EBT', 73, 16.5, 2, 140, 91, 1, NULL),
(1203, 'PTN 17.0 1P 30', 'PTN 16.5gsm 1p 30w 120d 3s', 'PTN', 83, 16.5, 1, 30, 120, 3, NULL),
(1204, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 86d 2s', 'STN', 86, 17, 1, 30, 86, 2, NULL),
(1205, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 80d 1s', 'SBT', 86, 16.5, 2, 140, 80, 1, NULL),
(1206, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 240w 136d 1s', 'EBT', 73, 16.5, 2, 240, 136, 1, NULL),
(1207, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 107d 1s', 'PBT', 87, 15.5, 2, 288, 107, 1, NULL),
(1208, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 107d 1s', 'EBT', 73, 16.5, 2, 288, 107, 1, NULL),
(1209, 'PBT 15.5 2P 288', 'PBT 16.5gsm 2p 288w 155d 1s', 'PBT', 87, 16.5, 2, 288, 155, 1, NULL),
(1210, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 128w 115d 1s', 'EBT', 73, 15.5, 3, 128, 115, 1, NULL),
(1211, 'PBT 15.5 2P 288', 'PBT 16.5gsm 2p 288w 145d 1s', 'PBT', 87, 16.5, 2, 288, 145, 1, NULL),
(1212, 'PBT 15.5 2P 288', 'PBT 16.5gsm 2p 288w 165d 1s', 'PBT', 87, 16.5, 2, 288, 165, 1, NULL),
(1213, 'PTN 17.0 3P 33', 'PTN 15.5gsm 3p 33w 115d 4s', 'PTN', 87, 15.5, 3, 33, 115, 4, NULL),
(1214, 'PTN 17.0 3P 33', 'PTN 15.5gsm 3p 33w 115d 3s', 'PTN', 87, 15.5, 3, 33, 115, 3, NULL),
(1215, 'PTN 17.0 3P 33', 'PTN 15.5gsm 3p 33w 120d 4s', 'PTN', 87, 15.5, 3, 33, 120, 4, NULL),
(1216, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 138d 1s', 'PBT', 87, 15.5, 2, 288, 138, 1, NULL),
(1217, 'PBT 15.5 2P 288', 'PBT 16.5gsm 2p 288w 116d 1s', 'PBT', 87, 16.5, 2, 288, 116, 1, NULL),
(1218, 'PTN 17.0 3P 22', 'PTN 15.5gsm 3p 20w 115d 6s', 'PTN', 87, 15.5, 3, 20, 115, 6, NULL),
(1219, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 226w 115d 1s', 'PBT', 87, 15.5, 2, 226, 115, 1, NULL),
(1220, 'PTN 17.0 3P 33', 'PTN 15.5gsm 2p 33.5w 115d 4s', 'PTN', 87, 15.5, 2, 33.5, 115, 4, NULL),
(1221, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 155d 1s', 'PBT', 87, 15.5, 2, 288, 155, 1, NULL),
(1222, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 160d 1s', 'PBT', 87, 15.5, 2, 288, 160, 1, NULL),
(1223, 'EBT 17.0 2P 140', 'PBT 15.5gsm 2p 140w 95d 1s', 'PBT', 87, 15.5, 2, 140, 95, 1, NULL),
(1224, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 105d 1s', 'PBT', 87, 16.5, 2, 140, 105, 1, NULL),
(1225, 'PBT 16.5 2P 140', 'PBT 15.5gsm 2p 140w 90d 1s', 'PBT', 87, 15.5, 2, 140, 90, 1, NULL),
(1226, 'PBT 15.5 2P 288', 'PBT 16.5gsm 2p 288w 160d 1s', 'PBT', 87, 16.5, 2, 288, 160, 1, NULL),
(1227, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 136d 1s', 'PBT', 87, 16.5, 2, 288, 136, 1, NULL),
(1228, 'PBT 16.5 2P 140', 'PBT 18.0gsm 2p 140w 97d 1s', 'PBT', 87, 18, 2, 140, 97, 1, NULL),
(1229, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 220w 145d 1s', 'PBT', 87, 16.5, 2, 220, 145, 1, NULL),
(1230, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 220w 150d 1s', 'PBT', 87, 16.5, 2, 220, 150, 1, NULL),
(1231, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 220w 140d 1s', 'PBT', 87, 16.5, 2, 220, 140, 1, NULL),
(1232, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 220w 130d 1s', 'PBT', 87, 16.5, 2, 220, 130, 1, NULL),
(1233, 'SKT 40.0 1P 100', 'SKT 33.0gsm 1p 90w 80d 1s', 'SKT', 86, 33, 1, 90, 80, 1, NULL),
(1234, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 95w 94d 1s', 'PBT', 87, 16.5, 2, 95, 94, 1, NULL),
(1235, 'EBT 16.5 2P 140', 'EBT 16.5gsm 3p 126w 100d 1s', 'EBT', 73, 16.5, 3, 126, 100, 1, NULL),
(1236, 'PBT 16.5 2P 140', 'PBT 18.0gsm 2p 30w 110d 1s', 'PBT', 87, 18, 2, 30, 110, 1, NULL),
(1237, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 100w 95d 1s', 'PBT', 87, 16.5, 2, 100, 95, 1, NULL),
(1238, 'EBT 16.5 2P 120', 'EBT 15.5gsm 3p 128w 105d 1s', 'EBT', 73, 15.5, 3, 128, 105, 1, NULL),
(1239, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 125w 110d 1s', 'EBT', 73, 15.5, 3, 125, 110, 1, NULL),
(1240, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 220w 120d 1s', 'PBT', 87, 16.5, 2, 220, 120, 1, NULL),
(1241, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 220w 110d 1s', 'PBT', 87, 16.5, 2, 220, 110, 1, NULL),
(1242, 'SBT 17.0 2P 256', 'SBT 16.5gsm 2p 128w 105d 1s', 'SBT', 73, 16.5, 2, 128, 105, 1, NULL),
(1243, 'EBT 16.5 2P 120', 'EBT 15.5gsm 2p 288w 120d 1s', 'EBT', 73, 15.5, 2, 288, 120, 1, NULL),
(1244, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 110d 1s', 'EBT', 73, 16.5, 2, 288, 110, 1, NULL),
(1245, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 256w 103d 1s', 'EBT', 73, 15.5, 3, 256, 103, 1, NULL),
(1246, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 255w 115d 1s', 'EBT', 73, 15.5, 3, 255, 115, 1, NULL),
(1247, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 238d 1s', 'EBT', 73, 16.5, 1, 288, 238, 1, NULL),
(1248, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 229d 1s', 'EBT', 73, 16.5, 1, 288, 229, 1, NULL),
(1249, 'EBT 16.5 2P 285', 'EBT 16.5gsm 2p 285w 147d 1s', 'EBT', 73, 16.5, 2, 285, 147, 1, NULL),
(1250, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 224d 1s', 'EBT', 73, 16.5, 1, 288, 224, 1, NULL),
(1251, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 128d 1s', 'EBT', 73, 16.5, 2, 288, 128, 1, NULL),
(1252, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 226d 1s', 'EBT', 73, 16.5, 1, 288, 226, 1, NULL),
(1253, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 138d 1s', 'EBT', 73, 16.5, 2, 288, 138, 1, NULL),
(1254, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 117d 1s', 'EBT', 73, 16.5, 2, 288, 117, 1, NULL),
(1255, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 144d 1s', 'EBT', 73, 16.5, 2, 288, 144, 1, NULL),
(1256, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 130d 1s', 'EBT', 73, 16.5, 2, 288, 130, 1, NULL),
(1257, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 279w 145d 1s', 'EBT', 73, 16.5, 2, 279, 145, 1, NULL),
(1258, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 279w 130d 1s', 'EBT', 73, 16.5, 2, 279, 130, 1, NULL),
(1259, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 125d 1s', 'EBT', 73, 16.5, 2, 279, 125, 1, NULL),
(1260, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 25w 115d 3s', 'EBT', 73, 15.5, 3, 25, 115, 3, NULL),
(1261, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 146d 1s', 'EBT', 73, 16.5, 2, 288, 146, 1, NULL),
(1262, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 228d 1s', 'EBT', 73, 16.5, 1, 288, 228, 1, NULL),
(1263, 'PBT 15.5 2P 288', 'PBT 16.5gsm 2p 288w 170d 1s', 'PBT', 87, 16.5, 2, 288, 170, 1, NULL),
(1264, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 135d 1s', 'EBT', 73, 16.5, 2, 279, 135, 1, NULL),
(1265, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 115d 1s', 'EBT', 73, 16.5, 2, 288, 115, 1, NULL),
(1266, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 90w 93d 1s', 'EBT', 73, 16.5, 2, 90, 93, 1, NULL),
(1267, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 83d 1s', 'EBT', 73, 16.5, 2, 140, 83, 1, NULL),
(1268, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 80w 85d 1s', 'EBT', 73, 16.5, 2, 80, 85, 1, NULL),
(1269, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 95d 1s', 'EBT', 73, 16.5, 2, 120, 95, 1, NULL),
(1270, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 210d 1s', 'EBT', 73, 16.5, 1, 288, 210, 1, NULL),
(1271, 'SBT 16.5 2P 140', 'SBT 18.5gsm 2p 140w 115d 1s', 'SBT', 86, 18.5, 2, 140, 115, 1, NULL),
(1272, 'SBT 16.5 2P 140', 'SBT 185.0gsm 2p 140w 100d 1s', 'SBT', 86, 185, 2, 140, 100, 1, NULL),
(1273, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 93d 1s', 'SBT', 86, 18, 2, 140, 93, 1, NULL),
(1274, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 213d 1s', 'EBT', 73, 16.5, 1, 288, 213, 1, NULL),
(1275, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 225d 1s', 'EBT', 73, 16.5, 1, 288, 225, 1, NULL),
(1276, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 108d 1s', 'SBT', 86, 18, 2, 140, 108, 1, NULL),
(1277, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 89d 1s', 'SBT', 86, 18, 2, 140, 89, 1, NULL),
(1278, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 239d 1s', 'EBT', 73, 16.5, 1, 288, 239, 1, NULL),
(1279, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 243d 1s', 'EBT', 73, 16.5, 1, 288, 243, 1, NULL),
(1280, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 227d 1s', 'SBT', 86, 16.5, 1, 288, 227, 1, NULL),
(1281, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 104d 1s', 'PBT', 87, 15.5, 2, 288, 104, 1, NULL),
(1282, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 102d 1s', 'PBT', 87, 15.5, 2, 288, 102, 1, NULL),
(1283, 'PBTb 15.5 1P 288', 'PBT 15.5gsm 1p 288w 123d 1s', 'PBT', 87, 15.5, 1, 288, 123, 1, NULL),
(1284, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 105d 5s', 'PTN', 87, 17, 1, 31.5, 105, 5, NULL),
(1285, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 105d 4s', 'PTN', 87, 17, 1, 31.5, 105, 4, NULL),
(1286, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 98d 5s', 'PTN', 87, 17, 1, 31.5, 98, 5, NULL),
(1287, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 98d 4s', 'PTN', 87, 17, 1, 31.5, 98, 4, NULL),
(1288, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 125d 1s', 'EBT', 73, 16.5, 2, 275, 125, 1, NULL),
(1289, 'PBTP 15.5 1P 288', 'PBTP 15.5gsm 1p 288w 228d 1s', 'PBTP', 87, 15.5, 1, 288, 228, 1, NULL),
(1290, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 76d 3s', 'PTN', 87, 17, 1, 33, 76, 3, NULL),
(1291, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 76d 3s', 'PTN', 87, 17, 1, 30, 76, 3, NULL),
(1292, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 105d 3s', 'PTN', 87, 17, 1, 30, 105, 3, NULL),
(1293, 'SKT 40.0 1P 288', 'SKT 42.0gsm 1p 288w 120d 1s', 'SKT', 86, 42, 1, 288, 120, 1, NULL),
(1294, 'SKT 40.0 1P 75', 'SKT 42.0gsm 1p 75w 120d 2s', 'SKT', 86, 42, 1, 75, 120, 2, NULL),
(1295, 'SKT 40.0 1P 100', 'SKT 42.0gsm 1p 100w 80d 1s', 'SKT', 86, 42, 1, 100, 80, 1, NULL),
(1296, 'SKT 40.0 1P 288', 'SKT 42.0gsm 1p 188w 120d 1s', 'SKT', 86, 42, 1, 188, 120, 1, NULL),
(1297, 'SKT 40.0 1P 100', 'SKT 42.0gsm 1p 100w 120d 1s', 'SKT', 86, 42, 1, 100, 120, 1, NULL),
(1298, 'SKT 40.0 1P 288', 'SKT 42.0gsm 1p 188w 100d 1s', 'SKT', 86, 42, 1, 188, 100, 1, NULL),
(1299, 'SKT 40.0 1P 100', 'SKT 42.0gsm 1p 100w 100d 2s', 'SKT', 86, 42, 1, 100, 100, 2, NULL),
(1300, 'SKT 21.0 2P 100', 'SKT 24.0gsm 2p 142w 115d 1s', 'SKT', 86, 24, 2, 142, 115, 1, NULL),
(1301, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 90d 1s', 'SBT', 86, 18, 2, 140, 90, 1, NULL),
(1302, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 103d 2s', 'SKT', 86, 21, 2, 100, 103, 2, NULL),
(1303, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 108d 2s', 'SKT', 86, 21, 2, 100, 108, 2, NULL),
(1304, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 95d 1s', 'SBT', 86, 18, 2, 140, 95, 1, NULL),
(1305, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 106d 5s', 'STN', 86, 17, 1, 30, 106, 5, NULL),
(1306, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 106d 4s', 'STN', 86, 17, 1, 30, 106, 4, NULL),
(1307, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 97d 1s', 'SBT', 86, 18, 2, 140, 97, 1, NULL),
(1308, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 111d 5s', 'STN', 86, 17, 1, 30, 111, 5, NULL),
(1309, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 111d 4s', 'STN', 86, 17, 1, 30, 111, 4, NULL),
(1310, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 112d 5s', 'STN', 86, 17, 1, 30, 112, 5, NULL),
(1311, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 112d 4s', 'STN', 86, 17, 1, 30, 112, 4, NULL),
(1312, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 111d 3s', 'STN', 86, 17, 1, 30, 111, 3, NULL),
(1313, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 104d 5s', 'PTN', 87, 17, 1, 31.5, 104, 5, NULL),
(1314, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 104d 4s', 'PTN', 87, 17, 1, 31.5, 104, 4, NULL),
(1315, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 2s', 'PTN', 87, 17, 1, 31.5, 115, 2, NULL),
(1316, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 135w 97d 1s', 'SBT', 86, 18, 2, 135, 97, 1, NULL),
(1317, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 164w 95d 1s', 'SBT', 86, 16.5, 2, 164, 95, 1, NULL),
(1318, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 164w 92d 1s', 'SBT', 86, 16.5, 2, 164, 92, 1, NULL),
(1319, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 85d 1s', 'SBT', 86, 16.5, 2, 120, 85, 1, NULL),
(1320, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 164w 85d 1s', 'SBT', 86, 16.5, 2, 164, 85, 1, NULL),
(1321, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 82w 110d 2s', 'PFT', 87, 15.5, 2, 82, 110, 2, NULL),
(1322, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 41w 110d 2s', 'PFT', 87, 15.5, 2, 41, 110, 2, NULL),
(1323, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 82w 110d 1s', 'PFT', 87, 15.5, 2, 82, 110, 1, NULL),
(1324, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 40w 110d 3s', 'PFT', 87, 15.5, 2, 40, 110, 3, NULL),
(1325, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 115d 1s', 'EBT', 73, 16.5, 2, 275, 115, 1, NULL),
(1326, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 41w 104d 2s', 'PFT', 87, 15.5, 2, 41, 104, 2, NULL),
(1327, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 40w 110d 2s', 'PFT', 87, 15.5, 2, 40, 110, 2, NULL),
(1328, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 100d 2s', 'STN', 86, 17, 1, 30, 100, 2, NULL),
(1329, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 82w 103d 2s', 'PFT', 87, 15.5, 2, 82, 103, 2, NULL),
(1330, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 41w 103d 2s', 'PFT', 87, 15.5, 2, 41, 103, 2, NULL),
(1331, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 82w 105d 2s', 'PFT', 87, 15.5, 2, 82, 105, 2, NULL),
(1332, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 41w 105d 2s', 'PFT', 87, 15.5, 2, 41, 105, 2, NULL),
(1333, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 40w 105d 3s', 'PFT', 87, 15.5, 2, 40, 105, 3, NULL),
(1334, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 82w 102d 2s', 'PFT', 87, 15.5, 2, 82, 102, 2, NULL),
(1335, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 41w 102d 2s', 'PFT', 87, 15.5, 2, 41, 102, 2, NULL),
(1336, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 82w 100d 2s', 'PFT', 87, 15.5, 2, 82, 100, 2, NULL),
(1337, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 41w 100d 2s', 'PFT', 87, 15.5, 2, 41, 100, 2, NULL),
(1338, 'PFT 15.5 2P 90', 'PFT 15.5gsm 2p 40w 100d 3s', 'PFT', 87, 15.5, 2, 40, 100, 3, NULL),
(1339, 'PFT 14.0 2P 42', 'PFT 14.0gsm 2p 40w 100d 4s', 'PFT', 87, 14, 2, 40, 100, 4, NULL),
(1340, 'PFT 14.0 2P 42', 'PFT 14.0gsm 2p 40w 100d 3s', 'PFT', 87, 14, 2, 40, 100, 3, NULL),
(1341, 'PFT 14.5 2P 100', 'PFT 14.5gsm 2p 100w 115d 4s', 'PFT', 87, 14.5, 2, 100, 115, 4, NULL),
(1342, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 100w 115d 4s', 'PFT', 87, 14, 2, 100, 115, 4, NULL),
(1343, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 80w 105d 2s', 'PFT', 87, 14, 2, 80, 105, 2, NULL),
(1344, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 108d 1s', 'SFT', 86, 15.5, 2, 90, 108, 1, NULL),
(1345, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 218d 2s', 'SFT', 86, 15.5, 2, 90, 218, 2, NULL),
(1346, 'SBT 17.5 2P 95', 'SBT 15.5gsm 2p 95w 75d 1s', 'SBT', 86, 15.5, 2, 95, 75, 1, NULL),
(1347, 'SFT 14.5 2P 100', 'SFT 14.0gsm 2p 100w 115d 2s', 'SFT', 86, 14, 2, 100, 115, 2, NULL),
(1348, 'SFT 14.5 2P 80', 'SFT 14.0gsm 2p 80w 115d 2s', 'SFT', 86, 14, 2, 80, 115, 2, NULL),
(1349, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 196d 1s', 'EBT', 73, 16.5, 2, 275, 196, 1, NULL),
(1350, 'SFT 14.5 2P 100', 'SFT 14.0gsm 2p 100w 120d 2s', 'SFT', 86, 14, 2, 100, 120, 2, NULL),
(1351, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 113d 1s', 'EBT', 73, 16.5, 2, 275, 113, 1, NULL),
(1352, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 94d 1s', 'EBT', 73, 16.5, 2, 140, 94, 1, NULL),
(1353, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 115d 3s', 'PTN', 87, 17, 1, 30, 115, 3, NULL),
(1354, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 1p 288w 225d 1s', 'PBTS', 87, 16.5, 1, 288, 225, 1, NULL),
(1355, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 100d 4s', 'PTN', 87, 17, 1, 30, 100, 4, NULL),
(1356, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 223d 1s', 'PBTS', 87, 15.5, 1, 288, 223, 1, NULL),
(1357, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 115d 1s', 'PTN', 87, 17, 1, 30, 115, 1, NULL),
(1358, 'PBTs 15.5 2P 288', 'PBTS 15.5gsm 1p 288w 230d 1s', 'PBTS', 87, 15.5, 1, 288, 230, 1, NULL),
(1359, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 108d 1s', 'EBT', 73, 16.5, 2, 275, 108, 1, NULL),
(1360, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 116d 1s', 'EBT', 73, 16.5, 2, 275, 116, 1, NULL),
(1361, 'PBTs 15.5 2P 288', 'PBTS 15.5gsm 1p 288w 225d 1s', 'PBTS', 87, 15.5, 1, 288, 225, 1, NULL),
(1362, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 1p 288w 223d 1s', 'PBTS', 87, 16.5, 1, 288, 223, 1, NULL),
(1363, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 126d 1s', 'EBT', 73, 16.5, 2, 275, 126, 1, NULL),
(1364, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 123d 1s', 'EBT', 73, 16.5, 2, 275, 123, 1, NULL),
(1365, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 1p 288w 226d 1s', 'PBTS', 87, 16.5, 1, 288, 226, 1, NULL),
(1366, 'PBTs 15.5 2P 288', 'PBTS 15.5gsm 1p 288w 226d 1s', 'PBTS', 87, 15.5, 1, 288, 226, 1, NULL),
(1367, 'SKT 40.0 1P 100', 'SKT 45.0gsm 1p 100w 115d 2s', 'SKT', 86, 45, 1, 100, 115, 2, NULL),
(1368, 'SKT 40.0 1P 100', 'SKT 45.0gsm 1p 75w 115d 2s', 'SKT', 86, 45, 1, 75, 115, 2, NULL),
(1369, 'SKT 40.0 1P 100', 'SKT 45.0gsm 1p 100w 100d 2s', 'SKT', 86, 45, 1, 100, 100, 2, NULL),
(1370, 'SKT 40.0 1P 100', 'SKT 45.0gsm 1p 75w 100d 1s', 'SKT', 86, 45, 1, 75, 100, 1, NULL),
(1371, 'SKT 40.0 1P 100', 'SKT 45.0gsm 1p 100w 86d 2s', 'SKT', 86, 45, 1, 100, 86, 2, NULL),
(1372, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 63d 5s', 'PTN', 87, 17, 1, 31.5, 63, 5, NULL),
(1373, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 63d 4s', 'PTN', 87, 17, 1, 31.5, 63, 4, NULL),
(1374, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 237d 1s', 'PBTS', 87, 16.5, 1, 288, 237, 1, NULL),
(1375, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 279w 110d 1s', 'EBT', 73, 16.5, 2, 279, 110, 1, NULL),
(1376, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 103d 5s', 'PTN', 87, 17, 1, 31.5, 103, 5, NULL),
(1377, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 103d 4s', 'PTN', 87, 17, 1, 31.5, 103, 4, NULL),
(1378, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 138d 1s', 'EBT', 73, 16.5, 2, 279, 138, 1, NULL),
(1379, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 137d 1s', 'PKT', 87, 22, 2, 288, 137, 1, NULL),
(1380, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 139d 1s', 'EBT', 73, 16.5, 2, 279, 139, 1, NULL),
(1381, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 142d 1s', 'EBT', 73, 16.5, 2, 279, 142, 1, NULL),
(1382, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 124d 1s', 'EBT', 73, 16.5, 2, 275, 124, 1, NULL),
(1383, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 110d 5s', 'PTN', 87, 17, 1, 31.5, 110, 5, NULL),
(1384, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 110d 4s', 'PTN', 87, 17, 1, 31.5, 110, 4, NULL),
(1385, 'SBT 17.0 2P 256', 'SBT 17.5gsm 2p 256w 110d 1s', 'SBT', 86, 17.5, 2, 256, 110, 1, NULL),
(1386, 'SBT 18.0 2P 256', 'SBT 17.5gsm 2p 30w 110d 4s', 'SBT', 86, 17.5, 2, 30, 110, 4, NULL),
(1387, 'SBT 18.0 2P 256', 'SBT 17.5gsm 2p 256w 115d 1s', 'SBT', 86, 17.5, 2, 256, 115, 1, NULL),
(1388, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 143d 1s', 'EBT', 73, 16.5, 2, 279, 143, 1, NULL),
(1389, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 142d 1s', 'SBT', 86, 16.5, 2, 288, 142, 1, NULL),
(1390, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 109d 1s', 'EBT', 73, 16.5, 2, 275, 109, 1, NULL),
(1391, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 102d 5s', 'PTN', 87, 17, 1, 31.5, 102, 5, NULL),
(1392, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 102d 4s', 'PTN', 87, 17, 1, 31.5, 102, 4, NULL),
(1393, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 2p 288w 226d 1s', 'PBTS', 87, 16.5, 2, 288, 226, 1, NULL),
(1394, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 1p 288w 224d 1s', 'PBTS', 87, 16.5, 1, 288, 224, 1, NULL),
(1395, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 1p 288w 228d 1s', 'PBTS', 87, 16.5, 1, 288, 228, 1, NULL),
(1396, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 227d 1s', 'PBTS', 87, 16.5, 1, 288, 227, 1, NULL),
(1397, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 100d 3s', 'PTN', 87, 17, 1, 33, 100, 3, NULL),
(1398, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 229d 1s', 'PBTS', 87, 16.5, 1, 288, 229, 1, NULL),
(1399, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 87d 3s', 'PTN', 87, 17, 1, 30, 87, 3, NULL),
(1400, 'EBT 16.5 2P 288', 'EBT 15.5gsm 2p 279w 117d 1s', 'EBT', 87, 15.5, 2, 279, 117, 1, NULL),
(1401, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 87d 3s', 'PTN', 87, 17, 1, 33, 87, 3, NULL),
(1402, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 144d 1s', 'PBT', 87, 16.5, 2, 288, 144, 1, NULL),
(1403, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 105d 1s', 'PBT', 87, 16.5, 2, 288, 105, 1, NULL),
(1404, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 135d 1s', 'PBT', 87, 16.5, 2, 288, 135, 1, NULL),
(1405, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 155d 1s', 'SBT', 86, 16.5, 2, 288, 155, 1, NULL),
(1406, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 223d 1s', 'EBT', 73, 16.5, 1, 288, 223, 1, NULL),
(1407, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 279w 120d 1s', 'EBT', 73, 16.5, 2, 279, 120, 1, NULL),
(1408, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 256w 107d 1s', 'EBT', 73, 15.5, 3, 256, 107, 1, NULL),
(1409, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 282w 167d 1s', 'SBT', 86, 16.5, 2, 282, 167, 1, NULL),
(1410, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 282w 170d 1s', 'SBT', 86, 16.5, 2, 282, 170, 1, NULL),
(1411, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 282w 160d 1s', 'SBT', 86, 16.5, 2, 282, 160, 1, NULL),
(1412, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 130w 107d 1s', 'EBT', 73, 15.5, 3, 130, 107, 1, NULL),
(1413, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 130w 113d 1s', 'EBT', 73, 15.5, 3, 130, 113, 1, NULL),
(1414, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 282w 170d 1s', 'EBT', 73, 16.5, 2, 282, 170, 1, NULL),
(1415, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 282w 175d 1s', 'SBT', 86, 16.5, 2, 282, 175, 1, NULL),
(1416, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 282w 165d 1s', 'SBT', 86, 16.5, 2, 282, 165, 1, NULL),
(1417, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 90d 5s', 'STN', 86, 17, 1, 30, 90, 5, NULL),
(1418, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 90d 4s', 'STN', 86, 17, 1, 30, 90, 4, NULL),
(1419, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 130w 100d 1s', 'EBT', 73, 15.5, 3, 130, 100, 1, NULL),
(1420, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 93d 1s', 'SBT', 86, 16.5, 2, 140, 93, 1, NULL),
(1421, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 108d 1s', 'SBT', 86, 16.5, 2, 140, 108, 1, NULL),
(1422, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 157d 1s', 'EBT', 73, 16.5, 2, 279, 157, 1, NULL),
(1423, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 155d 1s', 'EBT', 73, 16.5, 2, 279, 155, 1, NULL),
(1424, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 255w 104d 1s', 'SBT', 86, 18, 2, 255, 104, 1, NULL),
(1425, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 110d 1s', 'SBT', 86, 16.5, 2, 288, 110, 1, NULL),
(1426, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 106d 1s', 'SBT', 86, 16.5, 2, 288, 106, 1, NULL),
(1427, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 105d 4s', 'STN', 86, 17, 1, 30, 105, 4, NULL),
(1428, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 235d 1s', 'PBTS', 87, 16.5, 1, 288, 235, 1, NULL),
(1429, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 1p 288w 234d 1s', 'PBTS', 87, 16.5, 1, 288, 234, 1, NULL),
(1430, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 236d 1s', 'PBTS', 87, 16.5, 1, 288, 236, 1, NULL),
(1431, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 232d 1s', 'PBTS', 87, 16.5, 1, 288, 232, 1, NULL),
(1432, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 3s', 'PTN', 87, 17, 1, 31.5, 115, 3, NULL),
(1433, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 107d 3s', 'PTN', 87, 17, 1, 30, 107, 3, NULL),
(1434, 'PTN 17.0 1P 33', 'PTN 18.0gsm 1p 33w 107d 3s', 'PTN', 87, 18, 1, 33, 107, 3, NULL),
(1435, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 90d 5s', 'PTN', 87, 17, 1, 30, 90, 5, NULL),
(1436, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 90d 3s', 'PTN', 87, 17, 1, 33, 90, 3, NULL),
(1437, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 107d 5s', 'PTN', 87, 17, 1, 31.5, 107, 5, NULL),
(1438, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 107d 4s', 'PTN', 87, 17, 1, 31.5, 107, 4, NULL),
(1439, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 88d 4s', 'PTN', 87, 17, 1, 31.5, 88, 4, NULL),
(1440, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 237d 1s', 'PBTS', 87, 15.5, 1, 288, 237, 1, NULL),
(1441, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 112d 5s', 'PTN', 87, 17, 1, 31.5, 112, 5, NULL),
(1442, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 112d 3s', 'PTN', 87, 17, 1, 31.5, 112, 3, NULL),
(1443, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 112d 4s', 'PTN', 87, 17, 1, 31.5, 112, 4, NULL),
(1444, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 206d 1s', 'PBTS', 87, 16.5, 1, 288, 206, 1, NULL),
(1445, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 220d 1s', 'PBTS', 87, 16.5, 1, 288, 220, 1, NULL),
(1446, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 102d 3s', 'PTN', 87, 17, 1, 33, 102, 3, NULL),
(1447, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 105d 4s', 'PTN', 87, 17, 1, 30, 105, 4, NULL),
(1448, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 105d 3s', 'PTN', 87, 17, 1, 33, 105, 3, NULL),
(1449, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 80d 1s', 'EBT', 73, 16.5, 2, 140, 80, 1, NULL),
(1450, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 76d 1s', 'EBT', 73, 16.5, 2, 140, 76, 1, NULL),
(1451, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 135w 70d 1s', 'EBT', 73, 16.5, 2, 135, 70, 1, NULL),
(1452, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 147d 1s', 'EBT', 73, 16.5, 2, 279, 147, 1, NULL),
(1453, 'EBT 16.5 2P 140', 'EBT 17.5gsm 2p 142w 110d 1s', 'EBT', 73, 17.5, 2, 142, 110, 1, NULL),
(1454, 'EBT 16.5 2P 140', 'EBT 17.5gsm 2p 142w 90d 1s', 'EBT', 73, 17.5, 2, 142, 90, 1, NULL),
(1455, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 97w 90d 1s', 'EBT', 73, 16.5, 2, 97, 90, 1, NULL),
(1456, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 142w 110d 1s', 'EBT', 73, 16.5, 2, 142, 110, 1, NULL),
(1457, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 100w 92d 1s', 'EBT', 73, 16.5, 2, 100, 92, 1, NULL),
(1458, 'SBT 17.0 2P 254', 'SBT 16.5gsm 2p 30w 110d 4s', 'SBT', 86, 16.5, 2, 30, 110, 4, NULL),
(1459, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 100w 52d 1s', 'EBT', 73, 16.5, 2, 100, 52, 1, NULL),
(1460, 'SBT 17.0 2P 256', 'SBT 17.5gsm 2p 256w 100d 1s', 'SBT', 86, 17.5, 2, 256, 100, 1, NULL),
(1461, 'SBT 17.0 2P 256', 'SBT 17.5gsm 2p 30w 110d 5s', 'SBT', 86, 17.5, 2, 30, 110, 5, NULL),
(1462, 'SBT 17.0 2P 256', 'SBT 17.5gsm 2p 30w 110d 1s', 'SBT', 86, 17.5, 2, 30, 110, 1, NULL),
(1463, 'SBT 17.0 2P 256', 'SBT 17.5gsm 2p 30w 110d 3s', 'SBT', 86, 17.5, 2, 30, 110, 3, NULL),
(1464, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 85d 2s', 'STN', 86, 17, 1, 30, 85, 2, NULL),
(1465, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 146d 1s', 'PKT', 87, 22, 2, 288, 146, 1, NULL),
(1466, 'SBT 15.5 2P 100', 'SBT 15.5gsm 2p 140w 100d 1s', 'SBT', 86, 15.5, 2, 140, 100, 1, NULL),
(1467, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 85d 1s', 'SBT', 86, 16.5, 2, 140, 85, 1, NULL),
(1468, 'PKT 22.0 2P 288', 'PKT 22.0gsm 1p 288w 95d 1s', 'PKT', 87, 22, 1, 288, 95, 1, NULL),
(1469, 'PKT 22.0 2P 288', 'PKT 22.0gsm 1p 288w 100d 1s', 'PKT', 87, 22, 1, 288, 100, 1, NULL),
(1470, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 111d 5s', 'PTN', 87, 17, 1, 31.5, 111, 5, NULL),
(1471, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 109d 3s', 'PTN', 87, 17, 1, 33, 109, 3, NULL),
(1472, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 109d 4s', 'PTN', 87, 17, 1, 30, 109, 4, NULL),
(1473, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 70d 2s', 'PTN', 87, 17, 1, 30, 70, 2, NULL),
(1474, 'PBT 15.0 3P 254', 'PBT 18.0gsm 2p 255w 115d 1s', 'PBT', 87, 18, 2, 255, 115, 1, NULL),
(1475, 'PBT 17.0 2P 256', 'PBT 17.0gsm 2p 255w 110d 1s', 'PBT', 87, 17, 2, 255, 110, 1, NULL),
(1476, 'PBT 17.0 2P 256', 'PBT 18.0gsm 2p 256w 110d 1s', 'PBT', 87, 18, 2, 256, 110, 1, NULL),
(1477, 'PBT 17.0 2P 256', 'PBT 18.0gsm 2p 255w 110d 2s', 'PBT', 87, 18, 2, 255, 110, 2, NULL),
(1478, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 88d 1s', 'EBT', 73, 16.5, 2, 140, 88, 1, NULL),
(1479, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 128d 1s', 'EBT', 73, 16.5, 2, 279, 128, 1, NULL),
(1480, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 115d 4s', 'STN', 86, 17, 1, 33, 115, 4, NULL),
(1481, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 245d 1s', 'SBT', 86, 16.5, 1, 288, 245, 1, NULL),
(1482, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 118d 5s', 'STN', 86, 17, 1, 30, 118, 5, NULL),
(1483, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 118d 4s', 'STN', 86, 17, 1, 30, 118, 4, NULL),
(1484, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 250d 1s', 'EBT', 73, 16.5, 1, 288, 250, 1, NULL),
(1485, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 256w 110d 1s', 'EBT', 73, 15.5, 3, 256, 110, 1, NULL),
(1486, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 50w 92d 1s', 'EBT', 73, 16.5, 2, 50, 92, 1, NULL),
(1487, 'EBT 16.5 2P 257', 'EBT 16.5gsm 2p 240w 155d 1s', 'EBT', 73, 16.5, 2, 240, 155, 1, NULL),
(1488, 'SKT 40.0 1P 100', 'SKT 42.0gsm 1p 188w 124d 1s', 'SKT', 86, 42, 1, 188, 124, 1, NULL),
(1489, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 100w 94d 1s', 'EBT', 73, 16.5, 2, 100, 94, 1, NULL),
(1490, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 141w 100d 1s', 'SBT', 86, 18, 2, 141, 100, 1, NULL),
(1491, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 141w 100d 1s', 'SBT', 86, 16.5, 2, 141, 100, 1, NULL),
(1492, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 147d 1s', 'EBT', 73, 16.5, 2, 288, 147, 1, NULL),
(1493, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 100w 85d 1s', 'SBT', 86, 16.5, 2, 100, 85, 1, NULL),
(1494, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 105d 2s', 'PTN', 87, 17, 1, 30, 105, 2, NULL),
(1495, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 107d 1s', 'SBT', 86, 16.5, 2, 140, 107, 1, NULL),
(1496, 'SBT 18.0 2P 256', 'SBT 18.0gsm 2p 141w 107d 1s', 'SBT', 86, 18, 2, 141, 107, 1, NULL),
(1497, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 141w 87d 1s', 'SBT', 86, 18, 2, 141, 87, 1, NULL),
(1498, 'PFT 14 2P 126', 'PFT 14.0gsm 2p 100w 91d 1s', 'PFT', 87, 14, 2, 100, 91, 1, NULL),
(1499, 'PFT 14 2P 126', 'PFT 14.0gsm 2p 100w 107d 2s', 'PFT', 87, 14, 2, 100, 107, 2, NULL),
(1500, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 105d 4s', 'PTN', 87, 17, 1, 33, 105, 4, NULL),
(1501, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 100d 3s', 'PTN', 87, 17, 1, 30, 100, 3, NULL),
(1502, 'PTN 17.0 1P 33', 'PTN 18.0gsm 1p 33w 100d 4s', 'PTN', 87, 18, 1, 33, 100, 4, NULL),
(1503, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 80d 1s', 'SBT', 86, 18, 2, 140, 80, 1, NULL),
(1504, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 141w 95d 1s', 'SBT', 86, 16.5, 2, 141, 95, 1, NULL),
(1505, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 130w 87d 1s', 'SBT', 86, 16.5, 2, 130, 87, 1, NULL),
(1506, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 137w 84d 1s', 'SBT', 86, 16.5, 2, 137, 84, 1, NULL),
(1507, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 141w 85d 1s', 'SBT', 86, 16.5, 2, 141, 85, 1, NULL),
(1508, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 141w 92d 1s', 'SBT', 86, 18, 2, 141, 92, 1, NULL),
(1509, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 141w 105d 1s', 'SBT', 86, 18, 2, 141, 105, 1, NULL),
(1510, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 141w 90d 1s', 'SBT', 86, 18, 2, 141, 90, 1, NULL),
(1511, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 94d 1s', 'SBT', 86, 16.5, 2, 140, 94, 1, NULL),
(1512, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 140w 94d 1s', 'SBT', 86, 18, 2, 140, 94, 1, NULL),
(1513, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 108d 5s', 'PTN', 87, 17, 1, 31.5, 108, 5, NULL),
(1514, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 100d 3s', 'PTN', 87, 17, 1, 31.5, 100, 3, NULL),
(1515, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 80d 5s', 'PTN', 87, 17, 1, 31.5, 80, 5, NULL),
(1516, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 100w 95d 1s', 'SBT', 86, 16.5, 2, 100, 95, 1, NULL),
(1517, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 120w 100d 1s', 'SBT', 86, 18, 2, 120, 100, 1, NULL),
(1518, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 120w 90d 1s', 'SBT', 86, 18, 2, 120, 90, 1, NULL),
(1519, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 110w 84d 1s', 'SBT', 86, 16.5, 2, 110, 84, 1, NULL),
(1520, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 95d 1s', 'SBT', 86, 16.5, 2, 120, 95, 1, NULL),
(1521, 'SBT 17.0 2P 254', 'SBT 17.0gsm 2p 30w 115d 4s', 'SBT', 86, 17, 2, 30, 115, 4, NULL),
(1522, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 80w 80d 1s', 'SBT', 86, 16.5, 2, 80, 80, 1, NULL),
(1523, 'SBT 17.0 2P 256', 'SBT 16.0gsm 2p 255w 115d 1s', 'SBT', 86, 16, 2, 255, 115, 1, NULL),
(1524, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 245d 1s', 'PBTS', 87, 15.5, 1, 288, 245, 1, NULL),
(1525, 'SBT 16.5 2P 140', 'SBT 16.0gsm 2p 140w 100d 1s', 'SBT', 86, 16, 2, 140, 100, 1, NULL),
(1526, 'SBT 16.5 2P 140', 'SBT 16.0gsm 2p 30w 115d 4s', 'SBT', 86, 16, 2, 30, 115, 4, NULL),
(1527, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 96d 1s', 'SBT', 86, 16.5, 2, 140, 96, 1, NULL),
(1528, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 75d 1s', 'SBT', 86, 16.5, 2, 140, 75, 1, NULL),
(1529, 'EBT 17.0 2P 282', 'EBT 16.5gsm 1p 279w 150d 1s', 'EBT', 73, 16.5, 1, 279, 150, 1, NULL),
(1530, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 279w 145d 1s', 'EBT', 73, 16.5, 1, 279, 145, 1, NULL),
(1531, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 279w 130d 1s', 'EBT', 73, 16.5, 1, 279, 130, 1, NULL),
(1532, 'SFT 14.5 2P 100', 'SFT 15.0gsm 2p 100w 115d 1s', 'SFT', 86, 15, 2, 100, 115, 1, NULL),
(1533, 'SFT 14.5 2P 80', 'SFT 15.0gsm 2p 80w 115d 1s', 'SFT', 86, 15, 2, 80, 115, 1, NULL),
(1534, 'EBT 16.5 2P 275', 'EBT 16.5gsm 1p 275w 150d 1s', 'EBT', 73, 16.5, 1, 275, 150, 1, NULL),
(1535, 'PFT 14.5 2P 80', 'PFT 14.0gsm 2p 60w 115d 2s', 'PFT', 87, 14, 2, 60, 115, 2, NULL),
(1536, 'PFT 14.5 2P 80', 'PFT 14.0gsm 2p 60w 66d 1s', 'PFT', 87, 14, 2, 60, 66, 1, NULL),
(1537, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 85d 1s', 'EBT', 73, 16.5, 2, 140, 85, 1, NULL),
(1538, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 123d 1s', 'PBT', 87, 15.5, 2, 288, 123, 1, NULL),
(1539, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 100d 1s', 'EBT', 73, 16.5, 2, 275, 100, 1, NULL),
(1540, 'PBT 15.5 2P 288', 'PBT 15.5gsm 2p 288w 125d 1s', 'PBT', 87, 15.5, 2, 288, 125, 1, NULL),
(1541, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 98d 4s', 'STN', 86, 17, 1, 30, 98, 4, NULL),
(1542, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 98d 5s', 'STN', 86, 17, 1, 30, 98, 5, NULL),
(1543, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 188d 1s', 'PBTS', 87, 16.5, 1, 288, 188, 1, NULL),
(1544, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 115d 6s', 'PFT', 87, 14, 3, 20, 115, 6, NULL),
(1545, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 115d 5s', 'PFT', 87, 14, 3, 20, 115, 5, NULL),
(1546, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 115d 7s', 'PFT', 87, 14, 3, 20, 115, 7, NULL),
(1547, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 100w 100d 2s', 'PFT', 87, 14, 2, 100, 100, 2, NULL),
(1548, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 31.5w 92d 5s', 'PTN', 87, 17, 1, 31.5, 92, 5, NULL),
(1549, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 92d 4s', 'PTN', 87, 17, 1, 30, 92, 4, NULL),
(1550, 'EBT 15.5 3P 254', 'EBT 15.0gsm 3p 256w 115d 1s', 'EBT', 87, 15, 3, 256, 115, 1, NULL),
(1551, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 288w 818d 1s', 'EBT', 73, 16.5, 2, 288, 818, 1, NULL),
(1552, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 270w 106d 1s', 'EBT', 73, 16.5, 2, 270, 106, 1, NULL),
(1553, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 3w 115d 3s', 'EBT', 73, 15.5, 3, 3, 115, 3, NULL),
(1554, 'EBT 16.5 2P 164', 'EBT 17.5gsm 2p 165w 115d 1s', 'EBT', 73, 17.5, 2, 165, 115, 1, NULL),
(1555, 'EBT 16.5 2P 135', 'EBT 17.5gsm 2p 25w 115d 5s', 'EBT', 73, 17.5, 2, 25, 115, 5, NULL),
(1556, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 165w 115d 1s', 'EBT', 73, 16.5, 2, 165, 115, 1, NULL),
(1557, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 144d 1s', 'EBT', 73, 16.5, 2, 279, 144, 1, NULL),
(1558, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 95w 115d 1s', 'EBT', 73, 16.5, 2, 95, 115, 1, NULL),
(1559, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 136d 1s', 'EBT', 73, 16.5, 2, 279, 136, 1, NULL),
(1560, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 250d 1s', 'PBTS', 87, 15.5, 1, 288, 250, 1, NULL),
(1561, 'SBT 16.5 2P 140', 'SBT 18.5gsm 2p 142w 110d 1s', 'SBT', 86, 18.5, 2, 142, 110, 1, NULL),
(1562, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 115d 3s', 'PFT', 87, 14, 3, 20, 115, 3, NULL),
(1563, 'PBT 16.5 2P 140', 'PBT 18.0gsm 2p 140w 100d 1s', 'PBT', 87, 18, 2, 140, 100, 1, NULL),
(1564, 'PBT 16.5 2P 140', 'PBT 18.0gsm 2p 140w 90d 1s', 'PBT', 87, 18, 2, 140, 90, 1, NULL),
(1565, 'PBT 17.0 2P 256', 'PBT 18.0gsm 2p 255w 94d 1s', 'PBT', 87, 18, 2, 255, 94, 1, NULL),
(1566, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 115d 1s', 'PBT', 87, 16.5, 2, 140, 115, 1, NULL),
(1567, 'PBT 16.5 2P 140', 'PBT 18.0gsm 2p 140w 80d 1s', 'PBT', 87, 18, 2, 140, 80, 1, NULL),
(1568, 'PBT 16.5 2P 140', 'PBT 18.0gsm 2p 30w 100d 4s', 'PBT', 87, 18, 2, 30, 100, 4, NULL),
(1569, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 60d 1s', 'PBT', 87, 16.5, 2, 140, 60, 1, NULL),
(1570, 'EBT 16.5 2P 285', 'EBT 16.5gsm 2p 275w 150d 1s', 'EBT', 73, 16.5, 2, 275, 150, 1, NULL),
(1571, 'EBT 16.5 2P 285', 'EBT 16.5gsm 2p 279w 160d 1s', 'EBT', 73, 16.5, 2, 279, 160, 1, NULL),
(1572, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 900d 1s', 'SBT', 86, 16.5, 2, 140, 900, 1, NULL),
(1573, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 134d 1s', 'EBT', 73, 16.5, 2, 279, 134, 1, NULL),
(1574, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 198d 1s', 'SBT', 86, 16.5, 1, 288, 198, 1, NULL),
(1575, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 135w 110d 1s', 'PKT', 87, 22, 2, 135, 110, 1, NULL),
(1576, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 245d 1s', 'SBT', 86, 16.5, 2, 288, 245, 1, NULL),
(1577, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 164d 1s', 'SBT', 86, 16.5, 2, 288, 164, 1, NULL),
(1578, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 127d 1s', 'EBT', 73, 16.5, 2, 275, 127, 1, NULL),
(1579, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 115d 5s', 'STN', 86, 17, 1, 33, 115, 5, NULL),
(1580, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 226d 1s', 'SBT', 86, 16.5, 1, 288, 226, 1, NULL),
(1581, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 110d 4s', 'STN', 86, 17, 1, 33, 110, 4, NULL),
(1582, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 224d 1s', 'SBT', 86, 16.5, 1, 288, 224, 1, NULL),
(1583, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 228d 1s', 'SBT', 86, 16.5, 1, 288, 228, 1, NULL),
(1584, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 162d 1s', 'SBT', 86, 16.5, 2, 288, 162, 1, NULL),
(1585, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 158d 1s', 'SBT', 86, 16.5, 2, 288, 158, 1, NULL),
(1586, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 80d 5s', 'STN', 86, 17, 1, 30, 80, 5, NULL),
(1587, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 96d 5s', 'STN', 86, 17, 1, 30, 96, 5, NULL),
(1588, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 96d 4s', 'STN', 86, 17, 1, 30, 96, 4, NULL),
(1589, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 20w 115d 7s', 'STN', 86, 17, 1, 20, 115, 7, NULL),
(1590, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 20w 115d 4s', 'STN', 86, 17, 1, 20, 115, 4, NULL),
(1591, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 20w 115d 5s', 'STN', 86, 17, 1, 20, 115, 5, NULL),
(1592, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 80d 4s', 'STN', 86, 17, 1, 30, 80, 4, NULL),
(1593, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 115d 5s', 'PTN', 87, 17, 1, 33, 115, 5, NULL),
(1594, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 238d 1s', 'SBT', 86, 16.5, 1, 288, 238, 1, NULL),
(1595, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 240d 1s', 'SBT', 86, 16.5, 1, 288, 240, 1, NULL),
(1596, 'PTN 17.0 1P 30', 'PTN 15.5gsm 1p 30w 115d 3s', 'PTN', 87, 15.5, 1, 30, 115, 3, NULL),
(1597, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 100d 5s', 'PTN', 87, 17, 1, 33, 100, 5, NULL),
(1598, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 210d 1s', 'SBT', 86, 16.5, 1, 288, 210, 1, NULL),
(1599, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 117d 4s', 'PTN', 87, 17, 1, 31.5, 117, 4, NULL),
(1600, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 117d 5s', 'PTN', 87, 17, 1, 31.5, 117, 5, NULL),
(1601, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 170d 1s', 'SBT', 86, 16.5, 2, 288, 170, 1, NULL),
(1602, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 164w 76d 1s', 'SBT', 86, 16.5, 2, 164, 76, 1, NULL),
(1603, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 76d 1s', 'SBT', 86, 16.5, 2, 120, 76, 1, NULL),
(1604, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 245d 1s', 'PBTS', 87, 16.5, 1, 288, 245, 1, NULL),
(1605, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 20w 90d 5s', 'STN', 86, 17, 1, 20, 90, 5, NULL),
(1606, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 244d 1s', 'PBTS', 87, 16.5, 1, 288, 244, 1, NULL),
(1607, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 80d 3s', 'STN', 86, 17, 1, 30, 80, 3, NULL),
(1608, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 135w 91d 1s', 'EBT', 73, 16.5, 2, 135, 91, 1, NULL),
(1609, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 80d 2s', 'STN', 86, 17, 1, 30, 80, 2, NULL),
(1610, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 165w 100d 1s', 'SBT', 86, 16.5, 2, 165, 100, 1, NULL),
(1611, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 96d 2s', 'STN', 86, 17, 1, 33, 96, 2, NULL),
(1612, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 85d 2s', 'PTN', 87, 17, 1, 31.5, 85, 2, NULL),
(1613, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 95d 5s', 'PTN', 87, 17, 1, 31.5, 95, 5, NULL),
(1614, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 95d 4s', 'PTN', 87, 17, 1, 31.5, 95, 4, NULL),
(1615, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 150d 1s', 'PBTS', 87, 15.5, 1, 288, 150, 1, NULL),
(1616, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 233d 1s', 'PBTS', 87, 16.5, 1, 288, 233, 1, NULL),
(1617, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 235d 1s', 'PBTS', 87, 15.5, 1, 288, 235, 1, NULL),
(1618, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 31.5w 120d 4s', 'PTN', 87, 17, 1, 31.5, 120, 4, NULL),
(1619, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 130d 1s', 'EBT', 73, 16.5, 2, 275, 130, 1, NULL),
(1620, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 212d 1s', 'PBTS', 87, 16.5, 1, 288, 212, 1, NULL),
(1621, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 108d 4s', 'PTN', 87, 17, 1, 31.5, 108, 4, NULL),
(1622, 'SKT 40.0 1P 288', 'SKT 22.0gsm 1p 288w 235d 1s', 'SKT', 86, 22, 1, 288, 235, 1, NULL),
(1623, 'SKT 40.0 1P 288', 'SKT 22.0gsm 1p 288w 233d 1s', 'SKT', 86, 22, 1, 288, 233, 1, NULL),
(1624, 'SKT 40.0 1P 288', 'SKT 22.0gsm 1p 288w 230d 1s', 'SKT', 86, 22, 1, 288, 230, 1, NULL),
(1625, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 70d 4s', 'PTN', 87, 17, 1, 31.5, 70, 4, NULL),
(1626, 'SKT 40.0 1P 288', 'SKT 22.0gsm 1p 288w 236d 1s', 'SKT', 86, 22, 1, 288, 236, 1, NULL),
(1627, 'SKT 40.0 1P 288', 'SKT 22.0gsm 1p 288w 228d 1s', 'SKT', 86, 22, 1, 288, 228, 1, NULL),
(1628, 'SKT 40.0 1P 288', 'SKT 22.0gsm 1p 288w 238d 1s', 'SKT', 86, 22, 1, 288, 238, 1, NULL),
(1629, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 115d 6s', 'PTN', 87, 17, 1, 30, 115, 6, NULL),
(1630, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 115d 6s', 'PTN', 87, 19, 1, 30, 115, 6, NULL),
(1631, 'SBT 16.5 1P 288', 'SBT 17.0gsm 1p 288w 250d 1s', 'SBT', 86, 17, 1, 288, 250, 1, NULL),
(1632, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 100d 6s', 'PTN', 87, 17, 1, 30, 100, 6, NULL),
(1633, 'PTN 17.0 1P 30', 'PTN 18.0gsm 1p 30w 115d 6s', 'PTN', 87, 18, 1, 30, 115, 6, NULL),
(1634, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 90d 6s', 'PTN', 87, 17, 1, 30, 90, 6, NULL),
(1635, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 90d 2s', 'PTN', 87, 17, 1, 33, 90, 2, NULL),
(1636, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 91d 6s', 'PTN', 87, 17, 1, 30, 91, 6, NULL),
(1637, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 91d 3s', 'PTN', 87, 17, 1, 33, 91, 3, NULL),
(1638, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 93d 4s', 'PTN', 87, 17, 1, 30, 93, 4, NULL),
(1639, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 33w 93d 5s', 'PTN', 87, 17, 1, 33, 93, 5, NULL),
(1640, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 2p 288w 152d 1s', 'PBTS', 87, 16.5, 2, 288, 152, 1, NULL),
(1641, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 230d 1s', 'SBT', 86, 16.5, 2, 288, 230, 1, NULL),
(1642, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 220d 1s', 'SBT', 86, 16.5, 2, 288, 220, 1, NULL),
(1643, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 79d 1s', 'EBT', 73, 16.5, 2, 275, 79, 1, NULL),
(1644, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 267w 103d 1s', 'EBT', 73, 16.5, 2, 267, 103, 1, NULL),
(1645, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 229d 1s', 'SBT', 86, 16.5, 1, 288, 229, 1, NULL),
(1646, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 268w 93d 1s', 'EBT', 73, 16.5, 2, 268, 93, 1, NULL),
(1647, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 176d 1s', 'SBT', 86, 16.5, 2, 288, 176, 1, NULL),
(1648, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 100d 5s', 'PTN', 87, 17, 1, 30, 100, 5, NULL),
(1649, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 90d 4s', 'PTN', 87, 17, 1, 30, 90, 4, NULL),
(1650, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 180d 1s', 'SBT', 86, 16.5, 1, 288, 180, 1, NULL),
(1651, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 177d 1s', 'SBT', 86, 16.5, 2, 288, 177, 1, NULL),
(1652, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 175d 1s', 'SBT', 86, 16.5, 2, 288, 175, 1, NULL),
(1653, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 105d 2s', 'SKT', 86, 21, 2, 100, 105, 2, NULL),
(1654, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 105d 4s', 'PTN', 87, 15, 3, 33, 105, 4, NULL),
(1655, 'PTN 17.0 3P 33', 'PTN 15.0gsm 2p 33w 105d 4s', 'PTN', 87, 15, 2, 33, 105, 4, NULL),
(1656, 'PTN 17.0 3P 38', 'PTN 15.0gsm 3p 38w 88d 4s', 'PTN', 87, 15, 3, 38, 88, 4, NULL),
(1657, 'PTN 17.0 3P 38', 'PTN 15.0gsm 3p 38w 88d 3s', 'PTN', 87, 15, 3, 38, 88, 3, NULL),
(1658, 'SKT 21.0 2P 80', 'SKT 21.0gsm 2p 60w 85d 1s', 'SKT', 86, 21, 2, 60, 85, 1, NULL),
(1659, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 107d 2s', 'SKT', 86, 21, 2, 100, 107, 2, NULL),
(1660, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 75d 1s', 'SBT', 86, 16.5, 2, 120, 75, 1, NULL),
(1661, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 100d 2s', 'SKT', 86, 21, 2, 100, 100, 2, NULL),
(1662, 'SKT 21.0 2P 80', 'SKT 21.0gsm 2p 80w 115d 2s', 'SKT', 86, 21, 2, 80, 115, 2, NULL),
(1663, 'PTN 17.0 3P 33', 'PTN 17.0gsm 2p 33w 115d 4s', 'PTN', 87, 17, 2, 33, 115, 4, NULL),
(1664, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 97d 3s', 'PTN', 87, 17, 1, 30, 97, 3, NULL);
INSERT INTO `bpl_products` (`id`, `old`, `productname`, `gradetype`, `brightness`, `gsm`, `ply`, `width`, `diameter`, `slice`, `deleted_at`) VALUES
(1665, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 233d 1s', 'PBTS', 87, 15.5, 1, 288, 233, 1, NULL),
(1666, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 250w 138d 1s', 'EBT', 73, 16.5, 2, 250, 138, 1, NULL),
(1667, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 100w 86d 1s', 'SBT', 86, 16.5, 2, 100, 86, 1, NULL),
(1668, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 96d 4s', 'PTN', 87, 17, 1, 30, 96, 4, NULL),
(1669, 'PTN 17.0 1P 33', 'PTN 18.0gsm 1p 33w 96d 3s', 'PTN', 87, 18, 1, 33, 96, 3, NULL),
(1670, 'PTN 17.0 1P 33', 'PTN 18.0gsm 1p 33w 76d 3s', 'PTN', 87, 18, 1, 33, 76, 3, NULL),
(1671, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 78d 3s', 'PTN', 87, 17, 1, 30, 78, 3, NULL),
(1672, 'PBT 15.5 2P 288', 'PBT 16.5gsm 2p 288w 125d 1s', 'PBT', 87, 16.5, 2, 288, 125, 1, NULL),
(1673, 'PTN 17.0 3P 33', 'PTN 20.0gsm 2p 33w 115d 4s', 'PTN', 87, 20, 2, 33, 115, 4, NULL),
(1674, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 20w 115d 6s', 'PTN', 87, 17, 1, 20, 115, 6, NULL),
(1675, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 215d 1s', 'PBTS', 87, 16.5, 1, 288, 215, 1, NULL),
(1676, 'PTN 17.0 1P 33', 'PTN 20.0gsm 1p 20w 115d 6s', 'PTN', 87, 20, 1, 20, 115, 6, NULL),
(1677, 'PBT 16.5 2P 140', 'PBT 20.0gsm 2p 140w 100d 1s', 'PBT', 87, 20, 2, 140, 100, 1, NULL),
(1678, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 231d 1s', 'PBTS', 87, 16.5, 1, 288, 231, 1, NULL),
(1679, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 130w 76d 1s', 'SBT', 86, 16.5, 2, 130, 76, 1, NULL),
(1680, 'PTN 17.0 1P 30', 'PTN 20.0gsm 1p 25w 115d 6s', 'PTN', 87, 20, 1, 25, 115, 6, NULL),
(1681, 'PTN 17.0 1P 30', 'PTN 20.0gsm 1p 20w 115d 5s', 'PTN', 87, 20, 1, 20, 115, 5, NULL),
(1682, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 135w 95d 1s', 'SBT', 86, 16.5, 2, 135, 95, 1, NULL),
(1683, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 218d 1s', 'PBTS', 87, 16.5, 1, 288, 218, 1, NULL),
(1684, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 238d 1s', 'PBTS', 87, 16.5, 1, 288, 238, 1, NULL),
(1685, 'PTN 17.0 1P 33', 'PTN 20.0gsm 1p 33w 115d 3s', 'PTN', 87, 20, 1, 33, 115, 3, NULL),
(1686, 'PTN 17.0 1P 33', 'PTN 20.0gsm 1p 33w 80d 4s', 'PTN', 87, 20, 1, 33, 80, 4, NULL),
(1687, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 135w 75d 1s', 'EBT', 73, 16.5, 2, 135, 75, 1, NULL),
(1688, 'PFT 14.5 2P 80', 'PFT 14.5gsm 2p 80w 110d 2s', 'PFT', 87, 14.5, 2, 80, 110, 2, NULL),
(1689, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 142w 90d 1s', 'SBT', 86, 18, 2, 142, 90, 1, NULL),
(1690, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 142w 96d 1s', 'SBT', 86, 18, 2, 142, 96, 1, NULL),
(1691, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 130w 94d 1s', 'SBT', 86, 18, 2, 130, 94, 1, NULL),
(1692, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 100w 100d 1s', 'SBT', 86, 18, 2, 100, 100, 1, NULL),
(1693, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 107w 84d 1s', 'SBT', 86, 18, 2, 107, 84, 1, NULL),
(1694, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 142w 94d 1s', 'SBT', 86, 18, 2, 142, 94, 1, NULL),
(1695, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 142w 79d 1s', 'SBT', 86, 18, 2, 142, 79, 1, NULL),
(1696, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 110w 100d 1s', 'SBT', 86, 18, 2, 110, 100, 1, NULL),
(1697, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 110w 100d 1s', 'SBT', 86, 16.5, 2, 110, 100, 1, NULL),
(1698, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 223d 1s', 'SBT', 86, 16.5, 1, 288, 223, 1, NULL),
(1699, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 120w 110d 1s', 'SBT', 86, 18, 2, 120, 110, 1, NULL),
(1700, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 110w 85d 1s', 'SBT', 86, 18, 2, 110, 85, 1, NULL),
(1701, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 105w 81d 1s', 'SBT', 86, 18, 2, 105, 81, 1, NULL),
(1702, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 142w 80d 1s', 'SBT', 86, 18, 2, 142, 80, 1, NULL),
(1703, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 110w 95d 1s', 'SBT', 86, 18, 2, 110, 95, 1, NULL),
(1704, 'SKT 21.0 2P 132', 'SKT 22.0gsm 2p 140w 110d 1s', 'SKT', 86, 22, 2, 140, 110, 1, NULL),
(1705, 'SKT 21.0 2P 132', 'SKT 21.0gsm 2p 140w 100d 1s', 'SKT', 86, 21, 2, 140, 100, 1, NULL),
(1706, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 250d 1s', 'SBT', 86, 16.5, 2, 288, 250, 1, NULL),
(1707, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 123d 1s', 'SBT', 86, 16.5, 2, 288, 123, 1, NULL),
(1708, 'PTN 17.0 1P 33', 'PTN 18.0gsm 1p 33w 115d 3s', 'PTN', 87, 18, 1, 33, 115, 3, NULL),
(1709, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 80d 4s', 'PTN', 87, 17, 1, 30, 80, 4, NULL),
(1710, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 84d 3s', 'PTN', 87, 17, 1, 30, 84, 3, NULL),
(1711, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 85d 3s', 'PTN', 87, 17, 1, 30, 85, 3, NULL),
(1712, 'PTN 17.0 1P 33', 'PTN 20.0gsm 1p 20w 115d 3s', 'PTN', 87, 20, 1, 20, 115, 3, NULL),
(1713, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 123d 1s', 'EBT', 73, 16.5, 2, 288, 123, 1, NULL),
(1714, 'EBT 16.5 2P 285', 'EBT 16.5gsm 2p 285w 120d 1s', 'EBT', 73, 16.5, 2, 285, 120, 1, NULL),
(1715, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 234d 1s', 'SBT', 86, 16.5, 1, 288, 234, 1, NULL),
(1716, 'EBT 16.5 2P 285', 'EBT 16.5gsm 2p 285w 150d 1s', 'EBT', 73, 16.5, 2, 285, 150, 1, NULL),
(1717, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 90d 2s', 'PTN', 87, 19, 1, 30, 90, 2, NULL),
(1718, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 60d 3s', 'PTN', 87, 17, 1, 30, 60, 3, NULL),
(1719, 'PTN 17.0 1P 30', 'PTN 17.0gsm 1p 30w 92d 2s', 'PTN', 87, 17, 1, 30, 92, 2, NULL),
(1720, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 106d 1s', 'EBT', 73, 16.5, 2, 288, 106, 1, NULL),
(1721, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 120w 93d 1s', 'SBT', 86, 18, 2, 120, 93, 1, NULL),
(1722, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 128w 109d 1s', 'EBT', 86, 15.5, 3, 128, 109, 1, NULL),
(1723, 'PBT 16.5 2P 288', 'PBT 19.0gsm 2p 288w 120d 1s', 'PBT', 87, 19, 2, 288, 120, 1, NULL),
(1724, 'EBT 16.5 2P 140', 'EBT 15.5gsm 3p 128w 100d 1s', 'EBT', 73, 15.5, 3, 128, 100, 1, NULL),
(1725, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 83d 1s', 'SBT', 86, 16.5, 2, 140, 83, 1, NULL),
(1726, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 100w 52d 1s', 'SBT', 86, 16.5, 2, 100, 52, 1, NULL),
(1727, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 98d 2s', 'PTN', 87, 17, 1, 33, 98, 2, NULL),
(1728, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 75d 2s', 'PTN', 87, 17, 1, 33, 75, 2, NULL),
(1729, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 68d 2s', 'PTN', 87, 17, 1, 31.5, 68, 2, NULL),
(1730, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 30w 110d 1s', 'PTN', 87, 17, 1, 30, 110, 1, NULL),
(1731, 'SBT 16.5 2P 140', 'SBT 16.0gsm 2p 120w 95d 1s', 'SBT', 86, 16, 2, 120, 95, 1, NULL),
(1732, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 30w 115d 4s', 'SBT', 86, 16.5, 2, 30, 115, 4, NULL),
(1733, 'SKT 40.0 1P 288', 'SKT 40.0gsm 1p 188w 120d 1s', 'SKT', 86, 40, 1, 188, 120, 1, NULL),
(1734, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 242d 1s', 'SBT', 86, 16.5, 1, 288, 242, 1, NULL),
(1735, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 67d 1s', 'SKT', 86, 40, 1, 100, 67, 1, NULL),
(1736, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 126w 110d 1s', 'EBT', 73, 15.5, 3, 126, 110, 1, NULL),
(1737, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 221d 1s', 'SBT', 86, 16.5, 1, 288, 221, 1, NULL),
(1738, 'EBT 16.5 2P 275', 'EBT 16.5gsm 2p 275w 62d 1s', 'EBT', 73, 16.5, 2, 275, 62, 1, NULL),
(1739, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 110w 74d 1s', 'EBT', 73, 16.5, 2, 110, 74, 1, NULL),
(1740, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 74d 1s', 'EBT', 73, 16.5, 2, 120, 74, 1, NULL),
(1741, 'SBT 16.5 2P 40', 'SBT 16.5gsm 2p 40w 115d 2s', 'SBT', 86, 16.5, 2, 40, 115, 2, NULL),
(1742, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 165d 1s', 'SBT', 86, 16.5, 2, 288, 165, 1, NULL),
(1743, 'PFT 14.5 2P 80', 'PFT 14.0gsm 2p 60w 80d 2s', 'PFT', 87, 14, 2, 60, 80, 2, NULL),
(1744, 'EBT 16.5 2P 257', 'EBT 16.5gsm 2p 255w 115d 1s', 'EBT', 73, 16.5, 2, 255, 115, 1, NULL),
(1745, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 174d 1s', 'SBT', 86, 16.5, 2, 288, 174, 1, NULL),
(1746, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 173d 1s', 'SBT', 86, 16.5, 2, 288, 173, 1, NULL),
(1747, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 288w 140d 1s', 'SBT', 86, 16.5, 2, 288, 140, 1, NULL),
(1748, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 100w 90d 1s', 'SBT', 86, 16.5, 2, 100, 90, 1, NULL),
(1749, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 115d 3s', 'STN', 86, 17, 1, 33, 115, 3, NULL),
(1750, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 282w 145d 1s', 'PBT', 87, 16.5, 2, 282, 145, 1, NULL),
(1751, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 115d 1s', 'PBT', 87, 16.5, 2, 288, 115, 1, NULL),
(1752, 'PBT 16.5 2P 288', 'PBT 16.5gsm 3p 288w 115d 1s', 'PBT', 87, 16.5, 3, 288, 115, 1, NULL),
(1753, 'PBT 17.0 3P 288', 'PBT 17.0gsm 3p 288w 115d 1s', 'PBT', 87, 17, 3, 288, 115, 1, NULL),
(1754, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 40w 100d 3s', 'PBT', 87, 16.5, 2, 40, 100, 3, NULL),
(1755, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 130w 109d 1s', 'EBT', 73, 15.5, 3, 130, 109, 1, NULL),
(1756, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 143d 1s', 'EBT', 73, 16.5, 2, 288, 143, 1, NULL),
(1757, 'EBT 15.5 3P 254', 'EBT 16.5gsm 3p 30w 115d 4s', 'EBT', 73, 16.5, 3, 30, 115, 4, NULL),
(1758, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 83d 2s', 'STN', 86, 17, 1, 33, 83, 2, NULL),
(1759, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 256w 114d 1s', 'EBT', 73, 15.5, 3, 256, 114, 1, NULL),
(1760, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 155d 1s', 'EBT', 73, 16.5, 2, 288, 155, 1, NULL),
(1761, 'PBT 15.0 3P 254', 'PBT 15.0gsm 3p 256w 115d 1s', 'PBT', 87, 15, 3, 256, 115, 1, NULL),
(1762, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 256w 100d 1s', 'EBT', 73, 15.5, 3, 256, 100, 1, NULL),
(1763, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 118d 1s', 'EBT', 73, 16.5, 2, 288, 118, 1, NULL),
(1764, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 154d 1s', 'EBT', 73, 16.5, 2, 288, 154, 1, NULL),
(1765, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 288w 100d 1s', 'EBT', 73, 16.5, 2, 288, 100, 1, NULL),
(1766, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 30w 110d 3s', 'EBT', 73, 15.5, 3, 30, 110, 3, NULL),
(1767, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 30w 80d 1s', 'SBT', 86, 17, 2, 30, 80, 1, NULL),
(1768, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 222d 1s', 'EBT', 73, 16.5, 1, 288, 222, 1, NULL),
(1769, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 105d 1s', 'EBT', 73, 16.5, 2, 288, 105, 1, NULL),
(1770, 'EBT 17.0 1P 282', 'EBT 16.5gsm 1p 288w 155d 1s', 'EBT', 73, 16.5, 1, 288, 155, 1, NULL),
(1771, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 244d 1s', 'EBT', 73, 16.5, 1, 288, 244, 1, NULL),
(1772, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 248d 1s', 'EBT', 73, 16.5, 1, 288, 248, 1, NULL),
(1773, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 100d 4s', 'STN', 86, 17, 1, 33, 100, 4, NULL),
(1774, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 110d 2s', 'STN', 86, 17, 1, 33, 110, 2, NULL),
(1775, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 100d 2s', 'STN', 86, 17, 1, 33, 100, 2, NULL),
(1776, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 30w 110d 1s', 'STN', 86, 17, 1, 30, 110, 1, NULL),
(1777, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 110d 3s', 'STN', 86, 17, 1, 30, 110, 3, NULL),
(1778, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 94d 5s', 'STN', 86, 17, 1, 33, 94, 5, NULL),
(1779, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 94d 2s', 'STN', 86, 17, 1, 30, 94, 2, NULL),
(1780, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 107d 4s', 'STN', 86, 17, 1, 33, 107, 4, NULL),
(1781, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 112d 3s', 'STN', 86, 17, 1, 30, 112, 3, NULL),
(1782, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 112d 3s', 'STN', 86, 17, 1, 33, 112, 3, NULL),
(1783, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 117d 1s', 'SBT', 86, 16.5, 2, 288, 117, 1, NULL),
(1784, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 107d 1s', 'SBT', 86, 16.5, 2, 288, 107, 1, NULL),
(1785, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 236d 1s', 'SBT', 86, 16.5, 1, 288, 236, 1, NULL),
(1786, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 232d 1s', 'SBT', 86, 16.5, 1, 288, 232, 1, NULL),
(1787, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 92d 1s', 'SBT', 86, 16.5, 2, 120, 92, 1, NULL),
(1788, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 142w 100d 1s', 'SBT', 86, 16.5, 2, 142, 100, 1, NULL),
(1789, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 80d 4s', 'STN', 86, 17, 1, 33, 80, 4, NULL),
(1790, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 108d 4s', 'STN', 86, 17, 1, 33, 108, 4, NULL),
(1791, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 142w 92d 1s', 'SBT', 86, 18, 2, 142, 92, 1, NULL),
(1792, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 164w 105d 1s', 'SBT', 86, 16.5, 2, 164, 105, 1, NULL),
(1793, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 105d 1s', 'SBT', 86, 16.5, 2, 120, 105, 1, NULL),
(1794, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 220d 1s', 'PBTS', 87, 15.5, 1, 288, 220, 1, NULL),
(1795, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 290w 144d 1s', 'PKT', 87, 22, 2, 290, 144, 1, NULL),
(1796, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 148d 1s', 'PBT', 87, 16.5, 2, 288, 148, 1, NULL),
(1797, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 140d 1s', 'PKT', 87, 22, 2, 288, 140, 1, NULL),
(1798, 'PBT 16.5 2P 40', 'PBT 16.5gsm 2p 40w 115d 2s', 'PBT', 86, 16.5, 2, 40, 115, 2, NULL),
(1799, 'PBT 16.5 2P 140', 'PBT 17.0gsm 2p 25w 115d 4s', 'PBT', 87, 17, 2, 25, 115, 4, NULL),
(1800, 'PBT 17.0 2P 256', 'PBT 17.0gsm 2p 175w 115d 1s', 'PBT', 87, 17, 2, 175, 115, 1, NULL),
(1801, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 95d 1s', 'PBT', 87, 16.5, 2, 140, 95, 1, NULL),
(1802, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 25w 115d 4s', 'PBT', 87, 16.5, 2, 25, 115, 4, NULL),
(1803, 'PBTs 15.5 1P 288', 'PBT 16.5gsm 1p 288w 232d 1s', 'PBT', 87, 16.5, 1, 288, 232, 1, NULL),
(1804, 'PBT 16.5 2P 40', 'PBT 16.5gsm 2p 21w 115d 5s', 'PBT', 86, 16.5, 2, 21, 115, 5, NULL),
(1805, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 94d 1s', 'PBT', 87, 16.5, 2, 140, 94, 1, NULL),
(1806, 'PBT 16.5 2P 40', 'PBT 16.5gsm 2p 21w 115d 4s', 'PBT', 86, 16.5, 2, 21, 115, 4, NULL),
(1807, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 127d 1s', 'PBT', 87, 16.5, 2, 288, 127, 1, NULL),
(1808, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 178d 1s', 'SBT', 86, 16.5, 2, 288, 178, 1, NULL),
(1809, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 147d 1s', 'SBT', 86, 16.5, 2, 288, 147, 1, NULL),
(1810, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 144d 1s', 'SBT', 86, 16.5, 2, 288, 144, 1, NULL),
(1811, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 153d 1s', 'SBT', 86, 16.5, 2, 288, 153, 1, NULL),
(1812, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 212d 1s', 'PBTS', 87, 15.5, 1, 288, 212, 1, NULL),
(1813, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 146d 1s', 'PBT', 87, 16.5, 2, 288, 146, 1, NULL),
(1814, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 267w 90d 1s', 'PBT', 87, 16.5, 2, 267, 90, 1, NULL),
(1815, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 242d 1s', 'PBTS', 87, 16.5, 1, 288, 242, 1, NULL),
(1816, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 145d 1s', 'SBT', 86, 16.5, 2, 288, 145, 1, NULL),
(1817, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 190d 1s', 'PBTS', 87, 16.5, 1, 288, 190, 1, NULL),
(1818, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 200d 1s', 'PBTS', 87, 15.5, 1, 288, 200, 1, NULL),
(1819, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 33w 90d 3s', 'STN', 86, 17, 1, 33, 90, 3, NULL),
(1820, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 90d 3s', 'STN', 86, 17, 1, 30, 90, 3, NULL),
(1821, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 222d 1s', 'PBTS', 87, 15.5, 1, 288, 222, 1, NULL),
(1822, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 222d 1s', 'PBTS', 87, 16.5, 1, 288, 222, 1, NULL),
(1823, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 106d 4s', 'STN', 86, 17, 1, 33, 106, 4, NULL),
(1824, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 100d 5s', 'STN', 86, 17, 1, 33, 100, 5, NULL),
(1825, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 204d 1s', 'PBTS', 87, 16.5, 1, 288, 204, 1, NULL),
(1826, 'PBTs 15.5 2P 288', 'PBTS 19.0gsm 2p 288w 97d 1s', 'PBTS', 87, 19, 2, 288, 97, 1, NULL),
(1827, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 100d 6s', 'PTN', 87, 17, 1, 31.5, 100, 6, NULL),
(1828, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 110d 2s', 'PTN', 87, 17, 1, 31.5, 110, 2, NULL),
(1829, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 180d 1s', 'EBT', 73, 16.5, 1, 288, 180, 1, NULL),
(1830, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 160d 1s', 'EBT', 73, 16.5, 2, 288, 160, 1, NULL),
(1831, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 136d 1s', 'EBT', 73, 16.5, 2, 288, 136, 1, NULL),
(1832, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 100d 3s', 'STN', 86, 17, 1, 33, 100, 3, NULL),
(1833, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 115d 2s', 'STN', 86, 17, 1, 33, 115, 2, NULL),
(1834, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 230d 1s', 'EBT', 73, 16.5, 2, 288, 230, 1, NULL),
(1835, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 100d 2s', 'PTN', 87, 17, 1, 31.5, 100, 2, NULL),
(1836, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 112d 4s', 'STN', 86, 17, 1, 33, 112, 4, NULL),
(1837, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 116d 1s', 'EBT', 73, 16.5, 2, 288, 116, 1, NULL),
(1838, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 32w 115d 3s', 'PTN', 87, 17, 1, 32, 115, 3, NULL),
(1839, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 132d 1s', 'EBT', 73, 16.5, 2, 288, 132, 1, NULL),
(1840, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 97d 1s', 'EBT', 73, 16.5, 2, 140, 97, 1, NULL),
(1841, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 242d 1s', 'EBT', 73, 16.5, 1, 288, 242, 1, NULL),
(1842, 'SBT 15.5 2P 262', 'SBT 15.5gsm 2p 30w 117d 4s', 'SBT', 86, 15.5, 2, 30, 117, 4, NULL),
(1843, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 130w 80d 1s', 'SBT', 86, 16.5, 2, 130, 80, 1, NULL),
(1844, 'SBT 16.5 2P 40', 'SBT 16.5gsm 2p 30w 115d 3s', 'SBT', 86, 16.5, 2, 30, 115, 3, NULL),
(1845, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 100d 2s', 'SBT', 86, 16.5, 2, 140, 100, 2, NULL),
(1846, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 97d 4s', 'STN', 86, 17, 1, 33, 97, 4, NULL),
(1847, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 92d 4s', 'STN', 86, 17, 1, 33, 92, 4, NULL),
(1848, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 92d 4s', 'STN', 86, 17, 1, 30, 92, 4, NULL),
(1849, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 92d 3s', 'STN', 86, 17, 1, 33, 92, 3, NULL),
(1850, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 84d 1s', 'EBT', 73, 16.5, 2, 140, 84, 1, NULL),
(1851, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 111d 4s', 'STN', 86, 17, 1, 33, 111, 4, NULL),
(1852, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 78d 1s', 'EBT', 73, 16.5, 2, 140, 78, 1, NULL),
(1853, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 30w 105d 6s', 'STN', 86, 17, 1, 30, 105, 6, NULL),
(1854, 'SBT 16.5 2P 140', 'SBT 18.5gsm 2p 142w 100d 1s', 'SBT', 86, 18.5, 2, 142, 100, 1, NULL),
(1855, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 170d 1s', 'SBT', 86, 16.5, 1, 288, 170, 1, NULL),
(1856, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 157d 1s', 'SBT', 86, 16.5, 2, 288, 157, 1, NULL),
(1857, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 110d 3s', 'STN', 86, 17, 1, 33, 110, 3, NULL),
(1858, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 6s', 'STN', 86, 17, 1, 30, 115, 6, NULL),
(1859, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 168d 1s', 'SBT', 86, 16.5, 2, 288, 168, 1, NULL),
(1860, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 1700d 1s', 'SBT', 86, 16.5, 2, 288, 1700, 1, NULL),
(1861, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 138d 1s', 'SBT', 86, 16.5, 2, 288, 138, 1, NULL),
(1862, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 90d 1s', 'SBT', 86, 16.5, 2, 288, 90, 1, NULL),
(1863, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 138d 1s', 'PBT', 87, 16.5, 2, 288, 138, 1, NULL),
(1864, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 1s', 'STN', 86, 17, 1, 30, 115, 1, NULL),
(1865, 'PBTs 15.5 1P 288', 'PBTS 1.5gsm 1p 288w 240d 1s', 'PBTS', 87, 1.5, 1, 288, 240, 1, NULL),
(1866, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 157d 1s', 'PBT', 87, 16.5, 2, 288, 157, 1, NULL),
(1867, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 153d 1s', 'PBT', 87, 16.5, 2, 288, 153, 1, NULL),
(1868, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 147d 1s', 'PBT', 87, 16.5, 2, 288, 147, 1, NULL),
(1869, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 84d 1s', 'SBT', 86, 16.5, 2, 140, 84, 1, NULL),
(1870, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 230w 121d 1s', 'EBT', 73, 16.5, 2, 230, 121, 1, NULL),
(1871, 'PFT 14.5 2P 80', 'PFT 14.0gsm 2p 80w 102d 2s', 'PFT', 87, 14, 2, 80, 102, 2, NULL),
(1872, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 100w 102d 2s', 'PFT', 87, 14, 2, 100, 102, 2, NULL),
(1873, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 203w 120d 1s', 'EBT', 73, 16.5, 2, 203, 120, 1, NULL),
(1874, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 217d 1s', 'PBTS', 87, 16.5, 1, 288, 217, 1, NULL),
(1875, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 148d 1s', 'EBT', 73, 16.5, 1, 288, 148, 1, NULL),
(1876, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 149d 1s', 'EBT', 73, 16.5, 1, 288, 149, 1, NULL),
(1877, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 70d 5s', 'PTN', 87, 17, 1, 31.5, 70, 5, NULL),
(1878, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 119d 1s', 'EBT', 73, 16.5, 2, 288, 119, 1, NULL),
(1879, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 134d 1s', 'EBT', 73, 16.5, 1, 288, 134, 1, NULL),
(1880, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 145d 1s', 'EBT', 73, 16.5, 1, 288, 145, 1, NULL),
(1881, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 154d 1s', 'EBT', 73, 16.5, 1, 288, 154, 1, NULL),
(1882, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 104d 5s', 'STN', 86, 17, 1, 30, 104, 5, NULL),
(1883, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 104d 4s', 'STN', 86, 17, 1, 30, 104, 4, NULL),
(1884, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 200d 1s', 'EBT', 73, 16.5, 1, 288, 200, 1, NULL),
(1885, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 120d 4s', 'STN', 86, 17, 1, 30, 120, 4, NULL),
(1886, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 227d 1s', 'PBTS', 87, 15.5, 1, 288, 227, 1, NULL),
(1887, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 95d 5s', 'STN', 86, 17, 1, 30, 95, 5, NULL),
(1888, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 248d 1s', 'PBTS', 87, 16.5, 1, 288, 248, 1, NULL),
(1889, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 126w 109d 1s', 'EBT', 73, 15.5, 3, 126, 109, 1, NULL),
(1890, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 110d 2s', 'STN', 86, 17, 1, 30, 110, 2, NULL),
(1891, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 247d 1s', 'PBTS', 87, 16.5, 1, 288, 247, 1, NULL),
(1892, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 243d 1s', 'PBTS', 87, 16.5, 1, 288, 243, 1, NULL),
(1893, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 166d 1s', 'SBT', 86, 16.5, 2, 288, 166, 1, NULL),
(1894, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 94d 5s', 'STN', 86, 17, 1, 30, 94, 5, NULL),
(1895, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 94d 4s', 'STN', 86, 17, 1, 30, 94, 4, NULL),
(1896, 'PBTb 15.5 1P 288', 'PBT 16.5gsm 1p 288w 163d 1s', 'PBT', 87, 16.5, 1, 288, 163, 1, NULL),
(1897, 'PBTb 15.5 1P 288', 'PBT 16.5gsm 1p 288w 164d 1s', 'PBT', 87, 16.5, 1, 288, 164, 1, NULL),
(1898, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 110w 90d 1s', 'EBT', 73, 16.5, 2, 110, 90, 1, NULL),
(1899, 'PBT 15.5 2P 288', 'PBT 16.5gsm 1p 288w 148d 1s', 'PBT', 87, 16.5, 1, 288, 148, 1, NULL),
(1900, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 156d 1s', 'SBT', 86, 16.5, 2, 288, 156, 1, NULL),
(1901, 'PBTb 15.5 1P 288', 'PBT 16.5gsm 1p 288w 166d 1s', 'PBT', 87, 16.5, 1, 288, 166, 1, NULL),
(1902, 'PBTb 15.5 1P 288', 'PBT 16.5gsm 1p 288w 160d 1s', 'PBT', 87, 16.5, 1, 288, 160, 1, NULL),
(1903, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 142w 70d 1s', 'SBT', 86, 18, 2, 142, 70, 1, NULL),
(1904, 'SBT 16.5 2P 140', 'SBT 22.0gsm 2p 130w 117d 1s', 'SBT', 86, 22, 2, 130, 117, 1, NULL),
(1905, 'SBT 16.5 2P 140', 'SBT 22.0gsm 2p 130w 100d 1s', 'SBT', 86, 22, 2, 130, 100, 1, NULL),
(1906, 'SBT 16.5 2P 140', 'SBT 22.0gsm 2p 25w 115d 4s', 'SBT', 86, 22, 2, 25, 115, 4, NULL),
(1907, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 164w 100d 1s', 'SBT', 86, 18, 2, 164, 100, 1, NULL),
(1908, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 110d 3s', 'SFT', 86, 15.5, 2, 90, 110, 3, NULL),
(1909, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 75d 1s', 'SFT', 86, 15.5, 2, 90, 75, 1, NULL),
(1910, 'SFT 15.5 2P 90', 'SFT 15.0gsm 2p 19w 115d 8s', 'SFT', 86, 15, 2, 19, 115, 8, NULL),
(1911, 'SFT 14.5 2P 80', 'SFT 15.0gsm 2p 19w 115d 6s', 'SFT', 86, 15, 2, 19, 115, 6, NULL),
(1912, 'SFT 14.5 2P 80', 'SFT 15.0gsm 2p 19w 113d 7s', 'SFT', 86, 15, 2, 19, 113, 7, NULL),
(1913, 'SFT 14.5 2P 80', 'SFT 15.0gsm 2p 19w 115d 5s', 'SFT', 86, 15, 2, 19, 115, 5, NULL),
(1914, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 96d 1s', 'SBT', 86, 16.5, 2, 120, 96, 1, NULL),
(1915, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 164w 96d 1s', 'SBT', 86, 16.5, 2, 164, 96, 1, NULL),
(1916, 'STN 17.0 1P 30', 'STN 17.0gsm 2p 31.5w 115d 5s', 'STN', 86, 17, 2, 31.5, 115, 5, NULL),
(1917, 'STN 17.0 1P 30', 'STN 17.0gsm 2p 31.5w 110d 5s', 'STN', 86, 17, 2, 31.5, 110, 5, NULL),
(1918, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 31.5w 110d 4s', 'STN', 86, 17, 1, 31.5, 110, 4, NULL),
(1919, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 31.5w 112d 5s', 'STN', 86, 17, 1, 31.5, 112, 5, NULL),
(1920, 'STN 17.0 1P 30', 'STN 17.0gsm 2p 31.5w 112d 4s', 'STN', 86, 17, 2, 31.5, 112, 4, NULL),
(1921, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 31.5w 107d 5s', 'STN', 86, 17, 1, 31.5, 107, 5, NULL),
(1922, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 31.5w 104d 5s', 'STN', 86, 17, 1, 31.5, 104, 5, NULL),
(1923, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 31.5w 104d 4s', 'STN', 86, 17, 1, 31.5, 104, 4, NULL),
(1924, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 31.5w 100d 5s', 'STN', 86, 17, 1, 31.5, 100, 5, NULL),
(1925, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 31.5w 100d 4s', 'STN', 86, 17, 1, 31.5, 100, 4, NULL),
(1926, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 25w 115d 4s', 'EBT', 73, 17, 2, 25, 115, 4, NULL),
(1927, 'SBT 22.0 2P 130', 'SBT 17.0gsm 2p 130w 105d 1s', 'SBT', 73, 17, 2, 130, 105, 1, NULL),
(1928, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 130w 105d 1s', 'EBT', 73, 17, 2, 130, 105, 1, NULL),
(1929, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 25w 115d 4s', 'EBT', 73, 16.5, 2, 25, 115, 4, NULL),
(1930, 'EBT 16.5 2P 164', 'EBT 17.0gsm 2p 25w 115d 3s', 'EBT', 73, 17, 2, 25, 115, 3, NULL),
(1931, 'SBT 22.0 2P 130', 'SBT 22.0gsm 2p 25w 115d 3s', 'SBT', 86, 22, 2, 25, 115, 3, NULL),
(1932, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 88d 4s', 'STN', 86, 17, 1, 30, 88, 4, NULL),
(1933, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 164w 94d 1s', 'SBT', 86, 16.5, 2, 164, 94, 1, NULL),
(1934, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 94d 1s', 'SBT', 86, 16.5, 2, 120, 94, 1, NULL),
(1935, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 94d 3s', 'STN', 86, 17, 1, 30, 94, 3, NULL),
(1936, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 110d 3s', 'PTN', 87, 17, 1, 31.5, 110, 3, NULL),
(1937, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 279w 105d 1s', 'EBT', 73, 16.5, 2, 279, 105, 1, NULL),
(1938, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 97d 5s', 'PTN', 87, 17, 1, 31.5, 97, 5, NULL),
(1939, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 106d 5s', 'PTN', 87, 17, 1, 31.5, 106, 5, NULL),
(1940, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 106d 4s', 'PTN', 87, 17, 1, 31.5, 106, 4, NULL),
(1941, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 110d 4s', 'PTN', 87, 17, 1, 33, 110, 4, NULL),
(1942, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 108d 4s', 'PTN', 87, 17, 1, 33, 108, 4, NULL),
(1943, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 92d 4s', 'PTN', 87, 17, 1, 31.5, 92, 4, NULL),
(1944, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 92d 3s', 'PTN', 87, 17, 1, 31.5, 92, 3, NULL),
(1945, 'SBT 16.5 2P 40', 'SBT 16.5gsm 2p 30w 100d 4s', 'SBT', 86, 16.5, 2, 30, 100, 4, NULL),
(1946, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 132w 90d 1s', 'SBT', 86, 18, 2, 132, 90, 1, NULL),
(1947, 'SBT 20.0 2P 132', 'SBT 16.0gsm 2p 132w 115d 1s', 'SBT', 86, 16, 2, 132, 115, 1, NULL),
(1948, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 210d 1s', 'EBT', 73, 16.5, 2, 288, 210, 1, NULL),
(1949, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 105d 2s', 'PTN', 87, 17, 1, 33, 105, 2, NULL),
(1950, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 90d 3s', 'PTN', 87, 17, 1, 31.5, 90, 3, NULL),
(1951, 'SBT 22.0 2P 130', 'SBT 60.0gsm 2p 132w 115d 1s', 'SBT', 86, 60, 2, 132, 115, 1, NULL),
(1952, 'SBT 22.0 2P 130', 'SBT 16.0gsm 2p 25w 115d 3s', 'SBT', 86, 16, 2, 25, 115, 3, NULL),
(1953, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 109d 4s', 'STN', 86, 17, 1, 30, 109, 4, NULL),
(1954, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 109d 4s', 'STN', 86, 17, 1, 33, 109, 4, NULL),
(1955, 'PKT 22.0 2P 288', 'PKT 22.0gsm 1p 288w 150d 1s', 'PKT', 87, 22, 1, 288, 150, 1, NULL),
(1956, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 30w 90d 4s', 'SBT', 86, 16.5, 2, 30, 90, 4, NULL),
(1957, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 90d 5s', 'STN', 86, 17, 1, 33, 90, 5, NULL),
(1958, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 108d 3s', 'STN', 86, 17, 1, 33, 108, 3, NULL),
(1959, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 78d 6s', 'PTN', 87, 17, 1, 31.5, 78, 6, NULL),
(1960, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 83d 4s', 'PTN', 87, 17, 1, 31.5, 83, 4, NULL),
(1961, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 83d 3s', 'PTN', 87, 17, 1, 31.5, 83, 3, NULL),
(1962, 'SBT 20.0 2P 132', 'SBT 16.0gsm 2p 25w 115d 4s', 'SBT', 86, 16, 2, 25, 115, 4, NULL),
(1963, 'SBT 20.0 2P 132', 'SBT 16.0gsm 2p 132w 100d 1s', 'SBT', 86, 16, 2, 132, 100, 1, NULL),
(1964, 'SBT 16.5 1P 288', 'SBT 16.5gsm 2p 288w 226d 1s', 'SBT', 86, 16.5, 2, 288, 226, 1, NULL),
(1965, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 132w 115d 1s', 'SBT', 86, 16.5, 2, 132, 115, 1, NULL),
(1966, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 236d 1s', 'PBTS', 87, 15.5, 1, 288, 236, 1, NULL),
(1967, 'PBTs 15.5 1P 288', 'PBTS 15.5gsm 1p 288w 234d 1s', 'PBTS', 87, 15.5, 1, 288, 234, 1, NULL),
(1968, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 60d 3s', 'PTN', 87, 17, 1, 31.5, 60, 3, NULL),
(1969, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 60d 3s', 'PTN', 87, 17, 1, 33, 60, 3, NULL),
(1970, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 120d 2s', 'PTN', 87, 17, 1, 33, 120, 2, NULL),
(1971, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 106d 3s', 'PTN', 87, 17, 1, 33, 106, 3, NULL),
(1972, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 107d 3s', 'STN', 86, 17, 1, 30, 107, 3, NULL),
(1973, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 60d 4s', 'PTN', 87, 17, 1, 33, 60, 4, NULL),
(1974, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 25w 115d 1s', 'SBT', 86, 16.5, 2, 25, 115, 1, NULL),
(1975, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 132w 100d 1s', 'SBT', 86, 16.5, 2, 132, 100, 1, NULL),
(1976, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 213d 1s', 'PBTS', 87, 16.5, 1, 288, 213, 1, NULL),
(1977, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 203d 1s', 'PBTS', 87, 16.5, 1, 288, 203, 1, NULL),
(1978, 'SKT 40.0 1P 288', 'SKT 42.0gsm 1p 250w 120d 1s', 'SKT', 86, 42, 1, 250, 120, 1, NULL),
(1979, 'SKT 40.0 1P 288', 'SKT 42.0gsm 1p 25w 120d 4s', 'SKT', 86, 42, 1, 25, 120, 4, NULL),
(1980, 'SKT 40.0 1P 288', 'SKT 42.0gsm 1p 285w 120d 1s', 'SKT', 86, 42, 1, 285, 120, 1, NULL),
(1981, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 60d 2s', 'PTN', 87, 17, 1, 33, 60, 2, NULL),
(1982, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 104d 1s', 'SBT', 86, 16.5, 2, 140, 104, 1, NULL),
(1983, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 70d 5s', 'STN', 86, 17, 1, 33, 70, 5, NULL),
(1984, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 70d 4s', 'STN', 86, 17, 1, 30, 70, 4, NULL),
(1985, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 85d 2s', 'PTN', 87, 17, 1, 33, 85, 2, NULL),
(1986, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 100d 1s', 'SBT', 86, 16.5, 2, 288, 100, 1, NULL),
(1987, 'PBTs 15.5 1P 288', 'PBTS 16.5gsm 1p 288w 236d 2s', 'PBTS', 87, 16.5, 1, 288, 236, 2, NULL),
(1988, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 70d 3s', 'PTN', 87, 17, 1, 31.5, 70, 3, NULL),
(1989, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 93d 1s', 'SBT', 86, 16.5, 2, 120, 93, 1, NULL),
(1990, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 89d 1s', 'SBT', 86, 16.5, 2, 140, 89, 1, NULL),
(1991, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 100d 2s', 'PTN', 87, 17, 1, 33, 100, 2, NULL),
(1992, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 106d 4s', 'PTN', 87, 18, 1, 31.5, 106, 4, NULL),
(1993, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 106d 3s', 'PTN', 87, 18, 1, 31.5, 106, 3, NULL),
(1994, 'PTN 17.0 1P 33', 'PTN 18.0gsm 1p 33w 106d 2s', 'PTN', 87, 18, 1, 33, 106, 2, NULL),
(1995, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 115d 1s', 'PBT', 87, 17.5, 2, 255, 115, 1, NULL),
(1996, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 110d 1s', 'PBT', 87, 17.5, 2, 255, 110, 1, NULL),
(1997, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 25w 115d 4s', 'PBT', 87, 17.5, 2, 25, 115, 4, NULL),
(1998, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 106d 1s', 'PBT', 87, 17.5, 2, 255, 106, 1, NULL),
(1999, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 105d 1s', 'PBT', 87, 17.5, 2, 255, 105, 1, NULL),
(2000, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 30w 115d 4s', 'PBT', 87, 16.5, 2, 30, 115, 4, NULL),
(2001, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 113d 1s', 'PBT', 87, 17.5, 2, 255, 113, 1, NULL),
(2002, 'PBT 17.0 2P 256', 'PBT 17.0gsm 2p 255w 115d 1s', 'PBT', 87, 17, 2, 255, 115, 1, NULL),
(2003, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 30w 115d 1s', 'PBT', 87, 16.5, 2, 30, 115, 1, NULL),
(2004, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 111d 1s', 'PBT', 87, 17.5, 2, 255, 111, 1, NULL),
(2005, 'PBT 16.5 2P 140', 'PBT 17.5gsm 2p 30w 115d 4s', 'PBT', 87, 17.5, 2, 30, 115, 4, NULL),
(2006, 'PBT 16.5 2P 288', 'PBT 17.5gsm 2p 288w 140d 1s', 'PBT', 87, 17.5, 2, 288, 140, 1, NULL),
(2007, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 90d 5s', 'PTN', 87, 17, 1, 31.5, 90, 5, NULL),
(2008, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 108d 1s', 'PBT', 87, 17.5, 2, 255, 108, 1, NULL),
(2009, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 112d 1s', 'PBT', 87, 17.5, 2, 255, 112, 1, NULL),
(2010, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 110d 2s', 'PTN', 87, 17, 1, 33, 110, 2, NULL),
(2011, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 105d 2s', 'PTN', 87, 17, 1, 31.5, 105, 2, NULL),
(2012, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 256w 94d 1s', 'PBT', 87, 17.5, 2, 256, 94, 1, NULL),
(2013, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 30w 105d 4s', 'EBT', 73, 16.5, 2, 30, 105, 4, NULL),
(2014, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 205w 158d 1s', 'PBT', 87, 16.5, 2, 205, 158, 1, NULL),
(2015, 'PBT 16.5 2P 288', 'PBT 16.5gsm 2p 288w 143d 1s', 'PBT', 87, 16.5, 2, 288, 143, 1, NULL),
(2016, 'PBT 17.0 2P 256', 'PBT 16.5gsm 2p 30w 115d 5s', 'PBT', 87, 16.5, 2, 30, 115, 5, NULL),
(2017, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 216d 1s', 'SBT', 86, 16.5, 1, 288, 216, 1, NULL),
(2018, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 70d 3s', 'PTN', 87, 17, 1, 33, 70, 3, NULL),
(2019, 'PTN 17.0 1P 33', 'PTN 21.0gsm 1p 33w 105d 4s', 'PTN', 87, 21, 1, 33, 105, 4, NULL),
(2020, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 203d 1s', 'SBT', 86, 16.5, 1, 288, 203, 1, NULL),
(2021, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 207d 1s', 'SBT', 86, 16.5, 1, 288, 207, 1, NULL),
(2022, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 213d 1s', 'SBT', 86, 16.5, 1, 288, 213, 1, NULL),
(2023, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 30w 105100d 1s', 'PBT', 87, 16.5, 2, 30, 105100, 1, NULL),
(2024, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 30w 105100d 4s', 'PBT', 87, 16.5, 2, 30, 105100, 4, NULL),
(2025, 'PTN 17.0 1P 33', 'PTN 21.0gsm 1p 33w 100d 4s', 'PTN', 87, 21, 1, 33, 100, 4, NULL),
(2026, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 9s', 'STN', 86, 17, 1, 30, 115, 9, NULL),
(2027, 'SBT 16.5 2P 140', 'SBT 16.5gsm 1p 164w 100d 1s', 'SBT', 86, 16.5, 1, 164, 100, 1, NULL),
(2028, 'SKT 40.0 1P 288', 'SKT 22.0gsm 1p 288w 237d 1s', 'SKT', 86, 22, 1, 288, 237, 1, NULL),
(2029, 'SKT 40.0 1P 288', 'SKT 22.0gsm 1p 288w 239d 1s', 'SKT', 86, 22, 1, 288, 239, 1, NULL),
(2030, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 8s', 'STN', 86, 17, 1, 30, 115, 8, NULL),
(2031, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 105d 8s', 'STN', 86, 17, 1, 30, 105, 8, NULL),
(2032, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 102d 9s', 'STN', 86, 17, 1, 30, 102, 9, NULL),
(2033, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 100d 9s', 'STN', 86, 17, 1, 30, 100, 9, NULL),
(2034, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 100w 70d 1s', 'SBT', 86, 16.5, 2, 100, 70, 1, NULL),
(2035, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 30w 115d 5s', 'SBT', 86, 16.5, 2, 30, 115, 5, NULL),
(2036, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 90d 1s', 'STN', 86, 17, 1, 30, 90, 1, NULL),
(2037, 'SWT 19 1P 60', 'SWT 19.0gsm 1p 60w 56d 4s', 'SWT', 86, 19, 1, 60, 56, 4, NULL),
(2038, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 142w 105d 1s', 'SBT', 86, 16.5, 2, 142, 105, 1, NULL),
(2039, 'SBT 16.5 2P 140', 'SBT 185.0gsm 2p 142w 100d 1s', 'SBT', 86, 185, 2, 142, 100, 1, NULL),
(2040, 'PFT 14.0 2P 108', 'PFT 14.0gsm 2p 120w 115d 2s', 'PFT', 87, 14, 2, 120, 115, 2, NULL),
(2041, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 251d 1s', 'EBT', 73, 16.5, 1, 288, 251, 1, NULL),
(2042, 'PFT 14.5 2P 80', 'PFT 14.5gsm 2p 80w 115d 2s', 'PFT', 87, 14.5, 2, 80, 115, 2, NULL),
(2043, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 100w 87d 2s', 'PFT', 87, 14, 2, 100, 87, 2, NULL),
(2044, 'PFT 14.5 2P 80', 'PFT 14.0gsm 2p 80w 87d 2s', 'PFT', 87, 14, 2, 80, 87, 2, NULL),
(2045, 'PFT 14.5 2P 100', 'PFT 14.5gsm 2p 100w 87d 2s', 'PFT', 87, 14.5, 2, 100, 87, 2, NULL),
(2046, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 167d 1s', 'EBT', 73, 16.5, 2, 288, 167, 1, NULL),
(2047, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 100d 9s', 'PTN', 87, 17, 1, 31.5, 100, 9, NULL),
(2048, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 225w 118d 1s', 'EBT', 73, 16.5, 2, 225, 118, 1, NULL),
(2049, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 60d 6s', 'STN', 86, 17, 1, 30, 60, 6, NULL),
(2050, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 7s', 'PTN', 87, 17, 1, 31.5, 115, 7, NULL),
(2051, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 102d 7s', 'PTN', 87, 17, 1, 31.5, 102, 7, NULL),
(2052, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 9s', 'PTN', 87, 17, 1, 31.5, 115, 9, NULL),
(2053, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 60d 3s', 'STN', 86, 17, 1, 33, 60, 3, NULL),
(2054, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 105d 9s', 'PTN', 87, 17, 1, 31.5, 105, 9, NULL),
(2055, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 100d 7s', 'PTN', 87, 17, 1, 31.5, 100, 7, NULL),
(2056, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 102d 6s', 'STN', 86, 17, 1, 30, 102, 6, NULL),
(2057, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 70d 1s', 'EBT', 73, 16.5, 2, 140, 70, 1, NULL),
(2058, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 1070d 1s', 'EBT', 73, 16.5, 2, 140, 1070, 1, NULL),
(2059, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 115d 7s', 'STN', 86, 17, 1, 30, 115, 7, NULL),
(2060, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 87d 8s', 'STN', 86, 17, 1, 30, 87, 8, NULL),
(2061, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 6s', 'PTN', 87, 17, 1, 31.5, 115, 6, NULL),
(2062, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 85d 7s', 'PTN', 87, 17, 1, 31.5, 85, 7, NULL),
(2063, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 108d 4s', 'STN', 86, 17, 1, 30, 108, 4, NULL),
(2064, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 112d 7s', 'STN', 86, 17, 1, 30, 112, 7, NULL),
(2065, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 105d 9s', 'STN', 86, 17, 1, 30, 105, 9, NULL),
(2066, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 103d 8s', 'STN', 86, 17, 1, 30, 103, 8, NULL),
(2067, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 100d 7s', 'STN', 86, 17, 1, 30, 100, 7, NULL),
(2068, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 108d 5s', 'STN', 86, 17, 1, 30, 108, 5, NULL),
(2069, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 90w 100d 1s', 'SBT', 86, 16.5, 2, 90, 100, 1, NULL),
(2070, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 163d 1s', 'SBT', 86, 16.5, 2, 288, 163, 1, NULL),
(2071, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 1800d 1s', 'SBT', 86, 16.5, 2, 288, 1800, 1, NULL),
(2072, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 142w 104d 1s', 'SBT', 86, 18, 2, 142, 104, 1, NULL),
(2073, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 164w 112d 1s', 'SBT', 86, 16.5, 2, 164, 112, 1, NULL),
(2074, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 112d 1s', 'SBT', 86, 16.5, 2, 120, 112, 1, NULL),
(2075, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 135w 90d 1s', 'SBT', 86, 16.5, 2, 135, 90, 1, NULL),
(2076, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 193w 116d 1s', 'SBT', 86, 16.5, 2, 193, 116, 1, NULL),
(2077, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 210d 1s', 'SBT', 86, 16.5, 2, 288, 210, 1, NULL),
(2078, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 130w 100d 1s', 'SBT', 86, 16.5, 2, 130, 100, 1, NULL),
(2079, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 90w 95d 1s', 'SBT', 86, 16.5, 2, 90, 95, 1, NULL),
(2080, 'SWT 19 1P 60', 'SWT 22.0gsm 1p 60w 60d 2s', 'SWT', 86, 22, 1, 60, 60, 2, NULL),
(2081, 'SWT 19 1P 60', 'SWT 22.0gsm 1p 60w 60d 3s', 'SWT', 86, 22, 1, 60, 60, 3, NULL),
(2082, 'SWT 19 1P 60', 'SWT 19.0gsm 1p 60w 60d 3s', 'SWT', 86, 19, 1, 60, 60, 3, NULL),
(2083, 'SWT 19 1P 60', 'SWT 19.0gsm 1p 60w 60d 2s', 'SWT', 86, 19, 1, 60, 60, 2, NULL),
(2084, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 243d 1s', 'SBT', 86, 16.5, 1, 288, 243, 1, NULL),
(2085, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 241d 1s', 'SBT', 86, 16.5, 1, 288, 241, 1, NULL),
(2086, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 110d 9s', 'STN', 86, 17, 1, 30, 110, 9, NULL),
(2087, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 92d 9s', 'STN', 86, 17, 1, 30, 92, 9, NULL),
(2088, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 241d 1s', 'EBT', 73, 16.5, 1, 288, 241, 1, NULL),
(2089, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 60d 3s', 'STN', 86, 17, 1, 30, 60, 3, NULL),
(2090, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 250w 96d 1s', 'EBT', 73, 16.5, 2, 250, 96, 1, NULL),
(2091, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 110d 3s', 'PTN', 87, 17, 1, 33, 110, 3, NULL),
(2092, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 250w 115d 1s', 'EBT', 73, 16.5, 2, 250, 115, 1, NULL),
(2093, 'PTN 17.0 3P 22', 'PTN 15.0gsm 2p 22w 120d 4s', 'PTN', 87, 15, 2, 22, 120, 4, NULL),
(2094, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 97d 9s', 'PTN', 87, 17, 1, 31.5, 97, 9, NULL),
(2095, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 110d 7s', 'STN', 86, 17, 1, 30, 110, 7, NULL),
(2096, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 120d 7s', 'STN', 86, 17, 1, 30, 120, 7, NULL),
(2097, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 120d 4s', 'STN', 86, 17, 1, 33, 120, 4, NULL),
(2098, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 108d 3s', 'PTN', 87, 17, 1, 33, 108, 3, NULL),
(2099, 'SBT 15.5 2P 262', 'SBT 16.5gsm 2p 262w 115d 1s', 'SBT', 86, 16.5, 2, 262, 115, 1, NULL),
(2100, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 120d 6s', 'STN', 86, 17, 1, 30, 120, 6, NULL),
(2101, 'PBTs 15.5 1P 288', 'PBTS 17.5gsm 1p 288w 236d 1s', 'PBTS', 87, 17.5, 1, 288, 236, 1, NULL),
(2102, 'PTN 19.0 1P 32.5', 'PTN 22.0gsm 1p 32.5w 115d 4s', 'PTN', 87, 22, 1, 32.5, 115, 4, NULL),
(2103, 'PTN 19.0 1P 32.5', 'PTN 22.0gsm 1p 32.5w 108d 4s', 'PTN', 87, 22, 1, 32.5, 108, 4, NULL),
(2104, 'PTN 19.0 1P 32.5', 'PTN 22.0gsm 1p 32.5w 115d 5s', 'PTN', 87, 22, 1, 32.5, 115, 5, NULL),
(2105, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 110w 80d 1s', 'SKT', 86, 21, 2, 110, 80, 1, NULL),
(2106, 'PTN 17.0 1P 33', 'PTN 19.0gsm 1p 33w 106d 3s', 'PTN', 87, 19, 1, 33, 106, 3, NULL),
(2107, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 80w 115d 4s', 'PFT', 87, 14, 2, 80, 115, 4, NULL),
(2108, 'PFT 14.5 2P 42', 'PFT 14.5gsm 2p 40w 115d 4s', 'PFT', 87, 14.5, 2, 40, 115, 4, NULL),
(2109, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 100w 106d 2s', 'PFT', 87, 14, 2, 100, 106, 2, NULL),
(2110, 'STN 22.0 2P 140', 'STN 22.5gsm 1p 32.5w 115d 4s', 'STN', 86, 22.5, 1, 32.5, 115, 4, NULL),
(2111, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 102d 1s', 'SBT', 86, 16.5, 2, 140, 102, 1, NULL),
(2112, 'EBT 16.5 2P 140', 'EBT 18.0gsm 2p 142w 115d 1s', 'EBT', 73, 18, 2, 142, 115, 1, NULL),
(2113, 'EBT 16.5 2P 140', 'EBT 18.0gsm 2p 142w 104d 1s', 'EBT', 73, 18, 2, 142, 104, 1, NULL),
(2114, 'EBT 16.5 2P 140', 'EBT 18.0gsm 2p 142w 105d 1s', 'EBT', 73, 18, 2, 142, 105, 1, NULL),
(2115, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 107d 1s', 'EBT', 73, 16.5, 2, 120, 107, 1, NULL),
(2116, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 105w 100d 1s', 'EBT', 73, 16.5, 2, 105, 100, 1, NULL),
(2117, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 142w 115d 1s', 'EBT', 73, 16.5, 2, 142, 115, 1, NULL),
(2118, 'EBT 18.0 2P 140', 'EBT 18.0gsm 2p 140w 115d 1s', 'EBT', 73, 18, 2, 140, 115, 1, NULL),
(2119, 'EBT 16.5 2P 140', 'EBT 18.0gsm 2p 100w 109d 1s', 'EBT', 73, 18, 2, 100, 109, 1, NULL),
(2120, 'EBT 16.5 2P 140', 'EBT 18.0gsm 2p 100w 115d 1s', 'EBT', 73, 18, 2, 100, 115, 1, NULL),
(2121, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 101d 4s', 'PTN', 87, 17, 1, 31.5, 101, 4, NULL),
(2122, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 730d 1s', 'EBT', 73, 16.5, 2, 288, 730, 1, NULL),
(2123, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 220w 120d 1s', 'EBT', 73, 16.5, 2, 220, 120, 1, NULL),
(2124, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 220w 120d 1s', 'EBT', 73, 16.5, 1, 220, 120, 1, NULL),
(2125, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 155d 9s', 'PFT', 87, 14, 3, 20, 155, 9, NULL),
(2126, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 155d 10s', 'PFT', 87, 14, 3, 20, 155, 10, NULL),
(2127, 'PTN 17.0 1P 31.5', 'PTN 16.5gsm 2p 31.5w 100d 5s', 'PTN', 86, 16.5, 2, 31.5, 100, 5, NULL),
(2128, 'UBT 16.7 2P 288', 'UBT 16.7gsm 2p 275w 122d 1s', 'UBT', 67, 16.7, 2, 275, 122, 1, NULL),
(2129, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 74d 3s', 'PTN', 87, 17, 1, 31.5, 74, 3, NULL),
(2130, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 255w 115d 1s', 'SBT', 86, 16.5, 2, 255, 115, 1, NULL),
(2131, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 279w 150d 1s', 'SBT', 86, 16.5, 2, 279, 150, 1, NULL),
(2132, 'SBT 17.0 2P 30', 'SBT 17.5gsm 2p 30w 115d 1s', 'SBT', 86, 17.5, 2, 30, 115, 1, NULL),
(2133, 'EBT 16.5 2P 130', 'EBT 16.5gsm 2p 130w 100d 1s', 'EBT', 86, 16.5, 2, 130, 100, 1, NULL),
(2134, 'SBT 16.5 2P 140', 'SBT 16.6gsm 2p 140w 100d 1s', 'SBT', 86, 16.55, 2, 140, 100, 1, NULL),
(2135, 'SBT 16.5 2P 140', 'SBT 16.0gsm 2p 140w 95d 1s', 'SBT', 86, 16, 2, 140, 95, 1, NULL),
(2136, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 105d 4s', 'STN', 86, 18, 1, 33, 105, 4, NULL),
(2137, 'SBT 16.5 2P 140', 'SBT 18.0gsm 2p 2w 100d 1s', 'SBT', 86, 18, 2, 2, 100, 1, NULL),
(2138, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 100d 4s', 'SBT', 86, 16.5, 2, 140, 100, 4, NULL),
(2139, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 100d 9s', 'PTN', 87, 18, 1, 31.5, 100, 9, NULL),
(2140, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 110d 9s', 'PTN', 87, 18, 1, 31.5, 110, 9, NULL),
(2141, 'SBT 16.5 1P 288', 'SBT 17.5gsm 1p 288w 245d 1s', 'SBT', 86, 17.5, 1, 288, 245, 1, NULL),
(2142, 'PTN 17.0 1P 33', 'PTN 19.0gsm 1p 33w 107d 4s', 'PTN', 87, 19, 1, 33, 107, 4, NULL),
(2143, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 113d 5s', 'PTN', 87, 17, 1, 31.5, 113, 5, NULL),
(2144, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 113d 4s', 'PTN', 87, 17, 1, 31.5, 113, 4, NULL),
(2145, 'EBT 16.5 2P 285', 'EBT 17.5gsm 1p 285w 238d 1s', 'EBT', 73, 17.5, 1, 285, 238, 1, NULL),
(2146, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 115d 45s', 'PTN', 87, 17, 1, 31.5, 115, 45, NULL),
(2147, 'EBT 16.5 2P 288', 'EBT 17.5gsm 2p 288w 150d 1s', 'EBT', 73, 17.5, 2, 288, 150, 1, NULL),
(2148, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 150d 1s', 'EBT', 73, 17.5, 1, 288, 150, 1, NULL),
(2149, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 238d 1s', 'EBT', 73, 17.5, 1, 288, 238, 1, NULL),
(2150, 'EBT 16.5 2P 288', 'EBT 17.5gsm 2p 288w 120d 1s', 'EBT', 73, 17.5, 2, 288, 120, 1, NULL),
(2151, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 240d 1s', 'EBT', 73, 17.5, 1, 288, 240, 1, NULL),
(2152, 'PBT 16.5 2P 288', 'PBT 17.5gsm 2p 288w 150d 1s', 'PBT', 87, 17.5, 2, 288, 150, 1, NULL),
(2153, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 95d 6s', 'PTN', 87, 17, 1, 31.5, 95, 6, NULL),
(2154, 'STN 17.0 1P 30', 'STN 18.0gsm 1p 30w 115d 7s', 'STN', 86, 18, 1, 30, 115, 7, NULL),
(2155, 'STN 17.0 1P 30', 'STN 18.0gsm 1p 30w 112d 4s', 'STN', 86, 18, 1, 30, 112, 4, NULL),
(2156, 'STN 17.0 1P 30', 'STN 18.0gsm 1p 30w 112d 3s', 'STN', 86, 18, 1, 30, 112, 3, NULL),
(2157, 'STN 17.0 1P 33', 'STN 18.0gsm 1p 33w 112d 2s', 'STN', 86, 18, 1, 33, 112, 2, NULL),
(2158, 'PBT 15.5 2P 288', 'PBT 17.5gsm 2p 288w 130d 1s', 'PBT', 87, 17.5, 2, 288, 130, 1, NULL),
(2159, 'STN 17.0 1P 30', 'STN 18.0gsm 1p 30w 104d 5s', 'STN', 86, 18, 1, 30, 104, 5, NULL),
(2160, 'STN 17.0 1P 33', 'STN 18.0gsm 1p 33w 104d 2s', 'STN', 86, 18, 1, 33, 104, 2, NULL),
(2161, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 110d 2s', 'STN', 86, 18, 1, 33, 110, 2, NULL),
(2162, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 86d 2s', 'STN', 86, 18, 1, 33, 86, 2, NULL),
(2163, 'STN 17.0 1P 30', 'STN 18.0gsm 1p 30w 86d 7s', 'STN', 86, 18, 1, 30, 86, 7, NULL),
(2164, 'PBT 16.5 2P 288', 'PBT 17.5gsm 2p 288w 145d 1s', 'PBT', 87, 17.5, 2, 288, 145, 1, NULL),
(2165, 'STN 18.0 1P 30', 'STN 17.5gsm 1p 30w 115d 4s', 'STN', 87, 17.5, 1, 30, 115, 4, NULL),
(2166, 'PBT 16.5 2P 288', 'PBT 17.5gsm 2p 288w 120d 1s', 'PBT', 87, 17.5, 2, 288, 120, 1, NULL),
(2167, 'PBT 16.5 2P 288', 'PBT 17.5gsm 1p 288w 140d 1s', 'PBT', 87, 17.5, 1, 288, 140, 1, NULL),
(2168, 'PBT 16.5 2P 288', 'PBT 17.5gsm 1p 288w 150d 1s', 'PBT', 87, 17.5, 1, 288, 150, 1, NULL),
(2169, 'PBTs 15.5 1P 288', 'PBTS 17.5gsm 1p 288w 150d 1s', 'PBTS', 87, 17.5, 1, 288, 150, 1, NULL),
(2170, 'PFT 14.5 2P 100', 'PFT 18.0gsm 2p 100w 115d 2s', 'PFT', 87, 18, 2, 100, 115, 2, NULL),
(2171, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 80w 115d 21s', 'PFT', 87, 14, 2, 80, 115, 21, NULL),
(2172, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 100w 115d 278s', 'PFT', 87, 14, 2, 100, 115, 278, NULL),
(2173, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 110d 1s', 'STN', 86, 18, 1, 33, 110, 1, NULL),
(2174, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 8s', 'PTN', 87, 18, 1, 31.5, 115, 8, NULL),
(2175, 'SBT 16.5 2P 140', 'SBT 16.5gsm 3p 25w 115d 5s', 'SBT', 86, 16.5, 3, 25, 115, 5, NULL),
(2176, 'SBT 16.5 2P 140', 'SBT 16.5gsm 3p 25w 115d 4s', 'SBT', 86, 16.5, 3, 25, 115, 4, NULL),
(2177, 'SBT 16.5 2P 140', 'SBT 16.5gsm 3p 132w 90d 1s', 'SBT', 86, 16.5, 3, 132, 90, 1, NULL),
(2178, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 120d 9s', 'PFT', 87, 14, 3, 20, 120, 9, NULL),
(2179, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 120d 10s', 'PFT', 87, 14, 3, 20, 120, 10, NULL),
(2180, 'SBT 16.5 2P 40', 'SBT 16.5gsm 3p 132w 82d 1s', 'SBT', 86, 16.5, 3, 132, 82, 1, NULL),
(2181, 'SBT 16.5 2P 40', 'SBT 16.5gsm 3p 132w 115d 3s', 'SBT', 86, 16.5, 3, 132, 115, 3, NULL),
(2182, 'SBT 16.5 2P 140', 'SBT 16.5gsm 3p 25w 115d 1s', 'SBT', 86, 16.5, 3, 25, 115, 1, NULL),
(2183, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 115d 54s', 'STN', 86, 18, 1, 33, 115, 54, NULL),
(2184, 'SBT 16.5 2P 140', 'SBT 16.5gsm 3p 132w 100d 1s', 'SBT', 86, 16.5, 3, 132, 100, 1, NULL),
(2185, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 110d 2s', 'STN', 86, 18, 1, 30, 110, 2, NULL),
(2186, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 1w 100d 1s', 'SBT', 86, 16.5, 2, 1, 100, 1, NULL),
(2187, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 105d 4s', 'STN', 87, 19, 1, 30, 105, 4, NULL),
(2188, 'STN 17.0 1P 30', 'STN 19.0gsm 1p 30w 110d 3s', 'STN', 86, 19, 1, 30, 110, 3, NULL),
(2189, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 7s', 'PTN', 87, 18, 1, 31.5, 115, 7, NULL),
(2190, 'SBT 16.5 2P 288', 'SBT 17.5gsm 2p 288w 180d 1s', 'SBT', 86, 17.5, 2, 288, 180, 1, NULL),
(2191, 'SBT 16.5 2P 288', 'SBT 17.5gsm 2p 288w 100d 1s', 'SBT', 86, 17.5, 2, 288, 100, 1, NULL),
(2192, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 110d 3s', 'PTN', 87, 18, 1, 31.5, 110, 3, NULL),
(2193, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 120d 1s', 'SBT', 86, 16.5, 2, 120, 120, 1, NULL),
(2194, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 164w 120d 1s', 'SBT', 86, 16.5, 2, 164, 120, 1, NULL),
(2195, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 101d 4s', 'STN', 87, 19, 1, 30, 101, 4, NULL),
(2196, 'EBT 16.5 2P 288', 'EBT 17.5gsm 1p 288w 236d 1s', 'EBT', 73, 17.5, 1, 288, 236, 1, NULL),
(2197, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 242d 1s', 'EBT', 73, 17.5, 1, 288, 242, 1, NULL),
(2198, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 244d 1s', 'EBT', 73, 17.5, 1, 288, 244, 1, NULL),
(2199, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 250d 1s', 'EBT', 73, 17.5, 1, 288, 250, 1, NULL),
(2200, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 257d 1s', 'EBT', 73, 17.5, 1, 288, 257, 1, NULL);
INSERT INTO `bpl_products` (`id`, `old`, `productname`, `gradetype`, `brightness`, `gsm`, `ply`, `width`, `diameter`, `slice`, `deleted_at`) VALUES
(2201, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 120d 1s', 'EBT', 73, 17.5, 1, 288, 120, 1, NULL),
(2202, 'STN 18.0 1P 30', 'STN 348.0gsm 1p 30w 115d 4s', 'STN', 86, 348, 1, 30, 115, 4, NULL),
(2203, 'EBT 16.5 2P 288', 'EBT 17.5gsm 2p 288w 110d 1s', 'EBT', 73, 17.5, 2, 288, 110, 1, NULL),
(2204, 'PTN 17.0 1P 31.5', 'PTN 87.0gsm 1p 31.5w 115d 3s', 'PTN', 87, 87, 1, 31.5, 115, 3, NULL),
(2205, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 245d 1s', 'EBT', 73, 17.5, 1, 288, 245, 1, NULL),
(2206, 'PTN 17.0 1P 33', 'PTN 18.0gsm 1p 33w 100d 2s', 'PTN', 87, 18, 1, 33, 100, 2, NULL),
(2207, 'EBT 16.5 2P 288', 'EBT 17.5gsm 2p 288w 1d 1s', 'EBT', 73, 17.5, 2, 288, 1, 1, NULL),
(2208, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 235d 1s', 'EBT', 73, 17.5, 1, 288, 235, 1, NULL),
(2209, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 230d 1s', 'EBT', 73, 17.5, 1, 288, 230, 1, NULL),
(2210, 'EBT 16.5 1P 288', 'EBT 1,675.0gsm 1p 288w 150d 1s', 'EBT', 73, 1675, 1, 288, 150, 1, NULL),
(2211, 'EBT 16.5 2P 288', 'EBT 76.5gsm 2p 288w 150d 1s', 'EBT', 73, 76.5, 2, 288, 150, 1, NULL),
(2212, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 140d 1s', 'EBT', 73, 17.5, 1, 288, 140, 1, NULL),
(2213, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 100d 3s', 'STN', 86, 18, 1, 30, 100, 3, NULL),
(2214, 'PTN 17.0 1P 30', 'PTN 22.0gsm 1p 32w 115d 4s', 'PTN', 87, 22, 1, 32, 115, 4, NULL),
(2215, 'PTN 21.0 1P 33', 'PTN 20.0gsm 1p 33w 109d 4s', 'PTN', 87, 20, 1, 33, 109, 4, NULL),
(2216, 'PTN 21.0 1P 33', 'PTN 20.0gsm 1p 33w 104d 4s', 'PTN', 87, 20, 1, 33, 104, 4, NULL),
(2217, 'PTN 21.0 1P 33', 'PTN 20.0gsm 1p 33w 105d 4s', 'PTN', 87, 20, 1, 33, 105, 4, NULL),
(2218, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 106d 5s', 'PTN', 87, 18, 1, 31.5, 106, 5, NULL),
(2219, 'PTN 17.0 1P 31.5', 'PTN 185.0gsm 1p 31.5w 115d 9s', 'PTN', 87, 185, 1, 31.5, 115, 9, NULL),
(2220, 'PTN 17.0 1P 33', 'PTN 20.0gsm 1p 33w 115d 5s', 'PTN', 87, 20, 1, 33, 115, 5, NULL),
(2221, 'EBT 16.5 2P 288', 'EBT 17.5gsm 2p 288w 145d 1s', 'EBT', 73, 17.5, 2, 288, 145, 1, NULL),
(2222, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 234d 1s', 'EBT', 73, 17.5, 1, 288, 234, 1, NULL),
(2223, 'EBT 16.5 2P 288', 'EBT 17.5gsm 2p 288w 140d 1s', 'EBT', 73, 17.5, 2, 288, 140, 1, NULL),
(2224, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 115d 8s', 'PFT', 87, 14, 3, 20, 115, 8, NULL),
(2225, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 114d 1s', 'EBT', 73, 16.5, 2, 140, 114, 1, NULL),
(2226, 'EBT 16.5 2P 288', 'EBT 17.5gsm 2p 288w 130d 1s', 'EBT', 73, 17.5, 2, 288, 130, 1, NULL),
(2227, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 109d 5s', 'PFT', 87, 14, 3, 20, 109, 5, NULL),
(2228, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 100d 5s', 'PFT', 87, 14, 3, 20, 100, 5, NULL),
(2229, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 241d 1s', 'EBT', 73, 17.5, 1, 288, 241, 1, NULL),
(2230, 'EBT 16.5 1P 288', 'EBT 17.5gsm 1p 288w 243d 1s', 'EBT', 73, 17.5, 1, 288, 243, 1, NULL),
(2231, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 110d 5s', 'PFT', 87, 14, 3, 20, 110, 5, NULL),
(2232, 'EBT 16.5 2P 288', 'EBT 17.5gsm 2p 288w 125d 1s', 'EBT', 73, 17.5, 2, 288, 125, 1, NULL),
(2233, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 80d 9s', 'PTN', 87, 18, 1, 31.5, 80, 9, NULL),
(2234, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 105d 9s', 'PTN', 87, 18, 1, 31.5, 105, 9, NULL),
(2235, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 135w 100d 1s', 'EBT', 73, 16.5, 2, 135, 100, 1, NULL),
(2236, 'PKT 22.0 2P 288', 'PKT 23.0gsm 1p 288w 118d 1s', 'PKT', 87, 23, 1, 288, 118, 1, NULL),
(2237, 'PKT 22.0 2P 288', 'PKT 23.0gsm 2p 288w 120d 1s', 'PKT', 87, 23, 2, 288, 120, 1, NULL),
(2238, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 112d 9s', 'PTN', 87, 18, 1, 31.5, 112, 9, NULL),
(2239, 'PKT 22.0 2P 288', 'PKT 23.0gsm 2p 288w 150d 1s', 'PKT', 87, 23, 2, 288, 150, 1, NULL),
(2240, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 115d 6s', 'STN', 86, 18, 1, 33, 115, 6, NULL),
(2241, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 128w 90d 1s', 'SBT', 86, 16.5, 2, 128, 90, 1, NULL),
(2242, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 102d 1s', 'SBT', 86, 17, 2, 256, 102, 1, NULL),
(2243, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 105d 1s', 'SBT', 86, 17, 2, 256, 105, 1, NULL),
(2244, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 100d 1s', 'SBT', 86, 17, 2, 256, 100, 1, NULL),
(2245, 'SBT 16.5 2P 40', 'SBT 17.0gsm 2p 30w 110d 4s', 'SBT', 86, 17, 2, 30, 110, 4, NULL),
(2246, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 120w 91d 1s', 'SBT', 86, 16.5, 2, 120, 91, 1, NULL),
(2247, 'PTN 17.0 3P 38', 'PTN 15.0gsm 2p 38w 120d 1s', 'PTN', 87, 15, 2, 38, 120, 1, NULL),
(2248, 'PTN 17.0 3P 33', 'PTN 15.0gsm 2p 33w 120d 1s', 'PTN', 87, 15, 2, 33, 120, 1, NULL),
(2249, 'PTN 17.0 3P 22', 'PTN 15.0gsm 2p 22w 120d 1s', 'PTN', 87, 15, 2, 22, 120, 1, NULL),
(2250, 'PFT 14.0 2P 108', 'PFT 14.0gsm 2p 108w 120d 1s', 'PFT', 87, 14, 2, 108, 120, 1, NULL),
(2251, 'PTN 17.0 3P 33', 'PTN 15.0gsm 2p 33w 120d 4s', 'PTN', 87, 15, 2, 33, 120, 4, NULL),
(2252, 'PFT 14 2P 126', 'PFT 14.0gsm 2p 126w 110d 1s', 'PFT', 87, 14, 2, 126, 110, 1, NULL),
(2253, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 145w 100d 1s', 'SBT', 86, 16.5, 2, 145, 100, 1, NULL),
(2254, 'PTN 17.0 3P 38', 'PTN 15.0gsm 3p 38w 115d 7s', 'PTN', 87, 15, 3, 38, 115, 7, NULL),
(2255, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 95d 4s', 'PFT', 87, 14, 3, 20, 95, 4, NULL),
(2256, 'PTN 17.0 3P 38', 'PTN 15.0gsm 3p 38w 115d 6s', 'PTN', 87, 15, 3, 38, 115, 6, NULL),
(2257, 'EBT 16.5 1P 288', 'EBT 17.0gsm 1p 288w 238d 1s', 'EBT', 73, 17, 1, 288, 238, 1, NULL),
(2258, 'EBT 16.5 2P 288', 'EBT 17.0gsm 2p 288w 618d 1s', 'EBT', 73, 17, 2, 288, 618, 1, NULL),
(2259, 'EBT 16.5 1P 288', 'EBT 17.0gsm 1p 288w 234d 1s', 'EBT', 73, 17, 1, 288, 234, 1, NULL),
(2260, 'PTN 17.0 3P 33', 'PTN 17.0gsm 3p 33w 115d 4s', 'PTN', 87, 17, 3, 33, 115, 4, NULL),
(2261, 'EBT 16.5 1P 288', 'EBT 17.0gsm 1p 288w 236d 1s', 'EBT', 73, 17, 1, 288, 236, 1, NULL),
(2262, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 85w 70d 1s', 'EBT', 73, 16.5, 2, 85, 70, 1, NULL),
(2263, 'EBT 16.5 1P 288', 'EBT 17.0gsm 1p 288w 235d 1s', 'EBT', 73, 17, 1, 288, 235, 1, NULL),
(2264, 'STN 18.0 1P 30', 'STN 358.0gsm 1p 30w 115d 4s', 'STN', 86, 358, 1, 30, 115, 4, NULL),
(2265, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 230w 136d 1s', 'SBT', 86, 16.5, 2, 230, 136, 1, NULL),
(2266, 'EBT 16.5 2P 288', 'EBT 17.0gsm 2p 288w 112d 1s', 'EBT', 73, 17, 2, 288, 112, 1, NULL),
(2267, 'PTN 17.0 3P 38', 'PTN 15.0gsm 3p 38w 115d 2s', 'PTN', 87, 15, 3, 38, 115, 2, NULL),
(2268, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 115d 4s', 'PFT', 87, 14, 3, 20, 115, 4, NULL),
(2269, 'EBT 16.5 2P 288', 'EBT 17.0gsm 2p 288w 135d 1s', 'EBT', 73, 17, 2, 288, 135, 1, NULL),
(2270, 'SBT 16.5 1P 288', 'SBT 17.0gsm 1p 288w 234d 1s', 'SBT', 86, 17, 1, 288, 234, 1, NULL),
(2271, 'SWT 19 1P 60', 'SWT 22.0gsm 1p 19w 60d 6s', 'SWT', 86, 22, 1, 19, 60, 6, NULL),
(2272, 'SWT 19 1P 60', 'SWT 22.0gsm 1p 60w 90d 2s', 'SWT', 86, 22, 1, 60, 90, 2, NULL),
(2273, 'SWT 19 1P 60', 'SWT 22.0gsm 1p 60w 56d 2s', 'SWT', 86, 22, 1, 60, 56, 2, NULL),
(2274, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 115d 8s', 'PTN', 87, 15, 3, 33, 115, 8, NULL),
(2275, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 115d 6s', 'PTN', 87, 15, 3, 33, 115, 6, NULL),
(2276, 'PTN 17.0 1P 33', 'PTN 15.0gsm 3p 33w 95d 8s', 'PTN', 87, 15, 3, 33, 95, 8, NULL),
(2277, 'PTN 17.0 1P 33', 'PTN 15.0gsm 3p 33w 90d 8s', 'PTN', 87, 15, 3, 33, 90, 8, NULL),
(2278, 'PBTs 15.5 1P 288', 'PBTS 17.0gsm 1p 288w 150d 1s', 'PBTS', 87, 17, 1, 288, 150, 1, NULL),
(2279, 'STN 17.0 1P 30', 'STN 8.0gsm 1p 30w 115d 4s', 'STN', 86, 8, 1, 30, 115, 4, NULL),
(2280, 'SBT 16.5 2P 288', 'SBT 17.0gsm 2p 288w 17d 1s', 'SBT', 86, 17, 2, 288, 17, 1, NULL),
(2281, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 256w 112d 1s', 'EBT', 73, 15.5, 3, 256, 112, 1, NULL),
(2282, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 80d 1s', 'EBT', 73, 16.5, 2, 120, 80, 1, NULL),
(2283, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 130w 105d 1s', 'EBT', 73, 15.5, 3, 130, 105, 1, NULL),
(2284, 'EBT 16.5 2P 288', 'EBT 17.0gsm 2p 288w 160d 1s', 'EBT', 73, 17, 2, 288, 160, 1, NULL),
(2285, 'EBT 16.5 2P 288', 'EBT 17.0gsm 2p 288w 134d 1s', 'EBT', 73, 17, 2, 288, 134, 1, NULL),
(2286, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 92d 1s', 'EBT', 73, 16.5, 2, 120, 92, 1, NULL),
(2287, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 60d 5s', 'STN', 86, 18, 1, 30, 60, 5, NULL),
(2288, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 60d 4s', 'STN', 86, 18, 1, 33, 60, 4, NULL),
(2289, 'PTN 17.0 3P 38', 'PTN 15.0gsm 2p 38w 115d 4s', 'PTN', 87, 15, 2, 38, 115, 4, NULL),
(2290, 'PTN 17.0 3P 38', 'PTN 15.0gsm 3p 38w 120d 4s', 'PTN', 87, 15, 3, 38, 120, 4, NULL),
(2291, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 120d 4s', 'PTN', 87, 15, 3, 33, 120, 4, NULL),
(2292, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 104d 1s', 'EBT', 73, 16.5, 2, 140, 104, 1, NULL),
(2293, 'SBT 16.5 2P 288', 'SBT 17.0gsm 2p 288w 175d 1s', 'SBT', 86, 17, 2, 288, 175, 1, NULL),
(2294, 'SBT 16.5 2P 288', 'SBT 17.0gsm 2p 288w 172d 1s', 'SBT', 86, 17, 2, 288, 172, 1, NULL),
(2295, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 255w 104d 1s', 'PBT', 87, 17.5, 2, 255, 104, 1, NULL),
(2296, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 256w 115d 1s', 'PBT', 87, 17.5, 2, 256, 115, 1, NULL),
(2297, 'EBT 17.0 1P 282', 'EBT 17.0gsm 1p 279w 120d 1s', 'EBT', 73, 17, 1, 279, 120, 1, NULL),
(2298, 'PBT 17.0 2P 256', 'PBT 17.5gsm 2p 256w 115d 4s', 'PBT', 87, 17.5, 2, 256, 115, 4, NULL),
(2299, 'EBT 16.5 2P 288', 'EBT 17.0gsm 2p 279w 146d 1s', 'EBT', 73, 17, 2, 279, 146, 1, NULL),
(2300, 'EBT 17.0 2P 282', 'EBT 17.0gsm 2p 279w 152d 1s', 'EBT', 73, 17, 2, 279, 152, 1, NULL),
(2301, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 115d 6s', 'PTN', 87, 18, 1, 31.5, 115, 6, NULL),
(2302, 'EBT 17.0 2P 282', 'EBT 17.0gsm 2p 279w 124d 1s', 'EBT', 73, 17, 2, 279, 124, 1, NULL),
(2303, 'EBT 17.0 2P 282', 'EBT 17.0gsm 2p 279w 148d 1s', 'EBT', 73, 17, 2, 279, 148, 1, NULL),
(2304, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 110d 2s', 'PTN', 87, 15, 3, 33, 110, 2, NULL),
(2305, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 110d 42s', 'PTN', 87, 15, 3, 33, 110, 42, NULL),
(2306, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 110d 4s', 'PFT', 87, 14, 3, 20, 110, 4, NULL),
(2307, 'PBTs 15.5 1P 288', 'PBT 18.0gsm 1p 288w 150d 1s', 'PBT', 87, 18, 1, 288, 150, 1, NULL),
(2308, 'EBT 17.0 2P 282', 'EBT 17.0gsm 2p 279w 109d 1s', 'EBT', 73, 17, 2, 279, 109, 1, NULL),
(2309, 'EBT 17.0 2P 282', 'EBT 17.0gsm 2p 279w 102d 1s', 'EBT', 73, 17, 2, 279, 102, 1, NULL),
(2310, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 115d 12s', 'PFT', 87, 14, 3, 20, 115, 12, NULL),
(2311, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 115d 14s', 'PFT', 87, 14, 3, 20, 115, 14, NULL),
(2312, 'PFT 14.0 3P 20', 'PFT 14.5gsm 3p 20w 110d 7s', 'PFT', 87, 14.5, 3, 20, 110, 7, NULL),
(2313, 'PFT 14.0 3P 20', 'PFT 14.5gsm 3p 20w 110d 6s', 'PFT', 87, 14.5, 3, 20, 110, 6, NULL),
(2314, 'PFT 14.0 2P 42', 'PFT 14.0gsm 3p 20w 110d 6s', 'PFT', 87, 14, 3, 20, 110, 6, NULL),
(2315, 'PFT 14.5 2P 100', 'PFT 14.0gsm 2p 100w 112d 2s', 'PFT', 87, 14, 2, 100, 112, 2, NULL),
(2316, 'PFT 14.5 2P 80', 'PFT 14.0gsm 2p 80w 112d 2s', 'PFT', 87, 14, 2, 80, 112, 2, NULL),
(2317, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 110d 12s', 'PFT', 87, 14, 3, 20, 110, 12, NULL),
(2318, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 110d 7s', 'PTN', 87, 18, 1, 31.5, 110, 7, NULL),
(2319, 'PTN 17.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 100d 7s', 'PTN', 87, 18, 1, 31.5, 100, 7, NULL),
(2320, 'PTN 17.0 1P 33', 'PTN 19.0gsm 1p 33w 115d 3s', 'PTN', 87, 19, 1, 33, 115, 3, NULL),
(2321, 'PFT 14.5 2P 80', 'PFT 15.5gsm 2p 82w 110d 3s', 'PFT', 87, 15.5, 2, 82, 110, 3, NULL),
(2322, 'PFT 14.5 2P 80', 'PFT 15.5gsm 2p 80w 110d 3s', 'PFT', 87, 15.5, 2, 80, 110, 3, NULL),
(2323, 'SBT 16.5 1P 288', 'SBT 17.0gsm 1p 288w 238d 1s', 'SBT', 86, 17, 1, 288, 238, 1, NULL),
(2324, 'PFT 14.5 2P 80', 'PFT 15.5gsm 2p 82w 105d 3s', 'PFT', 87, 15.5, 2, 82, 105, 3, NULL),
(2325, 'SBT 16.5 1P 288', 'SBT 17.0gsm 1p 288w 236d 1s', 'SBT', 86, 17, 1, 288, 236, 1, NULL),
(2326, 'SBT 16.5 2P 288', 'SBT 17.0gsm 2p 288w 176d 1s', 'SBT', 86, 17, 2, 288, 176, 1, NULL),
(2327, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 110w 81d 1s', 'SBT', 86, 16.5, 2, 110, 81, 1, NULL),
(2328, 'PFT 14.0 2P 42', 'PFT 15.5gsm 2p 40w 110d 1s', 'PFT', 87, 15.5, 2, 40, 110, 1, NULL),
(2329, 'SBT 16.5 2P 288', 'SBT 17.0gsm 2p 288w 178d 1s', 'SBT', 86, 17, 2, 288, 178, 1, NULL),
(2330, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 279w 170d 1s', 'SBT', 86, 16.5, 2, 279, 170, 1, NULL),
(2331, 'SBT 16.5 2P 288', 'SBT 17.0gsm 2p 288w 158d 1s', 'SBT', 86, 17, 2, 288, 158, 1, NULL),
(2332, 'SBT 16.5 2P 288', 'SBT 17.0gsm 2p 197w 118d 1s', 'SBT', 86, 17, 2, 197, 118, 1, NULL),
(2333, 'SBT 16.5 2P 288', 'SBT 17.0gsm 2p 288w 174d 1s', 'SBT', 86, 17, 2, 288, 174, 1, NULL),
(2334, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 70d 1s', 'EBT', 73, 16.5, 2, 120, 70, 1, NULL),
(2335, 'STN 17.0 1P 30', 'STN 18.0gsm 1p 30w 115d 57s', 'STN', 86, 18, 1, 30, 115, 57, NULL),
(2336, 'PBT 16.5 2P 140', 'PBT 18.0gsm 2p 140w 115d 1s', 'PBT', 87, 18, 2, 140, 115, 1, NULL),
(2337, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 110d 4s', 'SBT', 86, 17, 2, 256, 110, 4, NULL),
(2338, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 139d 1s', 'SBT', 86, 16.5, 1, 288, 139, 1, NULL),
(2339, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 100d 2s', 'SBT', 84, 16.5, 2, 164, 100, 2, NULL),
(2340, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 115d 2s', 'SBT', 84, 17, 2, 130, 115, 2, NULL),
(2341, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 100d 2s', 'SBT', 84, 18, 2, 142, 100, 2, NULL),
(2342, 'EBT 16.5 2P 160', 'EBT 16.5gsm 2p 160w 100d 2s', 'EBT', 75, 16.5, 2, 160, 100, 2, NULL),
(2343, 'EBT 16.5 2P 160', 'EBT 16.5gsm 2p 160w 100d 1s', 'EBT', 75, 16.5, 2, 160, 100, 1, NULL),
(2344, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 115d 9s', 'PTN', 87, 19, 1, 30, 115, 9, NULL),
(2345, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 115d 9s', 'STN', 86, 18, 1, 30, 115, 9, NULL),
(2346, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 115d 8s', 'STN', 86, 18, 1, 30, 115, 8, NULL),
(2347, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 88d 1s', 'SBT', 84, 16.5, 2, 120, 88, 1, NULL),
(2348, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 88d 1s', 'SBT', 84, 16.5, 2, 164, 88, 1, NULL),
(2349, 'SBT 17.0 2P 25', 'SBT 17.0gsm 2p 25w 115d 4s', 'SBT', 84, 17, 2, 25, 115, 4, NULL),
(2350, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 105d 1s', 'EBT', 75, 17, 2, 279, 105, 1, NULL),
(2351, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 112d 2s', 'SFT', 86, 15.5, 2, 90, 112, 2, NULL),
(2352, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 160d 1s', 'EBT', 75, 17, 2, 279, 160, 1, NULL),
(2353, 'EBT 17.0 2P 140', 'EBT 17.0gsm 2p 190w 140d 1s', 'EBT', 75, 17, 2, 190, 140, 1, NULL),
(2354, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 100w 110d 2s', 'SFT', 86, 15.5, 2, 100, 110, 2, NULL),
(2355, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 100d 2s', 'SBT', 84, 16.5, 2, 120, 100, 2, NULL),
(2356, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 115d 4s', 'EBT', 73, 15.5, 3, 254, 115, 4, NULL),
(2357, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 70d 2s', 'PTN', 82, 18, 1, 33, 70, 2, NULL),
(2358, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 242d 1s', 'EBT', 75, 17, 1, 288, 242, 1, NULL),
(2359, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 220d 1s', 'EBT', 75, 17, 1, 288, 220, 1, NULL),
(2360, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 102d 1s', 'EBT', 73, 16.5, 2, 140, 102, 1, NULL),
(2361, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 105d 3s', 'STN', 86, 18, 1, 30, 105, 3, NULL),
(2362, 'EBT 16.5 2P 160', 'EBT 16.5gsm 2p 160w 90d 1s', 'EBT', 75, 16.5, 2, 160, 90, 1, NULL),
(2363, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 104d 4s', 'STN', 86, 18, 1, 30, 104, 4, NULL),
(2364, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 120w 108d 1s', 'EBT', 75, 17, 2, 120, 108, 1, NULL),
(2365, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 236d 1s', 'PBTS', 84, 17, 1, 288, 236, 1, NULL),
(2366, 'PFT 14.5 3P 22', 'PFT 14.5gsm 3p 22w 115d 7s', 'PFT', 85, 14.5, 3, 22, 115, 7, NULL),
(2367, 'PFT 14.5 3P 22', 'PFT 14.5gsm 3p 22w 115d 6s', 'PFT', 85, 14.5, 3, 22, 115, 6, NULL),
(2368, 'PFT 14.5 3P 22', 'PFT 14.5gsm 3p 22w 115d 16s', 'PFT', 85, 14.5, 3, 22, 115, 16, NULL),
(2369, 'PFT 14.5 3P 22', 'PFT 14.5gsm 3p 22w 115d 17s', 'PFT', 85, 14.5, 3, 22, 115, 17, NULL),
(2370, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 115d 3s', 'PFT', 87, 14.5, 2, 76, 115, 3, NULL),
(2371, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 115d 4s', 'PFT', 87, 14.5, 2, 57, 115, 4, NULL),
(2372, 'PFT 13.5 3P 19', 'PFT 13.5gsm 3p 19w 105d 1s', 'PFT', 85, 13.5, 3, 19, 105, 1, NULL),
(2373, 'PFT 14.5 3P 19', 'PFT 13.5gsm 3p 19w 115d 1s', 'PFT', 85, 13.5, 3, 19, 115, 1, NULL),
(2374, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 120d 4s', 'PFT', 87, 14, 3, 20, 120, 4, NULL),
(2375, 'PFT 13.5 3P 19', 'PFT 13.5gsm 3p 19w 115d 7s', 'PFT', 85, 13.5, 3, 19, 115, 7, NULL),
(2376, 'PFT 13.5 3P 19', 'PFT 13.5gsm 3p 19w 115d 2s', 'PFT', 85, 13.5, 3, 19, 115, 2, NULL),
(2377, 'PFT 13.5 3P 19', 'PFT 13.5gsm 3p 19w 115d 6s', 'PFT', 85, 13.5, 3, 19, 115, 6, NULL),
(2378, 'PFT 14.5 2P 80', 'PFT 14.5gsm 2p 80w 110d 1s', 'PFT', 87, 14.5, 2, 80, 110, 1, NULL),
(2379, 'SBT 15.5 2P 100', 'SBT 15.5gsm 2p 100w 110d 1s', 'SBT', 86, 15.5, 2, 100, 110, 1, NULL),
(2380, 'SBT 15.5 2P 100', 'SBT 15.5gsm 2p 100w 100d 2s', 'SBT', 86, 15.5, 2, 100, 100, 2, NULL),
(2381, 'EBT 15.5 3P 256', 'EBT 15.5gsm 3p 256w 104d 1s', 'EBT', 72, 15.5, 3, 256, 104, 1, NULL),
(2382, 'EBT 15.5 3P 256', 'EBT 15.5gsm 3p 256w 100d 2s', 'EBT', 72, 15.5, 3, 256, 100, 2, NULL),
(2383, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 160w 90d 1s', 'SBT', 84, 16.5, 2, 160, 90, 1, NULL),
(2384, 'STN 18.0 1P 33', 'STN 19.0gsm 1p 33w 115d 3s', 'STN', 86, 19, 1, 33, 115, 3, NULL),
(2385, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 107d 4s', 'STN', 86, 18, 1, 30, 107, 4, NULL),
(2386, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 107d 4s', 'STN', 86, 18, 1, 33, 107, 4, NULL),
(2387, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 100d 1s', 'PBT', 87, 17, 2, 288, 100, 1, NULL),
(2388, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 115d 5s', 'STN', 86, 19, 1, 32.5, 115, 5, NULL),
(2389, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 100d 5s', 'STN', 86, 19, 1, 32.5, 100, 5, NULL),
(2390, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 100d 4s', 'STN', 86, 19, 1, 32.5, 100, 4, NULL),
(2391, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 110d 5s', 'STN', 86, 19, 1, 32.5, 110, 5, NULL),
(2392, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 112d 5s', 'STN', 86, 19, 1, 32.5, 112, 5, NULL),
(2393, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 105d 5s', 'STN', 86, 19, 1, 32.5, 105, 5, NULL),
(2394, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 105d 3s', 'STN', 87, 19, 1, 30, 105, 3, NULL),
(2395, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 100d 3s', 'STN', 87, 19, 1, 30, 100, 3, NULL),
(2396, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 90d 1s', 'PBT', 87, 16.5, 2, 140, 90, 1, NULL),
(2397, 'STN 17.0 2P 30', 'STN 17.0gsm 2p 30w 110d 4s', 'STN', 86, 17, 2, 30, 110, 4, NULL),
(2398, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 100d 2s', 'STN', 86, 18, 1, 33, 100, 2, NULL),
(2399, 'STN 17.0 2P 30', 'STN 17.0gsm 2p 30w 110d 3s', 'STN', 86, 17, 2, 30, 110, 3, NULL),
(2400, 'PFT 14.5 2P 100', 'PFT 14.5gsm 2p 100w 110d 1s', 'PFT', 87, 14.5, 2, 100, 110, 1, NULL),
(2401, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 220w 130d 1s', 'SBT', 84, 17, 2, 220, 130, 1, NULL),
(2402, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 148d 1s', 'PBT', 87, 17, 2, 288, 148, 1, NULL),
(2403, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 115d 6s', 'PTN', 86, 20, 1, 33, 115, 6, NULL),
(2404, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 103d 4s', 'PTN', 86, 20, 1, 33, 103, 4, NULL),
(2405, 'SBT 17.0 2P 142', 'SBT 17.0gsm 2p 142w 115d 1s', 'SBT', 87, 17, 2, 142, 115, 1, NULL),
(2406, 'PBT 16.5 2P 140', 'PBT 17.0gsm 2p 140w 115d 1s', 'PBT', 87, 17, 2, 140, 115, 1, NULL),
(2407, 'SBT 17.0 2P 142', 'SBT 17.0gsm 2p 100w 107d 1s', 'SBT', 87, 17, 2, 100, 107, 1, NULL),
(2408, 'SBT 17.0 2P 142', 'SBT 17.0gsm 2p 142w 107d 1s', 'SBT', 86, 17, 2, 142, 107, 1, NULL),
(2409, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 107d 4s', 'PTN', 86, 20, 1, 33, 107, 4, NULL),
(2410, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 106d 4s', 'PTN', 86, 20, 1, 33, 106, 4, NULL),
(2411, 'STN 18.0 1P 33', 'STN 19.0gsm 1p 33w 115d 2s', 'STN', 86, 19, 1, 33, 115, 2, NULL),
(2412, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 100d 4s', 'PTN', 87, 19, 1, 30, 100, 4, NULL),
(2413, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 80d 5s', 'PTN', 87, 19, 1, 30, 80, 5, NULL),
(2414, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 80d 3s', 'PTN', 82, 18, 1, 33, 80, 3, NULL),
(2415, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 104d 6s', 'PTN', 87, 19, 1, 30, 104, 6, NULL),
(2416, 'PTN 18.0 1P 33', 'PTN 19.0gsm 1p 33w 104d 3s', 'PTN', 82, 19, 1, 33, 104, 3, NULL),
(2417, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 100d 3s', 'PTN', 87, 19, 1, 30, 100, 3, NULL),
(2418, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 110d 5s', 'PTN', 87, 17, 1, 33, 110, 5, NULL),
(2419, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 110d 2s', 'PTN', 87, 19, 1, 30, 110, 2, NULL),
(2420, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 115d 7s', 'SFT', 86, 15.5, 2, 90, 115, 7, NULL),
(2421, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 110w 85d 1s', 'EBT', 73, 16.5, 2, 110, 85, 1, NULL),
(2422, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 80d 6s', 'PTN', 82, 18, 1, 31.5, 80, 6, NULL),
(2423, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 87d 4s', 'PTN', 82, 18, 1, 33, 87, 4, NULL),
(2424, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 50d 6s', 'PTN', 82, 18, 1, 33, 50, 6, NULL),
(2425, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 100d 6s', 'PTN', 82, 18, 1, 31.5, 100, 6, NULL),
(2426, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 74d 1s', 'EBT', 73, 16.5, 2, 164, 74, 1, NULL),
(2427, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 238d 1s', 'PBTS', 84, 17, 1, 288, 238, 1, NULL),
(2428, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 134d 1s', 'PBT', 87, 17, 2, 288, 134, 1, NULL),
(2429, 'SBT 16.5 2P 288', 'SBT 16.5gsm 3p 288w 150d 1s', 'SBT', 86, 16.5, 3, 288, 150, 1, NULL),
(2430, 'SBT 17.0 2P 288', 'SBT 15.5gsm 2p 288w 120d 1s', 'SBT', 84, 15.5, 2, 288, 120, 1, NULL),
(2431, 'SBT 16.5 2P 120', 'SBT 15.5gsm 2p 288w 120d 2s', 'SBT', 84, 15.5, 2, 288, 120, 2, NULL),
(2432, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 124d 1s', 'PBT', 87, 17, 2, 288, 124, 1, NULL),
(2433, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 130d 1s', 'PBTS', 84, 17, 1, 288, 130, 1, NULL),
(2434, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 245d 1s', 'EBT', 75, 17, 1, 288, 245, 1, NULL),
(2435, 'EBT 15.5 3P 256', 'EBT 15.5gsm 3p 256w 108d 1s', 'EBT', 72, 15.5, 3, 256, 108, 1, NULL),
(2436, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 70w 85d 1s', 'EBT', 73, 16.5, 2, 70, 85, 1, NULL),
(2437, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 115d 1s', 'EBT', 73, 16.5, 2, 120, 115, 1, NULL),
(2438, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 115d 1s', 'EBT', 73, 16.5, 2, 164, 115, 1, NULL),
(2439, 'EBT 15.0 3P 130', 'EBT 15.0gsm 3p 130w 110d 1s', 'EBT', 72, 15, 3, 130, 110, 1, NULL),
(2440, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 135d 1s', 'SBT', 84, 16.5, 2, 120, 135, 1, NULL),
(2441, 'SBT 16.5 1P 288', 'SBT 16.5gsm 1p 288w 125d 1s', 'SBT', 86, 16.5, 1, 288, 125, 1, NULL),
(2442, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 113d 4s', 'PTN', 82, 18, 1, 31.5, 113, 4, NULL),
(2443, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 140w 95d 1s', 'EBT', 75, 17, 2, 140, 95, 1, NULL),
(2444, 'EBT 16.5 2P 140', 'EBT 17.0gsm 2p 140w 97d 1s', 'EBT', 75, 17, 2, 140, 97, 1, NULL),
(2445, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 116d 1s', 'EBT', 75, 17, 2, 279, 116, 1, NULL),
(2446, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 80d 3s', 'STN', 86, 18, 1, 33, 80, 3, NULL),
(2447, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 80d 6s', 'STN', 86, 18, 1, 30, 80, 6, NULL),
(2448, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 120d 7s', 'PFT', 87, 14, 3, 20, 120, 7, NULL),
(2449, 'PFT 14.5 3P 22', 'PFT 14.5gsm 3p 22w 110d 6s', 'PFT', 85, 14.5, 3, 22, 110, 6, NULL),
(2450, 'PFT 14.5 3P 22', 'PFT 14.5gsm 3p 22w 110d 7s', 'PFT', 85, 14.5, 3, 22, 110, 7, NULL),
(2451, 'PFT 15.0 2P 126', 'PFT 15.0gsm 3p 20w 110d 7s', 'PFT', 85, 15, 3, 20, 110, 7, NULL),
(2452, 'PKT 22.0 2P 140', 'PKT 22.0gsm 2p 140w 95d 1s', 'PKT', 87, 22, 2, 140, 95, 1, NULL),
(2453, 'SKT 22.0 2P 140', 'SKT 22.0gsm 2p 140w 90d 1s', 'SKT', 86, 22, 2, 140, 90, 1, NULL),
(2454, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 80d 4s', 'PTN', 87, 17, 1, 31.5, 80, 4, NULL),
(2455, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 170w 120d 1s', 'SBT', 84, 17, 2, 170, 120, 1, NULL),
(2456, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 80d 2s', 'STN', 86, 17, 1, 33, 80, 2, NULL),
(2457, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 243d 1s', 'SBT', 84, 17, 1, 288, 243, 1, NULL),
(2458, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 97d 1s', 'SBT', 86, 16.5, 2, 140, 97, 1, NULL),
(2459, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 88d 1s', 'EBT', 73, 16.5, 2, 120, 88, 1, NULL),
(2460, 'SBT 16.5 2P 170', 'SBT 16.5gsm 2p 170w 100d 1s', 'SBT', 83, 16.5, 2, 170, 100, 1, NULL),
(2461, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 110w 90d 1s', 'SBT', 84, 16.5, 2, 110, 90, 1, NULL),
(2462, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 95d 4s', 'STN', 86, 18, 1, 30, 95, 4, NULL),
(2463, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 95d 5s', 'STN', 86, 18, 1, 30, 95, 5, NULL),
(2464, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 93d 4s', 'STN', 86, 18, 1, 30, 93, 4, NULL),
(2465, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 93d 3s', 'STN', 86, 18, 1, 30, 93, 3, NULL),
(2466, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 225d 1s', 'EBT', 75, 17, 1, 288, 225, 1, NULL),
(2467, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 95d 5s', 'PTN', 82, 18, 1, 31.5, 95, 5, NULL),
(2468, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 95d 4s', 'PTN', 82, 18, 1, 31.5, 95, 4, NULL),
(2469, 'SBT 15.5 2P 262', 'SBT 15.5gsm 2p 262w 112d 1s', 'SBT', 86, 15.5, 2, 262, 112, 1, NULL),
(2470, 'SBT 15.5 2P 25', 'SBT 15.5gsm 2p 25w 115d 3s', 'SBT', 86, 15.5, 2, 25, 115, 3, NULL),
(2471, 'SBT 15.5 2P 30', 'SBT 15.5gsm 2p 30w 110d 4s', 'SBT', 86, 15.5, 2, 30, 110, 4, NULL),
(2472, 'SBT 15.5 2P 30', 'SBT 15.5gsm 2p 30w 110d 3s', 'SBT', 86, 15.5, 2, 30, 110, 3, NULL),
(2473, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 210w 108d 1s', 'EBT', 75, 17, 2, 210, 108, 1, NULL),
(2474, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 95d 1s', 'SBT', 84, 18, 2, 142, 95, 1, NULL),
(2475, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 122d 1s', 'PBT', 87, 17, 2, 288, 122, 1, NULL),
(2476, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 128d 1s', 'PBT', 87, 17, 2, 288, 128, 1, NULL),
(2477, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 33w 115d 1s', 'PTN', 87, 19, 1, 33, 115, 1, NULL),
(2478, 'PTN 17.0 1P 33', 'PTN 19.0gsm 1p 33w 110d 4s', 'PTN', 87, 19, 1, 33, 110, 4, NULL),
(2479, 'PKT 22.0 2P 288', 'PKT 22.0gsm 2p 288w 120d 1s', 'PKT', 87, 22, 2, 288, 120, 1, NULL),
(2480, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 112d 5s', 'PTN', 82, 18, 1, 31.5, 112, 5, NULL),
(2481, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 112d 4s', 'PTN', 82, 18, 1, 31.5, 112, 4, NULL),
(2482, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 33w 80d 4s', 'EBT', 73, 16.5, 2, 33, 80, 4, NULL),
(2483, 'EBT 15.5 3P 256', 'EBT 15.5gsm 3p 120w 103d 1s', 'EBT', 72, 15.5, 3, 120, 103, 1, NULL),
(2484, 'EBT 17.0 2P 140', 'EBT 17.0gsm 2p 140w 85d 1s', 'EBT', 73, 17, 2, 140, 85, 1, NULL),
(2485, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 90d 4s', 'STN', 86, 18, 1, 33, 90, 4, NULL),
(2486, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 100w 99d 1s', 'SBT', 86, 16.5, 2, 100, 99, 1, NULL),
(2487, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 237d 1s', 'EBT', 75, 17, 1, 288, 237, 1, NULL),
(2488, 'EBT 16.5 1P 288', 'EBT 15.5gsm 1p 288w 240d 1s', 'EBT', 72, 15.5, 1, 288, 240, 1, NULL),
(2489, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 80w 100d 1s', 'EBT', 73, 16.5, 2, 80, 100, 1, NULL),
(2490, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 33w 83d 3s', 'EBT', 73, 16.5, 2, 33, 83, 3, NULL),
(2491, 'EBT 15.5 3P 256', 'EBT 15.5gsm 3p 256w 105d 1s', 'EBT', 72, 15.5, 3, 256, 105, 1, NULL),
(2492, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 110d 3s', 'PFT', 87, 14.5, 2, 76, 110, 3, NULL),
(2493, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 88d 1s', 'EBT', 73, 16.5, 2, 164, 88, 1, NULL),
(2494, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 80d 1s', 'EBT', 73, 16.5, 2, 164, 80, 1, NULL),
(2495, 'PTN 17.0 3P 33', 'PTN 15.0gsm 1p 33w 115d 4s', 'PTN', 87, 15, 1, 33, 115, 4, NULL),
(2496, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 86d 1s', 'SBT', 84, 16.5, 2, 120, 86, 1, NULL),
(2497, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 86d 1s', 'SBT', 84, 16.5, 2, 164, 86, 1, NULL),
(2498, 'SKT 22.0 2P 140', 'SKT 22.0gsm 2p 90w 95d 1s', 'SKT', 86, 22, 2, 90, 95, 1, NULL),
(2499, 'SKT 20.0 2P 140', 'SKT 20.0gsm 2p 140w 90d 1s', 'SKT', 84, 20, 2, 140, 90, 1, NULL),
(2500, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 120d 2s', 'SKT', 86, 40, 1, 100, 120, 2, NULL),
(2501, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 115d 2s', 'SKT', 86, 40, 1, 100, 115, 2, NULL),
(2502, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 115d 1s', 'SKT', 86, 40, 1, 100, 115, 1, NULL),
(2503, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 102d 2s', 'SKT', 86, 40, 1, 100, 102, 2, NULL),
(2504, 'SKT 40.0 1P 75', 'SKT 40.0gsm 1p 75w 115d 1s', 'SKT', 86, 40, 1, 75, 115, 1, NULL),
(2505, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 231d 1s', 'PBTS', 84, 17, 1, 288, 231, 1, NULL),
(2506, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 102d 4s', 'PTN', 86, 20, 1, 33, 102, 4, NULL),
(2507, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 112d 4s', 'PTN', 86, 20, 1, 33, 112, 4, NULL),
(2508, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 100d 4s', 'PTN', 86, 20, 1, 33, 100, 4, NULL),
(2509, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 155d 1s', 'PBT', 87, 17, 2, 288, 155, 1, NULL),
(2510, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 160d 1s', 'PBT', 87, 17, 2, 288, 160, 1, NULL),
(2511, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 115d 3s', 'SKT', 86, 40, 1, 100, 115, 3, NULL),
(2512, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 90d 3s', 'PTN', 86, 20, 1, 33, 90, 3, NULL),
(2513, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 115d 2s', 'PTN', 86, 20, 1, 33, 115, 2, NULL),
(2514, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 222w 130d 1s', 'EBT', 73, 16.5, 2, 222, 130, 1, NULL),
(2515, 'EBT 16.5 1P 288', 'EBT 16.5gsm 1p 288w 140d 1s', 'EBT', 73, 16.5, 1, 288, 140, 1, NULL),
(2516, 'EBT 16.5 2P 288', 'EBT 17.0gsm 2p 220w 140d 1s', 'EBT', 73, 17, 2, 220, 140, 1, NULL),
(2517, 'EBT 16.5 2P 288', 'EBT 17.0gsm 2p 183w 108d 1s', 'EBT', 73, 17, 2, 183, 108, 1, NULL),
(2518, 'SBT 16.5 2P 110', 'SBT 16.5gsm 2p 110w 87d 1s', 'SBT', 83, 16.5, 2, 110, 87, 1, NULL),
(2519, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 108d 1s', 'EBT', 73, 16.5, 2, 120, 108, 1, NULL),
(2520, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 120d 2s', 'SKT', 86, 21, 2, 100, 120, 2, NULL),
(2521, 'SKT 21.0 2P 80', 'SKT 21.0gsm 2p 86w 115d 2s', 'SKT', 86, 21, 2, 86, 115, 2, NULL),
(2522, 'SKT 21.0 2P 80', 'SKT 21.0gsm 2p 86w 110d 2s', 'SKT', 86, 21, 2, 86, 110, 2, NULL),
(2523, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 125d 1s', 'SBT', 84, 17, 2, 288, 125, 1, NULL),
(2524, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 115d 5s', 'PTN', 87, 15, 3, 33, 115, 5, NULL),
(2525, 'PFT 14.5 2P 100', 'PFT 14.5gsm 2p 100w 115d 1s', 'PFT', 87, 14.5, 2, 100, 115, 1, NULL),
(2526, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 282w 143d 1s', 'SBT', 86, 16.5, 2, 282, 143, 1, NULL),
(2527, 'PFT 14.5 2P 80', 'PFT 14.5gsm 2p 80w 100d 1s', 'PFT', 87, 14.5, 2, 80, 100, 1, NULL),
(2528, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 120d 3s', 'PTN', 87, 15, 3, 33, 120, 3, NULL),
(2529, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 247w 100d 1s', 'SBT', 86, 16.5, 2, 247, 100, 1, NULL),
(2530, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 100d 4s', 'PTN', 87, 15, 3, 33, 100, 4, NULL),
(2531, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 118d 5s', 'STN', 86, 18, 1, 30, 118, 5, NULL),
(2532, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 118d 4s', 'STN', 84, 18, 1, 30, 118, 4, NULL),
(2533, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 135d 1s', 'PBT', 87, 17, 2, 288, 135, 1, NULL),
(2534, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 288w 138d 1s', 'PBT', 87, 17, 2, 288, 138, 1, NULL),
(2535, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 115d 6s', 'PTN', 87, 19, 1, 33, 115, 6, NULL),
(2536, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 100d 6s', 'PTN', 87, 19, 1, 33, 100, 6, NULL),
(2537, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 80d 3s', 'PTN', 87, 19, 1, 30, 80, 3, NULL),
(2538, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 80d 6s', 'PTN', 87, 19, 1, 33, 80, 6, NULL),
(2539, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 164d 1s', 'SBT', 84, 17, 2, 288, 164, 1, NULL),
(2540, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 83d 1s', 'PFT', 87, 14, 2, 80, 83, 1, NULL),
(2541, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 90d 2s', 'SBT', 84, 16.5, 2, 164, 90, 2, NULL),
(2542, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 230w 100d 1s', 'EBT', 75, 17, 2, 230, 100, 1, NULL),
(2543, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 108d 4s', 'STN', 86, 18, 1, 30, 108, 4, NULL),
(2544, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 150d 1s', 'EBT', 75, 17, 1, 288, 150, 1, NULL),
(2545, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 115d 2s', 'PTN', 82, 18, 1, 33, 115, 2, NULL),
(2546, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 120d 1s', 'EBT', 75, 17, 1, 288, 120, 1, NULL),
(2547, 'EBT 16.5 2P 257', 'EBT 17.0gsm 2p 257w 150d 1s', 'EBT', 75, 17, 2, 257, 150, 1, NULL),
(2548, 'SKT 20.0 2P 132', 'SKT 20.0gsm 2p 132w 112d 1s', 'SKT', 84, 20, 2, 132, 112, 1, NULL),
(2549, 'SFT 14.5 2P 80', 'SFT 14.5gsm 2p 80w 102d 1s', 'SFT', 86, 14.5, 2, 80, 102, 1, NULL),
(2550, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 245w 90d 1s', 'SBT', 86, 16.5, 2, 245, 90, 1, NULL),
(2551, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 90w 90d 1s', 'EBT', 73, 16.5, 2, 90, 90, 1, NULL),
(2552, 'EBT 16.5 1P 288', 'EBT 17.0gsm 1p 288w 248d 1s', 'EBT', 73, 17, 1, 288, 248, 1, NULL),
(2553, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 246d 1s', 'EBT', 75, 17, 1, 288, 246, 1, NULL),
(2554, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 79d 1s', 'EBT', 73, 16.5, 2, 120, 79, 1, NULL),
(2555, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 245d 1s', 'SBT', 84, 17, 1, 288, 245, 1, NULL),
(2556, 'SFT 14.5 2P 100', 'SFT 14.5gsm 2p 100w 80d 1s', 'SFT', 86, 14.5, 2, 100, 80, 1, NULL),
(2557, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 84d 1s', 'EBT', 73, 16.5, 2, 120, 84, 1, NULL),
(2558, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 84d 1s', 'EBT', 73, 16.5, 2, 164, 84, 1, NULL),
(2559, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 102d 1s', 'EBT', 73, 16.5, 2, 120, 102, 1, NULL),
(2560, 'SBT 15.5 2P 80', 'SBT 16.5gsm 2p 90w 115d 1s', 'SBT', 86, 16.5, 2, 90, 115, 1, NULL),
(2561, 'SBT 17.0 2P 142', 'SBT 17.0gsm 2p 90w 100d 1s', 'SBT', 86, 17, 2, 90, 100, 1, NULL),
(2562, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 30w 75d 5s', 'EBT', 73, 16.5, 2, 30, 75, 5, NULL),
(2563, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 235d 1s', 'PBTS', 84, 17, 1, 288, 235, 1, NULL),
(2564, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 239d 1s', 'PBTS', 84, 17, 1, 288, 239, 1, NULL),
(2565, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 237d 1s', 'PBTS', 84, 17, 1, 288, 237, 1, NULL),
(2566, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 95w 100d 1s', 'EBT', 73, 16.5, 2, 95, 100, 1, NULL),
(2567, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 224w 122d 1s', 'SBT', 84, 17, 2, 224, 122, 1, NULL),
(2568, 'PBT 16.5 2P 275', 'PBT 16.5gsm 2p 275w 120d 1s', 'PBT', 87, 16.5, 2, 275, 120, 1, NULL),
(2569, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 200w 120d 1s', 'PBT', 87, 17, 2, 200, 120, 1, NULL),
(2570, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 203d 1s', 'PBTS', 84, 17, 1, 288, 203, 1, NULL),
(2571, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 92d 5s', 'STN', 86, 18, 1, 30, 92, 5, NULL),
(2572, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 92d 3s', 'STN', 86, 18, 1, 30, 92, 3, NULL),
(2573, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 209d 1s', 'PBTS', 84, 17, 1, 288, 209, 1, NULL),
(2574, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 92d 4s', 'STN', 86, 18, 1, 30, 92, 4, NULL),
(2575, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 110d 4s', 'PTN', 87, 19, 1, 32.5, 110, 4, NULL),
(2576, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 100d 4s', 'PTN', 87, 19, 1, 32.5, 100, 4, NULL),
(2577, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 100d 2s', 'PTN', 87, 19, 1, 33, 100, 2, NULL),
(2578, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 105d 3s', 'PTN', 87, 19, 1, 30, 105, 3, NULL),
(2579, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 105d 2s', 'PTN', 87, 19, 1, 33, 105, 2, NULL),
(2580, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 110d 3s', 'PTN', 87, 19, 1, 30, 110, 3, NULL),
(2581, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 75d 4s', 'PTN', 82, 18, 1, 33, 75, 4, NULL),
(2582, 'PTN 17.0 1P 66', 'PTN 17.0gsm 2p 66w 115d 2s', 'PTN', 85, 17, 2, 66, 115, 2, NULL),
(2583, 'PTN 17.0 1P 66', 'PTN 17.0gsm 1p 66w 115d 1s', 'PTN', 85, 17, 1, 66, 115, 1, NULL),
(2584, 'PTN 17.0 1P 66', 'PTN 17.0gsm 1p 66w 110d 2s', 'PTN', 85, 17, 1, 66, 110, 2, NULL),
(2585, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 98d 4s', 'PTN', 82, 18, 1, 33, 98, 4, NULL),
(2586, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 30w 110d 3s', 'PTN', 82, 18, 1, 30, 110, 3, NULL),
(2587, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 30w 86d 3s', 'PTN', 82, 18, 1, 30, 86, 3, NULL),
(2588, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 86d 4s', 'PTN', 82, 18, 1, 33, 86, 4, NULL),
(2589, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 110d 3s', 'PTN', 82, 18, 1, 33, 110, 3, NULL),
(2590, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 84d 6s', 'PFT', 87, 15, 3, 21, 84, 6, NULL),
(2591, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 82d 6s', 'PFT', 87, 15, 3, 21, 82, 6, NULL),
(2592, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 80d 4s', 'PFT', 87, 15, 3, 21, 80, 4, NULL),
(2593, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 107d 6s', 'PFT', 87, 15.3, 3, 21, 107, 6, NULL),
(2594, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 115d 4s', 'PFT', 87, 15.3, 3, 21, 115, 4, NULL),
(2595, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 235d 1s', 'SBT', 84, 17, 1, 288, 235, 1, NULL),
(2596, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 83w 87d 1s', 'EBT', 73, 16.5, 2, 83, 87, 1, NULL),
(2597, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 75w 90d 1s', 'EBT', 73, 16.5, 2, 75, 90, 1, NULL),
(2598, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 82w 90d 1s', 'EBT', 73, 16.5, 2, 82, 90, 1, NULL),
(2599, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 87w 78d 1s', 'EBT', 73, 16.5, 2, 87, 78, 1, NULL),
(2600, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 230d 1s', 'SBT', 84, 17, 1, 288, 230, 1, NULL),
(2601, 'PFT 14.5 2P 76', 'PFT 14.5gsm 2p 76w 112d 3s', 'PFT', 87, 14.5, 2, 76, 112, 3, NULL),
(2602, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 112d 4s', 'PFT', 85, 14.5, 2, 57, 112, 4, NULL),
(2603, 'SBT 16.5 2P 130', 'SBT 16.5gsm 2p 130w 110d 1s', 'SBT', 86, 16.5, 2, 130, 110, 1, NULL),
(2604, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 70d 1s', 'SBT', 86, 16.5, 2, 140, 70, 1, NULL),
(2605, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 75w 60d 1s', 'SBT', 84, 16.5, 2, 75, 60, 1, NULL),
(2606, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 70w 87d 1s', 'SBT', 84, 16.5, 2, 70, 87, 1, NULL),
(2607, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 102d 6s', 'PFT', 87, 15.3, 3, 21, 102, 6, NULL),
(2608, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 100d 6s', 'PFT', 87, 15.3, 3, 21, 100, 6, NULL),
(2609, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 103d 6s', 'PFT', 87, 15.3, 3, 21, 103, 6, NULL),
(2610, 'PFT 13.5 3P 19', 'PFT 14.5gsm 3p 19w 115d 7s', 'PFT', 85, 14.5, 3, 19, 115, 7, NULL),
(2611, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 112d 6s', 'PFT', 87, 15.3, 3, 21, 112, 6, NULL),
(2612, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 112d 5s', 'PFT', 87, 15.3, 3, 21, 112, 5, NULL),
(2613, 'PFT 13.5 4P 19', 'PFT 13.5gsm 4p 19w 112d 7s', 'PFT', 85, 13.5, 4, 19, 112, 7, NULL),
(2614, 'PFT 13.5 4P 19', 'PFT 13.5gsm 4p 19w 110d 7s', 'PFT', 85, 13.5, 4, 19, 110, 7, NULL),
(2615, 'PFT 14.5 2P 100', 'PFT 14.5gsm 2p 100w 100d 2s', 'PFT', 87, 14.5, 2, 100, 100, 2, NULL),
(2616, 'PFT 14.5 2P 80', 'PFT 14.5gsm 2p 80w 100d 2s', 'PFT', 87, 14.5, 2, 80, 100, 2, NULL),
(2617, 'PBT 17.0 1P 288', 'PBT 17.0gsm 1p 288w 240d 1s', 'PBT', 84, 17, 1, 288, 240, 1, NULL),
(2618, 'SKT 22.0 1P 288', 'SKT 22.0gsm 2p 288w 120d 1s', 'SKT', 86, 22, 2, 288, 120, 1, NULL),
(2619, 'SKT 22.0 1P 288', 'SKT 22.0gsm 2p 288w 100d 1s', 'SKT', 86, 22, 2, 288, 100, 1, NULL),
(2620, 'SKT 22.0 1P 288', 'SKT 22.0gsm 2p 288w 90d 1s', 'SKT', 86, 22, 2, 288, 90, 1, NULL),
(2621, 'PFT 13.5 4P 19', 'PFT 13.5gsm 4p 19w 112d 8s', 'PFT', 85, 13.5, 4, 19, 112, 8, NULL),
(2622, 'EBT 15.0 1P 256', 'EBT 15.0gsm 1p 256w 110d 1s', 'EBT', 75, 15, 1, 256, 110, 1, NULL),
(2623, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 106d 1s', 'EBT', 73, 16.5, 2, 164, 106, 1, NULL),
(2624, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 112d 1s', 'EBT', 73, 16.5, 2, 120, 112, 1, NULL),
(2625, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 112d 1s', 'EBT', 73, 16.5, 2, 164, 112, 1, NULL),
(2626, 'EBT 15.0 3P 130', 'EBT 15.0gsm 3p 130w 112d 1s', 'EBT', 72, 15, 3, 130, 112, 1, NULL),
(2627, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 92d 1s', 'EBT', 73, 16.5, 2, 164, 92, 1, NULL),
(2628, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 80d 1s', 'EBT', 75, 17, 2, 279, 80, 1, NULL),
(2629, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 113d 1s', 'SBT', 84, 18, 2, 142, 113, 1, NULL),
(2630, 'SBT 18.0 2P 132', 'SBT 18.0gsm 2p 132w 105d 1s', 'SBT', 86, 18, 2, 132, 105, 1, NULL),
(2631, 'PFT 13.5 4P 19', 'PFT 13.5gsm 4p 19w 110d 6s', 'PFT', 85, 13.5, 4, 19, 110, 6, NULL),
(2632, 'PFT 13.5 4P 19', 'PFT 14.5gsm 3p 19w 112d 1s', 'PFT', 85, 14.5, 3, 19, 112, 1, NULL),
(2633, 'PFT 13.5 3P 19', 'PFT 14.5gsm 3p 19w 112d 2s', 'PFT', 85, 14.5, 3, 19, 112, 2, NULL),
(2634, 'PFT 13.5 3P 19', 'PFT 14.5gsm 3p 19w 98d 2s', 'PFT', 85, 14.5, 3, 19, 98, 2, NULL),
(2635, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 110d 4s', 'PFT', 85, 14.5, 2, 57, 110, 4, NULL),
(2636, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 111d 2s', 'PFT', 87, 14, 2, 100, 111, 2, NULL),
(2637, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 225d 1s', 'PBTS', 84, 17, 1, 288, 225, 1, NULL),
(2638, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 112d 3s', 'PFT', 85, 14.5, 2, 57, 112, 3, NULL),
(2639, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 282w 160d 1s', 'SBT', 84, 17, 2, 282, 160, 1, NULL),
(2640, 'SBT 14.5 3P 182', 'SBT 14.5gsm 3p 182w 112d 1s', 'SBT', 86, 14.5, 3, 182, 112, 1, NULL),
(2641, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 82d 1s', 'SBT', 86, 16.5, 2, 140, 82, 1, NULL),
(2642, 'SKT 20.0 2P 132', 'SKT 20.0gsm 2p 132w 111d 1s', 'SKT', 84, 20, 2, 132, 111, 1, NULL),
(2643, 'SKT 20.0 2P 132', 'SKT 20.0gsm 2p 132w 2d 1s', 'SKT', 84, 20, 2, 132, 2, 1, NULL),
(2644, 'SKT 20.0 2P 132', 'SKT 20.0gsm 2p 132w 105d 1s', 'SKT', 84, 20, 2, 132, 105, 1, NULL),
(2645, 'SKT 20.0 2P 132', 'SKT 20.0gsm 2p 132w 95d 1s', 'SKT', 84, 20, 2, 132, 95, 1, NULL),
(2646, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 288w 120d 1s', 'SKT', 86, 21, 2, 288, 120, 1, NULL),
(2647, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 79d 1s', 'EBT', 73, 16.5, 2, 140, 79, 1, NULL),
(2648, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 85d 5s', 'STN', 86, 18, 1, 30, 85, 5, NULL),
(2649, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 85d 4s', 'STN', 86, 18, 1, 30, 85, 4, NULL),
(2650, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 75d 4s', 'STN', 86, 18, 1, 30, 75, 4, NULL),
(2651, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 70d 4s', 'STN', 86, 18, 1, 30, 70, 4, NULL),
(2652, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 90w 100d 1s', 'PBT', 87, 16.5, 2, 90, 100, 1, NULL),
(2653, 'PBT 16.5 2P 288', 'PBT 17.0gsm 2p 220w 92d 1s', 'PBT', 87, 17, 2, 220, 92, 1, NULL),
(2654, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 100w 110d 2s', 'PBT', 87, 17, 2, 100, 110, 2, NULL),
(2655, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 242w 120d 1s', 'PBT', 87, 17, 2, 242, 120, 1, NULL),
(2656, 'SBT 17.5 2P 95', 'SBT 17.5gsm 2p 95w 105d 1s', 'SBT', 86, 17.5, 2, 95, 105, 1, NULL),
(2657, 'SBT 17.5 2P 165', 'SBT 17.5gsm 2p 165w 105d 1s', 'SBT', 86, 17.5, 2, 165, 105, 1, NULL),
(2658, 'PBTb 15.5 1P 288', 'PBT 15.5gsm 1p 288w 250d 1s', 'PBT', 87, 15.5, 1, 288, 250, 1, NULL),
(2659, 'SBT 16.5 3P 132', 'SBT 16.5gsm 3p 132w 105d 1s', 'SBT', 86, 16.5, 3, 132, 105, 1, NULL),
(2660, 'SBT 16.5 3P 132', 'SBT 16.5gsm 3p 132w 108d 1s', 'SBT', 86, 16.5, 3, 132, 108, 1, NULL),
(2661, 'SKT 22.0 1P 288', 'SKT 22.0gsm 2p 288w 115d 1s', 'SKT', 86, 22, 2, 288, 115, 1, NULL),
(2662, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 220w 125d 1s', 'PBT', 87, 17, 2, 220, 125, 1, NULL),
(2663, 'PBTb 15.5 1P 288', 'PBT 17.0gsm 1p 288w 180d 1s', 'PBT', 87, 17, 1, 288, 180, 1, NULL),
(2664, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 82d 1s', 'SBT', 84, 18, 2, 142, 82, 1, NULL),
(2665, 'EBT 16.5 2P 160', 'EBT 16.5gsm 2p 150w 100d 1s', 'EBT', 75, 16.5, 2, 150, 100, 1, NULL),
(2666, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 112d 5s', 'PTN', 87, 19, 1, 32.5, 112, 5, NULL),
(2667, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 112d 4s', 'PTN', 87, 19, 1, 32.5, 112, 4, NULL),
(2668, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 100d 4s', 'PTN', 87, 19, 1, 33, 100, 4, NULL),
(2669, 'STN 17.0 2P 30', 'STN 17.0gsm 2p 31.5w 110d 4s', 'STN', 86, 17, 2, 31.5, 110, 4, NULL),
(2670, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 233d 1s', 'PBTS', 84, 17, 1, 288, 233, 1, NULL),
(2671, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 228d 1s', 'PBTS', 84, 17, 1, 288, 228, 1, NULL),
(2672, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 230d 1s', 'PBTS', 84, 17, 1, 288, 230, 1, NULL),
(2673, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 234d 1s', 'PBTS', 84, 17, 1, 288, 234, 1, NULL),
(2674, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 70d 3s', 'STN', 86, 17, 1, 30, 70, 3, NULL),
(2675, 'STN 17.0 1P 33', 'STN 17.0gsm 1p 33w 70d 3s', 'STN', 86, 17, 1, 33, 70, 3, NULL),
(2676, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 80w 100d 1s', 'SBT', 86, 16.5, 2, 80, 100, 1, NULL),
(2677, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 100w 100d 1s', 'SBT', 86, 16.5, 2, 100, 100, 1, NULL),
(2678, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 80d 6s', 'STN', 86, 17, 1, 30, 80, 6, NULL),
(2679, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 150d 2s', 'PFT', 87, 14, 2, 100, 150, 2, NULL),
(2680, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 111d 2s', 'PFT', 87, 14, 2, 80, 111, 2, NULL),
(2681, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 224d 1s', 'EBT', 75, 17, 2, 288, 224, 1, NULL),
(2682, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 84w 100d 1s', 'EBT', 73, 16.5, 2, 84, 100, 1, NULL),
(2683, 'EBT 19.0 2P 255', 'EBT 19.0gsm 2p 130w 110d 1s', 'EBT', 76, 19, 2, 130, 110, 1, NULL),
(2684, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 228d 1s', 'EBT', 75, 17, 1, 288, 228, 1, NULL),
(2685, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 74w 82d 1s', 'EBT', 73, 16.5, 2, 74, 82, 1, NULL),
(2686, 'EBT 19.0 2P 255', 'EBT 19.0gsm 2p 255w 106d 1s', 'EBT', 76, 19, 2, 255, 106, 1, NULL),
(2687, 'EBT 15.0 2P 30', 'EBT 15.0gsm 2p 30w 110d 5s', 'EBT', 75, 15, 2, 30, 110, 5, NULL),
(2688, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 122d 1s', 'EBT', 75, 17, 2, 288, 122, 1, NULL),
(2689, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 100w 84d 1s', 'EBT', 73, 16.5, 2, 100, 84, 1, NULL),
(2690, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 90w 85d 1s', 'EBT', 73, 16.5, 2, 90, 85, 1, NULL),
(2691, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 87d 1s', 'EBT', 73, 16.5, 2, 140, 87, 1, NULL),
(2692, 'SBT 17.0 2P 30', 'SBT 17.0gsm 2p 30w 110d 5s', 'SBT', 84, 17, 2, 30, 110, 5, NULL),
(2693, 'PBT 17.0 1P 288', 'PBT 17.0gsm 1p 288w 230d 1s', 'PBT', 84, 17, 1, 288, 230, 1, NULL),
(2694, 'EBT 16.5 2P 135', 'EBT 16.5gsm 2p 135w 90d 1s', 'EBT', 73, 16.5, 2, 135, 90, 1, NULL),
(2695, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 135w 92d 1s', 'EBT', 73, 16.5, 2, 135, 92, 1, NULL),
(2696, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 85d 1s', 'EBT', 73, 16.5, 2, 120, 85, 1, NULL),
(2697, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 135w 87d 1s', 'EBT', 73, 16.5, 2, 135, 87, 1, NULL),
(2698, 'EBT 16.5 2P 130', 'EBT 16.5gsm 2p 130w 87d 1s', 'EBT', 73, 16.5, 2, 130, 87, 1, NULL),
(2699, 'EBT 17.0 2P 279', 'EBT 16.5gsm 2p 164w 75d 1s', 'EBT', 75, 16.5, 2, 164, 75, 1, NULL),
(2700, 'PBT 18.0 2P 142', 'PBT 18.0gsm 2p 142w 115d 1s', 'PBT', 87, 18, 2, 142, 115, 1, NULL),
(2701, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 100d 3s', 'STN', 86, 19, 1, 33, 100, 3, NULL),
(2702, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 80d 4s', 'STN', 86, 19, 1, 33, 80, 4, NULL),
(2703, 'PTN 17.0 1P 31.5', 'PTN 17.0gsm 1p 31.5w 60d 2s', 'PTN', 87, 17, 1, 31.5, 60, 2, NULL),
(2704, 'STN 17.0 2P 31.5', 'STN 17.0gsm 2p 31.5w 110d 2s', 'STN', 86, 17, 2, 31.5, 110, 2, NULL),
(2705, 'PTN 17.0 1P 30', 'PTN 18.0gsm 1p 30w 112d 1s', 'PTN', 87, 18, 1, 30, 112, 1, NULL),
(2706, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 232d 1s', 'PBTS', 84, 17, 1, 288, 232, 1, NULL),
(2707, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 1109d 1s', 'EBT', 73, 16.5, 2, 140, 1109, 1, NULL),
(2708, 'SBT 17.0 2P 30', 'SBT 17.0gsm 2p 30w 115d 1s', 'SBT', 84, 17, 2, 30, 115, 1, NULL),
(2709, 'EBT 18.0 2P 120', 'EBT 17.0gsm 2p 120w 90d 1s', 'EBT', 75, 17, 2, 120, 90, 1, NULL),
(2710, 'SBT 17.5 2P 165', 'SBT 17.5gsm 2p 165w 110d 1s', 'SBT', 89, 17.5, 2, 165, 110, 1, NULL),
(2711, 'SBT 17.5 2P 95', 'SBT 17.5gsm 2p 95w 110d 1s', 'SBT', 89, 17.5, 2, 95, 110, 1, NULL),
(2712, 'PBT 17.0 1P 288', 'PBT 17.0gsm 1p 288w 140d 1s', 'PBT', 84, 17, 1, 288, 140, 1, NULL),
(2713, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 233d 1s', 'EBT', 75, 17, 1, 288, 233, 1, NULL),
(2714, 'SBT 14.5 2P 40', 'SBT 14.5gsm 2p 40w 110d 3s', 'SBT', 84, 14.5, 2, 40, 110, 3, NULL),
(2715, 'EBT 17.0 2P 130', 'EBT 16.5gsm 2p 25w 115d 5s', 'EBT', 73, 16.5, 2, 25, 115, 5, NULL),
(2716, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 83w 95d 1s', 'EBT', 73, 16.5, 2, 83, 95, 1, NULL),
(2717, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 73w 62d 1s', 'EBT', 73, 16.5, 2, 73, 62, 1, NULL),
(2718, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 95w 90d 1s', 'EBT', 73, 16.5, 2, 95, 90, 1, NULL),
(2719, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 95w 93d 1s', 'EBT', 73, 16.5, 2, 95, 93, 1, NULL),
(2720, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 90w 75d 1s', 'EBT', 73, 16.5, 2, 90, 75, 1, NULL),
(2721, 'EBT 16.5 2P 257', 'EBT 16.5gsm 2p 262w 115d 1s', 'EBT', 73, 16.5, 2, 262, 115, 1, NULL),
(2722, 'EBT 16.5 2P 257', 'EBT 16.5gsm 2p 262w 110d 1s', 'EBT', 73, 16.5, 2, 262, 110, 1, NULL),
(2723, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 200d 1s', 'EBT', 75, 17, 1, 288, 200, 1, NULL),
(2724, 'EBT 16.5 2P 120', 'EBT 16.5gsm 1p 120w 100d 1s', 'EBT', 73, 16.5, 1, 120, 100, 1, NULL),
(2725, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 245w 115d 1s', 'EBT', 75, 17, 2, 245, 115, 1, NULL),
(2726, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 118d 1s', 'EBT', 75, 17, 2, 279, 118, 1, NULL),
(2727, 'EBT 15.0 2P 30', 'EBT 15.0gsm 2p 30w 115d 3s', 'EBT', 75, 15, 2, 30, 115, 3, NULL),
(2728, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 112d 6s', 'STN', 86, 18, 1, 30, 112, 6, NULL),
(2729, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 112d 3s', 'STN', 86, 18, 1, 33, 112, 3, NULL),
(2730, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 80d 2s', 'STN', 86, 18, 1, 30, 80, 2, NULL),
(2731, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 115d 1s', 'STN', 86, 18, 1, 30, 115, 1, NULL),
(2732, 'PFT 14.0 3P 100', 'PFT 14.0gsm 3p 100w 115d 1s', 'PFT', 84, 14, 3, 100, 115, 1, NULL),
(2733, 'STN 18.0 1P 29.5', 'STN 18.0gsm 1p 29.5w 102d 5s', 'STN', 86, 18, 1, 29.5, 102, 5, NULL),
(2734, 'STN 18.0 1P 29.5', 'STN 18.0gsm 1p 29.5w 110d 5s', 'STN', 86, 18, 1, 29.5, 110, 5, NULL),
(2735, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 103d 4s', 'STN', 86, 18, 1, 30, 103, 4, NULL),
(2736, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 103d 4s', 'STN', 86, 18, 1, 33, 103, 4, NULL),
(2737, 'EBT 15.5 3P 30', 'EBT 15.5gsm 2p 30w 115d 5s', 'EBT', 72, 15.5, 2, 30, 115, 5, NULL),
(2738, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 90d 3s', 'STN', 86, 18, 1, 30, 90, 3, NULL),
(2739, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 226d 1s', 'EBT', 75, 17, 1, 288, 226, 1, NULL),
(2740, 'SBT 16.5 2P 170', 'SBT 16.5gsm 2p 170w 100d 2s', 'SBT', 83, 16.5, 2, 170, 100, 2, NULL);
INSERT INTO `bpl_products` (`id`, `old`, `productname`, `gradetype`, `brightness`, `gsm`, `ply`, `width`, `diameter`, `slice`, `deleted_at`) VALUES
(2741, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 223w 120d 1s', 'PBT', 87, 17, 2, 223, 120, 1, NULL),
(2742, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 146d 1s', 'SBT', 84, 17, 2, 288, 146, 1, NULL),
(2743, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 135w 80d 1s', 'PBT', 87, 16.5, 2, 135, 80, 1, NULL),
(2744, 'SBT 16.5 2P 130', 'SBT 16.5gsm 2p 130w 90d 1s', 'SBT', 86, 16.5, 2, 130, 90, 1, NULL),
(2745, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 220w 100d 1s', 'SBT', 84, 17, 2, 220, 100, 1, NULL),
(2746, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 114d 2s', 'STN', 86, 18, 1, 30, 114, 2, NULL),
(2747, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 120w 105d 1s', 'PBT', 87, 16.5, 2, 120, 105, 1, NULL),
(2748, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 180d 1s', 'EBT', 75, 17, 1, 288, 180, 1, NULL),
(2749, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 190w 115d 1s', 'SBT', 86, 16.5, 2, 190, 115, 1, NULL),
(2750, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 110w 60d 1s', 'EBT', 73, 16.5, 2, 110, 60, 1, NULL),
(2751, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 220d 1s', 'PBTS', 84, 17, 1, 288, 220, 1, NULL),
(2752, 'SKT 19.0 2P 260', 'SKT 19.0gsm 2p 260w 108d 1s', 'SKT', 86, 19, 2, 260, 108, 1, NULL),
(2753, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 119d 5s', 'PTN', 82, 18, 1, 31.5, 119, 5, NULL),
(2754, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 119d 4s', 'PTN', 82, 18, 1, 31.5, 119, 4, NULL),
(2755, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 210d 1s', 'PBTS', 84, 17, 1, 288, 210, 1, NULL),
(2756, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 105d 4s', 'PTN', 87, 19, 1, 33, 105, 4, NULL),
(2757, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 102d 5s', 'PTN', 82, 18, 1, 31.5, 102, 5, NULL),
(2758, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 102d 4s', 'PTN', 82, 18, 1, 31.5, 102, 4, NULL),
(2759, 'PFT 14.5 2P 100', 'PFT 14.5gsm 2p 100w 90d 2s', 'PFT', 87, 14.5, 2, 100, 90, 2, NULL),
(2760, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 80w 60d 1s', 'EBT', 73, 16.5, 2, 80, 60, 1, NULL),
(2761, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 80w 87d 1s', 'EBT', 73, 16.5, 2, 80, 87, 1, NULL),
(2762, 'PTN 19.0 1P 30', 'PTN 18.0gsm 1p 30w 115d 1s', 'PTN', 87, 18, 1, 30, 115, 1, NULL),
(2763, 'PKT 25.0 2P 275', 'PKT 25.0gsm 2p 275w 112d 1s', 'PKT', 87, 25, 2, 275, 112, 1, NULL),
(2764, 'PKT 24.0 2P 30', 'PKT 24.0gsm 2p 30w 110d 4s', 'PKT', 86, 24, 2, 30, 110, 4, NULL),
(2765, 'PKT 24.0 2P 30', 'PKT 24.0gsm 2p 30w 110d 2s', 'PKT', 86, 24, 2, 30, 110, 2, NULL),
(2766, 'PKT 22.0 2P 288', 'PKT 21.0gsm 2p 288w 150d 1s', 'PKT', 87, 21, 2, 288, 150, 1, NULL),
(2767, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 95d 4s', 'PTN', 82, 18, 1, 33, 95, 4, NULL),
(2768, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 95d 3s', 'PTN', 82, 18, 1, 33, 95, 3, NULL),
(2769, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 150d 4s', 'PTN', 82, 18, 1, 33, 150, 4, NULL),
(2770, 'PBT 17.0 1P 288', 'PBT 17.0gsm 1p 288w 100d 1s', 'PBT', 84, 17, 1, 288, 100, 1, NULL),
(2771, 'SKT 22.0 1P 288', 'SKT 21.0gsm 1p 288w 245d 1s', 'SKT', 86, 21, 1, 288, 245, 1, NULL),
(2772, 'SKT 22.0 1P 288', 'SKT 23.0gsm 1p 288w 250d 1s', 'SKT', 86, 23, 1, 288, 250, 1, NULL),
(2773, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 33w 80d 4s', 'PTN', 87, 17, 1, 33, 80, 4, NULL),
(2774, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 158d 1s', 'EBT', 75, 17, 2, 279, 158, 1, NULL),
(2775, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 240w 110d 1s', 'EBT', 75, 17, 2, 240, 110, 1, NULL),
(2776, 'EBT 16.5 2P 120', 'EBT 17.0gsm 2p 120w 100d 1s', 'EBT', 75, 17, 2, 120, 100, 1, NULL),
(2777, 'PFT 14.0 2P 126', 'PFT 14.0gsm 2p 126w 110d 2s', 'PFT', 86, 14, 2, 126, 110, 2, NULL),
(2778, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 115d 1s', 'PTN', 87, 19, 1, 32.5, 115, 1, NULL),
(2779, 'EBT 16.5 2P 130', 'EBT 16.5gsm 2p 130w 95d 1s', 'EBT', 73, 16.5, 2, 130, 95, 1, NULL),
(2780, 'PFT 14.0 2P 20', 'PFT 14.0gsm 2p 20w 115d 7s', 'PFT', 86, 14, 2, 20, 115, 7, NULL),
(2781, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 204w 115d 1s', 'EBT', 75, 17, 2, 204, 115, 1, NULL),
(2782, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 80d 4s', 'STN', 86, 18, 1, 33, 80, 4, NULL),
(2783, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 115d 2s', 'PTN', 87, 19, 1, 32.5, 115, 2, NULL),
(2784, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 218w 110d 1s', 'EBT', 75, 17, 2, 218, 110, 1, NULL),
(2785, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 85w 100d 1s', 'EBT', 73, 16.5, 2, 85, 100, 1, NULL),
(2786, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 110d 6s', 'PFT', 87, 15, 3, 21, 110, 6, NULL),
(2787, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 140d 1s', 'PBTS', 84, 17, 1, 288, 140, 1, NULL),
(2788, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 105d 6s', 'PFT', 87, 15, 3, 21, 105, 6, NULL),
(2789, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 100d 6s', 'PFT', 87, 15, 3, 21, 100, 6, NULL),
(2790, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 115d 2s', 'PFT', 87, 14, 2, 40, 115, 2, NULL),
(2791, 'PFT 14.0 2P 100', 'PFT 17.0gsm 1p 100w 115d 1s', 'PFT', 84, 17, 1, 100, 115, 1, NULL),
(2792, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 108d 1s', 'EBT', 73, 16.5, 2, 164, 108, 1, NULL),
(2793, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 115d 3s', 'PFT', 87, 15, 3, 21, 115, 3, NULL),
(2794, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 97d 1s', 'EBT', 73, 16.5, 2, 120, 97, 1, NULL),
(2795, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 97d 1s', 'EBT', 73, 16.5, 2, 164, 97, 1, NULL),
(2796, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 180d 1s', 'PBTS', 84, 17, 1, 288, 180, 1, NULL),
(2797, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 65d 4s', 'STN', 86, 18, 1, 33, 65, 4, NULL),
(2798, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 32.5w 115d 1s', 'STN', 86, 19, 1, 32.5, 115, 1, NULL),
(2799, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 105d 5s', 'PTN', 87, 19, 1, 32.5, 105, 5, NULL),
(2800, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 105d 4s', 'PTN', 87, 19, 1, 32.5, 105, 4, NULL),
(2801, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 110d 5s', 'PTN', 87, 19, 1, 32.5, 110, 5, NULL),
(2802, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 100d 3s', 'PTN', 82, 18, 1, 33, 100, 3, NULL),
(2803, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 115d 2s', 'PTN', 87, 19, 1, 33, 115, 2, NULL),
(2804, 'EBT 16.5 2P 137', 'EBT 16.5gsm 2p 137w 105d 1s', 'EBT', 73, 16.5, 2, 137, 105, 1, NULL),
(2805, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 80d 4s', 'PTN', 82, 18, 1, 31.5, 80, 4, NULL),
(2806, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 80d 3s', 'PTN', 82, 18, 1, 31.5, 80, 3, NULL),
(2807, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 230w 115d 1s', 'SBT', 84, 17, 2, 230, 115, 1, NULL),
(2808, 'SBT 17.5 2P 25', 'SBT 17.5gsm 2p 25w 115d 6s', 'SBT', 86, 17.5, 2, 25, 115, 6, NULL),
(2809, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 82d 1s', 'EBT', 73, 16.5, 2, 120, 82, 1, NULL),
(2810, 'PTN 16.5 2P 33', 'PTN 16.5gsm 2p 33w 115d 4s', 'PTN', 88, 16.5, 2, 33, 115, 4, NULL),
(2811, 'PTN 16.5 2P 33', 'PTN 16.5gsm 2p 33w 112d 4s', 'PTN', 88, 16.5, 2, 33, 112, 4, NULL),
(2812, 'PTN 16.5 2P 33', 'PTN 16.5gsm 2p 33w 115d 3s', 'PTN', 88, 16.5, 2, 33, 115, 3, NULL),
(2813, 'PTN 16.5 2P 33', 'PTN 16.5gsm 2p 33w 115d 2s', 'PTN', 88, 16.5, 2, 33, 115, 2, NULL),
(2814, 'PTN 16.5 2P 33', 'PTN 16.5gsm 2p 33w 110d 4s', 'PTN', 88, 16.5, 2, 33, 110, 4, NULL),
(2815, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 108d 1s', 'SBT', 84, 18, 2, 142, 108, 1, NULL),
(2816, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 127d 1s', 'SBT', 84, 17, 2, 288, 127, 1, NULL),
(2817, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 120w 92d 1s', 'SBT', 84, 18, 2, 120, 92, 1, NULL),
(2818, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 100w 90d 1s', 'SBT', 84, 18, 2, 100, 90, 1, NULL),
(2819, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 93d 4s', 'PTN', 82, 18, 1, 31.5, 93, 4, NULL),
(2820, 'EBT 16.5 2P 137', 'EBT 16.5gsm 2p 137w 95d 1s', 'EBT', 73, 16.5, 2, 137, 95, 1, NULL),
(2821, 'EBT 16.5 2P 288', 'EBT 16.5gsm 2p 288w 180d 1s', 'EBT', 73, 16.5, 2, 288, 180, 1, NULL),
(2822, 'SBT 17.5 2P 165', 'SBT 17.5gsm 2p 165w 112d 1s', 'SBT', 89, 17.5, 2, 165, 112, 1, NULL),
(2823, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 106d 1s', 'EBT', 75, 17, 2, 279, 106, 1, NULL),
(2824, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 100d 2s', 'PTN', 82, 18, 1, 31.5, 100, 2, NULL),
(2825, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 116d 1s', 'SBT', 86, 17, 2, 256, 116, 1, NULL),
(2826, 'SBT 17.0 2P 256', 'SBT 17.0gsm 2p 256w 108d 1s', 'SBT', 86, 17, 2, 256, 108, 1, NULL),
(2827, 'SBT 17.0 2P 30', 'SBT 17.0gsm 2p 30w 115d 5s', 'SBT', 84, 17, 2, 30, 115, 5, NULL),
(2828, 'SBT 16.5 2P 175', 'SBT 16.5gsm 2p 175w 100d 1s', 'SBT', 86, 16.5, 2, 175, 100, 1, NULL),
(2829, 'PTN 19.0 1P 29', 'PTN 19.0gsm 1p 29w 115d 4s', 'PTN', 88, 19, 1, 29, 115, 4, NULL),
(2830, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 93d 1s', 'EBT', 73, 16.5, 2, 120, 93, 1, NULL),
(2831, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 93d 1s', 'EBT', 73, 16.5, 2, 164, 93, 1, NULL),
(2832, 'PTN 19.0 1P 29', 'PTN 19.0gsm 1p 29w 110d 5s', 'PTN', 88, 19, 1, 29, 110, 5, NULL),
(2833, 'PTN 19.0 1P 29', 'PTN 19.0gsm 1p 29w 105d 5s', 'PTN', 88, 19, 1, 29, 105, 5, NULL),
(2834, 'PBT 17.0 2P 256', 'PBT 17.0gsm 2p 256w 115d 1s', 'PBT', 87, 17, 2, 256, 115, 1, NULL),
(2835, 'EBT 16.5 2P 160', 'EBT 16.5gsm 2p 164w 100d 2s', 'EBT', 75, 16.5, 2, 164, 100, 2, NULL),
(2836, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 2010d 1s', 'PBTS', 84, 17, 1, 288, 2010, 1, NULL),
(2837, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 10d 5s', 'PTN', 82, 18, 1, 31.5, 10, 5, NULL),
(2838, 'PBT 17.0 2P 256', 'PBT 17.0gsm 2p 25w 115d 5s', 'PBT', 87, 17, 2, 25, 115, 5, NULL),
(2839, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 70d 3s', 'PTN', 82, 18, 1, 31.5, 70, 3, NULL),
(2840, 'PBT 17.0 2P 256', 'PBT 17.0gsm 2p 256w 111d 1s', 'PBT', 87, 17, 2, 256, 111, 1, NULL),
(2841, 'PTN 19.0 1P 29', 'PTN 18.0gsm 1p 29w 115d 5s', 'PTN', 88, 18, 1, 29, 115, 5, NULL),
(2842, 'PTN 19.0 1P 29', 'PTN 18.0gsm 1p 29w 105d 4s', 'PTN', 88, 18, 1, 29, 105, 4, NULL),
(2843, 'PBT 17.0 1P 288', 'PBT 17.0gsm 1p 288w 160d 1s', 'PBT', 84, 17, 1, 288, 160, 1, NULL),
(2844, 'PBT 18.5 2P 144', 'PBT 18.0gsm 2p 144w 115d 1s', 'PBT', 87, 18, 2, 144, 115, 1, NULL),
(2845, 'PTN 18.0 1P 29', 'PTN 18.0gsm 1p 30w 115d 2s', 'PTN', 86, 18, 1, 30, 115, 2, NULL),
(2846, 'SBT 15.5 2P 80', 'SBT 15.5gsm 2p 80w 105d 1s', 'SBT', 86, 15.5, 2, 80, 105, 1, NULL),
(2847, 'PFT 14.0 2P 40', 'PFT 14.5gsm 2p 38w 115d 2s', 'PFT', 87, 14.5, 2, 38, 115, 2, NULL),
(2848, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 100d 3s', 'PTN', 82, 18, 1, 31.5, 100, 3, NULL),
(2849, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 86d 5s', 'PTN', 82, 18, 1, 31.5, 86, 5, NULL),
(2850, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 86d 4s', 'PTN', 82, 18, 1, 31.5, 86, 4, NULL),
(2851, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 115d 5s', 'PTN', 82, 18, 1, 33, 115, 5, NULL),
(2852, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 90d 5s', 'STN', 86, 18, 1, 33, 90, 5, NULL),
(2853, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 90d 6s', 'STN', 86, 18, 1, 30, 90, 6, NULL),
(2854, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 30w 100d 4s', 'PTN', 82, 18, 1, 30, 100, 4, NULL),
(2855, 'PTN 19.0 1P 30', 'PTN 18.0gsm 1p 30w 95d 4s', 'PTN', 87, 18, 1, 30, 95, 4, NULL),
(2856, 'PBT 17.0 1P 288', 'PBT 17.0gsm 1p 288w 186d 1s', 'PBT', 84, 17, 1, 288, 186, 1, NULL),
(2857, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 105d 4s', 'PTN', 82, 18, 1, 33, 105, 4, NULL),
(2858, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 120w 100d 1s', 'SBT', 84, 17, 2, 120, 100, 1, NULL),
(2859, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 122d 5s', 'PTN', 82, 18, 1, 31.5, 122, 5, NULL),
(2860, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 122d 4s', 'PTN', 82, 18, 1, 31.5, 122, 4, NULL),
(2861, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 90d 3s', 'PTN', 87, 18, 1, 30, 90, 3, NULL),
(2862, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 288w 270d 1s', 'SBT', 86, 16.5, 2, 288, 270, 1, NULL),
(2863, 'STN 18.0 1P 29', 'STN 18.0gsm 1p 29w 115d 5s', 'STN', 85, 18, 1, 29, 115, 5, NULL),
(2864, 'STN 18.0 1P 29', 'STN 18.0gsm 1p 29w 110d 5s', 'STN', 85, 18, 1, 29, 110, 5, NULL),
(2865, 'STN 18.0 1P 29', 'STN 18.0gsm 1p 29w 110d 4s', 'STN', 85, 18, 1, 29, 110, 4, NULL),
(2866, 'SKT 22.0 1P 288', 'SKT 18.0gsm 2p 288w 130d 1s', 'SKT', 86, 18, 2, 288, 130, 1, NULL),
(2867, 'SKT 22.0 1P 288', 'SKT 22.0gsm 2p 288w 130d 1s', 'SKT', 86, 22, 2, 288, 130, 1, NULL),
(2868, 'EBT 16.5 2P 120', 'EBT 15.0gsm 2p 120w 100d 1s', 'EBT', 73, 15, 2, 120, 100, 1, NULL),
(2869, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 117d 1s', 'EBT', 73, 16.5, 2, 120, 117, 1, NULL),
(2870, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 117d 1s', 'EBT', 73, 16.5, 2, 164, 117, 1, NULL),
(2871, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 115d 5s', 'ETN', 74, 17, 1, 28, 115, 5, NULL),
(2872, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 115d 4s', 'ETN', 74, 17, 1, 28, 115, 4, NULL),
(2873, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 100d 5s', 'ETN', 74, 17, 1, 28, 100, 5, NULL),
(2874, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 110d 5s', 'ETN', 74, 17, 1, 28, 110, 5, NULL),
(2875, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 100d 4s', 'ETN', 74, 17, 1, 28, 100, 4, NULL),
(2876, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 95d 2s', 'SBT', 84, 18, 2, 142, 95, 2, NULL),
(2877, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 90d 2s', 'SBT', 84, 18, 2, 142, 90, 2, NULL),
(2878, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 100d 3s', 'ETN', 74, 17, 1, 28, 100, 3, NULL),
(2879, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 105d 1s', 'PFT', 87, 14, 2, 80, 105, 1, NULL),
(2880, 'SKT 42.0 1P 80', 'SKT 42.0gsm 1p 80w 115d 3s', 'SKT', 84, 42, 1, 80, 115, 3, NULL),
(2881, 'SKT 42.0 1P 80', 'SKT 42.0gsm 1p 80w 110d 3s', 'SKT', 84, 42, 1, 80, 110, 3, NULL),
(2882, 'PBT 16.5 2P 144', 'PBT 16.5gsm 2p 142w 115d 1s', 'PBT', 87, 16.5, 2, 142, 115, 1, NULL),
(2883, 'PBT 16.5 2P 142', 'PBT 16.5gsm 2p 142w 122d 1s', 'PBT', 86, 16.5, 2, 142, 122, 1, NULL),
(2884, 'PBT 16.5 2P 275', 'PBT 16.5gsm 2p 275w 115d 1s', 'PBT', 87, 16.5, 2, 275, 115, 1, NULL),
(2885, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 107d 1s', 'PBT', 87, 16.5, 2, 140, 107, 1, NULL),
(2886, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 108d 1s', 'PBT', 87, 16.5, 2, 140, 108, 1, NULL),
(2887, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 90d 4s', 'ETN', 74, 17, 1, 28, 90, 4, NULL),
(2888, 'SBT 17.5 2P 282', 'SBT 17.5gsm 2p 279w 150d 1s', 'SBT', 82, 17.5, 2, 279, 150, 1, NULL),
(2889, 'SBT 18.0 2P 142', 'SBT 17.5gsm 2p 142w 100d 1s', 'SBT', 89, 17.5, 2, 142, 100, 1, NULL),
(2890, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 279w 135d 1s', 'SBT', 82, 17, 2, 279, 135, 1, NULL),
(2891, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 220d 1s', 'SBT', 84, 17, 1, 288, 220, 1, NULL),
(2892, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 279w 157d 1s', 'SBT', 82, 17, 2, 279, 157, 1, NULL),
(2893, 'SBT 17.5 2P 95', 'SBT 17.5gsm 2p 95w 108d 1s', 'SBT', 89, 17.5, 2, 95, 108, 1, NULL),
(2894, 'SBT 17.5 2P 165', 'SBT 17.5gsm 2p 165w 108d 1s', 'SBT', 89, 17.5, 2, 165, 108, 1, NULL),
(2895, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 93d 2s', 'SBT', 84, 16.5, 2, 120, 93, 2, NULL),
(2896, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 93d 2s', 'SBT', 84, 16.5, 2, 164, 93, 2, NULL),
(2897, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 60d 5s', 'ETN', 74, 17, 1, 28, 60, 5, NULL),
(2898, 'PTN 18.0 1P 33', 'PTN 17.0gsm 1p 33w 150d 1s', 'PTN', 84, 17, 1, 33, 150, 1, NULL),
(2899, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 98d 1s', 'EBT', 73, 16.5, 2, 140, 98, 1, NULL),
(2900, 'PBT 16.5 1P 288', 'PBT 15.5gsm 1p 288w 150d 1s', 'PBT', 86, 15.5, 1, 288, 150, 1, NULL),
(2901, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 254w 112d 1s', 'EBT', 75, 15, 2, 254, 112, 1, NULL),
(2902, 'EBT 16.5 2P 137', 'EBT 16.5gsm 2p 137w 90d 1s', 'EBT', 73, 16.5, 2, 137, 90, 1, NULL),
(2903, 'PBT 17.0 2P 288', 'PBT 17.0gsm 2p 226w 150d 1s', 'PBT', 87, 17, 2, 226, 150, 1, NULL),
(2904, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 9d 1s', 'EBT', 73, 16.5, 2, 120, 9, 1, NULL),
(2905, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 96d 1s', 'EBT', 73, 16.5, 2, 120, 96, 1, NULL),
(2906, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 96d 1s', 'EBT', 73, 16.5, 2, 164, 96, 1, NULL),
(2907, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 254w 102d 1s', 'EBT', 75, 15, 2, 254, 102, 1, NULL),
(2908, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 100w 77d 1s', 'EBT', 73, 16.5, 2, 100, 77, 1, NULL),
(2909, 'EBT 17.0 2P 142', 'EBT 16.5gsm 2p 142w 100d 1s', 'EBT', 75, 16.5, 2, 142, 100, 1, NULL),
(2910, 'EBT 17.0 2P 142', 'EBT 17.0gsm 2p 142w 100d 1s', 'EBT', 75, 17, 2, 142, 100, 1, NULL),
(2911, 'EBT 17.0 2P 254', 'EBT 17.0gsm 2p 255w 115d 1s', 'EBT', 73, 17, 2, 255, 115, 1, NULL),
(2912, 'EBT 17.0 2P 140', 'EBT 17.0gsm 2p 30w 115d 4s', 'EBT', 73, 17, 2, 30, 115, 4, NULL),
(2913, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 210d 1s', 'SBT', 84, 17, 1, 288, 210, 1, NULL),
(2914, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 140w 100d 1s', 'SBT', 84, 17, 2, 140, 100, 1, NULL),
(2915, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 70d 5s', 'STN', 86, 18, 1, 30, 70, 5, NULL),
(2916, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 100d 2s', 'STN', 86, 18, 1, 30, 100, 2, NULL),
(2917, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 95d 3s', 'PTN', 82, 18, 1, 31.5, 95, 3, NULL),
(2918, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 200d 1s', 'SBT', 84, 17, 1, 288, 200, 1, NULL),
(2919, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 288w 242d 1s', 'SBT', 84, 17, 1, 288, 242, 1, NULL),
(2920, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 88d 1s', 'SBT', 86, 16.5, 2, 140, 88, 1, NULL),
(2921, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 90d 4s', 'STN', 86, 18, 1, 30, 90, 4, NULL),
(2922, 'PFT(PEACH) 15.5 2P 84', 'PFT(PEACH) 15.5gsm 2p 84w 115d 6s', 'PFT(PEACH)', 85, 15.5, 2, 84, 115, 6, NULL),
(2923, 'PFT(PEACH) 15.5 2P 84', 'PFT(PEACH) 15.5gsm 2p 84w 115d 4s', 'PFT(PEACH)', 85, 15.5, 2, 84, 115, 4, NULL),
(2924, 'EBT 15.5 3P 254', 'EBT 15.5gsm 2p 254w 115d 1s', 'EBT', 73, 15.5, 2, 254, 115, 1, NULL),
(2925, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 110d 4s', 'ETN', 74, 17, 1, 28, 110, 4, NULL),
(2926, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 109d 1s', 'EBT', 73, 16.5, 2, 140, 109, 1, NULL),
(2927, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 105d 1s', 'PFT', 87, 14, 2, 100, 105, 1, NULL),
(2928, 'PFT 15.5 2P 82', 'PFT 15.5gsm 2p 84w 110d 3s', 'PFT', 85, 15.5, 2, 84, 110, 3, NULL),
(2929, 'PFT 15.5 2P 82', 'PFT 15.5gsm 2p 84w 115d 3s', 'PFT', 85, 15.5, 2, 84, 115, 3, NULL),
(2930, 'PFT 15.5 2P 82', 'PFT 15.5gsm 2p 20w 115d 2s', 'PFT', 85, 15.5, 2, 20, 115, 2, NULL),
(2931, 'PFT 14.5 2P 57', 'PFT 14.5gsm 2p 57w 110d 1s', 'PFT', 85, 14.5, 2, 57, 110, 1, NULL),
(2932, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 115d 7s', 'PFT', 87, 15, 3, 21, 115, 7, NULL),
(2933, 'PFT 15.3 3P 21', 'PFT 15.3gsm 3p 21w 115d 7s', 'PFT', 87, 15.3, 3, 21, 115, 7, NULL),
(2934, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 115d 5s', 'PFT', 87, 15, 3, 21, 115, 5, NULL),
(2935, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 105d 7s', 'PFT', 87, 14, 3, 20, 105, 7, NULL),
(2936, 'PFT 14.0 3P 20', 'PFT 14.0gsm 3p 20w 100d 7s', 'PFT', 87, 14, 3, 20, 100, 7, NULL),
(2937, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 100d 2s', 'PFT', 87, 14, 2, 80, 100, 2, NULL),
(2938, 'SKT 40.0 1P 30', 'SKT 40.0gsm 1p 30w 120d 4s', 'SKT', 84, 40, 1, 30, 120, 4, NULL),
(2939, 'SKT 40.0 1P 30', 'SKT 40.0gsm 1p 30w 120d 2s', 'SKT', 84, 40, 1, 30, 120, 2, NULL),
(2940, 'SKT 42.0 1P 100', 'SKT 42.0gsm 1p 100w 110d 2s', 'SKT', 84, 42, 1, 100, 110, 2, NULL),
(2941, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 105d 2s', 'SKT', 86, 40, 1, 100, 105, 2, NULL),
(2942, 'SKT 34.0 1P 86', 'SKT 34.0gsm 1p 86w 115d 1s', 'SKT', 84, 34, 1, 86, 115, 1, NULL),
(2943, 'SKT 34.0 1P 86', 'SKT 34.0gsm 1p 25w 115d 1s', 'SKT', 84, 34, 1, 25, 115, 1, NULL),
(2944, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 60d 5s', 'PTN', 82, 18, 1, 31.5, 60, 5, NULL),
(2945, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 60d 4s', 'PTN', 82, 18, 1, 31.5, 60, 4, NULL),
(2946, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 118d 4s', 'STN', 86, 18, 1, 33, 118, 4, NULL),
(2947, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 150d 4s', 'PTN', 87, 15, 3, 33, 150, 4, NULL),
(2948, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 100d 4s', 'STN', 86, 19, 1, 33, 100, 4, NULL),
(2949, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 140w 95d 1s', 'SBT', 84, 17, 2, 140, 95, 1, NULL),
(2950, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 85d 1s', 'SBT', 84, 18, 2, 142, 85, 1, NULL),
(2951, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 120w 80d 1s', 'SBT', 84, 18, 2, 120, 80, 1, NULL),
(2952, 'SBT 16.5 2P 120', 'SBT 16.5gsm 1p 120w 100d 1s', 'SBT', 84, 16.5, 1, 120, 100, 1, NULL),
(2953, 'STN 19.0 1P 33', 'STN 19.0gsm 2p 33w 115d 4s', 'STN', 86, 19, 2, 33, 115, 4, NULL),
(2954, 'PBT 16.5 1P 288', 'PBT 15.0gsm 1p 288w 150d 1s', 'PBT', 86, 15, 1, 288, 150, 1, NULL),
(2955, 'SBT 16.5 2P 288', 'SBT 16.5gsm 2p 90w 90d 1s', 'SBT', 86, 16.5, 2, 90, 90, 1, NULL),
(2956, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 65w 73d 1s', 'EBT', 73, 16.5, 2, 65, 73, 1, NULL),
(2957, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 10d 1s', 'SBT', 84, 18, 2, 142, 10, 1, NULL),
(2958, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 70w 80d 1s', 'SBT', 86, 16.5, 2, 70, 80, 1, NULL),
(2959, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 170d 1s', 'EBT', 75, 17, 2, 288, 170, 1, NULL),
(2960, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 110w 95d 1s', 'EBT', 73, 16.5, 2, 110, 95, 1, NULL),
(2961, 'ETN 17.0 1P 28', 'EBT 17.0gsm 1p 28w 100d 1s', 'EBT', 73, 17, 1, 28, 100, 1, NULL),
(2962, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 90w 54d 1s', 'SBT', 86, 16.5, 2, 90, 54, 1, NULL),
(2963, 'STN 18.0 1P 29.5', 'STN 18.0gsm 1p 28.5w 110d 5s', 'STN', 86, 18, 1, 28.5, 110, 5, NULL),
(2964, 'STN 18.0 1P 29.5', 'STN 18.0gsm 1p 28.5w 110d 4s', 'STN', 86, 18, 1, 28.5, 110, 4, NULL),
(2965, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 70d 5s', 'PTN', 82, 18, 1, 31.5, 70, 5, NULL),
(2966, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 70d 4s', 'PTN', 82, 18, 1, 31.5, 70, 4, NULL),
(2967, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 100d 5s', 'STN', 87, 19, 1, 30, 100, 5, NULL),
(2968, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 100d 4s', 'STN', 87, 19, 1, 30, 100, 4, NULL),
(2969, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 105d 5s', 'STN', 87, 19, 1, 30, 105, 5, NULL),
(2970, 'PTN 21.0 1P 33', 'PTN 21.0gsm 1p 33w 80d 4s', 'PTN', 87, 21, 1, 33, 80, 4, NULL),
(2971, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 90d 4s', 'PTN', 87, 19, 1, 33, 90, 4, NULL),
(2972, 'SKT 20.0 2P 186', 'SKT 20.0gsm 2p 186w 110d 1s', 'SKT', 86, 20, 2, 186, 110, 1, NULL),
(2973, 'SKT 20.0 2P 100', 'SKT 20.0gsm 2p 100w 110d 2s', 'SKT', 86, 20, 2, 100, 110, 2, NULL),
(2974, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 114d 4s', 'STN', 86, 18, 1, 33, 114, 4, NULL),
(2975, 'SKT 20.0 2P 100', 'SKT 20.0gsm 2p 100w 105d 2s', 'SKT', 86, 20, 2, 100, 105, 2, NULL),
(2976, 'SBT 16.5 3P 25', 'SBT 16.5gsm 3p 20w 115d 5s', 'SBT', 84, 16.5, 3, 20, 115, 5, NULL),
(2977, 'SKT 20.0 2P 288', 'SKT 20.0gsm 2p 288w 110d 1s', 'SKT', 86, 20, 2, 288, 110, 1, NULL),
(2978, 'PTN 19.0 1P 33', 'PTN 18.0gsm 1p 33w 90d 5s', 'PTN', 82, 18, 1, 33, 90, 5, NULL),
(2979, 'STN 18.0 1P 30', 'STN 17.0gsm 1p 57.5w 110d 1s', 'STN', 86, 17, 1, 57.5, 110, 1, NULL),
(2980, 'PTN 19.0 1P 33', 'PTN 119.0gsm 1p 33w 70d 5s', 'PTN', 82, 119, 1, 33, 70, 5, NULL),
(2981, 'SBT 16.5 3P 25', 'SBT 16.5gsm 3p 20w 115d 6s', 'SBT', 84, 16.5, 3, 20, 115, 6, NULL),
(2982, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 120d 1s', 'SBT', 84, 18, 2, 142, 120, 1, NULL),
(2983, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 87d 1s', 'SBT', 84, 18, 2, 142, 87, 1, NULL),
(2984, 'PFT 14.5 2P 100', 'PFT 14.5gsm 2p 100w 108d 1s', 'PFT', 87, 14.5, 2, 100, 108, 1, NULL),
(2985, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 85d 2s', 'EBT', 84, 16.5, 2, 120, 85, 2, NULL),
(2986, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 85w 92d 1s', 'EBT', 73, 16.5, 2, 85, 92, 1, NULL),
(2987, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 75w 75d 1s', 'EBT', 73, 16.5, 2, 75, 75, 1, NULL),
(2988, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 128d 1s', 'EBT', 75, 17, 2, 288, 128, 1, NULL),
(2989, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 80w 95d 1s', 'EBT', 73, 16.5, 2, 80, 95, 1, NULL),
(2990, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 91d 1s', 'EBT', 73, 16.5, 2, 120, 91, 1, NULL),
(2991, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 110w 100d 1s', 'EBT', 73, 16.5, 2, 110, 100, 1, NULL),
(2992, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 100w 76d 1s', 'EBT', 73, 16.5, 2, 100, 76, 1, NULL),
(2993, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 158d 1s', 'EBT', 75, 17, 2, 288, 158, 1, NULL),
(2994, 'SBT 20.0 2P 132', 'SBT 20.0gsm 2p 132w 110d 1s', 'SBT', 86, 20, 2, 132, 110, 1, NULL),
(2995, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 106d 1s', 'SKT', 86, 21, 2, 100, 106, 1, NULL),
(2996, 'SKT 21.0 2P 80', 'SKT 21.0gsm 2p 80w 106d 1s', 'SKT', 86, 21, 2, 80, 106, 1, NULL),
(2997, 'UKT 40.0 1P 288', 'UKT 23.0gsm 1p 288w 150d 1s', 'UKT', 87, 23, 1, 288, 150, 1, NULL),
(2998, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 117d 1s', 'SBT', 84, 17, 2, 130, 117, 1, NULL),
(2999, 'SBT 17.0 2P 142', 'SBT 17.0gsm 2p 142w 90d 1s', 'SBT', 86, 17, 2, 142, 90, 1, NULL),
(3000, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 86d 1s', 'SBT', 86, 16.5, 2, 140, 86, 1, NULL),
(3001, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 87d 1s', 'SBT', 86, 16.5, 2, 140, 87, 1, NULL),
(3002, 'SBT 16.5 2P 130', 'SBT 16.5gsm 2p 130w 108d 1s', 'SBT', 86, 16.5, 2, 130, 108, 1, NULL),
(3003, 'SBT 16.5 2P 120', 'SBT 16.5gsm 2p 120w 68d 1s', 'SBT', 84, 16.5, 2, 120, 68, 1, NULL),
(3004, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 124d 1s', 'EBT', 75, 17, 2, 288, 124, 1, NULL),
(3005, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 100d 1s', 'SBT', 84, 17, 2, 130, 100, 1, NULL),
(3006, 'EBT 16.5 2P 130', 'EBT 16.5gsm 2p 130w 105d 1s', 'EBT', 73, 16.5, 2, 130, 105, 1, NULL),
(3007, 'PBT 16.5 2P 142', 'PBT 16.5gsm 2p 142w 100d 2s', 'PBT', 86, 16.5, 2, 142, 100, 2, NULL),
(3008, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 115d 5s', 'STN', 86, 19, 1, 33, 115, 5, NULL),
(3009, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 112d 4s', 'STN', 86, 19, 1, 33, 112, 4, NULL),
(3010, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 115d 3s', 'STN', 87, 19, 1, 30, 115, 3, NULL),
(3011, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 118d 5s', 'STN', 86, 18, 1, 33, 118, 5, NULL),
(3012, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 78d 1s', 'PBT', 87, 16.5, 2, 140, 78, 1, NULL),
(3013, 'ETN 17.0 1P 28', 'ETN 16.5gsm 1p 66w 115d 5s', 'ETN', 74, 16.5, 1, 66, 115, 5, NULL),
(3014, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 100d 1s', 'EBT', 75, 17, 2, 288, 100, 1, NULL),
(3015, 'SBT 20.0 2P 132', 'SKT 20.0gsm 2p 132w 78d 1s', 'SKT', 84, 20, 2, 132, 78, 1, NULL),
(3016, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 108w 92d 1s', 'SBT', 86, 16.5, 2, 108, 92, 1, NULL),
(3017, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 80d 1s', 'PFT', 87, 14, 2, 100, 80, 1, NULL),
(3018, 'SBT 16.5 2P 147', 'SBT 16.5gsm 2p 144w 115d 1s', 'SBT', 84, 16.5, 2, 144, 115, 1, NULL),
(3019, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 144w 100d 1s', 'SBT', 86, 16.5, 2, 144, 100, 1, NULL),
(3020, 'SBT 17.0 3P 288', 'SBT 17.0gsm 3p 288w 170d 1s', 'SBT', 84, 17, 3, 288, 170, 1, NULL),
(3021, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 1120d 5s', 'STN', 86, 18, 1, 30, 1120, 5, NULL),
(3022, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 116d 4s', 'STN', 86, 18, 1, 33, 116, 4, NULL),
(3023, 'SBT 17.0 3P 288', 'SBT 17.0gsm 3p 288w 160d 1s', 'SBT', 84, 17, 3, 288, 160, 1, NULL),
(3024, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 117d 3s', 'STN', 86, 18, 1, 33, 117, 3, NULL),
(3025, 'SBT 17.0 3P 288', 'SBT 17.0gsm 3p 288w 165d 1s', 'SBT', 84, 17, 3, 288, 165, 1, NULL),
(3026, 'EBT 15.0 3P 130', 'EBT 14.0gsm 3p 130w 110d 1s', 'EBT', 87, 14, 3, 130, 110, 1, NULL),
(3027, 'EBT 15.0 3P 130', 'EBT 14.0gsm 3p 130w 115d 1s', 'EBT', 86, 14, 3, 130, 115, 1, NULL),
(3028, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 218d 1s', 'EBT', 75, 17, 1, 288, 218, 1, NULL),
(3029, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 165d 1s', 'EBT', 75, 17, 2, 288, 165, 1, NULL),
(3030, 'SBT 17.0 2P 255', 'SBT 17.0gsm 2p 255w 107d 1s', 'SBT', 84, 17, 2, 255, 107, 1, NULL),
(3031, 'SBT 17.0 2P 255', 'SBT 17.0gsm 2p 255w 105d 1s', 'SBT', 84, 17, 2, 255, 105, 1, NULL),
(3032, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 108d 5s', 'ETN', 74, 17, 1, 28, 108, 5, NULL),
(3033, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 112d 5s', 'ETN', 74, 17, 1, 28, 112, 5, NULL),
(3034, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 112d 4s', 'ETN', 74, 17, 1, 28, 112, 4, NULL),
(3035, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 114d 5s', 'ETN', 74, 17, 1, 28, 114, 5, NULL),
(3036, 'STN 17.0 2P 31.5', 'STN 17.0gsm 2p 31.5w 108d 4s', 'STN', 86, 17, 2, 31.5, 108, 4, NULL),
(3037, 'STN 17.0 2P 31.5', 'STN 17.0gsm 2p 31.5w 108d 5s', 'STN', 86, 17, 2, 31.5, 108, 5, NULL),
(3038, 'SBT 16.5 2P 140', 'SBT 17.5gsm 2p 140w 100d 1s', 'SBT', 86, 17.5, 2, 140, 100, 1, NULL),
(3039, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 114d 3s', 'STN', 86, 18, 1, 33, 114, 3, NULL),
(3040, 'SBT 17.5 2P 130', 'SBT 17.5gsm 2p 130w 110d 1s', 'SBT', 86, 17.5, 2, 130, 110, 1, NULL),
(3041, 'EBT 17.0 1P 282', 'EBT 17.0gsm 1p 275w 150d 1s', 'EBT', 73, 17, 1, 275, 150, 1, NULL),
(3042, 'EBT 15.5 2P 256', 'EBT 17.0gsm 1p 256w 120d 1s', 'EBT', 73, 17, 1, 256, 120, 1, NULL),
(3043, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 220w 145d 1s', 'EBT', 75, 17, 2, 220, 145, 1, NULL),
(3044, 'SBT 15.5 2P 100', 'SBT 14.5gsm 2p 100w 115d 2s', 'SBT', 86, 14.5, 2, 100, 115, 2, NULL),
(3045, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 211w 132d 1s', 'EBT', 75, 17, 2, 211, 132, 1, NULL),
(3046, 'SBT 16.0 3P 140', 'SBT 16.0gsm 2p 140w 115d 1s', 'SBT', 86, 16, 2, 140, 115, 1, NULL),
(3047, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 116d 5s', 'STN', 86, 18, 1, 30, 116, 5, NULL),
(3048, 'SKT 23.0 2P 140', 'SKT 23.0gsm 2p 140w 100d 1s', 'SKT', 86, 23, 2, 140, 100, 1, NULL),
(3049, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 86d 1s', 'EBT', 73, 16.5, 2, 120, 86, 1, NULL),
(3050, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 86d 1s', 'EBT', 73, 16.5, 2, 164, 86, 1, NULL),
(3051, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 104d 1s', 'EBT', 75, 16.5, 2, 120, 104, 1, NULL),
(3052, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 107d 5s', 'STN', 86, 18, 1, 30, 107, 5, NULL),
(3053, 'PTN 17.0 1P 30', 'PTN 19.0gsm 1p 30w 115d 2s', 'PTN', 87, 19, 1, 30, 115, 2, NULL),
(3054, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 131w 115d 1s', 'EBT', 73, 17, 2, 131, 115, 1, NULL),
(3055, 'EBT 15.0 2P 30', 'EBT 15.0gsm 2p 30w 115d 2s', 'EBT', 75, 15, 2, 30, 115, 2, NULL),
(3056, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 105d 4s', 'ETN', 74, 17, 1, 28, 105, 4, NULL),
(3057, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 105d 5s', 'ETN', 74, 17, 1, 28, 105, 5, NULL),
(3058, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 95d 5s', 'ETN', 74, 17, 1, 28, 95, 5, NULL),
(3059, 'ETN 17.0 1P 28', 'ETN 17.0gsm 1p 28w 95d 4s', 'ETN', 74, 17, 1, 28, 95, 4, NULL),
(3060, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 130w 90d 1s', 'SBT', 84, 18, 2, 130, 90, 1, NULL),
(3061, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 130w 95d 1s', 'SBT', 84, 18, 2, 130, 95, 1, NULL),
(3062, 'EBT 18.0 2P 140', 'EBT 18.0gsm 2p 140w 96d 1s', 'EBT', 73, 18, 2, 140, 96, 1, NULL),
(3063, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 110d 1s', 'SFT', 86, 15.5, 2, 90, 110, 1, NULL),
(3064, 'EBT 18.0 2P 140', 'EBT 18.0gsm 2p 140w 109d 1s', 'EBT', 73, 18, 2, 140, 109, 1, NULL),
(3065, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 115d 6s', 'STN', 86, 19, 1, 33, 115, 6, NULL),
(3066, 'SFT 15.0 2P 100', 'SFT 15.0gsm 2p 100w 85d 2s', 'SFT', 84, 15, 2, 100, 85, 2, NULL),
(3067, 'SFT 15.0 2P 80', 'SFT 15.0gsm 2p 80w 85d 1s', 'SFT', 84, 15, 2, 80, 85, 1, NULL),
(3068, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 120w 108d 1s', 'EBT', 75, 15, 2, 120, 108, 1, NULL),
(3069, 'EBT 15.0 2P 254', 'EBT 16.5gsm 2p 127w 110d 1s', 'EBT', 75, 16.5, 2, 127, 110, 1, NULL),
(3070, 'EBT 16.5 2P 130', 'EBT 15.0gsm 2p 127w 110d 1s', 'EBT', 75, 15, 2, 127, 110, 1, NULL),
(3071, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 100w 90d 1s', 'EBT', 73, 16.5, 2, 100, 90, 1, NULL),
(3072, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 82d 1s', 'EBT', 73, 16.5, 2, 140, 82, 1, NULL),
(3073, 'EBT 16.5 2P 135', 'EBT 16.5gsm 2p 135w 115d 1s', 'EBT', 73, 16.5, 2, 135, 115, 1, NULL),
(3074, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 80d 3s', 'STN', 86, 18, 1, 30, 80, 3, NULL),
(3075, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 104d 3s', 'STN', 86, 18, 1, 30, 104, 3, NULL),
(3076, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 104d 3s', 'STN', 86, 18, 1, 33, 104, 3, NULL),
(3077, 'EBT 15.0 2P 130', 'EBT 15.0gsm 2p 130w 110d 1s', 'EBT', 73, 15, 2, 130, 110, 1, NULL),
(3078, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 105d 2s', 'STN', 86, 18, 1, 30, 105, 2, NULL),
(3079, 'EBT 17.0 2P 254', 'EBT 17.0gsm 2p 225w 105d 1s', 'EBT', 73, 17, 2, 225, 105, 1, NULL),
(3080, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 220w 120d 1s', 'EBT', 75, 17, 2, 220, 120, 1, NULL),
(3081, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 67d 5s', 'STN', 86, 17, 1, 30, 67, 5, NULL),
(3082, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 67d 4s', 'STN', 86, 17, 1, 30, 67, 4, NULL),
(3083, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 101d 5s', 'STN', 86, 17, 1, 30, 101, 5, NULL),
(3084, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 101d 4s', 'STN', 86, 17, 1, 30, 101, 4, NULL),
(3085, 'SFT 15.5 2P 40', 'SFT 15.5gsm 2p 40w 115d 2s', 'SFT', 84, 15.5, 2, 40, 115, 2, NULL),
(3086, 'SFT 15.5 2P 82', 'SFT 15.0gsm 2p 82w 115d 3s', 'SFT', 84, 15, 2, 82, 115, 3, NULL),
(3087, 'SFT 15.5 2P 82', 'SFT 15.5gsm 2p 82w 110d 3s', 'SFT', 84, 15.5, 2, 82, 110, 3, NULL),
(3088, 'EBT 17.5 2P 95', 'EBT 17.5gsm 2p 95w 80d 1s', 'EBT', 75, 17.5, 2, 95, 80, 1, NULL),
(3089, 'EBT 17.5 2P 95', 'EBT 17.5gsm 2p 95w 70d 1s', 'EBT', 75, 17.5, 2, 95, 70, 1, NULL),
(3090, 'SKT 23.0 2P 140', 'SKT 23.0gsm 1p 288w 240d 1s', 'SKT', 86, 23, 1, 288, 240, 1, NULL),
(3091, 'SWT 23.0 1P 19', 'SWT 23.0gsm 1p 19w 60d 7s', 'SWT', 86, 23, 1, 19, 60, 7, NULL),
(3092, 'SKT 23.0 1P 288', 'SKT 23.0gsm 2p 288w 180d 1s', 'SKT', 86, 23, 2, 288, 180, 1, NULL),
(3093, 'SKT 23.0 1P 288', 'SKT 23.0gsm 2p 288w 110d 1s', 'SKT', 86, 23, 2, 288, 110, 1, NULL),
(3094, 'SKT 23.0 1P 288', 'SKT 23.0gsm 2p 288w 160d 1s', 'SKT', 86, 23, 2, 288, 160, 1, NULL),
(3095, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 106d 4s', 'STN', 86, 18, 1, 30, 106, 4, NULL),
(3096, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 106d 4s', 'STN', 86, 18, 1, 33, 106, 4, NULL),
(3097, 'UTN 17.0 1P 66', 'UTN 17.0gsm 1p 66w 115d 2s', 'UTN', 55, 17, 1, 66, 115, 2, NULL),
(3098, 'EBT 17.5 2P 95', 'EBT 17.5gsm 2p 100w 115d 1s', 'EBT', 75, 17.5, 2, 100, 115, 1, NULL),
(3099, 'EBT 17.5 2P 95', 'EBT 17.5gsm 2p 73w 115d 1s', 'EBT', 75, 17.5, 2, 73, 115, 1, NULL),
(3100, 'PBT 15.5 2P 110', 'PBT 15.5gsm 2p 100w 100d 1s', 'PBT', 87, 15.5, 2, 100, 100, 1, NULL),
(3101, 'UTN 17.0 1P 66', 'UTN 17.0gsm 1p 66w 105d 2s', 'UTN', 55, 17, 1, 66, 105, 2, NULL),
(3102, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 200w 100d 1s', 'EBT', 73, 16.5, 2, 200, 100, 1, NULL),
(3103, 'SBT 16.5 2P 109', 'SBT 16.5gsm 2p 100w 100d 2s', 'SBT', 86, 16.5, 2, 100, 100, 2, NULL),
(3104, 'SBT 16.5 2P 175', 'SBT 16.5gsm 2p 176w 100d 1s', 'SBT', 86, 16.5, 2, 176, 100, 1, NULL),
(3105, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 108d 3s', 'STN', 86, 18, 1, 30, 108, 3, NULL),
(3106, 'SBT 15.5 2P 80', 'SBT 15.5gsm 2p 85w 115d 1s', 'SBT', 86, 15.5, 2, 85, 115, 1, NULL),
(3107, 'SKT 40.0 1P 75', 'SKT 40.0gsm 1p 65w 120d 1s', 'SKT', 86, 40, 1, 65, 120, 1, NULL),
(3108, 'SFT 15.5 2P 90', 'SFT 15.5gsm 2p 90w 115d 3s', 'SFT', 86, 15.5, 2, 90, 115, 3, NULL),
(3109, 'PFT 15.5 3P 43', 'PFT 15.5gsm 3p 38w 117d 3s', 'PFT', 87, 15.5, 3, 38, 117, 3, NULL),
(3110, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 90d 5s', 'STN', 87, 19, 1, 30, 90, 5, NULL),
(3111, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 103d 4s', 'STN', 86, 19, 1, 33, 103, 4, NULL),
(3112, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 105d 2s', 'SBT', 84, 18, 2, 142, 105, 2, NULL),
(3113, 'SKT 42.0 1P 80', 'SKT 42.0gsm 1p 90w 115d 1s', 'SKT', 84, 42, 1, 90, 115, 1, NULL),
(3114, 'PTN 17.0 1P 33', 'PTN 17.0gsm 1p 35w 115d 2s', 'PTN', 87, 17, 1, 35, 115, 2, NULL),
(3115, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 100w 100d 1s', 'EBT', 73, 16.5, 2, 100, 100, 1, NULL),
(3116, 'PBTB 16.5 1P 288', 'PBTB 17.0gsm 1p 288w 150d 1s', 'PBTB', 84, 17, 1, 288, 150, 1, NULL),
(3117, 'SBT 18.0 2P 142', 'SBT 16.5gsm 2p 14w 100d 2s', 'SBT', 84, 16.5, 2, 14, 100, 2, NULL),
(3118, 'EBT 15.0 2P 254', 'EBT 15.0gsm 2p 254w 107d 1s', 'EBT', 75, 15, 2, 254, 107, 1, NULL),
(3119, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 92d 4s', 'PTN', 82, 18, 1, 31.5, 92, 4, NULL),
(3120, 'EBT 15.0 2P 30', 'EBT 15.0gsm 2p 254w 115d 4s', 'EBT', 75, 15, 2, 254, 115, 4, NULL),
(3121, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 157d 1s', 'EBT', 75, 17, 2, 279, 157, 1, NULL),
(3122, 'EBT 17.0 2P 288', 'EBT 17.0gsm 2p 288w 50d 1s', 'EBT', 75, 17, 2, 288, 50, 1, NULL),
(3123, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 100w 96d 1s', 'EBT', 73, 16.5, 2, 100, 96, 1, NULL),
(3124, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 200w 100d 1s', 'EBT', 75, 17, 2, 200, 100, 1, NULL),
(3125, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 72d 1s', 'EBT', 73, 16.5, 2, 120, 72, 1, NULL),
(3126, 'PFT 14.0 3P 20', 'PFT 17.0gsm 2p 20w 150d 6s', 'PFT', 75, 17, 2, 20, 150, 6, NULL),
(3127, 'EBT 15.5 2P 262', 'EBT 15.5gsm 2p 262w 100d 1s', 'EBT', 74, 15.5, 2, 262, 100, 1, NULL),
(3128, 'EBT 15.5 2P 262', 'EBT 15.0gsm 2p 262w 115d 1s', 'EBT', 73, 15, 2, 262, 115, 1, NULL),
(3129, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 107d 1s', 'EBT', 73, 16.5, 2, 164, 107, 1, NULL),
(3130, 'EBT 18.0 2P 140', 'EBT 18.0gsm 2p 140w 105d 1s', 'EBT', 73, 18, 2, 140, 105, 1, NULL),
(3131, 'EBT 18.0 2P 140', 'EBT 18.0gsm 2p 140w 90d 1s', 'EBT', 73, 18, 2, 140, 90, 1, NULL),
(3132, 'SWT 19 1P 60', 'SWT 19.0gsm 1p 60w 56d 3s', 'SWT', 86, 19, 1, 60, 56, 3, NULL),
(3133, 'SWT 19 1P 60', 'SWT 19.0gsm 1p 60w 56d 2s', 'SWT', 86, 19, 1, 60, 56, 2, NULL),
(3134, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 120d 2s', 'PFT', 87, 14, 2, 80, 120, 2, NULL),
(3135, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 107d 4s', 'PFT', 87, 14, 2, 40, 107, 4, NULL),
(3136, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 107d 3s', 'PFT', 87, 14, 2, 40, 107, 3, NULL),
(3137, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 70d 1s', 'PFT', 87, 14, 2, 80, 70, 1, NULL),
(3138, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 70d 1s', 'PFT', 87, 14, 2, 40, 70, 1, NULL),
(3139, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 105d 4s', 'PFT', 87, 14, 2, 40, 105, 4, NULL),
(3140, 'PFT 14.0 2P 40', 'PFT 14.0gsm 2p 40w 105d 3s', 'PFT', 87, 14, 2, 40, 105, 3, NULL),
(3141, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 102d 1s', 'PBT', 87, 16.5, 2, 140, 102, 1, NULL),
(3142, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 85d 3s', 'PTN', 82, 18, 1, 31.5, 85, 3, NULL),
(3143, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 103d 5s', 'PTN', 82, 18, 1, 31.5, 103, 5, NULL),
(3144, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 103d 4s', 'PTN', 82, 18, 1, 31.5, 103, 4, NULL),
(3145, 'PBTS 16.5 1P 288', 'PBTS 16.5gsm 1p 288w 211d 2s', 'PBTS', 86, 16.5, 1, 288, 211, 2, NULL),
(3146, 'PBTs 15.5 2P 288', 'PBTS 16.5gsm 2p 288w 150d 1s', 'PBTS', 87, 16.5, 2, 288, 150, 1, NULL),
(3147, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 100w 60d 1s', 'EBT', 73, 16.5, 2, 100, 60, 1, NULL),
(3148, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 90d 3s', 'STN', 86, 19, 1, 33, 90, 3, NULL),
(3149, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 90d 3s', 'STN', 87, 19, 1, 30, 90, 3, NULL),
(3150, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 107d 4s', 'STN', 86, 19, 1, 33, 107, 4, NULL),
(3151, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 112d 4s', 'STN', 87, 19, 1, 30, 112, 4, NULL),
(3152, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 70d 1s', 'EBT', 73, 16.5, 2, 164, 70, 1, NULL),
(3153, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 110d 3s', 'STN', 86, 19, 1, 33, 110, 3, NULL),
(3154, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 58d 1s', 'EBT', 73, 16.5, 2, 120, 58, 1, NULL),
(3155, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 105d 4s', 'STN', 86, 19, 1, 33, 105, 4, NULL),
(3156, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 1156d 4s', 'STN', 87, 19, 1, 30, 1156, 4, NULL),
(3157, 'SBT 17.0 2P 282', 'SBT 17.0gsm 2p 279w 147d 1s', 'SBT', 82, 17, 2, 279, 147, 1, NULL),
(3158, 'PFT 14.0 2P 20', 'PFT 14.0gsm 2p 20w 115d 4s', 'PFT', 86, 14, 2, 20, 115, 4, NULL),
(3159, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 90d 3s', 'PTN', 82, 18, 1, 31.5, 90, 3, NULL),
(3160, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 279w 1500d 1s', 'SBT', 84, 17, 1, 279, 1500, 1, NULL),
(3161, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 136d 1s', 'PBTB', 87, 16.5, 2, 288, 136, 1, NULL),
(3162, 'SBT 17.0 2P 279', 'SBT 17.0gsm 2p 279w 110d 1s', 'SBT', 82, 17, 2, 279, 110, 1, NULL),
(3163, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 132d 1s', 'PBTB', 87, 16.5, 2, 288, 132, 1, NULL),
(3164, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 128d 1s', 'PBTB', 87, 16.5, 2, 288, 128, 1, NULL),
(3165, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 0d 1s', 'SBT', 84, 18, 2, 142, 0, 1, NULL),
(3166, 'SBT 17.0 2P 279', 'SBT 17.0gsm 2p 279w 150d 2s', 'SBT', 82, 17, 2, 279, 150, 2, NULL),
(3167, 'SBT 17.0 2P 275', 'SBT 17.0gsm 2p 275w 110d 1s', 'SBT', 82, 17, 2, 275, 110, 1, NULL),
(3168, 'SBT 17.0 2P 275', 'SBT 17.0gsm 2p 275w 125d 1s', 'SBT', 82, 17, 2, 275, 125, 1, NULL),
(3169, 'SBT 17.0 2P 275', 'SBT 17.0gsm 2p 275w 115d 1s', 'SBT', 82, 17, 2, 275, 115, 1, NULL),
(3170, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 142d 1s', 'PBTB', 87, 16.5, 2, 288, 142, 1, NULL),
(3171, 'PBTB 16.5 2P 288', 'PBTB 16.5gsm 2p 288w 107d 1s', 'PBTB', 87, 16.5, 2, 288, 107, 1, NULL),
(3172, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 93d 5s', 'PTN', 82, 18, 1, 31.5, 93, 5, NULL),
(3173, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 80d 5s', 'PTN', 82, 18, 1, 31.5, 80, 5, NULL),
(3174, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 107d 1s', 'SBT', 84, 18, 2, 142, 107, 1, NULL),
(3175, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 100d 2s', 'EBT', 73, 16.5, 2, 120, 100, 2, NULL),
(3176, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 90d 1s', 'PFT', 87, 14, 2, 80, 90, 1, NULL),
(3177, 'PFT 14.0 2P 100', 'PFT 14.0gsm 2p 100w 130d 2s', 'PFT', 87, 14, 2, 100, 130, 2, NULL),
(3178, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 130d 1s', 'PFT', 87, 14, 2, 80, 130, 1, NULL),
(3179, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 107d 1s', 'PFT', 87, 14, 2, 80, 107, 1, NULL),
(3180, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 152d 1s', 'SBT', 84, 17, 2, 288, 152, 1, NULL),
(3181, 'EBT 16.5 2P 164', 'EBT 16.5gsm 1p 164w 96d 1s', 'EBT', 73, 16.5, 1, 164, 96, 1, NULL),
(3182, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 108d 1s', 'EBT', 73, 15.5, 3, 254, 108, 1, NULL),
(3183, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 220w 105d 1s', 'EBT', 75, 17, 2, 220, 105, 1, NULL),
(3184, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 190w 100d 1s', 'EBT', 75, 17, 2, 190, 100, 1, NULL),
(3185, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 220w 150d 1s', 'EBT', 75, 17, 2, 220, 150, 1, NULL),
(3186, 'EBT 15.5 3P 254', 'EBT 15.5gsm 3p 254w 112d 1s', 'EBT', 73, 15.5, 3, 254, 112, 1, NULL),
(3187, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 159d 1s', 'SBT', 84, 17, 2, 288, 159, 1, NULL),
(3188, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 73d 1s', 'EBT', 73, 16.5, 2, 120, 73, 1, NULL),
(3189, 'EBT 15.5 3P 25', 'EBT 15.5gsm 3p 254w 115d 5s', 'EBT', 72, 15.5, 3, 254, 115, 5, NULL),
(3190, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 173d 1s', 'SBT', 84, 17, 2, 288, 173, 1, NULL),
(3191, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 105d 2s', 'STN', 86, 18, 1, 33, 105, 2, NULL),
(3192, 'SWT 23.0 1P 60', 'SWT 23.0gsm 1p 60w 60d 4s', 'SWT', 86, 23, 1, 60, 60, 4, NULL),
(3193, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 98d 5s', 'PTN', 82, 18, 1, 31.5, 98, 5, NULL),
(3194, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 98d 4s', 'PTN', 82, 18, 1, 31.5, 98, 4, NULL),
(3195, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 132d 1s', 'SBT', 84, 17, 2, 288, 132, 1, NULL),
(3196, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 105d 5s', 'STN', 86, 18, 1, 33, 105, 5, NULL),
(3197, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 1d 1s', 'SBT', 84, 18, 2, 142, 1, 1, NULL),
(3198, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 1010d 1s', 'EBT', 73, 16.5, 2, 140, 1010, 1, NULL),
(3199, 'SBT 16.5 2P 147', 'SBT 16.5gsm 2p 147w 100d 1s', 'SBT', 84, 16.5, 2, 147, 100, 1, NULL),
(3200, 'STN 17.0 1P 33', 'STN 16.5gsm 2p 33w 115d 4s', 'STN', 73, 16.5, 2, 33, 115, 4, NULL),
(3201, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 288w 90d 1s', 'SBT', 84, 17, 2, 288, 90, 1, NULL),
(3202, 'SKT 21.0 2P 100', 'SKT 21.0gsm 2p 100w 115d 2s', 'SKT', 86, 21, 2, 100, 115, 2, NULL),
(3203, 'EBT 15.0 3P 254', 'EBT 15.0gsm 3p 254w 110d 1s', 'EBT', 73, 15, 3, 254, 110, 1, NULL),
(3204, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 120w 60d 1s', 'EBT', 73, 16.5, 2, 120, 60, 1, NULL),
(3205, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 80w 88d 1s', 'EBT', 73, 16.5, 2, 80, 88, 1, NULL),
(3206, 'PBT+ 15.0 2P 288', 'PBT+ 15.0gsm 2p 288w 156d 1s', 'PBT+', 88, 15, 2, 288, 156, 1, NULL),
(3207, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 112d 3s', 'PTN', 87, 18, 1, 30, 112, 3, NULL),
(3208, 'PBT+ 15.0 1P 288', 'PBT+ 16.5gsm 1p 288w 250d 1s', 'PBT+', 86, 16.5, 1, 288, 250, 1, NULL),
(3209, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 116d 5s', 'PTN', 82, 18, 1, 31.5, 116, 5, NULL),
(3210, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 116d 4s', 'PTN', 82, 18, 1, 33, 116, 4, NULL),
(3211, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 116d 4s', 'PTN', 82, 18, 1, 31.5, 116, 4, NULL),
(3212, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 116d 2s', 'PTN', 82, 18, 1, 31.5, 116, 2, NULL),
(3213, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 96d 3s', 'PTN', 82, 18, 1, 31.5, 96, 3, NULL),
(3214, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 90d 3s', 'PTN', 82, 18, 1, 33, 90, 3, NULL),
(3215, 'PTN 18.0 1P 33', 'PTN 18.0gsm 1p 33w 105d 3s', 'PTN', 82, 18, 1, 33, 105, 3, NULL),
(3216, 'PBTS 16.5 1P 288', 'PBTS 16.5gsm 1p 288w 170d 1s', 'PBTS', 86, 16.5, 1, 288, 170, 1, NULL),
(3217, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 95d 2s', 'STN', 86, 18, 1, 30, 95, 2, NULL),
(3218, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 90d 2s', 'PTN', 82, 18, 1, 31.5, 90, 2, NULL),
(3219, 'SBT 16.5 2P 110', 'SBT 16.5gsm 2p 100w 110d 1s', 'SBT', 83, 16.5, 2, 100, 110, 1, NULL),
(3220, 'SBT 16.5 2P 164', 'SBT 16.5gsm 2p 164w 105d 2s', 'SBT', 84, 16.5, 2, 164, 105, 2, NULL),
(3221, 'SBT 19.0 2P 25', 'SBT 19.0gsm 2p 25w 115d 2s', 'SBT', 84, 19, 2, 25, 115, 2, NULL),
(3222, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 60d 3s', 'STN', 86, 18, 1, 30, 60, 3, NULL),
(3223, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 80d 5s', 'STN', 86, 18, 1, 30, 80, 5, NULL),
(3224, 'PTN 15.0 3P 22', 'PTN 15.0gsm 3p 22w 100d 3s', 'PTN', 87, 15, 3, 22, 100, 3, NULL),
(3225, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 60d 3s', 'STN', 86, 18, 1, 33, 60, 3, NULL),
(3226, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 112d 1s', 'SBT', 84, 18, 2, 142, 112, 1, NULL),
(3227, 'SKT 23.0 2P 140', 'SKT 23.0gsm 2p 140w 110d 1s', 'SKT', 86, 23, 2, 140, 110, 1, NULL),
(3228, 'EBT 15.0 3P 254', 'EBT 15.0gsm 3p 254w 108d 1s', 'EBT', 73, 15, 3, 254, 108, 1, NULL),
(3229, 'EBT 15.0 2P 30', 'EBT 15.0gsm 3p 30w 115d 1s', 'EBT', 75, 15, 3, 30, 115, 1, NULL),
(3230, 'EBT 15.0 3P 254', 'EBT 15.0gsm 3p 254w 112d 1s', 'EBT', 73, 15, 3, 254, 112, 1, NULL),
(3231, 'EBT 15.0 3P 254', 'EBT 15.0gsm 3p 254w 105d 1s', 'EBT', 73, 15, 3, 254, 105, 1, NULL),
(3232, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 90d 2s', 'STN', 86, 18, 1, 33, 90, 2, NULL),
(3233, 'EBT 15.0 3P 254', 'EBT 15.0gsm 3p 254w 107d 1s', 'EBT', 73, 15, 3, 254, 107, 1, NULL),
(3234, 'EBT 15.0 3P 254', 'EBT 15.0gsm 3p 30w 115d 4s', 'EBT', 73, 15, 3, 30, 115, 4, NULL),
(3235, 'EBT 15.0 3P 130', 'EBT 15.0gsm 3p 130w 107d 1s', 'EBT', 72, 15, 3, 130, 107, 1, NULL),
(3236, 'SKT 23.0 1P 288', 'SKT 23.0gsm 1p 288w 120d 1s', 'SKT', 86, 23, 1, 288, 120, 1, NULL),
(3237, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 106d 1s', 'EBT', 73, 16.5, 2, 140, 106, 1, NULL),
(3238, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 90d 5s', 'PTN', 87, 18, 1, 30, 90, 5, NULL),
(3239, 'STN 22.0 2P 140', 'STN 20.2gsm 2p 185w 115d 1s', 'STN', 86, 20.2, 2, 185, 115, 1, NULL),
(3240, 'PKT+ 21.0 1P 288', 'PKT+ 21.0gsm 1p 288w 78d 1s', 'PKT+', 86, 21, 1, 288, 78, 1, NULL),
(3241, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 33w 115d 1s', 'PTN', 82, 18, 1, 33, 115, 1, NULL),
(3242, 'PKT 23.0 2P 140', 'PKT 23.0gsm 2p 144w 110d 1s', 'PKT', 87, 23, 2, 144, 110, 1, NULL),
(3243, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 113d 1s', 'SBT', 86, 16.5, 2, 140, 113, 1, NULL),
(3244, 'SBT 16.5 2P 40', 'SBT 16.5gsm 2p 40w 110d 4s', 'SBT', 86, 16.5, 2, 40, 110, 4, NULL),
(3245, 'SBT 17.0 2P 279', 'SBT 17.0gsm 2p 279w 105d 1s', 'SBT', 82, 17, 2, 279, 105, 1, NULL),
(3246, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 118d 2s', 'PFT', 87, 14, 2, 80, 118, 2, NULL),
(3247, 'PFT 14.0 2P 80', 'PFT 18.0gsm 1p 80w 115d 2s', 'PFT', 82, 18, 1, 80, 115, 2, NULL),
(3248, 'SBT 15.5 2P 30', 'SBT 15.5gsm 2p 30w 115d 2s', 'SBT', 86, 15.5, 2, 30, 115, 2, NULL),
(3249, 'EBT 15.5 2P 262', 'EBT 15.5gsm 2p 262w 97d 1s', 'EBT', 73, 15.5, 2, 262, 97, 1, NULL),
(3250, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 10d 1s', 'EBT', 73, 16.5, 2, 120, 10, 1, NULL),
(3251, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 95d 3s', 'STN', 86, 18, 1, 30, 95, 3, NULL),
(3252, 'EBT 17.0 2P 289', 'EBT 17.0gsm 2p 289w 100d 1s', 'EBT', 73, 17, 2, 289, 100, 1, NULL),
(3253, 'STN 19.0 2P 33', 'STN 19.0gsm 2p 33w 107d 1s', 'STN', 85, 19, 2, 33, 107, 1, NULL),
(3254, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 85d 4s', 'STN', 86, 18, 1, 33, 85, 4, NULL),
(3255, 'PBTS 16.5 1P 288', 'PBTS 16.5gsm 1p 288w 120d 1s', 'PBTS', 86, 16.5, 1, 288, 120, 1, NULL),
(3256, 'STN 19.0 1P 32.5', 'STN 19.0gsm 1p 33w 104d 4s', 'STN', 86, 19, 1, 33, 104, 4, NULL),
(3257, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 115d 2s', 'STN', 87, 19, 1, 30, 115, 2, NULL),
(3258, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 90d 4s', 'STN', 86, 19, 1, 33, 90, 4, NULL),
(3259, 'EBT 15.0 2P 130', 'EBT 15.0gsm 2p 130w 108d 1s', 'EBT', 73, 15, 2, 130, 108, 1, NULL),
(3260, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 103d 1s', 'PBT', 87, 16.5, 2, 140, 103, 1, NULL),
(3261, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 112d 1s', 'PBT', 87, 16.5, 2, 140, 112, 1, NULL),
(3262, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 122d 4s', 'STN', 86, 18, 1, 30, 122, 4, NULL),
(3263, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 122d 4s', 'STN', 86, 18, 1, 33, 122, 4, NULL),
(3264, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 122d 3s', 'STN', 86, 18, 1, 33, 122, 3, NULL),
(3265, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 92d 3s', 'STN', 86, 18, 1, 33, 92, 3, NULL),
(3266, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 250d 1s', 'EBT', 75, 17, 1, 288, 250, 1, NULL),
(3267, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 289w 250d 1s', 'EBT', 75, 17, 1, 289, 250, 1, NULL),
(3268, 'PFT 14.5 2P 42', 'PFT 14.5gsm 2p 42w 100d 1s', 'PFT', 87, 14.5, 2, 42, 100, 1, NULL),
(3269, 'SBT 19.0 2P 142', 'SBT 19.0gsm 2p 130w 112d 1s', 'SBT', 85, 19, 2, 130, 112, 1, NULL),
(3270, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 85d 4s', 'STN', 86, 17, 1, 30, 85, 4, NULL),
(3271, 'STN 17.0 1P 30', 'STN 17.0gsm 1p 30w 85d 3s', 'STN', 86, 17, 1, 30, 85, 3, NULL),
(3272, 'SFT 14.5 2P 80', 'SFT 14.5gsm 2p 30w 70d 2s', 'SFT', 86, 14.5, 2, 30, 70, 2, NULL),
(3273, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 60d 4s', 'STN', 86, 18, 1, 30, 60, 4, NULL),
(3274, 'PBT 16.5 2P 140', 'PBT 16.5gsm 2p 140w 70d 1s', 'PBT', 87, 16.5, 2, 140, 70, 1, NULL),
(3275, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 98d 1s', 'SBT', 86, 16.5, 2, 140, 98, 1, NULL),
(3276, 'PBT 16.5 1P 288', 'PBT 16.5gsm 1p 288w 90d 1s', 'PBT', 86, 16.5, 1, 288, 90, 1, NULL),
(3277, 'EBT 17.0 2P 140', 'EBT 17.0gsm 2p 140w 107d 1s', 'EBT', 73, 17, 2, 140, 107, 1, NULL),
(3278, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 103d 1s', 'EBT', 73, 16.5, 2, 120, 103, 1, NULL),
(3279, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 164w 103d 1s', 'EBT', 73, 16.5, 2, 164, 103, 1, NULL),
(3280, 'PTN 20.0 1P 33', 'PTN 20.0gsm 1p 33w 120d 4s', 'PTN', 86, 20, 1, 33, 120, 4, NULL);
INSERT INTO `bpl_products` (`id`, `old`, `productname`, `gradetype`, `brightness`, `gsm`, `ply`, `width`, `diameter`, `slice`, `deleted_at`) VALUES
(3281, 'PTN 19.0 1P 30', 'PTN 19.0gsm 1p 30w 120d 5s', 'PTN', 87, 19, 1, 30, 120, 5, NULL),
(3282, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 75d 5s', 'PTN', 87, 18, 1, 30, 75, 5, NULL),
(3283, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 75d 4s', 'PTN', 87, 18, 1, 30, 75, 4, NULL),
(3284, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 110d 2s', 'SKT', 86, 40, 1, 100, 110, 2, NULL),
(3285, 'SKT 40.0 1P 80', 'SKT 40.0gsm 1p 80w 110d 2s', 'SKT', 86, 40, 1, 80, 110, 2, NULL),
(3286, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 110d 1s', 'SKT', 86, 40, 1, 100, 110, 1, NULL),
(3287, 'SKT+ 21.0 2P 288', 'SKT+ 40.0gsm 1p 282w 150d 1s', 'SKT+', 86, 40, 1, 282, 150, 1, NULL),
(3288, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 110d 5s', 'PTN', 87, 18, 1, 30, 110, 5, NULL),
(3289, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 60d 4s', 'PTN', 87, 18, 1, 30, 60, 4, NULL),
(3290, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 60d 5s', 'PTN', 87, 18, 1, 30, 60, 5, NULL),
(3291, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 80d 4s', 'STN', 86, 18, 1, 30, 80, 4, NULL),
(3292, 'EBT 19.0 2P 255', 'EBT 19.0gsm 2p 255w 105d 1s', 'EBT', 76, 19, 2, 255, 105, 1, NULL),
(3293, 'SKT 23.0 1P 288', 'SKT 15.0gsm 1p 288w 115d 1s', 'SKT', 86, 15, 1, 288, 115, 1, NULL),
(3294, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 60d 6s', 'STN', 86, 18, 1, 30, 60, 6, NULL),
(3295, 'SKT 23.0 1P 288', 'SKT 23.0gsm 1p 288w 1500d 1s', 'SKT', 86, 23, 1, 288, 1500, 1, NULL),
(3296, 'PKT 23.0 1P 288', 'PKT 25.0gsm 1p 288w 80d 1s', 'PKT', 87, 25, 1, 288, 80, 1, NULL),
(3297, 'SKT 23.0 1P 288', 'SKT 23.0gsm 2p 288w 120d 1s', 'SKT', 86, 23, 2, 288, 120, 1, NULL),
(3298, 'SKT 23.0 1P 288', 'SKT 25.0gsm 2p 288w 120d 1s', 'SKT', 86, 25, 2, 288, 120, 1, NULL),
(3299, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 80d 5s', 'STN', 86, 18, 1, 33, 80, 5, NULL),
(3300, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 1150d 1s', 'SBT', 84, 18, 2, 142, 1150, 1, NULL),
(3301, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 136d 1s', 'EBT', 75, 17, 2, 279, 136, 1, NULL),
(3302, 'EBT 16.5 2P 120', 'EBT 16.5gsm 2p 120w 110d 2s', 'EBT', 73, 16.5, 2, 120, 110, 2, NULL),
(3303, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 95d 4s', 'STN', 86, 19, 1, 33, 95, 4, NULL),
(3304, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 95d 3s', 'STN', 87, 19, 1, 30, 95, 3, NULL),
(3305, 'SBT 17.5 2P 95', 'SBT 17.5gsm 2p 95w 93d 1s', 'SBT', 89, 17.5, 2, 95, 93, 1, NULL),
(3306, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 70d 6s', 'STN', 86, 18, 1, 30, 70, 6, NULL),
(3307, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 70d 3s', 'STN', 86, 18, 1, 33, 70, 3, NULL),
(3308, 'STN 18.0 1P 32', 'STN 18.0gsm 1p 32w 115d 5s', 'STN', 86, 18, 1, 32, 115, 5, NULL),
(3309, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 115d 1s', 'STN', 87, 19, 1, 30, 115, 1, NULL),
(3310, 'SFT 14.5 2P 120', 'SFT 14.5gsm 2p 120w 100d 1s', 'SFT', 84, 14.5, 2, 120, 100, 1, NULL),
(3311, 'EBT 16.5 2P 164', 'EBT 16.5gsm 2p 160w 97d 1s', 'EBT', 73, 16.5, 2, 160, 97, 1, NULL),
(3312, 'EBT 15.0 3P 254', 'EBT 15.0gsm 3p 254w 100d 1s', 'EBT', 73, 15, 3, 254, 100, 1, NULL),
(3313, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 10d 1s', 'SBT', 86, 16.5, 2, 140, 10, 1, NULL),
(3314, 'SFT 14.5 2P 120', 'SFT 14.5gsm 2p 120w 112d 1s', 'SFT', 84, 14.5, 2, 120, 112, 1, NULL),
(3315, 'SBT 16.5 2P 140', 'SBT 16.5gsm 2p 140w 1115d 1s', 'SBT', 86, 16.5, 2, 140, 1115, 1, NULL),
(3316, 'SBT 17.0 2P 30', 'SBT 17.0gsm 2p 30w 110d 2s', 'SBT', 84, 17, 2, 30, 110, 2, NULL),
(3317, 'EBT 15.0 2P 30', 'EBT 15.0gsm 2p 30w 110d 3s', 'EBT', 75, 15, 2, 30, 110, 3, NULL),
(3318, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 126d 1s', 'EBT', 75, 17, 2, 279, 126, 1, NULL),
(3319, 'PFT 14.0 2P 100', 'PFT 16.5gsm 1p 100w 150d 2s', 'PFT', 87, 16.5, 1, 100, 150, 2, NULL),
(3320, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 100d 1s', 'PFT', 87, 14, 2, 80, 100, 1, NULL),
(3321, 'STN 19.0 1P 30', 'STN 19.0gsm 1p 30w 120d 4s', 'STN', 87, 19, 1, 30, 120, 4, NULL),
(3322, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 120d 3s', 'STN', 86, 19, 1, 33, 120, 3, NULL),
(3323, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 100d 2s', 'STN', 86, 19, 1, 33, 100, 2, NULL),
(3324, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 115d 3s', 'PTN', 87, 19, 1, 32.5, 115, 3, NULL),
(3325, 'PTN 19.0 1P 32.5', 'PTN 19.0gsm 1p 32.5w 90d 4s', 'PTN', 87, 19, 1, 32.5, 90, 4, NULL),
(3326, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 140w 101d 1s', 'EBT', 73, 16.5, 2, 140, 101, 1, NULL),
(3327, 'SBT 17.0 2P 30', 'SBT 17.0gsm 2p 30w 110d 1s', 'SBT', 84, 17, 2, 30, 110, 1, NULL),
(3328, 'SBT 19.0 2P 25', 'SBT 19.0gsm 2p 25w 115d 5s', 'SBT', 84, 19, 2, 25, 115, 5, NULL),
(3329, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 110d 2s', 'STN', 86, 19, 1, 33, 110, 2, NULL),
(3330, 'EBT 15.5 2P 256', 'EBT 15.5gsm 2p 256w 110d 1s', 'EBT', 73, 15.5, 2, 256, 110, 1, NULL),
(3331, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 150d 2s', 'EBT', 75, 17, 2, 279, 150, 2, NULL),
(3332, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 180d 1s', 'EBT', 75, 17, 2, 279, 180, 1, NULL),
(3333, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 109d 5s', 'PTN', 82, 18, 1, 31.5, 109, 5, NULL),
(3334, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 109d 4s', 'PTN', 82, 18, 1, 31.5, 109, 4, NULL),
(3335, 'PTN 18.0 1P 31.5', 'PTN 18.0gsm 1p 31.5w 120d 3s', 'PTN', 82, 18, 1, 31.5, 120, 3, NULL),
(3336, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 95d 4s', 'STN', 86, 18, 1, 33, 95, 4, NULL),
(3337, 'STN 18.0 1P 33', 'STN 18.0gsm 1p 33w 95d 5s', 'STN', 86, 18, 1, 33, 95, 5, NULL),
(3338, 'PTN 18.0 1P 30', 'PTN 18.0gsm 1p 30w 105d 3s', 'PTN', 87, 18, 1, 30, 105, 3, NULL),
(3339, 'STN 18.0 1P 30', 'STN 18.0gsm 1p 30w 103d 5s', 'STN', 86, 18, 1, 30, 103, 5, NULL),
(3340, 'SBT 18.0 2P 142', 'SBT 18.0gsm 2p 142w 111d 2s', 'SBT', 84, 18, 2, 142, 111, 2, NULL),
(3341, 'STN 19.0 1P 33', 'STN 19.0gsm 1p 33w 98d 4s', 'STN', 86, 19, 1, 33, 98, 4, NULL),
(3342, 'EBT 15.5 3P 130', 'EBT 15.5gsm 2p 130w 115d 1s', 'EBT', 72, 15.5, 2, 130, 115, 1, NULL),
(3343, 'PKT+ 21.0 1P 288', 'PKT 21.0gsm 1p 288w 150d 1s', 'PKT', 86, 21, 1, 288, 150, 1, NULL),
(3344, 'PFT 14.0 2P 40', 'PFT 14.5gsm 2p 40w 110d 3s', 'PFT', 87, 14.5, 2, 40, 110, 3, NULL),
(3345, 'SBT 16.5 2P 164', 'SBT 17.5gsm 2p 164w 115d 1s', 'SBT', 89, 17.5, 2, 164, 115, 1, NULL),
(3346, 'SBT 16.5 2P 109', 'SBT 16.5gsm 2p 95w 100d 1s', 'SBT', 86, 16.5, 2, 95, 100, 1, NULL),
(3347, 'SKT 40.0 1P 140', 'SKT 42.0gsm 1p 140w 115d 1s', 'SKT', 86, 42, 1, 140, 115, 1, NULL),
(3348, 'EBT 17.0 1P 288', 'EBT 17.0gsm 2p 288w 240d 1s', 'EBT', 75, 17, 2, 288, 240, 1, NULL),
(3349, 'SBT 17.0 1P 288', 'SBT 17.0gsm 1p 285w 115d 1s', 'SBT', 84, 17, 1, 285, 115, 1, NULL),
(3350, 'SBT 17.0 2P 288', 'SBT 17.0gsm 2p 285w 115d 1s', 'SBT', 84, 17, 2, 285, 115, 1, NULL),
(3351, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 240d 1s', 'SKT', 86, 40, 1, 100, 240, 1, NULL),
(3352, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 120d 1s', 'PBTS', 84, 17, 1, 288, 120, 1, NULL),
(3353, 'PTN 17.0 3P 33', 'PTN 15.0gsm 3p 33w 120d 1s', 'PTN', 87, 15, 3, 33, 120, 1, NULL),
(3354, 'SWT 19 1P 60', 'SWT 19.0gsm 1p 60w 50d 3s', 'SWT', 86, 19, 1, 60, 50, 3, NULL),
(3355, 'STN 19.0 2P 33', 'STN 19.0gsm 1p 33w 115d 1s', 'STN', 85, 19, 1, 33, 115, 1, NULL),
(3356, 'PFT 15.0 3P 21', 'PFT 15.0gsm 3p 21w 80d 1s', 'PFT', 87, 15, 3, 21, 80, 1, NULL),
(3357, 'PFT 14.0 2P 80', 'PFT 14.0gsm 2p 80w 80d 1s', 'PFT', 87, 14, 2, 80, 80, 1, NULL),
(3358, 'PBTb 15.5 1P 288', 'PBTB 15.5gsm 1p 288w 250d 1s', 'PBTB', 87, 15.5, 1, 288, 250, 1, NULL),
(3359, 'EBT 17.0 1P 288', 'EBT 17.0gsm 1p 288w 115d 1s', 'EBT', 75, 17, 1, 288, 115, 1, NULL),
(3360, 'PBTB 16.5 1P 288', 'PBTB 16.5gsm 1p 288w 120d 1s', 'PBTB', 87, 16.5, 1, 288, 120, 1, NULL),
(3361, 'PFT 15.0 2P 80', 'PFT 15.0gsm 2p 40w 115d 3s', 'PFT', 86, 15, 2, 40, 115, 3, NULL),
(3362, 'PBTS 16.5 1P 288', 'PBTS 16.5gsm 2p 288w 245d 1s', 'PBTS', 86, 16.5, 2, 288, 245, 1, NULL),
(3363, 'PBTS 17.0 1P 288', 'PBTS 17.0gsm 1p 288w 250d 1s', 'PBTS', 84, 17, 1, 288, 250, 1, NULL),
(3364, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 111d 1s', 'EBT', 75, 17, 2, 279, 111, 1, NULL),
(3365, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 115d 3s', 'PTN', 86, 19, 1, 31.5, 115, 3, NULL),
(3366, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 100d 5s', 'PTN', 86, 19, 1, 31.5, 100, 5, NULL),
(3367, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 100d 4s', 'PTN', 86, 19, 1, 31.5, 100, 4, NULL),
(3368, 'PFT 15.3 2P 84', 'PFT 15.3gsm 2p 84w 115d 2s', 'PFT', 87, 15.3, 2, 84, 115, 2, NULL),
(3369, 'PFT 15.3 2P 84', 'PFT 15.3gsm 2p 84w 115d 1s', 'PFT', 87, 15.3, 2, 84, 115, 1, NULL),
(3370, 'SBT 16.0 2P 288', 'SBT 16.0gsm 2p 288w 125d 1s', 'SBT', 84, 16, 2, 288, 125, 1, NULL),
(3371, 'SBT 16.0 2P 288', 'SBT 16.0gsm 2p 288w 140d 1s', 'SBT', 84, 16, 2, 288, 140, 1, NULL),
(3372, 'PFT(PEACH) 15.3 2P 100', 'PFT 15.3gsm 2p 100w 115d 2s', 'PFT', 42, 15.3, 2, 100, 115, 2, NULL),
(3373, 'PFT(PEACH) 15.3 2P 80', 'PFT 15.3gsm 2p 80w 115d 2s', 'PFT', 42, 15.3, 2, 80, 115, 2, NULL),
(3374, 'EBT 15.0 2P 30', 'EBT 15.5gsm 2p 30w 115d 4s', 'EBT', 73, 15.5, 2, 30, 115, 4, NULL),
(3375, 'SKT 40.0 1P 100', 'SKT 40.0gsm 1p 100w 72d 1s', 'SKT', 86, 40, 1, 100, 72, 1, NULL),
(3376, 'SKT 40.0 1P 75', 'SKT 40.0gsm 1p 75w 72d 1s', 'SKT', 86, 40, 1, 75, 72, 1, NULL),
(3377, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 105d 5s', 'PTN', 86, 19, 1, 31.5, 105, 5, NULL),
(3378, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 105d 4s', 'PTN', 86, 19, 1, 31.5, 105, 4, NULL),
(3379, 'PTN 19.0 1P 31.5', 'PTN 19.0gsm 1p 31.5w 115d 6s', 'PTN', 86, 19, 1, 31.5, 115, 6, NULL),
(3380, 'EBT 16.5 2P 140', 'EBT 17.0gsm 2p 140w 140d 1s', 'EBT', 75, 17, 2, 140, 140, 1, NULL),
(3381, 'PTN 17.0 1P 25', 'PTN 17.0gsm 1p 25w 115d 3s', 'PTN', 86, 17, 1, 25, 115, 3, NULL),
(3382, 'PTN 21.0 1P 31.5', 'PTN 16.5gsm 1p 31.5w 150d 5s', 'PTN', 87, 16.5, 1, 31.5, 150, 5, NULL),
(3383, 'PTN 19.0 1P 33', 'PTN 19.0gsm 1p 33w 115d 5s', 'PTN', 87, 19, 1, 33, 115, 5, NULL),
(3384, 'PBTb 15.5 1P 288', 'PBTB 15.5gsm 1p 288w 140d 1s', 'PBTB', 87, 15.5, 1, 288, 140, 1, NULL),
(3385, 'PTN 15.0 3P 33', 'PTN 15.0gsm 3p 33w 95d 4s', 'PTN', 87, 15, 3, 33, 95, 4, NULL),
(3386, 'PBT 16.5 2P 275', 'PBT 16.5gsm 2p 275w 108d 1s', 'PBT', 87, 16.5, 2, 275, 108, 1, NULL),
(3387, 'EBT 17.0 2P 279', 'EBT 17.0gsm 2p 279w 1130d 1s', 'EBT', 75, 17, 2, 279, 1130, 1, NULL),
(3388, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 130w 100d 1s', 'EBT', 73, 17, 2, 130, 100, 1, NULL),
(3389, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 130w 108d 1s', 'EBT', 73, 17, 2, 130, 108, 1, NULL),
(3390, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 115d 5s', 'SBT', 84, 17, 2, 130, 115, 5, NULL),
(3391, 'EBT 17.0 2P 130', 'EBT 17.0gsm 2p 130w 90d 1s', 'EBT', 73, 17, 2, 130, 90, 1, NULL),
(3392, 'SBT 16.0 3P 140', 'SBT 16.0gsm 3p 140w 100d 1s', 'SBT', 86, 16, 3, 140, 100, 1, NULL),
(3393, 'SBT 17.0 2P 130', 'SBT 17.0gsm 2p 130w 103d 1s', 'SBT', 84, 17, 2, 130, 103, 1, NULL),
(3394, 'SBT 16.0 2P 288', 'SBT 16.0gsm 2p 288w 160d 1s', 'SBT', 84, 16, 2, 288, 160, 1, NULL),
(3395, 'SBT 16.0 2P 288', 'SBT 16.0gsm 2p 288w 153d 1s', 'SBT', 84, 16, 2, 288, 153, 1, NULL),
(3396, 'SBT 16.0 2P 288', 'SBT 16.0gsm 2p 288w 157d 1s', 'SBT', 84, 16, 2, 288, 157, 1, NULL),
(3397, 'EBT 16.5 2P 140', 'EBT 16.5gsm 2p 100w 93d 1s', 'EBT', 73, 16.5, 2, 100, 93, 1, NULL),
(3398, 'STN 18.0 1P 31.5', 'STN 18.0gsm 2p 31.5w 115d 5s', 'STN', 84, 18, 2, 31.5, 115, 5, NULL),
(3399, 'STN 18.0 1P 31.5', 'STN 18.0gsm 2p 31.5w 110d 1s', 'STN', 86, 18, 2, 31.5, 110, 1, NULL),
(3400, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 100d 5s', 'PTN', 87, 21, 1, 31.5, 100, 5, NULL),
(3401, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 100d 4s', 'PTN', 87, 21, 1, 31.5, 100, 4, NULL),
(3402, 'SBT 17.0 2P 165', 'SBT 17.0gsm 2p 165w 105d 1s', 'SBT', 84, 17, 2, 165, 105, 1, NULL),
(3403, 'SBT 17.0 2P 95', 'SBT 17.0gsm 2p 95w 105d 1s', 'SBT', 84, 17, 2, 95, 105, 1, NULL),
(3404, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 105d 5s', 'STN', 86, 17, 1, 29, 105, 5, NULL),
(3405, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 105d 4s', 'STN', 86, 17, 1, 29, 105, 4, NULL),
(3406, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 107d 5s', 'STN', 86, 17, 1, 29, 107, 5, NULL),
(3407, 'STN 17.0 1P 29', 'STN 17.0gsm 1p 29w 107d 4s', 'STN', 86, 17, 1, 29, 107, 4, NULL),
(3408, 'STN 18.0 1P 31.5', 'STN 18.0gsm 1p 31.5w 98d 4s', 'STN', 86, 18, 1, 31.5, 98, 4, NULL),
(3409, 'PTN 21.0 1P 31.5', 'PTN 21.0gsm 1p 31.5w 115d 3s', 'PTN', 87, 21, 1, 31.5, 115, 3, NULL),
(3410, 'SFT 15.0 2P 100', 'SFT 15.0gsm 2p 100w 105d 2s', 'SFT', 84, 15, 2, 100, 105, 2, NULL),
(3411, 'EBT 15.0 2P 30', 'EBT 17.0gsm 2p 30w 110d 5s', 'EBT', 75, 17, 2, 30, 110, 5, NULL),
(3412, 'EBT 17.0 2P 256', 'EBT 17.0gsm 2p 256w 105d 1s', 'EBT', 75, 17, 2, 256, 105, 1, NULL),
(3413, 'EBT 17.0 2P 30', 'EBT 17.0gsm 2p 30w 110d 1s', 'EBT', 86, 17, 2, 30, 110, 1, NULL),
(3414, 'EBT 17.0 2P 256', 'EBT 17.0gsm 2p 256w 107d 1s', 'EBT', 75, 17, 2, 256, 107, 1, NULL),
(3415, 'ETN 17.0 1P 28.5', 'ETN 17.0gsm 1p 28.5w 110d 5s', 'ETN', 73, 17, 1, 28.5, 110, 5, NULL),
(3416, NULL, 'PBTS 16.0gsm 1p 288w 240d 1s', 'PBTS', 87, 16, 1, 288, 240, 1, NULL),
(3417, NULL, 'SBT 16.0gsm 1p 288w 150d 1s', 'SBT', 84, 16, 1, 288, 150, 1, NULL),
(3421, NULL, 'PTN 18.0gsm 1p 32w 115d 4s', 'PTN', 87, 18, 1, 32, 115, 4, NULL),
(3422, NULL, 'SBT 16.0gsm 2p 288w 150d 1s', 'SBT', 84, 16, 2, 288, 150, 1, NULL),
(3424, NULL, 'SBT 16.0gsm 2p 279w 150d 1s', 'SBT', 84, 16, 2, 279, 150, 1, NULL),
(3426, NULL, 'EBT 20.0gsm 2p 255w 115d 1s', 'EBT', 75, 20, 2, 255, 115, 1, NULL),
(3427, NULL, 'SKT 40.0gsm 1p 128w 115d 1s', 'SKT', 84, 40, 1, 128, 115, 1, NULL),
(3430, NULL, 'SBT 17.0gsm 2p 28w 115d 3s', 'SBT', 84, 17, 2, 28, 115, 3, NULL),
(3432, NULL, 'EBT 20.0gsm 2p 30w 115d 4s', 'EBT', 75, 20, 2, 30, 115, 4, NULL),
(3433, 'STN 17.0 1P 31.5', 'STN 17.0gsm 1p 31.5w 110d 5s', 'STN', 86, 17, 1, 31.5, 110, 5, NULL),
(3434, NULL, 'EBT 18.0gsm 2p 142w 110d 1s', 'EBT', 75, 18, 2, 142, 110, 1, NULL),
(3435, NULL, 'SBT 15.0gsm 2p 140w 115d 1s', 'SBT', 75, 15, 2, 140, 115, 1, NULL),
(3436, NULL, 'SBT 15.0gsm 2p 133.5w 115d 1s', 'SBT', 75, 15, 2, 133.5, 115, 1, NULL),
(3437, NULL, 'EBT 15.0gsm 2p 140w 115d 1s', 'EBT', 75, 15, 2, 140, 115, 1, NULL),
(3438, NULL, 'EBT 15.0gsm 2p 133.5w 115d 1s', 'EBT', 75, 15, 2, 133.5, 115, 1, NULL),
(3442, NULL, 'SBT 16.0gsm 2p 279w 180d 1s', 'SBT', 84, 16, 2, 279, 180, 1, NULL),
(3443, NULL, 'SKT 45.0gsm 1p 288w 120d 1s', 'SKT', 85, 45, 1, 288, 120, 1, NULL),
(3444, NULL, 'PBTB 18.0gsm 1p 288w 150d 1s', 'PBTB', 89, 18, 1, 288, 150, 1, NULL),
(3445, NULL, 'UBT 16.5gsm 2p 147w 115d 1s', 'UBT', 56, 16.5, 2, 147, 115, 1, NULL),
(3446, NULL, 'UBT 16.5gsm 2p 137w 115d 1s', 'UBT', 56, 16.5, 2, 137, 115, 1, NULL),
(3449, NULL, 'SBT 20.0gsm 2p 255w 115d 1s', 'SBT', 85, 20, 2, 255, 115, 1, NULL),
(3450, NULL, 'SKT 21.0gsm 2p 140w 110d 1s', 'SKT', 85, 21, 2, 140, 110, 1, NULL),
(3451, NULL, 'PBTB 18.0gsm 2p 288w 150d 1s', 'PBTB', 89, 18, 2, 288, 150, 1, NULL),
(3452, NULL, 'SKT 24.0gsm 2p 135w 115d 1s', 'SKT', 85, 24, 2, 135, 115, 1, NULL),
(3453, NULL, 'SKT 20.0gsm 2p 256w 115d 1s', 'SKT', 85, 20, 2, 256, 115, 1, NULL),
(3455, NULL, 'EBT 16.5gsm 2p 137w 115d 1s', 'EBT', 75, 16.5, 2, 137, 115, 1, NULL),
(3457, NULL, 'STN 17.0gsm 1p 25w 115d 5s', 'STN', 85, 17, 1, 25, 115, 5, NULL),
(3458, NULL, 'UKT 40.0gsm 2p 135w 115d 1s', 'UKT', 58, 40, 2, 135, 115, 1, NULL),
(3459, NULL, 'UKT 40.0gsm 2p 255w 115d 1s', 'UKT', 58, 40, 2, 255, 115, 1, NULL),
(3460, NULL, 'EBT 18.0gsm 2p 132w 115d 1s', 'EBT', 76, 18, 2, 132, 115, 1, NULL),
(3463, NULL, 'SKT 40.0gsm 2p 30w 115d 4s', 'SKT', 85, 40, 2, 30, 115, 4, NULL),
(3464, NULL, 'EBT 17.0gsm 2p 200w 115d 1s', 'EBT', 75, 17, 2, 200, 115, 1, NULL),
(3465, NULL, 'EBT 17.0gsm 2p 180w 115d 1s', 'EBT', 75, 17, 2, 180, 115, 1, NULL),
(3466, NULL, 'EBT 17.0gsm 1p 142w 150d 1s', 'EBT', 75, 17, 1, 142, 150, 1, NULL),
(3468, NULL, 'PKT 21.0gsm 2p 130w 115d 1s', 'PKT', 88, 21, 2, 130, 115, 1, NULL),
(3469, NULL, 'SBT 17.0gsm 2p 132w 115d 1s', 'SBT', 85, 17, 2, 132, 115, 1, NULL),
(3470, NULL, 'UKT 40.0gsm 2p 30w 115d 4s', 'UKT', 56, 40, 2, 30, 115, 4, NULL),
(3471, NULL, 'UKT 40.0gsm 2p 255w 105d 1s', 'UKT', 56, 40, 2, 255, 105, 1, NULL),
(3472, NULL, 'UKT 40.0gsm 2p 255w 110d 1s', 'UKT', 56, 40, 2, 255, 110, 1, NULL),
(3473, NULL, 'UBT 19.0gsm 2p 288w 115d 1s', 'UBT', 56, 19, 2, 288, 115, 1, NULL),
(3474, NULL, 'PBTS 16.0gsm 2p 288w 180d 1s', 'PBTS', 88, 16, 2, 288, 180, 1, NULL),
(3476, NULL, 'SBT 16.5gsm 2p 165w 115d 1s', 'SBT', 85, 16.5, 2, 165, 115, 1, NULL),
(3477, NULL, 'SBT 16.5gsm 2p 95w 115d 1s', 'SBT', 85, 16.5, 2, 95, 115, 1, NULL),
(3479, NULL, 'SKT 24.0gsm 1p 288w 180d 1s', 'SKT', 85, 24, 1, 288, 180, 1, NULL),
(3480, NULL, 'SKT 40.0gsm 1p 256w 115d 1s', 'SKT', 85, 40, 1, 256, 115, 1, NULL),
(3483, NULL, 'UBT 17.0gsm 2p 140w 110d 1s', 'UBT', 55, 17, 2, 140, 110, 1, NULL),
(3484, NULL, 'UBT 17.0gsm 2p 140w 100d 1s', 'UBT', 55, 17, 2, 140, 100, 1, NULL),
(3485, NULL, 'UBT 17.0gsm 2p 140w 80d 1s', 'UBT', 55, 17, 2, 140, 80, 1, NULL),
(3486, NULL, 'UBT 21.0gsm 1p 288w 240d 1s', 'UBT', 56, 21, 1, 288, 240, 1, NULL),
(3487, NULL, 'UBT 21.0gsm 2p 288w 180d 1s', 'UBT', 56, 21, 2, 288, 180, 1, NULL),
(3488, NULL, 'SKT 23.0gsm 2p 144w 115d 1s', 'SKT', 85, 23, 2, 144, 115, 1, NULL),
(3489, NULL, 'UBT 17.0gsm 2p 144w 115d 1s', 'UBT', 56, 17, 2, 144, 115, 1, NULL),
(3490, NULL, 'UKT 23.0gsm 2p 144w 115d 1s', 'UKT', 56, 23, 2, 144, 115, 1, NULL),
(3491, NULL, 'SKT 24.0gsm 1p 289w 240d 1s', 'SKT', 85, 24, 1, 289, 240, 1, NULL),
(3492, NULL, 'SKT 45.0gsm 1p 289w 120d 1s', 'SKT', 85, 45, 1, 289, 120, 1, NULL),
(3493, NULL, 'PTN 15.0gsm 2p 66w 115d 1s', 'PTN', 86, 15, 2, 66, 115, 1, NULL),
(3494, NULL, 'PTN 15.0gsm 2p 66w 115d 2s', 'PTN', 86, 15, 2, 66, 115, 2, NULL),
(3495, NULL, 'UBT 16.5gsm 2p 140w 110d 1s', 'UBT', 56, 16.5, 2, 140, 110, 1, NULL),
(3496, NULL, 'UKT 40.0gsm 1p 288w 240d 1s', 'UKT', 56, 40, 1, 288, 240, 1, NULL),
(3497, NULL, 'SBT 17.0gsm 2p 100w 115d 1s', 'SBT', 84, 17, 2, 100, 115, 1, NULL),
(3498, NULL, 'SBT 17.0gsm 2p 80w 115d 1s', 'SBT', 84, 17, 2, 80, 115, 1, NULL),
(3503, NULL, 'SKTS 25.0gsm 1p 288w 240d 1s', 'SKTS', 85, 25, 1, 288, 240, 1, NULL),
(3504, NULL, 'PKTS 25.0gsm 1p 288w 240d 1s', 'PKTS', 88, 25, 1, 288, 240, 1, NULL),
(3505, NULL, 'PFT 15.5gsm 2p 42.5w 115d 3s', 'PFT', 88, 15.5, 2, 42.5, 115, 3, NULL),
(3506, NULL, 'PBTB 20.0gsm 1p 288w 150d 1s', 'PBTB', 86, 20, 1, 288, 150, 1, NULL),
(3507, NULL, 'PBTS 17.0gsm 2p 288w 180d 1s', 'PBTS', 86, 17, 2, 288, 180, 1, NULL),
(3509, NULL, 'PBTS 17.0gsm 2p 188w 150d 1s', 'PBTS', 86, 17, 2, 188, 150, 1, NULL),
(3510, NULL, 'SBT 18.5gsm 2p 132w 115d 1s', 'SBT', 86, 18.5, 2, 132, 115, 1, NULL),
(3511, NULL, 'SBT 18.5gsm 2p 130w 115d 1s', 'SBT', 86, 18.5, 2, 130, 115, 1, NULL),
(3512, NULL, 'PBTB 20.0gsm 2p 288w 120d 1s', 'PBTB', 86, 20, 2, 288, 120, 1, NULL),
(3513, NULL, 'PBTB 20.0gsm 2p 288w 180d 1s', 'PBTB', 86, 20, 2, 288, 180, 1, NULL),
(3514, NULL, 'PBTB 20.0gsm 2p 288w 150d 1s', 'PBTB', 86, 20, 2, 288, 150, 1, NULL),
(3515, NULL, 'PKT+ 25.0gsm 1p 288w 180d 1s', 'PKT+', 87, 25, 1, 288, 180, 1, NULL),
(3516, NULL, 'PKT+ 25.0gsm 1p 288w 240d 1s', 'PKT+', 87, 25, 1, 288, 240, 1, NULL),
(3517, NULL, 'PKT+ 25.0gsm 2p 288w 150d 1s', 'PKT+', 87, 25, 2, 288, 150, 1, NULL),
(3518, NULL, 'PKT+ 25.0gsm 2p 288w 180d 1s', 'PKT+', 87, 25, 2, 288, 180, 1, NULL),
(3519, NULL, 'SKT+ 25.0gsm 1p 288w 240d 1s', 'SKT+', 85, 25, 1, 288, 240, 1, NULL),
(3520, NULL, 'SKT+ 25.0gsm 1p 288w 180d 1s', 'SKT+', 85, 25, 1, 288, 180, 1, NULL),
(3521, NULL, 'SKT+ 25.0gsm 2p 288w 180d 1s', 'SKT+', 85, 25, 2, 288, 180, 1, NULL),
(3522, NULL, 'SKT+ 25.0gsm 2p 288w 150d 1s', 'SKT+', 85, 25, 2, 288, 150, 1, NULL),
(3523, NULL, 'STN 17.0gsm 2p 29w 115d 3s', 'STN', 86, 17, 2, 29, 115, 3, NULL),
(3524, NULL, 'SKT+ 28.0gsm 1p 288w 240d 1s', 'SKT+', 85, 28, 1, 288, 240, 1, NULL),
(3525, NULL, 'STN 20.0gsm 2p 30w 115d 4s', 'STN', 86, 20, 2, 30, 115, 4, NULL),
(3526, NULL, 'STN 20.0gsm 2p 30w 115d 3s', 'STN', 86, 20, 2, 30, 115, 3, NULL),
(3527, NULL, 'STN 20.0gsm 2p 30w 115d 2s', 'STN', 86, 20, 2, 30, 115, 2, NULL),
(3528, NULL, 'SKT 20.0gsm 2p 30w 115d 4s', 'SKT', 86, 20, 2, 30, 115, 4, NULL),
(3529, NULL, 'SKT 20.0gsm 2p 30w 115d 3s', 'SKT', 86, 20, 2, 30, 115, 3, NULL),
(3530, NULL, 'SKT 20.0gsm 2p 30w 115d 2s', 'SKT', 86, 20, 2, 30, 115, 2, NULL),
(3531, NULL, 'EBT 18.0gsm 2p 279w 150d 1s', 'EBT', 75, 18, 2, 279, 150, 1, NULL),
(3532, NULL, 'EBT 18.0gsm 2p 279w 120d 1s', 'EBT', 75, 18, 2, 279, 120, 1, NULL),
(3533, NULL, 'EBT 18.0gsm 1p 279w 170d 1s', 'EBT', 75, 18, 1, 279, 170, 1, NULL),
(3534, NULL, 'SKT 40.0gsm 1p 25w 115d 4s', 'SKT', 84, 40, 1, 25, 115, 4, NULL),
(3536, NULL, 'SKT 40.0gsm 1p 25w 115d 3s', 'SKT', 84, 40, 1, 25, 115, 3, NULL),
(3537, NULL, 'SKT 40.0gsm 1p 25w 115d 2s', 'SKT', 84, 40, 1, 25, 115, 2, NULL),
(3538, NULL, 'EBT 18.0gsm 1p 279w 150d 1s', 'EBT', 75, 18, 1, 279, 150, 1, NULL),
(3539, NULL, 'PKT 20.0gsm 2p 165w 115d 1s', 'PKT', 86, 20, 2, 165, 115, 1, NULL),
(3540, NULL, 'PKT 20.0gsm 2p 120w 115d 1s', 'PKT', 86, 20, 2, 120, 115, 1, NULL),
(3541, NULL, 'PKT 22.0gsm 2p 165w 115d 1s', 'PKT', 86, 22, 2, 165, 115, 1, NULL),
(3542, NULL, 'PKT 22.0gsm 2p 120w 115d 1s', 'PKT', 86, 22, 2, 120, 115, 1, NULL),
(3543, NULL, 'PKT 24.0gsm 2p 165w 115d 1s', 'PKT', 86, 24, 2, 165, 115, 1, NULL),
(3544, NULL, 'PKT 24.0gsm 2p 120w 115d 1s', 'PKT', 86, 24, 2, 120, 115, 1, NULL),
(3545, NULL, 'EBT 18.0gsm 1p 276w 150d 1s', 'EBT', 75, 18, 1, 276, 150, 1, NULL),
(3546, NULL, 'UBT 22.0gsm 2p 180w 115d 1s', 'UBT', 58, 22, 2, 180, 115, 1, NULL),
(3547, NULL, 'UBT 22.0gsm 2p 200w 115d 1s', 'UBT', 58, 22, 2, 200, 115, 1, NULL),
(3548, NULL, 'EBT 20.0gsm 2p 180w 115d 1s', 'EBT', 75, 20, 2, 180, 115, 1, NULL),
(3549, NULL, 'EBT 20.0gsm 2p 200w 115d 1s', 'EBT', 75, 20, 2, 200, 115, 1, NULL),
(3550, NULL, 'EBT 18.0gsm 1p 276w 120d 1s', 'EBT', 75, 18, 1, 276, 120, 1, NULL),
(3551, NULL, 'EBT 18.0gsm 1p 288w 240d 1s', 'EBT', 75, 18, 1, 288, 240, 1, NULL),
(3552, NULL, 'EBT 18.0gsm 2p 288w 150d 1s', 'EBT', 75, 18, 2, 288, 150, 1, NULL),
(3553, NULL, 'EBT 18.0gsm 2p 288w 120d 1s', 'EBT', 75, 18, 2, 288, 120, 1, NULL),
(3554, NULL, 'SBT 19.5gsm 1p 288w 240d 1s', 'SBT', 85, 19.5, 1, 288, 240, 1, NULL),
(3555, NULL, 'STN 19.0gsm 1p 31.5w 115d 4s', 'STN', 86, 19, 1, 31.5, 115, 4, NULL),
(3556, NULL, 'STN 19.0gsm 1p 31.5w 115d 5s', 'STN', 86, 19, 1, 31.5, 115, 5, NULL),
(3557, NULL, 'PTN 23.0gsm 1p 31.5w 115d 4s', 'PTN', 86, 23, 1, 31.5, 115, 4, NULL),
(3558, NULL, 'PTN 23.0gsm 1p 31.5w 115d 5s', 'PTN', 86, 23, 1, 31.5, 115, 5, NULL),
(3559, NULL, 'PBTS 17.0gsm 2p 288w 150d 1s', 'PBTS', 86, 17, 2, 288, 150, 1, NULL),
(3562, NULL, 'SKT 24.0gsm 2p 288w 150d 1s', 'SKT', 86, 24, 2, 288, 150, 1, NULL),
(3563, NULL, 'EBT 19.5gsm 1p 288w 240d 1s', 'EBT', 76, 19.5, 1, 288, 240, 1, NULL),
(3564, NULL, 'SKT 45.0gsm 1p 95w 100d 2s', 'SKT', 86, 45, 1, 95, 100, 2, NULL),
(3565, NULL, 'EBT 20.0gsm 1p 288w 240d 1s', 'EBT', 75, 20, 1, 288, 240, 1, NULL),
(3566, NULL, 'EBT 20.0gsm 2p 288w 150d 1s', 'EBT', 75, 20, 2, 288, 150, 1, NULL),
(3567, NULL, 'EBT 20.0gsm 2p 288w 120d 1s', 'EBT', 75, 20, 2, 288, 120, 1, NULL),
(3568, NULL, 'STN 18.0gsm 1p 31.5w 125d 4s', 'STN', 86, 18, 1, 31.5, 125, 4, NULL),
(3569, NULL, 'STN 18.0gsm 1p 31.5w 125d 5s', 'STN', 86, 18, 1, 31.5, 125, 5, NULL),
(3570, NULL, 'PTN 21.0gsm 1p 31.5w 125d 4s', 'PTN', 87, 21, 1, 31.5, 125, 4, NULL),
(3571, NULL, 'PTN 21.0gsm 1p 31.5w 125d 5s', 'PTN', 87, 21, 1, 31.5, 125, 5, NULL),
(3572, NULL, 'SBT 20.0gsm 1p 288w 240d 1s', 'SBT', 86, 20, 1, 288, 240, 1, NULL),
(3573, NULL, 'SBT 20.0gsm 2p 288w 120d 1s', 'SBT', 86, 20, 2, 288, 120, 1, NULL),
(3574, NULL, 'SBT 20.0gsm 2p 288w 150d 1s', 'SBT', 86, 20, 2, 288, 150, 1, NULL),
(3575, NULL, 'SBT 20.0gsm 2p 288w 180d 1s', 'SBT', 86, 20, 2, 288, 180, 1, NULL),
(3576, NULL, 'EBT 20.0gsm 2p 279w 150d 1s', 'EBT', 73, 20, 2, 279, 150, 1, NULL),
(3577, NULL, 'EBT 20.0gsm 2p 279w 120d 1s', 'EBT', 73, 20, 2, 279, 120, 1, NULL),
(3578, NULL, 'UBT 20.0gsm 2p 288w 150d 1s', 'UBT', 56, 20, 2, 288, 150, 1, NULL),
(3579, NULL, 'UBT 21.0gsm 2p 288w 150d 1s', 'UBT', 56, 21, 2, 288, 150, 1, NULL),
(3580, NULL, 'STN 18.0gsm 2p 40w 115d 4s', 'STN', 86, 18, 2, 40, 115, 4, NULL),
(3581, NULL, 'STN 18.0gsm 2p 40w 115d 3s', 'STN', 86, 18, 2, 40, 115, 3, NULL),
(3582, NULL, 'STN 16.5gsm 2p 40w 115d 4s', 'STN', 86, 16.5, 2, 40, 115, 4, NULL),
(3583, NULL, 'STN 16.5gsm 2p 40w 115d 3s', 'STN', 86, 16.5, 2, 40, 115, 3, NULL),
(3584, NULL, 'STN 17.0gsm 2p 40w 115d 4s', 'STN', 86, 17, 2, 40, 115, 4, NULL),
(3585, NULL, 'STN 17.0gsm 2p 40w 115d 3s', 'STN', 86, 17, 2, 40, 115, 3, NULL),
(3586, NULL, 'STN 17.0gsm 2p 28w 115d 5s', 'STN', 86, 17, 2, 28, 115, 5, NULL),
(3587, NULL, 'STN 17.0gsm 2p 28w 115d 4s', 'STN', 86, 17, 2, 28, 115, 4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bpl_proforma`
--

DROP TABLE IF EXISTS `bpl_proforma`;
CREATE TABLE IF NOT EXISTS `bpl_proforma` (
  `order_id` int(11) NOT NULL,
  `customer_ref` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `freight` varchar(100) CHARACTER SET utf8 NOT NULL,
  `container` int(11) NOT NULL,
  `freight_price` float NOT NULL,
  `terms` varchar(100) CHARACTER SET utf8 NOT NULL,
  `shipment` varchar(100) CHARACTER SET utf8 NOT NULL,
  `payment_term_id` int(11) NOT NULL,
  `nxp` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `currency_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date` varchar(11) CHARACTER SET utf8 NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_proforma_items`
--

DROP TABLE IF EXISTS `bpl_proforma_items`;
CREATE TABLE IF NOT EXISTS `bpl_proforma_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_item_id` int(11) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_item_id` (`order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bpl_sales`
--

DROP TABLE IF EXISTS `bpl_sales`;
CREATE TABLE IF NOT EXISTS `bpl_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(20) CHARACTER SET utf8 NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL,
  `customerid` int(11) NOT NULL,
  `date` varchar(11) CHARACTER SET utf8 NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ref` (`ref`,`customerid`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_sales`
--

INSERT INTO `bpl_sales` (`id`, `ref`, `username`, `customerid`, `date`, `created_at`, `updated_at`, `deleted_at`) VALUES
(159, '001', 'vincent', 2, '2021/11/04', '2021-11-04 15:00:00', NULL, NULL),
(160, '002', 'vincent', 2, '2021/11/04', '2021-11-04 15:00:04', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bpl_sales_items`
--

DROP TABLE IF EXISTS `bpl_sales_items`;
CREATE TABLE IF NOT EXISTS `bpl_sales_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `productid` int(11) DEFAULT NULL,
  `weight` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_sales_items`
--

INSERT INTO `bpl_sales_items` (`id`, `order_id`, `productid`, `weight`) VALUES
(260, 159, 1, 2000),
(261, 159, 2, 2000),
(262, 159, 5, 2000),
(263, 159, 4, 2000),
(264, 159, 6, 2000),
(265, 160, 1, 2000),
(266, 160, 2, 2000),
(267, 160, 5, 2000),
(268, 160, 4, 2000),
(269, 160, 6, 2000);

-- --------------------------------------------------------

--
-- Table structure for table `bpl_stock`
--

DROP TABLE IF EXISTS `bpl_stock`;
CREATE TABLE IF NOT EXISTS `bpl_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` tinyint(4) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) UNSIGNED NOT NULL,
  `weight` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE KEYS` (`location_id`,`product_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bpl_stock`
--

INSERT INTO `bpl_stock` (`id`, `location_id`, `product_id`, `quantity`, `weight`) VALUES
(1, 3, 1, 0, 0),
(2, 3, 2, 1, 1500),
(3, 4, 1, 1, 1500);

-- --------------------------------------------------------

--
-- Table structure for table `bpl_stock_locations`
--

DROP TABLE IF EXISTS `bpl_stock_locations`;
CREATE TABLE IF NOT EXISTS `bpl_stock_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL,
  `location` varchar(20) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location` (`location`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_stock_locations`
--

INSERT INTO `bpl_stock_locations` (`id`, `type`, `location`) VALUES
(1, 0, 'PM2'),
(2, 0, 'PM3'),
(3, 1, 'PM2 Store'),
(4, 1, 'PM3 Store'),
(5, 1, 'Waste Paper Store');

-- --------------------------------------------------------

--
-- Table structure for table `bpl_storeentrance`
--

DROP TABLE IF EXISTS `bpl_storeentrance`;
CREATE TABLE IF NOT EXISTS `bpl_storeentrance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `barcode` varchar(20) CHARACTER SET utf8 NOT NULL,
  `location_id` tinyint(4) NOT NULL,
  `date` varchar(20) CHARACTER SET utf8 NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_storeentrance`
--

INSERT INTO `bpl_storeentrance` (`id`, `user`, `barcode`, `location_id`, `date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 'admin', '21-11-30-M2-001', 3, '2021/12/01', NULL, '2021-12-01 15:03:26', NULL, NULL),
(4, 'admin', '21-11-29-M3-001', 4, '2021/12/01', NULL, '2021-12-01 15:04:04', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bpl_storeentrance_trash`
--

DROP TABLE IF EXISTS `bpl_storeentrance_trash`;
CREATE TABLE IF NOT EXISTS `bpl_storeentrance_trash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletion_id` varchar(255) NOT NULL,
  `created_at` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_storeentrance_trash`
--

INSERT INTO `bpl_storeentrance_trash` (`id`, `deletion_id`, `created_at`, `user`) VALUES
(1, 'BPL_SE_DEL_001', '21-12-01', 'clinton');

-- --------------------------------------------------------

--
-- Table structure for table `bpl_storeentrance_trash_details`
--

DROP TABLE IF EXISTS `bpl_storeentrance_trash_details`;
CREATE TABLE IF NOT EXISTS `bpl_storeentrance_trash_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletion_id` varchar(255) NOT NULL,
  `date_of_entrance` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `barcode` varchar(1255) NOT NULL,
  `productname` varchar(255) NOT NULL,
  `gradetype` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `weight` int(11) NOT NULL,
  `created_at` varchar(255) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bpl_storeentrance_trash_details`
--

INSERT INTO `bpl_storeentrance_trash_details` (`id`, `deletion_id`, `date_of_entrance`, `barcode`, `productname`, `gradetype`, `location`, `weight`, `created_at`, `updated_at`, `user`) VALUES
(1, 'BPL_SE_DEL_001', '2021-12-01 15:03:26.000000', '21-11-29-M2-001', 'EBT 15.0gsm 1p 256w 115d 1s', 'EBT', 'PM2 Store', 1000, '21-12-01', '2021-12-01 15:05:49', 'clinton'),
(2, 'BPL_SE_DEL_001', '2021-12-01 15:03:26.000000', '21-11-29-M2-002', 'EBT 15.0gsm 1p 256w 115d 1s', 'EBT', 'PM2 Store', 2000, '21-12-01', '2021-12-01 15:05:49', 'clinton');

-- --------------------------------------------------------

--
-- Table structure for table `bpl_storeexit`
--

DROP TABLE IF EXISTS `bpl_storeexit`;
CREATE TABLE IF NOT EXISTS `bpl_storeexit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `barcode` varchar(20) CHARACTER SET utf8 NOT NULL,
  `location_id` tinyint(4) NOT NULL,
  `date` varchar(20) CHARACTER SET utf8 NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso` char(2) NOT NULL,
  `name` varchar(80) NOT NULL,
  `nicename` varchar(80) NOT NULL,
  `iso3` char(3) DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  `phonecode` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`) VALUES
(1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG', 4, 93),
(2, 'AL', 'ALBANIA', 'Albania', 'ALB', 8, 355),
(3, 'DZ', 'ALGERIA', 'Algeria', 'DZA', 12, 213),
(4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM', 16, 1684),
(5, 'AD', 'ANDORRA', 'Andorra', 'AND', 20, 376),
(6, 'AO', 'ANGOLA', 'Angola', 'AGO', 24, 244),
(7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA', 660, 1264),
(8, 'AQ', 'ANTARCTICA', 'Antarctica', NULL, NULL, 0),
(9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG', 28, 1268),
(10, 'AR', 'ARGENTINA', 'Argentina', 'ARG', 32, 54),
(11, 'AM', 'ARMENIA', 'Armenia', 'ARM', 51, 374),
(12, 'AW', 'ARUBA', 'Aruba', 'ABW', 533, 297),
(13, 'AU', 'AUSTRALIA', 'Australia', 'AUS', 36, 61),
(14, 'AT', 'AUSTRIA', 'Austria', 'AUT', 40, 43),
(15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE', 31, 994),
(16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS', 44, 1242),
(17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR', 48, 973),
(18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD', 50, 880),
(19, 'BB', 'BARBADOS', 'Barbados', 'BRB', 52, 1246),
(20, 'BY', 'BELARUS', 'Belarus', 'BLR', 112, 375),
(21, 'BE', 'BELGIUM', 'Belgium', 'BEL', 56, 32),
(22, 'BZ', 'BELIZE', 'Belize', 'BLZ', 84, 501),
(23, 'BJ', 'BENIN', 'Benin', 'BEN', 204, 229),
(24, 'BM', 'BERMUDA', 'Bermuda', 'BMU', 60, 1441),
(25, 'BT', 'BHUTAN', 'Bhutan', 'BTN', 64, 975),
(26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL', 68, 591),
(27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH', 70, 387),
(28, 'BW', 'BOTSWANA', 'Botswana', 'BWA', 72, 267),
(29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', NULL, NULL, 0),
(30, 'BR', 'BRAZIL', 'Brazil', 'BRA', 76, 55),
(31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', NULL, NULL, 246),
(32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN', 96, 673),
(33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR', 100, 359),
(34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA', 854, 226),
(35, 'BI', 'BURUNDI', 'Burundi', 'BDI', 108, 257),
(36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM', 116, 855),
(37, 'CM', 'CAMEROON', 'Cameroon', 'CMR', 120, 237),
(38, 'CA', 'CANADA', 'Canada', 'CAN', 124, 1),
(39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV', 132, 238),
(40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM', 136, 1345),
(41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF', 140, 236),
(42, 'TD', 'CHAD', 'Chad', 'TCD', 148, 235),
(43, 'CL', 'CHILE', 'Chile', 'CHL', 152, 56),
(44, 'CN', 'CHINA', 'China', 'CHN', 156, 86),
(45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', NULL, NULL, 61),
(46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', NULL, NULL, 672),
(47, 'CO', 'COLOMBIA', 'Colombia', 'COL', 170, 57),
(48, 'KM', 'COMOROS', 'Comoros', 'COM', 174, 269),
(49, 'CG', 'CONGO', 'Congo', 'COG', 178, 242),
(50, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', 'COD', 180, 242),
(51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK', 184, 682),
(52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI', 188, 506),
(53, 'CI', 'COTE D\'IVOIRE', 'Cote D\'Ivoire', 'CIV', 384, 225),
(54, 'HR', 'CROATIA', 'Croatia', 'HRV', 191, 385),
(55, 'CU', 'CUBA', 'Cuba', 'CUB', 192, 53),
(56, 'CY', 'CYPRUS', 'Cyprus', 'CYP', 196, 357),
(57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE', 203, 420),
(58, 'DK', 'DENMARK', 'Denmark', 'DNK', 208, 45),
(59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI', 262, 253),
(60, 'DM', 'DOMINICA', 'Dominica', 'DMA', 212, 1767),
(61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM', 214, 1809),
(62, 'EC', 'ECUADOR', 'Ecuador', 'ECU', 218, 593),
(63, 'EG', 'EGYPT', 'Egypt', 'EGY', 818, 20),
(64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV', 222, 503),
(65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ', 226, 240),
(66, 'ER', 'ERITREA', 'Eritrea', 'ERI', 232, 291),
(67, 'EE', 'ESTONIA', 'Estonia', 'EST', 233, 372),
(68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH', 231, 251),
(69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK', 238, 500),
(70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO', 234, 298),
(71, 'FJ', 'FIJI', 'Fiji', 'FJI', 242, 679),
(72, 'FI', 'FINLAND', 'Finland', 'FIN', 246, 358),
(73, 'FR', 'FRANCE', 'France', 'FRA', 250, 33),
(74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF', 254, 594),
(75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF', 258, 689),
(76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', NULL, NULL, 0),
(77, 'GA', 'GABON', 'Gabon', 'GAB', 266, 241),
(78, 'GM', 'GAMBIA', 'Gambia', 'GMB', 270, 220),
(79, 'GE', 'GEORGIA', 'Georgia', 'GEO', 268, 995),
(80, 'DE', 'GERMANY', 'Germany', 'DEU', 276, 49),
(81, 'GH', 'GHANA', 'Ghana', 'GHA', 288, 233),
(82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB', 292, 350),
(83, 'GR', 'GREECE', 'Greece', 'GRC', 300, 30),
(84, 'GL', 'GREENLAND', 'Greenland', 'GRL', 304, 299),
(85, 'GD', 'GRENADA', 'Grenada', 'GRD', 308, 1473),
(86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP', 312, 590),
(87, 'GU', 'GUAM', 'Guam', 'GUM', 316, 1671),
(88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM', 320, 502),
(89, 'GN', 'GUINEA', 'Guinea', 'GIN', 324, 224),
(90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB', 624, 245),
(91, 'GY', 'GUYANA', 'Guyana', 'GUY', 328, 592),
(92, 'HT', 'HAITI', 'Haiti', 'HTI', 332, 509),
(93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', NULL, NULL, 0),
(94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT', 336, 39),
(95, 'HN', 'HONDURAS', 'Honduras', 'HND', 340, 504),
(96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG', 344, 852),
(97, 'HU', 'HUNGARY', 'Hungary', 'HUN', 348, 36),
(98, 'IS', 'ICELAND', 'Iceland', 'ISL', 352, 354),
(99, 'IN', 'INDIA', 'India', 'IND', 356, 91),
(100, 'ID', 'INDONESIA', 'Indonesia', 'IDN', 360, 62),
(101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN', 364, 98),
(102, 'IQ', 'IRAQ', 'Iraq', 'IRQ', 368, 964),
(103, 'IE', 'IRELAND', 'Ireland', 'IRL', 372, 353),
(104, 'IL', 'ISRAEL', 'Israel', 'ISR', 376, 972),
(105, 'IT', 'ITALY', 'Italy', 'ITA', 380, 39),
(106, 'JM', 'JAMAICA', 'Jamaica', 'JAM', 388, 1876),
(107, 'JP', 'JAPAN', 'Japan', 'JPN', 392, 81),
(108, 'JO', 'JORDAN', 'Jordan', 'JOR', 400, 962),
(109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ', 398, 7),
(110, 'KE', 'KENYA', 'Kenya', 'KEN', 404, 254),
(111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR', 296, 686),
(112, 'KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', 'Korea, Democratic People\'s Republic of', 'PRK', 408, 850),
(113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR', 410, 82),
(114, 'KW', 'KUWAIT', 'Kuwait', 'KWT', 414, 965),
(115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ', 417, 996),
(116, 'LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', 'Lao People\'s Democratic Republic', 'LAO', 418, 856),
(117, 'LV', 'LATVIA', 'Latvia', 'LVA', 428, 371),
(118, 'LB', 'LEBANON', 'Lebanon', 'LBN', 422, 961),
(119, 'LS', 'LESOTHO', 'Lesotho', 'LSO', 426, 266),
(120, 'LR', 'LIBERIA', 'Liberia', 'LBR', 430, 231),
(121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY', 434, 218),
(122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE', 438, 423),
(123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU', 440, 370),
(124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX', 442, 352),
(125, 'MO', 'MACAO', 'Macao', 'MAC', 446, 853),
(126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD', 807, 389),
(127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG', 450, 261),
(128, 'MW', 'MALAWI', 'Malawi', 'MWI', 454, 265),
(129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS', 458, 60),
(130, 'MV', 'MALDIVES', 'Maldives', 'MDV', 462, 960),
(131, 'ML', 'MALI', 'Mali', 'MLI', 466, 223),
(132, 'MT', 'MALTA', 'Malta', 'MLT', 470, 356),
(133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL', 584, 692),
(134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ', 474, 596),
(135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT', 478, 222),
(136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS', 480, 230),
(137, 'YT', 'MAYOTTE', 'Mayotte', NULL, NULL, 269),
(138, 'MX', 'MEXICO', 'Mexico', 'MEX', 484, 52),
(139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM', 583, 691),
(140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA', 498, 373),
(141, 'MC', 'MONACO', 'Monaco', 'MCO', 492, 377),
(142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG', 496, 976),
(143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR', 500, 1664),
(144, 'MA', 'MOROCCO', 'Morocco', 'MAR', 504, 212),
(145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ', 508, 258),
(146, 'MM', 'MYANMAR', 'Myanmar', 'MMR', 104, 95),
(147, 'NA', 'NAMIBIA', 'Namibia', 'NAM', 516, 264),
(148, 'NR', 'NAURU', 'Nauru', 'NRU', 520, 674),
(149, 'NP', 'NEPAL', 'Nepal', 'NPL', 524, 977),
(150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD', 528, 31),
(151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT', 530, 599),
(152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL', 540, 687),
(153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL', 554, 64),
(154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC', 558, 505),
(155, 'NE', 'NIGER', 'Niger', 'NER', 562, 227),
(156, 'NG', 'NIGERIA', 'Nigeria', 'NGA', 566, 234),
(157, 'NU', 'NIUE', 'Niue', 'NIU', 570, 683),
(158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK', 574, 672),
(159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP', 580, 1670),
(160, 'NO', 'NORWAY', 'Norway', 'NOR', 578, 47),
(161, 'OM', 'OMAN', 'Oman', 'OMN', 512, 968),
(162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK', 586, 92),
(163, 'PW', 'PALAU', 'Palau', 'PLW', 585, 680),
(164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', NULL, NULL, 970),
(165, 'PA', 'PANAMA', 'Panama', 'PAN', 591, 507),
(166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG', 598, 675),
(167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY', 600, 595),
(168, 'PE', 'PERU', 'Peru', 'PER', 604, 51),
(169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL', 608, 63),
(170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN', 612, 0),
(171, 'PL', 'POLAND', 'Poland', 'POL', 616, 48),
(172, 'PT', 'PORTUGAL', 'Portugal', 'PRT', 620, 351),
(173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI', 630, 1787),
(174, 'QA', 'QATAR', 'Qatar', 'QAT', 634, 974),
(175, 'RE', 'REUNION', 'Reunion', 'REU', 638, 262),
(176, 'RO', 'ROMANIA', 'Romania', 'ROM', 642, 40),
(177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643, 70),
(178, 'RW', 'RWANDA', 'Rwanda', 'RWA', 646, 250),
(179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN', 654, 290),
(180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA', 659, 1869),
(181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA', 662, 1758),
(182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM', 666, 508),
(183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT', 670, 1784),
(184, 'WS', 'SAMOA', 'Samoa', 'WSM', 882, 684),
(185, 'SM', 'SAN MARINO', 'San Marino', 'SMR', 674, 378),
(186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP', 678, 239),
(187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU', 682, 966),
(188, 'SN', 'SENEGAL', 'Senegal', 'SEN', 686, 221),
(189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', NULL, NULL, 381),
(190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC', 690, 248),
(191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE', 694, 232),
(192, 'SG', 'SINGAPORE', 'Singapore', 'SGP', 702, 65),
(193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK', 703, 421),
(194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN', 705, 386),
(195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB', 90, 677),
(196, 'SO', 'SOMALIA', 'Somalia', 'SOM', 706, 252),
(197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF', 710, 27),
(198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', NULL, NULL, 0),
(199, 'ES', 'SPAIN', 'Spain', 'ESP', 724, 34),
(200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA', 144, 94),
(201, 'SD', 'SUDAN', 'Sudan', 'SDN', 736, 249),
(202, 'SR', 'SURINAME', 'Suriname', 'SUR', 740, 597),
(203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM', 744, 47),
(204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ', 748, 268),
(205, 'SE', 'SWEDEN', 'Sweden', 'SWE', 752, 46),
(206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE', 756, 41),
(207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR', 760, 963),
(208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN', 158, 886),
(209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK', 762, 992),
(210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA', 834, 255),
(211, 'TH', 'THAILAND', 'Thailand', 'THA', 764, 66),
(212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', NULL, NULL, 670),
(213, 'TG', 'TOGO', 'Togo', 'TGO', 768, 228),
(214, 'TK', 'TOKELAU', 'Tokelau', 'TKL', 772, 690),
(215, 'TO', 'TONGA', 'Tonga', 'TON', 776, 676),
(216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO', 780, 1868),
(217, 'TN', 'TUNISIA', 'Tunisia', 'TUN', 788, 216),
(218, 'TR', 'TURKEY', 'Turkey', 'TUR', 792, 90),
(219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM', 795, 7370),
(220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA', 796, 1649),
(221, 'TV', 'TUVALU', 'Tuvalu', 'TUV', 798, 688),
(222, 'UG', 'UGANDA', 'Uganda', 'UGA', 800, 256),
(223, 'UA', 'UKRAINE', 'Ukraine', 'UKR', 804, 380),
(224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE', 784, 971),
(225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR', 826, 44),
(226, 'US', 'UNITED STATES', 'United States', 'USA', 840, 1),
(227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', NULL, NULL, 1),
(228, 'UY', 'URUGUAY', 'Uruguay', 'URY', 858, 598),
(229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB', 860, 998),
(230, 'VU', 'VANUATU', 'Vanuatu', 'VUT', 548, 678),
(231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN', 862, 58),
(232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM', 704, 84),
(233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB', 92, 1284),
(234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR', 850, 1340),
(235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF', 876, 681),
(236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH', 732, 212),
(237, 'YE', 'YEMEN', 'Yemen', 'YEM', 887, 967),
(238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB', 894, 260),
(239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE', 716, 263);

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(20) CHARACTER SET utf8mb4 NOT NULL,
  `decimal_unit` varchar(20) CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currencies_code_unique` (`code`),
  UNIQUE KEY `currencies_name_unique` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factoryentrance_details`
--

DROP TABLE IF EXISTS `factoryentrance_details`;
CREATE TABLE IF NOT EXISTS `factoryentrance_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factoryname` varchar(255) NOT NULL,
  `entrancelocation` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factoryexit_details`
--

DROP TABLE IF EXISTS `factoryexit_details`;
CREATE TABLE IF NOT EXISTS `factoryexit_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factoryname` varchar(255) NOT NULL,
  `exitlocation` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_blocked_reel`
--

DROP TABLE IF EXISTS `factory_blocked_reel`;
CREATE TABLE IF NOT EXISTS `factory_blocked_reel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) NOT NULL,
  `location` varchar(50) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `weight` float NOT NULL,
  `dateblocked` varchar(20) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `factory_details`
--

DROP TABLE IF EXISTS `factory_details`;
CREATE TABLE IF NOT EXISTS `factory_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) NOT NULL,
  `linename` varchar(255) NOT NULL,
  `sublinename` varchar(25) DEFAULT NULL,
  `linecode` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_entrance_rawmaterials`
--

DROP TABLE IF EXISTS `factory_entrance_rawmaterials`;
CREATE TABLE IF NOT EXISTS `factory_entrance_rawmaterials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) NOT NULL,
  `location` varchar(50) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `weight` float NOT NULL,
  `dateofentrance` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=191461 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `factory_entrance_reel`
--

DROP TABLE IF EXISTS `factory_entrance_reel`;
CREATE TABLE IF NOT EXISTS `factory_entrance_reel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) NOT NULL,
  `location` varchar(50) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `dateofentrance` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=8979 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `factory_event`
--

DROP TABLE IF EXISTS `factory_event`;
CREATE TABLE IF NOT EXISTS `factory_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `barcode` varchar(20) NOT NULL,
  `productname` varchar(200) NOT NULL,
  `weight` double NOT NULL,
  `event` set('remain','return') NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=564 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `factory_exit`
--

DROP TABLE IF EXISTS `factory_exit`;
CREATE TABLE IF NOT EXISTS `factory_exit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `productid` int(11) NOT NULL,
  `exitlocation` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL,
  `bundles` int(11) NOT NULL,
  `dateofexit` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=592029 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_hod`
--

DROP TABLE IF EXISTS `factory_hod`;
CREATE TABLE IF NOT EXISTS `factory_hod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `division` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_lines`
--

DROP TABLE IF EXISTS `factory_lines`;
CREATE TABLE IF NOT EXISTS `factory_lines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factoryname` varchar(20) DEFAULT NULL,
  `linename` varchar(255) NOT NULL,
  `linecode` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_machine_maintenance`
--

DROP TABLE IF EXISTS `factory_machine_maintenance`;
CREATE TABLE IF NOT EXISTS `factory_machine_maintenance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jobtitle` varchar(100) NOT NULL,
  `jobid` varchar(50) DEFAULT NULL,
  `linename` varchar(255) NOT NULL,
  `project` varchar(100) NOT NULL,
  `subproject` varchar(100) NOT NULL,
  `division` varchar(100) NOT NULL,
  `staff` varchar(100) NOT NULL,
  `user` varchar(255) NOT NULL,
  `date` varchar(11) NOT NULL,
  `starttime` varchar(20) NOT NULL,
  `endtime` varchar(20) NOT NULL,
  `note` text NOT NULL,
  `duration` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16467 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_machine_maintenance_comment`
--

DROP TABLE IF EXISTS `factory_machine_maintenance_comment`;
CREATE TABLE IF NOT EXISTS `factory_machine_maintenance_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `user` varchar(100) NOT NULL,
  `comment` text NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_preproduction`
--

DROP TABLE IF EXISTS `factory_preproduction`;
CREATE TABLE IF NOT EXISTS `factory_preproduction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `productname` varchar(200) NOT NULL,
  `linename` varchar(50) NOT NULL,
  `bundles` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `linename` (`linename`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_preproduction_history`
--

DROP TABLE IF EXISTS `factory_preproduction_history`;
CREATE TABLE IF NOT EXISTS `factory_preproduction_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `linename` text NOT NULL,
  `productname` text NOT NULL,
  `quantity` int(11) NOT NULL,
  `username` text NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14289 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_production`
--

DROP TABLE IF EXISTS `factory_production`;
CREATE TABLE IF NOT EXISTS `factory_production` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `shift` varchar(10) DEFAULT NULL,
  `productid` int(11) NOT NULL,
  `factory` varchar(20) NOT NULL,
  `linename` varchar(255) NOT NULL,
  `sublinename` varchar(25) DEFAULT NULL,
  `barcode` varchar(255) NOT NULL,
  `bundles` int(3) NOT NULL,
  `specs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`specs`)),
  `netweight` float NOT NULL DEFAULT 0,
  `grossweight` float NOT NULL DEFAULT 0,
  `dateofproduction` varchar(20) NOT NULL,
  `actualdate` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=596180 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_projects`
--

DROP TABLE IF EXISTS `factory_projects`;
CREATE TABLE IF NOT EXISTS `factory_projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lineid` int(11) NOT NULL,
  `linename` varchar(255) NOT NULL,
  `sublinename` varchar(255) NOT NULL,
  `project` varchar(255) NOT NULL,
  `code` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_staff`
--

DROP TABLE IF EXISTS `factory_staff`;
CREATE TABLE IF NOT EXISTS `factory_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `division` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `factory_sublines`
--

DROP TABLE IF EXISTS `factory_sublines`;
CREATE TABLE IF NOT EXISTS `factory_sublines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lineid` int(11) NOT NULL,
  `linename` varchar(255) NOT NULL,
  `sublinename` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_subprojects`
--

DROP TABLE IF EXISTS `factory_subprojects`;
CREATE TABLE IF NOT EXISTS `factory_subprojects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lineid` int(11) NOT NULL,
  `linename` varchar(255) NOT NULL,
  `sublinename` varchar(255) NOT NULL,
  `project` varchar(255) NOT NULL,
  `projectcode` varchar(100) NOT NULL,
  `subproject` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_transfer`
--

DROP TABLE IF EXISTS `factory_transfer`;
CREATE TABLE IF NOT EXISTS `factory_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `factoryname` varchar(50) NOT NULL,
  `dateoftransfer` varchar(20) NOT NULL,
  `origin` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_usage_rawmaterials`
--

DROP TABLE IF EXISTS `factory_usage_rawmaterials`;
CREATE TABLE IF NOT EXISTS `factory_usage_rawmaterials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) NOT NULL,
  `shift` varchar(10) DEFAULT NULL,
  `location` varchar(50) NOT NULL,
  `linename` varchar(50) NOT NULL,
  `project` varchar(50) NOT NULL,
  `pre_productname` varchar(255) DEFAULT NULL,
  `weight` float NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `dateofuse` varchar(20) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE KEYS` (`shift`,`barcode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=131089 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `factory_usage_reel`
--

DROP TABLE IF EXISTS `factory_usage_reel`;
CREATE TABLE IF NOT EXISTS `factory_usage_reel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) NOT NULL,
  `shift` varchar(10) DEFAULT NULL,
  `location` varchar(50) NOT NULL,
  `linename` varchar(50) NOT NULL,
  `project` varchar(50) NOT NULL,
  `pre_productname` varchar(255) DEFAULT NULL,
  `weight` float NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `dateofuse` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE KEYS` (`shift`,`barcode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=118562 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `factory_waste`
--

DROP TABLE IF EXISTS `factory_waste`;
CREATE TABLE IF NOT EXISTS `factory_waste` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `causes_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `shift` varchar(10) DEFAULT NULL,
  `factoryname` varchar(50) NOT NULL,
  `linename` varchar(50) NOT NULL,
  `project` varchar(50) NOT NULL,
  `pre_productname` varchar(255) DEFAULT NULL,
  `weight` float NOT NULL,
  `dateofentry` varchar(20) NOT NULL,
  `origin` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factory_waste_details`
--

DROP TABLE IF EXISTS `factory_waste_details`;
CREATE TABLE IF NOT EXISTS `factory_waste_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `causes` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_customers`
--

DROP TABLE IF EXISTS `jumboreel_customers`;
CREATE TABLE IF NOT EXISTS `jumboreel_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customername` varchar(255) NOT NULL,
  `customerlabel` varchar(20) NOT NULL,
  `customercountry` varchar(50) NOT NULL,
  `customeraddress` text NOT NULL,
  `customertelephone` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customername` (`customername`),
  UNIQUE KEY `customerlabel` (`customerlabel`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_factoryexit`
--

DROP TABLE IF EXISTS `jumboreel_factoryexit`;
CREATE TABLE IF NOT EXISTS `jumboreel_factoryexit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `exitlocation` varchar(50) NOT NULL,
  `dateofexit` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12583 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_factoryexit_details`
--

DROP TABLE IF EXISTS `jumboreel_factoryexit_details`;
CREATE TABLE IF NOT EXISTS `jumboreel_factoryexit_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factoryname` varchar(255) NOT NULL,
  `exitlocation` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_grades`
--

DROP TABLE IF EXISTS `jumboreel_grades`;
CREATE TABLE IF NOT EXISTS `jumboreel_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gradename` tinytext NOT NULL,
  `gradetype` varchar(5) NOT NULL,
  `grade` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gradetype` (`gradetype`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_production_forecast`
--

DROP TABLE IF EXISTS `jumboreel_production_forecast`;
CREATE TABLE IF NOT EXISTS `jumboreel_production_forecast` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gradeid` int(11) NOT NULL,
  `weight` float NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gradeid` (`gradeid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_production_forecast_history`
--

DROP TABLE IF EXISTS `jumboreel_production_forecast_history`;
CREATE TABLE IF NOT EXISTS `jumboreel_production_forecast_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gradeid` int(11) NOT NULL,
  `weight` float NOT NULL,
  `month` varchar(2) NOT NULL,
  `year` varchar(4) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_products`
--

DROP TABLE IF EXISTS `jumboreel_products`;
CREATE TABLE IF NOT EXISTS `jumboreel_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productname` varchar(200) NOT NULL,
  `gradetype` varchar(20) NOT NULL,
  `gradename` varchar(200) NOT NULL,
  `grade` set('Economy','Premium') DEFAULT NULL,
  `brightness` float NOT NULL,
  `gsm` float NOT NULL,
  `ply` int(11) NOT NULL,
  `width` float NOT NULL,
  `diameter` float NOT NULL,
  `slice` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productname` (`productname`)
) ENGINE=InnoDB AUTO_INCREMENT=707 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_stock`
--

DROP TABLE IF EXISTS `jumboreel_stock`;
CREATE TABLE IF NOT EXISTS `jumboreel_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(20) NOT NULL,
  `productid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `weight` double NOT NULL,
  `modification` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`modification`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE KEYS` (`location`,`productid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_storeentrance`
--

DROP TABLE IF EXISTS `jumboreel_storeentrance`;
CREATE TABLE IF NOT EXISTS `jumboreel_storeentrance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL,
  `barcode` varchar(20) CHARACTER SET utf8 NOT NULL,
  `entrancelocation` varchar(50) CHARACTER SET utf8 NOT NULL,
  `dateofentrance` varchar(20) CHARACTER SET utf8 NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8798 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_storeentrance_details`
--

DROP TABLE IF EXISTS `jumboreel_storeentrance_details`;
CREATE TABLE IF NOT EXISTS `jumboreel_storeentrance_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(255) CHARACTER SET utf8 NOT NULL,
  `entrancelocation` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_storeexit`
--

DROP TABLE IF EXISTS `jumboreel_storeexit`;
CREATE TABLE IF NOT EXISTS `jumboreel_storeexit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `exitlocation` varchar(50) NOT NULL,
  `dateofexit` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8684 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jumboreel_storeexit_details`
--

DROP TABLE IF EXISTS `jumboreel_storeexit_details`;
CREATE TABLE IF NOT EXISTS `jumboreel_storeexit_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storename` varchar(20) NOT NULL,
  `exitlocation` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `local_governments`
--

DROP TABLE IF EXISTS `local_governments`;
CREATE TABLE IF NOT EXISTS `local_governments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_id` (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=775 DEFAULT CHARSET=utf32 COMMENT='Local governments in Nigeria.';

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
CREATE TABLE IF NOT EXISTS `logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `time` int(10) UNSIGNED DEFAULT NULL,
  `user` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `system` text DEFAULT NULL,
  `ip` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel` (`channel`) USING HASH,
  KEY `level` (`level`) USING HASH,
  KEY `time` (`time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=301842 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `productid` int(11) NOT NULL AUTO_INCREMENT,
  `productname` varchar(255) NOT NULL,
  `productcode` varchar(255) NOT NULL,
  `productbundles` varchar(50) DEFAULT NULL,
  `productgroup` varchar(50) DEFAULT NULL,
  `basepaper` varchar(255) DEFAULT NULL,
  `mach` varchar(255) DEFAULT NULL,
  `embossing` varchar(255) DEFAULT NULL,
  `lamedge` varchar(255) DEFAULT NULL,
  `revnumber` int(20) NOT NULL DEFAULT 0,
  `revdate` varchar(20) NOT NULL,
  `productrolls` int(20) NOT NULL DEFAULT 0,
  `productpacks` int(20) NOT NULL DEFAULT 0,
  `gsm` float NOT NULL DEFAULT 0,
  `logweight` float NOT NULL DEFAULT 0,
  `sheetwidth` varchar(20) NOT NULL DEFAULT '0:0:0',
  `sheetlength` float NOT NULL DEFAULT 0,
  `clipweight` float NOT NULL DEFAULT 0,
  `actualrollweight` float NOT NULL DEFAULT 0,
  `rolllength` float NOT NULL DEFAULT 0,
  `coreweight` float NOT NULL DEFAULT 0,
  `corediameter` float NOT NULL DEFAULT 0,
  `diameter` float NOT NULL DEFAULT 0,
  `perimeter` float NOT NULL DEFAULT 0,
  `pulls` float NOT NULL DEFAULT 0,
  `netweight` float NOT NULL DEFAULT 0,
  `hardrollsource` varchar(50) DEFAULT NULL,
  `ply` int(11) NOT NULL DEFAULT 0,
  `hardrollwidth` float NOT NULL DEFAULT 0,
  `rollsperbundle` int(11) NOT NULL DEFAULT 0,
  `wrapperweight` float NOT NULL DEFAULT 0,
  `polybagweight` float NOT NULL DEFAULT 0,
  `polybundleweight` float NOT NULL DEFAULT 0,
  `sheetcounts` int(11) NOT NULL DEFAULT 0,
  `grossweight` float NOT NULL DEFAULT 0,
  `hardrollgsm` varchar(5) DEFAULT NULL,
  `waste` varchar(4) DEFAULT NULL,
  `bundlespertonne` varchar(20) DEFAULT NULL,
  `imagepath` varchar(255) DEFAULT NULL,
  `timestamp` int(11) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`productid`),
  UNIQUE KEY `productcode` (`productcode`),
  UNIQUE KEY `productname` (`productname`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `products_old`
--

DROP TABLE IF EXISTS `products_old`;
CREATE TABLE IF NOT EXISTS `products_old` (
  `productid` int(11) NOT NULL AUTO_INCREMENT,
  `productname` varchar(255) NOT NULL,
  `productcode` varchar(255) NOT NULL,
  `productbundles` varchar(50) DEFAULT NULL,
  `productgroup` varchar(50) DEFAULT NULL,
  `basepaper` varchar(255) DEFAULT NULL,
  `mach` varchar(255) DEFAULT NULL,
  `embossing` varchar(255) DEFAULT NULL,
  `lamedge` varchar(255) DEFAULT NULL,
  `revnumber` int(20) NOT NULL DEFAULT 0,
  `revdate` varchar(20) NOT NULL,
  `productrolls` int(20) NOT NULL DEFAULT 0,
  `productpacks` int(20) NOT NULL DEFAULT 0,
  `gsm` float NOT NULL DEFAULT 0,
  `logweight` float NOT NULL DEFAULT 0,
  `sheetwidth` varchar(20) NOT NULL DEFAULT '0:0:0',
  `sheetlength` float NOT NULL DEFAULT 0,
  `clipweight` float NOT NULL DEFAULT 0,
  `actualrollweight` float NOT NULL DEFAULT 0,
  `rolllength` float NOT NULL DEFAULT 0,
  `coreweight` float NOT NULL DEFAULT 0,
  `corediameter` float NOT NULL DEFAULT 0,
  `diameter` float NOT NULL DEFAULT 0,
  `perimeter` float NOT NULL DEFAULT 0,
  `pulls` float NOT NULL DEFAULT 0,
  `netweight` float NOT NULL DEFAULT 0,
  `hardrollsource` varchar(50) DEFAULT NULL,
  `ply` int(11) NOT NULL DEFAULT 0,
  `hardrollwidth` float NOT NULL DEFAULT 0,
  `rollsperbundle` int(11) NOT NULL DEFAULT 0,
  `wrapperweight` float NOT NULL DEFAULT 0,
  `polybagweight` float NOT NULL DEFAULT 0,
  `polybundleweight` float NOT NULL DEFAULT 0,
  `sheetcounts` int(11) NOT NULL DEFAULT 0,
  `grossweight` float NOT NULL DEFAULT 0,
  `hardrollgsm` varchar(5) DEFAULT NULL,
  `waste` varchar(4) DEFAULT NULL,
  `bundlespertonne` varchar(20) DEFAULT NULL,
  `imagepath` varchar(255) DEFAULT NULL,
  `timestamp` int(11) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`productid`),
  UNIQUE KEY `productcode` (`productcode`),
  UNIQUE KEY `productname` (`productname`)
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `qc_revision`
--

DROP TABLE IF EXISTS `qc_revision`;
CREATE TABLE IF NOT EXISTS `qc_revision` (
  `id` int(11) NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials`
--

DROP TABLE IF EXISTS `rawmaterials`;
CREATE TABLE IF NOT EXISTS `rawmaterials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `suppliercode` varchar(3) DEFAULT NULL,
  `productid` int(11) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `weight` float NOT NULL,
  `dateofcreation` varchar(20) NOT NULL,
  `location` varchar(30) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` int(11) NOT NULL,
  `sub_barcode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`sub_barcode`)),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=248436 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_groups`
--

DROP TABLE IF EXISTS `rawmaterials_groups`;
CREATE TABLE IF NOT EXISTS `rawmaterials_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(50) NOT NULL,
  `groupcode` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `groupname` (`groupname`),
  UNIQUE KEY `groupcode` (`groupcode`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_products`
--

DROP TABLE IF EXISTS `rawmaterials_products`;
CREATE TABLE IF NOT EXISTS `rawmaterials_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storecode` varchar(100) NOT NULL,
  `productname` varchar(255) NOT NULL,
  `accountcode` varchar(100) NOT NULL,
  `groupid` int(11) NOT NULL,
  `subgroupid` int(11) NOT NULL,
  `common` set('Yes','No') NOT NULL DEFAULT 'No',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storecode` (`storecode`),
  UNIQUE KEY `productname` (`productname`)
) ENGINE=MyISAM AUTO_INCREMENT=306 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_stock`
--

DROP TABLE IF EXISTS `rawmaterials_stock`;
CREATE TABLE IF NOT EXISTS `rawmaterials_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(20) NOT NULL,
  `productid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `weight` double NOT NULL,
  `modification` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`modification`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE KEYS` (`location`,`productid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_stocks`
--

DROP TABLE IF EXISTS `rawmaterials_stocks`;
CREATE TABLE IF NOT EXISTS `rawmaterials_stocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productid` int(11) NOT NULL,
  `productname` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `weight` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_store`
--

DROP TABLE IF EXISTS `rawmaterials_store`;
CREATE TABLE IF NOT EXISTS `rawmaterials_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productname` text NOT NULL,
  `weight` float NOT NULL,
  `date` text NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  `origin` varchar(20) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL,
  `modifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`modifications`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1349 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_storeexit`
--

DROP TABLE IF EXISTS `rawmaterials_storeexit`;
CREATE TABLE IF NOT EXISTS `rawmaterials_storeexit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `productid` int(11) NOT NULL,
  `exitlocation` varchar(50) NOT NULL,
  `factoryname` varchar(50) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `weight` float NOT NULL,
  `dateofexit` varchar(20) NOT NULL,
  `status` varchar(5) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=167460 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_storeexit_details`
--

DROP TABLE IF EXISTS `rawmaterials_storeexit_details`;
CREATE TABLE IF NOT EXISTS `rawmaterials_storeexit_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storename` varchar(255) NOT NULL,
  `exitlocation` varchar(255) NOT NULL,
  `factoryname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_subgroups`
--

DROP TABLE IF EXISTS `rawmaterials_subgroups`;
CREATE TABLE IF NOT EXISTS `rawmaterials_subgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subgroupname` varchar(50) NOT NULL,
  `subgroupcode` varchar(6) NOT NULL,
  `groupid` int(11) NOT NULL,
  `sub_barcode` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subgroupname` (`subgroupname`),
  UNIQUE KEY `groupcode` (`subgroupcode`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_supplier`
--

DROP TABLE IF EXISTS `rawmaterials_supplier`;
CREATE TABLE IF NOT EXISTS `rawmaterials_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplierid` varchar(20) NOT NULL,
  `suppliername` varchar(200) NOT NULL,
  `suppliercode` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_transfer`
--

DROP TABLE IF EXISTS `rawmaterials_transfer`;
CREATE TABLE IF NOT EXISTS `rawmaterials_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `exitlocation` varchar(50) NOT NULL,
  `transferlocation` varchar(50) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `dateoftransfer` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rawmaterials_transferlocations`
--

DROP TABLE IF EXISTS `rawmaterials_transferlocations`;
CREATE TABLE IF NOT EXISTS `rawmaterials_transferlocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exitlocation` varchar(50) NOT NULL,
  `transferlocation` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `redirections`
--

DROP TABLE IF EXISTS `redirections`;
CREATE TABLE IF NOT EXISTS `redirections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sales_customers`
--

DROP TABLE IF EXISTS `sales_customers`;
CREATE TABLE IF NOT EXISTS `sales_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customercode` varchar(255) NOT NULL,
  `customername` varchar(255) NOT NULL,
  `customeraddress` varchar(1000) DEFAULT NULL,
  `customerphonenumber` varchar(20) DEFAULT NULL,
  `customercity` varchar(50) NOT NULL,
  `customerstate` varchar(255) DEFAULT NULL,
  `customerdesignation` varchar(50) DEFAULT NULL,
  `customerregion` varchar(50) DEFAULT NULL,
  `customercountry` varchar(255) NOT NULL,
  `channel` varchar(25) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1709 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_delivery`
--

DROP TABLE IF EXISTS `sales_delivery`;
CREATE TABLE IF NOT EXISTS `sales_delivery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deliverynumber` int(11) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `username` varchar(255) NOT NULL,
  `loadnumber` int(11) NOT NULL,
  `dateofdelivery` varchar(11) NOT NULL,
  `timestamp` int(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55216 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_delivery_daily`
--

DROP TABLE IF EXISTS `sales_delivery_daily`;
CREATE TABLE IF NOT EXISTS `sales_delivery_daily` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productid` varchar(11) NOT NULL,
  `productname` varchar(255) NOT NULL,
  `bundles` int(11) NOT NULL,
  `closingdate` varchar(20) NOT NULL,
  `openingdate` varchar(20) NOT NULL,
  `status` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1253854 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_designation`
--

DROP TABLE IF EXISTS `sales_designation`;
CREATE TABLE IF NOT EXISTS `sales_designation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sales_region` varchar(50) NOT NULL,
  `sales_designation` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_forecast`
--

DROP TABLE IF EXISTS `sales_forecast`;
CREATE TABLE IF NOT EXISTS `sales_forecast` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productid` int(11) NOT NULL,
  `bundles` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_forecast_history`
--

DROP TABLE IF EXISTS `sales_forecast_history`;
CREATE TABLE IF NOT EXISTS `sales_forecast_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productid` int(11) NOT NULL,
  `bundles` int(11) NOT NULL,
  `dateofforecast` varchar(20) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8040 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_loading`
--

DROP TABLE IF EXISTS `sales_loading`;
CREATE TABLE IF NOT EXISTS `sales_loading` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loadnumber` int(11) NOT NULL,
  `loader` varchar(255) DEFAULT NULL,
  `barcode` varchar(20) NOT NULL,
  `username` varchar(255) NOT NULL,
  `sod_id` int(11) DEFAULT NULL,
  `cageroomcode` varchar(7) NOT NULL,
  `transporterid` int(11) NOT NULL,
  `trucknumber` varchar(30) DEFAULT NULL,
  `truckdriver` varchar(50) DEFAULT NULL,
  `quantityloaded` int(11) NOT NULL,
  `dateofloading` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` int(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=329894 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_loading_return`
--

DROP TABLE IF EXISTS `sales_loading_return`;
CREATE TABLE IF NOT EXISTS `sales_loading_return` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `barcode` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `loading_id` int(11) NOT NULL,
  `sod_id` int(11) NOT NULL,
  `quantityunloaded` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=151594 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_order`
--

DROP TABLE IF EXISTS `sales_order`;
CREATE TABLE IF NOT EXISTS `sales_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) DEFAULT NULL,
  `orderid` varchar(20) NOT NULL,
  `warehousecode` varchar(3) NOT NULL,
  `customerid` int(11) NOT NULL,
  `dateoforder` varchar(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderid` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=61431 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_order_details`
--

DROP TABLE IF EXISTS `sales_order_details`;
CREATE TABLE IF NOT EXISTS `sales_order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(20) CHARACTER SET utf8 NOT NULL,
  `productid` int(11) NOT NULL,
  `quantityordered` int(11) NOT NULL,
  `foc` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=328516 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_return`
--

DROP TABLE IF EXISTS `sales_return`;
CREATE TABLE IF NOT EXISTS `sales_return` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `returnnumber` int(11) NOT NULL,
  `sod_id` int(11) NOT NULL,
  `quantityreturned` int(11) NOT NULL,
  `quantityrejected` int(11) NOT NULL,
  `dateofreturn` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1757 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_transporters`
--

DROP TABLE IF EXISTS `sales_transporters`;
CREATE TABLE IF NOT EXISTS `sales_transporters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transportername` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transportername` (`transportername`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_warehouse`
--

DROP TABLE IF EXISTS `sales_warehouse`;
CREATE TABLE IF NOT EXISTS `sales_warehouse` (
  `warehouselocation` varchar(255) NOT NULL,
  `warehousecode` varchar(50) NOT NULL,
  PRIMARY KEY (`warehousecode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sales_waybill`
--

DROP TABLE IF EXISTS `sales_waybill`;
CREATE TABLE IF NOT EXISTS `sales_waybill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `barcode` varchar(50) NOT NULL,
  `username` varchar(255) NOT NULL,
  `deliverynumber` varchar(20) NOT NULL,
  `receiptnumber` int(11) DEFAULT NULL,
  `transportcost` float NOT NULL,
  `dateofwaybill` varchar(20) NOT NULL,
  `timestamp` int(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18045 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
CREATE TABLE IF NOT EXISTS `states` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COMMENT='States in Nigeria.';

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehousecode` varchar(2) CHARACTER SET utf8 NOT NULL,
  `productid` int(11) NOT NULL,
  `productcode` varchar(10) CHARACTER SET utf8 NOT NULL,
  `opening` int(11) NOT NULL DEFAULT 0,
  `closing` int(11) NOT NULL,
  `date` varchar(20) NOT NULL DEFAULT '2020/05/04',
  `timestamp` int(11) NOT NULL DEFAULT 1589962267,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stockhistory`
--

DROP TABLE IF EXISTS `stockhistory`;
CREATE TABLE IF NOT EXISTS `stockhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehousecode` varchar(3) NOT NULL DEFAULT '01',
  `productid` int(11) NOT NULL,
  `opening` int(11) NOT NULL,
  `closing` int(11) NOT NULL,
  `date` varchar(20) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `warehousecode` (`warehousecode`,`productid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=301928 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stockhistory_daily_old`
--

DROP TABLE IF EXISTS `stockhistory_daily_old`;
CREATE TABLE IF NOT EXISTS `stockhistory_daily_old` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehousecode` varchar(3) NOT NULL DEFAULT '01',
  `productid` varchar(11) NOT NULL,
  `bundles` int(11) NOT NULL,
  `closingdate` varchar(20) NOT NULL,
  `openingdate` varchar(20) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2454626 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stockhistory_old`
--

DROP TABLE IF EXISTS `stockhistory_old`;
CREATE TABLE IF NOT EXISTS `stockhistory_old` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehousecode` varchar(3) NOT NULL,
  `productid` varchar(11) DEFAULT NULL,
  `bundles` int(11) NOT NULL,
  `closingdate` varchar(20) NOT NULL,
  `openingdate` varchar(20) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1958 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_2020_05_04`
--

DROP TABLE IF EXISTS `stock_2020_05_04`;
CREATE TABLE IF NOT EXISTS `stock_2020_05_04` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehousecode` varchar(2) CHARACTER SET utf8 NOT NULL,
  `productid` int(11) NOT NULL,
  `productcode` varchar(10) CHARACTER SET utf8 NOT NULL,
  `opening` int(11) NOT NULL DEFAULT 0,
  `closing` int(11) NOT NULL,
  `date` varchar(20) NOT NULL DEFAULT '2020/05/04',
  `timestamp` int(11) NOT NULL DEFAULT 1589962267,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_transfer`
--

DROP TABLE IF EXISTS `stock_transfer`;
CREATE TABLE IF NOT EXISTS `stock_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `transfernumber` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `warehousecode` varchar(3) NOT NULL,
  `trucknumber` varchar(20) DEFAULT NULL,
  `quantitytransferred` int(11) NOT NULL,
  `dateoftransfer` varchar(20) NOT NULL,
  `timestamp` int(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4507 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `storebundle`
--

DROP TABLE IF EXISTS `storebundle`;
CREATE TABLE IF NOT EXISTS `storebundle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehousecode` varchar(3) NOT NULL DEFAULT '01',
  `productid` int(11) DEFAULT NULL,
  `bundles` int(11) NOT NULL,
  `timestamp` text NOT NULL,
  `modifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`modifications`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `warehousecode` (`warehousecode`,`productid`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `store_adjustment`
--

DROP TABLE IF EXISTS `store_adjustment`;
CREATE TABLE IF NOT EXISTS `store_adjustment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehousecode` varchar(3) NOT NULL,
  `floor` tinyint(3) NOT NULL,
  `productid` int(11) NOT NULL,
  `purpose` varchar(15) DEFAULT NULL,
  `bundles` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `date` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `store_cagerooms`
--

DROP TABLE IF EXISTS `store_cagerooms`;
CREATE TABLE IF NOT EXISTS `store_cagerooms` (
  `cageroomnumber` varchar(50) NOT NULL,
  `cageroomcode` varchar(7) NOT NULL,
  `warehousecode` varchar(3) NOT NULL,
  PRIMARY KEY (`cageroomcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `store_entrance`
--

DROP TABLE IF EXISTS `store_entrance`;
CREATE TABLE IF NOT EXISTS `store_entrance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `productid` int(11) NOT NULL,
  `entrancelocation` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL,
  `bundles` int(5) NOT NULL,
  `dateofentrance` varchar(20) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=555219 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `store_floors`
--

DROP TABLE IF EXISTS `store_floors`;
CREATE TABLE IF NOT EXISTS `store_floors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `floor_name` varchar(10) NOT NULL,
  `warehousecode` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userid` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `fullname` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `userlevel` int(11) NOT NULL DEFAULT 1,
  `redirection_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `username`, `fullname`, `email`, `password`, `userlevel`, `redirection_id`, `created_at`) VALUES
(5, 'admin', NULL, NULL, '$2y$10$GgucKQwVLLBzTycTV3CmFO0YY2TOla383bvdVAT1tz0/O9ljFGUAa', 1, 2, '2020-12-17 08:54:53'),
(8, 'rafic', NULL, NULL, '$2y$10$CNOyunBu8PbzP9cnGhT6Je78uv3p5qT0wjp30kX/bQc9zA5dSYgGa', 2, 0, '2020-12-17 08:54:53'),
(9, 'malek', NULL, NULL, '$2y$10$ukxRj7Y7u3F8lqgtdfZmkelb5mR..lm5XmzjiyJR0UHlieDBqWQ66', 2, 25, '2020-12-17 08:54:53'),
(13, 'Jamal', NULL, NULL, '$2y$10$9utozTKWP7aeFOH2oJq7reHWMb5Rf49iTnGEVL9dFzUgaupmcgMiu', 13, 10, '2020-12-17 08:54:53'),
(35, 'store elevator', NULL, NULL, '$2y$10$rh2cAvfG3RHA0AOgK7Kxduyxg4Q5hQ0XL/RJ/l6JRriX9j0eNvRZW', 16, 0, '2020-12-17 08:54:53'),
(49, 'jad', NULL, NULL, '$2y$10$GR8in1JOz9sJkAIlQ8rgK./GIKu1N57e7zZooz0XNB9VCe1nkpHJi', 1, 2, '2020-12-17 08:54:53'),
(53, 'mansourfg', NULL, NULL, '$2y$10$CB8fDI06xftuqEGE3vDVr.Q1fkIn3BkN6lnbMfktQvnjk6VCUjHJa', 13, 10, '2020-12-17 08:54:53'),
(55, 'mogamat', NULL, NULL, '$2y$10$NpXTx.06ItR3OoZosKGmbO.Kw2BIrNRrk7eAIItnDYl3mLkpQxzwm', 7, 10, '2020-12-17 08:54:53'),
(59, 'toyin', NULL, NULL, '$2y$10$Xy6Ay4uYS28dZXW2SOn6Su6ajiLisezACMtpUTr7JPHs1lEbyWc3i', 31, 2, '2020-12-17 08:54:53'),
(60, 'felix', NULL, NULL, '$2y$10$oWC6NsT1f/Scg69Fhf4l8.mOdkVWc.qbD5LrBZkruXiXr7MNYsLXS', 31, 2, '2020-12-17 08:54:53'),
(62, 'elias', NULL, NULL, '$2y$10$6glOL0Q7ShVN8a/1mCfdBugVdYnps1UTWubq3Bx6Y2tztcykiVcmO', 7, 25, '2020-12-17 08:54:53'),
(68, 'storefc2', NULL, NULL, '$2y$10$8QH3xg4dv2k7Pbn8.PC3Q.GTOP8gh97F1F7iDuHPXzZv2DS8rRXKW', 19, 0, '2020-12-17 08:54:53'),
(69, 'storefc1', NULL, NULL, '$2y$10$o5HoG.TmGUXmd8buuHOboeLMunmgsFCxBFuswU0Yk2ZSyQJDzWFq.', 18, 0, '2020-12-17 08:54:53'),
(75, 'yemi', NULL, NULL, '$2y$10$HXhwC3dY2WmhWLWyLLCTrOnSPQ/ebtoEkoNWRESvAqj4V/ekjAPEq', 7, 0, '2020-12-17 08:54:53'),
(76, 'remi', NULL, NULL, '$2y$10$Bug04Zvt8mKYTyZjTGRWje3uttuSSlz5louM4N3vrhh1NwDzyQ9bu', 7, 0, '2020-12-17 08:54:53'),
(81, 'salesrep', NULL, NULL, '$2y$10$B9LZjhryD7I2ZAFZ4Ca6UuAnidDetZ0NMcYeY5CLKdnnSFQQAOmyK', 11, 0, '2020-12-17 08:54:53'),
(90, 'Jean', NULL, NULL, '$2y$10$1OUQ1NsuDgJ0Ay1MTAWDOelnmVWeP1vHKZMjL4ljM7CuVIIcwQe0e', 8, 5, '2020-12-17 08:54:53'),
(91, 'froilan', NULL, NULL, '$2y$10$5cPko7mjyMaBlWyPaVaVIuXWliwTpDy.5aRCeaiAsmvtNQGt/Oltq', 8, 5, '2020-12-17 08:54:53'),
(92, 'kasim', NULL, NULL, '$2y$10$SE8l5JXOEp9phAf/HVWqsOqdMyFBjlKVEZGojEGtez.j8myOkcsa2', 8, 5, '2020-12-17 08:54:53'),
(94, 'pm2', NULL, NULL, '$2y$10$.o0vWEBlGNqy/zaYkdygAefOR0xKi.6A3stIyVyntnqbBegI7peVq', 41, 0, '2020-12-17 08:54:53'),
(95, 'pm3', NULL, NULL, '$2y$10$JZ6pREAdWBL0fFA1gsTlPe131fM3SVZ2HQPHRHrLTBjkYWVIYQZHG', 41, 0, '2020-12-17 08:54:53'),
(96, 'rabih', NULL, NULL, '$2y$10$akXhscx7VcMCFlUtkaVESOrEiB1.4cWPuLLzm.gjOyW45f05YheMa', 6, 0, '2020-12-17 08:54:53'),
(97, 'pawan', NULL, NULL, '$2y$10$.QuXe71pczxaljKH6ELm5.aeFGtdrW66KMmXDX/ZnN1.pFjV3H0xO', 6, 7, '2020-12-17 08:54:53'),
(98, 'Gbemi', NULL, NULL, '$2y$10$sArOzwFnqnSHOXyKpnMwFOOM2Fe0cqERcF/2LcLJzYbh/SzIZ6FmC', 12, 9, '2020-12-17 08:54:53'),
(100, 'charbel', NULL, NULL, '$2y$10$eYHtfcU3.Q.FR7G2.il/G.uGqECwxNbNpu9RRgkRLUtQCMmV8EGuq', 8, 5, '2020-12-17 08:54:53'),
(101, 'paul', NULL, NULL, '$2y$10$9.L0Ulew/xJ.UwFWH0WGA.Y5pBdIptjVuVncNTv0vwqXBVxQj68GO', 5, 3, '2020-12-17 08:54:53'),
(104, 'gloria', NULL, NULL, '$2y$10$HqIouCEihVTqZfO1Nccw0uZfQvkxREmBIrYaNYSkY0SE2t8NcycOe', 14, 11, '2020-12-17 08:54:53'),
(115, 'andrew', 'Andrew Marin', 'andre@belimpex.ng', '$2y$10$eYHtfcU3.Q.FR7G2.il/G.uGqECwxNbNpu9RRgkRLUtQCMmV8EGuq', 1, 2, '2020-12-17 08:54:53'),
(116, 'olaitan', NULL, NULL, '$2y$10$Ed.oUttM7iEPZcmq63yAH.CgtWJfGU4RDfEcxTHJfJ2k.W7Ao3sAG', 24, 16, '2020-12-17 08:54:53'),
(119, 'yusuf', NULL, NULL, '$2y$10$u3l2SSjqJ4B1UF3u8GqpXOklj76Fs1lcObn1dQmznTbCb4W3owZ7S', 14, 0, '2020-12-17 08:54:53'),
(120, 'kazim', NULL, NULL, '$2y$10$ufX4qoiiNq.6hNKw9AiB5eH8Dnn/ov7hYAt0hysLhlHXJQ9jnn51W', 22, 15, '2020-12-17 08:54:53'),
(125, 'tayo', NULL, NULL, '$2y$10$Moc5/I3s1lcTOQiW58mC.eJF00u9hCfCZO3D0v9XeFT5WbXiYc3rq', 15, 0, '2020-12-17 08:54:53'),
(126, 'customerlist', NULL, NULL, '$2y$10$Nqun8J6bCrdqVgbgEe0JOu8tAO31ZgKoaacknIijTf5Y.ya90PKtm', 70, 22, '2020-12-17 08:54:53'),
(130, 'blessing', NULL, NULL, '$2y$10$YE.9Idu7R1C0mpWyiwreCO/GACRyeVKnM4.h4dI0eiPihPP5sea/y', 7, 10, '2020-12-17 08:54:53'),
(131, 'Esther2', NULL, NULL, '$2y$10$CoGj.Q.hq7SMIqtwfRtdv.IAw59cqKJ/jMAiLCLlOHBjkAurw01N6', 12, 9, '2020-12-17 08:54:53'),
(133, 'david jumbo', NULL, NULL, '$2y$10$Y89.o9gkZrx9bj3WQbXO8e/H0XqOXX3O/cixtr2gORHzdK30aeOHi', 28, 17, '2020-12-17 08:54:53'),
(134, 'johnson', NULL, NULL, '$2y$10$mIffTVz1Y0UW8XmWoS4TX.O1n9sIfZPd8yPMxePS4sqI1ynhGQRWi', 28, 17, '2020-12-17 08:54:53'),
(136, 'Chady', NULL, NULL, '$2y$10$1YP1Xu1gL6j7CZMIpmtiwu2hdBjp6.wKK1GbhdmSW7GfUGhkYN.9a', 5, 3, '2020-12-17 08:54:53'),
(139, 'john', NULL, NULL, '$2y$10$mokwDZBrc1dkA3Dt6kd.IumteyuP.SxUk2AICkbJGRDybQzRLbwIK', 43, 0, '2020-12-17 08:54:53'),
(142, 'femi', NULL, NULL, '$2y$10$MI..EKe3Ae8i0j2TWLMdQ.vCtoW7FZjsB38vnXZuyiQ/9xIOda4DS', 25, 5, '2020-12-17 08:54:53'),
(143, 'josephraw', NULL, NULL, '$2y$10$PK1i2SVjB/l33KmL3CtFwe1J/UD/jbM22CuQtmoi/wDAz.oRsU176', 36, 18, '2020-12-17 08:54:53'),
(148, 'eskaf', NULL, NULL, '$2y$10$muz0KeuuV1XEqwU22G.63.BtxTi10hxM3ewCb9E6k3.0axAHmA3mK', 2, 25, '2020-12-17 08:54:53'),
(149, 'edwin', NULL, NULL, '$2y$10$6FiDyb.vS3TsgH7KM6S0TuYoaAg3.5OsSBW6chQ7BKPJhRgoVY8vG', 47, 3, '2020-12-17 08:54:53'),
(153, 'bashiru', NULL, NULL, '$2y$10$4z4tdnR6vhdI4/lc8Tbrj.2PHZ2TnQhg0M9.bJpe.W8z8LaSHXdyu', 23, 6, '2020-12-17 08:54:53'),
(154, 'joshua', NULL, NULL, '$2y$10$fhEJxm4yP46mdNXVrWTQ5eWETpknfQd9V5BIZMv4X7DFKkRH1L4OG', 26, 6, '2020-12-17 08:54:53'),
(155, 'taiwo', NULL, NULL, '$2y$10$IlEedbYvfGgMZpcoXG/qqOPyQeBxF9T9/opjb9V3r.hb9jhW3Ulqq', 26, 0, '2020-12-17 08:54:53'),
(157, 'dami', NULL, NULL, '$2y$10$7bSIV5Sxoz1uEY.dunEO/e33FkYItZQJN4LHia7FZ7pBpmoaZPiYG', 8, 5, '2020-12-17 08:54:53'),
(158, 'ojo', NULL, NULL, '$2y$10$on6lACQz.xMiM.7TQKxk2e6GIiwMHNvyPtmsnkZR3Q5ChE2YysmYq', 8, 5, '2020-12-17 08:54:53'),
(160, 'maria', NULL, NULL, '$2y$10$cEPXbgKm7yUBB6D1HaNrzOpGSftKtnonhs7vhGfX9/2D4GuvU4k02', 24, 16, '2020-12-17 08:54:53'),
(161, 'ibrahim', NULL, NULL, '$2y$10$3WQs3twv3KMipvt/Ky5x2OFGcmOb2/T9s69oLXEdSY8eBvnUdXntq', 36, 18, '2020-12-17 08:54:53'),
(172, 'mansour', NULL, NULL, '$2y$10$f4IYOq/jHlJ1S/N.A6rH/.eyZAt0JBoVZLTtRbM2L3mozTfR7kKJG', 8, 5, '2020-12-17 08:54:53'),
(174, 'Ope', NULL, NULL, '$2y$10$pCjs7bUmYx72RsqL2wBF4OwqngvxMyQp.PsMj3JmzSWyKy9z6f2mm', 22, 15, '2020-12-17 08:54:53'),
(175, 'prince', NULL, NULL, '$2y$10$s2mqyhUoTsHmVbPB4zLaQeaZSFUTOgJR9ZcM8rc8rT/glIETjoQ1G', 71, 0, '2020-12-17 08:54:53'),
(176, 'ogiji', NULL, NULL, '$2y$10$VN6T1qZjuLf8/6CPkte2F.3aGSJ5myhgA5xw/yQZnLZJQxtRU7tVW', 22, 15, '2020-12-17 08:54:53'),
(177, 'Daniel', NULL, NULL, '$2y$10$XMnaKbyNPBTqdQtyrJX1VennOWAg50RfFMwycnYkLjRhrFStTz8wi', 72, 24, '2020-12-17 08:54:53'),
(178, 'Edgard', NULL, NULL, '$2y$10$4RGUHnxXhnIGP5mr/zAT9.AJVxpd7PYEEmabD8TP1v3GAWaWeOT.y', 49, 21, '2020-12-17 08:54:53'),
(179, 'Hasmen', NULL, NULL, '$2y$10$r79YmY2UZe2SZePfd0rY8e/9yDATjt63ca7L6qqVBa.QGqase3lky', 49, 21, '2020-12-17 08:54:53'),
(180, 'edwin1', NULL, NULL, '$2y$10$8dJvLaxm7PUt7SRaZU9v3u5qwv4qr0KmEbT9vPTNlYl1CKICJ3Gpa', 49, 21, '2020-12-17 08:54:53'),
(181, 'gbolaham', NULL, NULL, '$2y$10$qvf1dslOJiElTuZQc49d1OcpJPMejIs/.9mo1wjKMqXR0JAfrN19q', 49, 21, '2020-12-17 08:54:53'),
(183, 'andre', NULL, NULL, '$2y$10$IBh.yGQD7nB3jmnwjv7QMeWf.4Xahel21qgbsApgpsiUbdRos1aSC', 49, 3, '2020-12-17 08:54:53'),
(184, 'Anita', NULL, NULL, '$2y$10$6PxRoxlJzYSsbVoUHyDiQO.v3uWdcHE7ikaF6noplsy2kasXr81UG', 10, 26, '2020-12-17 08:54:53'),
(185, 'Balaji', NULL, NULL, '$2y$10$gbNz.jZf.JCUdsfrgKEJKOTQSWr060L4IiG5Gg5Qe0DNY6Qf6.ZAC', 7, 10, '2020-12-17 08:54:53'),
(188, 'Esther', 'Esther Aderonmu', 'e.aderonmu@belimpex.ng', '$2y$10$qeW7mYaiWl8fSOKCnTCoIe7jhyhhsmPmCxqgRiWWRCX6fH9nvkuQG', 73, 30, '2020-12-17 08:54:53'),
(189, 'clinton', NULL, NULL, '$2y$10$w/HyyBMzAycKA3YdZFHx8.niy1V/7R/9n7daZ0Xhpwmajp7S6qaRi', 1, 2, '2020-12-17 08:54:53'),
(190, 'vincent', NULL, NULL, '$2y$10$vQkzc5Dm1mVfdpfbU7.MeeppqeUxhgpGM1BGteU6J9RxsvI7M5gnW', 1, 0, '2021-09-01 08:04:54'),
(192, 'nonadmin', NULL, NULL, '$2y$10$6JIYZlzhJ60GmDfkY3pbUuHrBbgCYB64JNYg0Eyeqks57li/hGWXO', 46, 0, '2021-09-06 09:04:11'),
(193, 'lecrosoft', NULL, NULL, '$2y$10$YD8zoUrgK9CCkxNIyfe0BeOfKFVAZASxZjF1vtqc0J1WuYbHCK16q', 1, 0, '2021-09-17 09:40:38'),
(194, 'buruji2', NULL, NULL, '$2y$10$qnqFQBRzZvWuA5uYzRyvN..A.phtq12hB7HbXzYnpf/d2N/NSpoK.', 2, 0, '2021-09-22 14:44:10'),
(195, 'buruji20', NULL, NULL, '$2y$10$4Pi/Ylg5XArUyuyibxLnjO8zw5zjwqwKI3BPFzbAc6Fl43rwjYxyW', 20, 0, '2021-09-22 14:44:35'),
(196, 'buruji30', NULL, NULL, '$2y$10$bSxnqcsYyCFqZ8CRGOMI3u2gPQLdvGKvNK.r2QwQE0gxRf2NhhW4a', 30, 0, '2021-09-22 14:44:55'),
(197, 'test', NULL, NULL, '$2y$10$XoPDd3Ibfi/rxt.rVVQ2Z.5HJ/Y0H8c8/MvlbdFqLiMNWi60lYVTC', 43, 0, '2021-09-24 14:33:57'),
(198, 'test_delivery', NULL, NULL, '$2y$10$4P6jtsNXICidvK9mPoM67e6Gwm.VVCo7s./BU/yMKC50mfcBIGFVy', 30, 0, '2021-10-11 15:32:00');

-- --------------------------------------------------------

--
-- Table structure for table `userlevels`
--

DROP TABLE IF EXISTS `userlevels`;
CREATE TABLE IF NOT EXISTS `userlevels` (
  `level` int(11) NOT NULL,
  `default_user` text NOT NULL,
  `role_description` text NOT NULL,
  UNIQUE KEY `level` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userlevels`
--

INSERT INTO `userlevels` (`level`, `default_user`, `role_description`) VALUES
(1, 'Admin User', ''),
(2, 'All Reports and BPL Entries User', ''),
(3, 'Factory Production Report User', ''),
(4, 'Factory Exit Report User', ''),
(5, 'B.P.L Report User', ''),
(6, 'Machine Report User', ''),
(7, 'General Report User', 'User can view the general report page'),
(8, 'Factory Report User', ''),
(9, 'Factory Report User, BPL Customers', ''),
(10, 'Special Order Booking User', ''),
(11, 'Sales Representative User', ''),
(12, 'Sales Order User', ''),
(13, 'Sales Loading, Delivery, Return User', ''),
(14, 'Sales Waybill User', ''),
(15, 'Sales Loading, Delivery User (Abuja)', ''),
(16, 'Floor B Elevator Store Entrance User', ''),
(17, 'Store Locations User', ''),
(18, 'Floor C Gate Store Entrance User', ''),
(19, 'Floor C Buffer Room Store Entrance User', ''),
(20, 'All Reports User', ''),
(21, 'Bil-1 Factory Entrance User', ''),
(22, 'Factory Production User', ''),
(23, 'Bil-1 Factory Exit User', ''),
(24, 'Factory Machines User', ''),
(25, 'Factory Production, Waste & Delay User', ''),
(26, 'Gambini Factory Exit User', ''),
(27, 'Gambini Factory Entrance User', ''),
(28, 'BIL Factories Jumboreels User', ''),
(29, 'All excluding BPL Sales Reports User', ''),
(30, 'B.P.L Production and Store User', ''),
(31, 'Quality User', ''),
(32, 'B.P.L Store User', ''),
(36, 'Raw Materials User', ''),
(38, 'P.M 2 Store Exit User', ''),
(39, 'P.M 3 Store Exit User', ''),
(40, 'Waste Paper Store Exit User', ''),
(41, 'B.P.L Production User', ''),
(42, 'P.M 2 Factory Exit User', ''),
(43, 'P.M 3 Factory Exit User', ''),
(44, 'Waste Paper Store Entrance User', ''),
(45, 'P.M 2 Store Entrance User', ''),
(46, 'P.M 3 Store Entrance User', ''),
(47, 'B.P.L Customer Entry & Reports User', ''),
(48, 'B.P.L Reports User', ''),
(49, 'B.P.L Production Modify User', ''),
(70, 'Sales Customer List User', ''),
(71, 'Loading Return', ''),
(72, 'Store Adjustment', ''),
(73, 'BPL Entries User', '');

-- --------------------------------------------------------

--
-- Table structure for table `wp_grades`
--

DROP TABLE IF EXISTS `wp_grades`;
CREATE TABLE IF NOT EXISTS `wp_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wp_grades`
--

INSERT INTO `wp_grades` (`id`, `code`, `name`, `deleted_at`) VALUES
(1, 'RMG00001', 'PULP (LONG FIBRE)', NULL),
(2, 'RMG00002', 'UPB/A+ WASTE PAPERS', NULL),
(3, 'RMG00003', 'LPB/A WASTE PAPERS', NULL),
(7, 'RMG00004', 'WLA/SPB+ WASTE PAPERS', NULL),
(22, 'RMG00005', 'weweqew', NULL),
(67, 'RMG00006', 'WLA/SPB+ WASTE ', NULL),
(69, 'RMG00007', 'sdsdsdsd', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wp_suppliers`
--

DROP TABLE IF EXISTS `wp_suppliers`;
CREATE TABLE IF NOT EXISTS `wp_suppliers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) CHARACTER SET utf8 NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `telephone` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `address` text CHARACTER SET utf8 DEFAULT NULL,
  `location` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `region` varchar(50) CHARACTER SET utf8 NOT NULL,
  `state` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wp_suppliers`
--

INSERT INTO `wp_suppliers` (`id`, `number`, `name`, `telephone`, `address`, `location`, `region`, `state`, `created_at`, `deleted_at`) VALUES
(4, '40131310', 'SGGL', '0803376687', '1 Taylor Road Iddo Rice Market Beside G. Cappa', 'W', 'West', 'LAGOS STATE', '2022-01-14 10:36:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wp_weighbridge`
--

DROP TABLE IF EXISTS `wp_weighbridge`;
CREATE TABLE IF NOT EXISTS `wp_weighbridge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(50) CHARACTER SET utf8 NOT NULL,
  `truck_number` varchar(20) CHARACTER SET utf8 NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `grade_count` smallint(6) DEFAULT NULL,
  `grades` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`grades`)),
  `full_weight` float NOT NULL,
  `empty_weight` float DEFAULT NULL,
  `date` varchar(20) CHARACTER SET utf8 NOT NULL,
  `remarks` text CHARACTER SET utf8 DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `net_weight` float GENERATED ALWAYS AS (`full_weight` - `empty_weight`) VIRTUAL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`truck_number`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wp_weighbridge`
--

INSERT INTO `wp_weighbridge` (`id`, `ref`, `truck_number`, `supplier_id`, `grade_count`, `grades`, `full_weight`, `empty_weight`, `date`, `remarks`, `created_at`, `deleted_at`) VALUES
(7, 'JJJ32541IeQJcy', 'JJJ32541', 4, NULL, '2', 1500, 1000, '2022/01/14', 'oaky', '2022-01-14 14:24:02', NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `local_governments`
--
ALTER TABLE `local_governments`
  ADD CONSTRAINT `FK` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
