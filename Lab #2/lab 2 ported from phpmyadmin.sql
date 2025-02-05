-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 05, 2025 at 11:07 AM
-- Server version: 8.0.33
-- PHP Version: 7.2.24-0ubuntu0.18.04.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bech1695`
--
CREATE DATABASE IF NOT EXISTS `bech1695` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `bech1695`;

-- --------------------------------------------------------

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
CREATE TABLE IF NOT EXISTS `Customer` (
  `Customer_ID` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for customers\r\n\r\n',
  `Name` varchar(45) NOT NULL COMMENT 'Allows full names up to 45 characters',
  `Address _1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'First line of address',
  `Address_2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Optional second line of address maybe for unit number or apartment number',
  `City` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Customer city - accepts spaces between words as input',
  `State` varchar(2) NOT NULL COMMENT 'Use 2-character state abbreviations (e.g., "CA")',
  `Zip` int NOT NULL COMMENT 'Allows ZIP+4 (e.g., "12345-6789")',
  `Phone_1` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Main phone number, largest international phone number is 15',
  `Phone_2` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Second phone number',
  `Referred_By` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Optional: who referred Customer',
  `Customer_Since` date NOT NULL COMMENT 'When did the customer start being a customer? ',
  `Notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'Customer notes, note stay with customer ',
  PRIMARY KEY (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Individual Customer';

-- --------------------------------------------------------

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
CREATE TABLE IF NOT EXISTS `Item` (
  `Item_SKU` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Unique identifier for items',
  `Item_Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'Optional description of the item',
  `Unit_Price` decimal(10,2) NOT NULL COMMENT 'Price per unit of the item for purchase',
  PRIMARY KEY (`Item_SKU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Single Item';

-- --------------------------------------------------------

--
-- Table structure for table `Retail_Sale`
--

DROP TABLE IF EXISTS `Retail_Sale`;
CREATE TABLE IF NOT EXISTS `Retail_Sale` (
  `Sale_ID` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for each sale\r\n\r\nAutomatically increments for each new sale entry',
  `Customer_ID` int UNSIGNED NOT NULL COMMENT 'References a specific customer from the Customer table\r\n\r\nLinks each sale to a customer who made the purchase',
  `Date` date NOT NULL COMMENT 'Stores the date when the sale transaction occurred',
  `Sold_By` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Represents the name or identifier of the employee who handled the sale\r\n\r\nUseful for tracking employee performance and accountability',
  `Delivery_Charge` decimal(10,2) DEFAULT NULL COMMENT 'Stores the delivery cost (if applicable) for the sale\r\n\r\nAllows NULL values for in-store purchases without delivery',
  `Sales_Tax` decimal(10,2) DEFAULT NULL COMMENT 'Stores the calculated sales tax for the transaction\r\n\r\nHelps maintain tax compliance and financial reporting',
  `Special_Instructions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'Captures any additional notes or special requests related to the sale',
  PRIMARY KEY (`Sale_ID`),
  KEY `Customer ID` (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Single Sale Transaction Invoice';

-- --------------------------------------------------------

--
-- Table structure for table `Retail_Sale_Item`
--

DROP TABLE IF EXISTS `Retail_Sale_Item`;
CREATE TABLE IF NOT EXISTS `Retail_Sale_Item` (
  `Sale_ID` int UNSIGNED NOT NULL COMMENT 'References Retail Sale(Sale ID)',
  `Item_SKU` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'References Item(Item SKU)',
  `Quantity` int NOT NULL COMMENT 'The number of the item purchased',
  KEY `Sale ID` (`Sale_ID`),
  KEY `Item SKU` (`Item_SKU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Item Sold';

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Retail_Sale`
--
ALTER TABLE `Retail_Sale`
  ADD CONSTRAINT `FK_CustomerID` FOREIGN KEY (`Customer_ID`) REFERENCES `Customer` (`Customer_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Retail_Sale_Item`
--
ALTER TABLE `Retail_Sale_Item`
  ADD CONSTRAINT `FK_ItemSKU` FOREIGN KEY (`Item_SKU`) REFERENCES `Item` (`Item_SKU`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SaleID` FOREIGN KEY (`Sale_ID`) REFERENCES `Retail_Sale` (`Sale_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
