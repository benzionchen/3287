-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bech1695
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bech1695
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bech1695` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bech1695` ;

-- -----------------------------------------------------
-- Table `bech1695`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bech1695`.`Customer` ;

CREATE TABLE IF NOT EXISTS `bech1695`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50) NULL DEFAULT NULL,
  `LastName` VARCHAR(50) NULL DEFAULT NULL,
  `Address1` VARCHAR(100) NULL DEFAULT NULL,
  `Address2` VARCHAR(100) NULL DEFAULT NULL,
  `City` VARCHAR(50) NULL DEFAULT NULL,
  `State` VARCHAR(20) NULL DEFAULT NULL,
  `ZIP` VARCHAR(10) NULL DEFAULT NULL,
  `Phone1` VARCHAR(15) NULL DEFAULT NULL,
  `Phone2` VARCHAR(15) NULL DEFAULT NULL,
  `ReferredBy` VARCHAR(50) NULL DEFAULT NULL,
  `CustomerSince` DATE NULL DEFAULT NULL,
  `Notes` TEXT NULL DEFAULT NULL,
  `PrefersMowing` TINYINT(1) NULL DEFAULT NULL,
  `PrefersLandscaping` TINYINT(1) NULL DEFAULT NULL,
  `PrefersOther` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bech1695`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bech1695`.`Employee` ;

CREATE TABLE IF NOT EXISTS `bech1695`.`Employee` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50) NULL DEFAULT NULL,
  `LastName` VARCHAR(50) NULL DEFAULT NULL,
  `Role` VARCHAR(50) NULL DEFAULT NULL,
  `Phone` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bech1695`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bech1695`.`Supplier` ;

CREATE TABLE IF NOT EXISTS `bech1695`.`Supplier` (
  `SupplierID` INT NOT NULL AUTO_INCREMENT,
  `Category` VARCHAR(50) NULL DEFAULT NULL,
  `Name` VARCHAR(100) NULL DEFAULT NULL,
  `Address1` VARCHAR(100) NULL DEFAULT NULL,
  `Address2` VARCHAR(100) NULL DEFAULT NULL,
  `City` VARCHAR(50) NULL DEFAULT NULL,
  `State` VARCHAR(20) NULL DEFAULT NULL,
  `ZIP` VARCHAR(10) NULL DEFAULT NULL,
  `PhoneOrders` VARCHAR(20) NULL DEFAULT NULL,
  `ContactName` VARCHAR(50) NULL DEFAULT NULL,
  `ContactPhone` VARCHAR(20) NULL DEFAULT NULL,
  `ShippingBillingTerms` TEXT NULL DEFAULT NULL,
  `Notes` TEXT NULL DEFAULT NULL,
  `Preferred` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`SupplierID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bech1695`.`InventoryItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bech1695`.`InventoryItem` ;

CREATE TABLE IF NOT EXISTS `bech1695`.`InventoryItem` (
  `ItemSKU` VARCHAR(20) NOT NULL,
  `Name` VARCHAR(100) NULL DEFAULT NULL,
  `Type` ENUM('Tree', 'Shrub', 'Perennial', 'Mulch', 'Gravel', 'Topsoil', 'Stone', 'Paver', 'Timber', 'Sand') NULL DEFAULT NULL,
  `Size` VARCHAR(50) NULL DEFAULT NULL,
  `UnitOfMeasure` ENUM('Each', 'CubicYards', 'Pallet') NULL DEFAULT NULL,
  `PurchasePrice` DECIMAL(10,2) NULL DEFAULT NULL,
  `QtyAvailable` INT NULL DEFAULT NULL,
  `SupplierID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ItemSKU`),
  INDEX `SupplierID` (`SupplierID` ASC) VISIBLE,
  CONSTRAINT `InventoryItem_ibfk_1`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `bech1695`.`Supplier` (`SupplierID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bech1695`.`OrderLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bech1695`.`OrderLog` ;

CREATE TABLE IF NOT EXISTS `bech1695`.`OrderLog` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NULL DEFAULT NULL,
  `SupplierID` INT NULL DEFAULT NULL,
  `ConfirmationNumber` VARCHAR(50) NULL DEFAULT NULL,
  `ItemSKU` VARCHAR(20) NULL DEFAULT NULL,
  `Quantity` INT NULL DEFAULT NULL,
  `Price` DECIMAL(10,2) NULL DEFAULT NULL,
  `ExtendedPrice` DECIMAL(10,2) NULL DEFAULT NULL,
  `Taxes` DECIMAL(10,2) NULL DEFAULT NULL,
  `Shipping` DECIMAL(10,2) NULL DEFAULT NULL,
  `Total` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `SupplierID` (`SupplierID` ASC) VISIBLE,
  INDEX `ItemSKU` (`ItemSKU` ASC) VISIBLE,
  CONSTRAINT `OrderLog_ibfk_1`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `bech1695`.`Supplier` (`SupplierID`),
  CONSTRAINT `OrderLog_ibfk_2`
    FOREIGN KEY (`ItemSKU`)
    REFERENCES `bech1695`.`InventoryItem` (`ItemSKU`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bech1695`.`Sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bech1695`.`Sale` ;

CREATE TABLE IF NOT EXISTS `bech1695`.`Sale` (
  `SaleID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NULL DEFAULT NULL,
  `SaleDate` DATE NULL DEFAULT NULL,
  `SoldByEmployeeID` INT NULL DEFAULT NULL,
  `SaleType` ENUM('InStore', 'Delivery', 'Landscaping') NULL DEFAULT NULL,
  `DeliveryCharge` DECIMAL(10,2) NULL DEFAULT NULL,
  `SalesTax` DECIMAL(10,2) NULL DEFAULT NULL,
  `LandscapingRelated` TINYINT(1) NULL DEFAULT NULL,
  `SpecialInstructions` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`SaleID`),
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `SoldByEmployeeID` (`SoldByEmployeeID` ASC) VISIBLE,
  CONSTRAINT `Sale_ibfk_1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `bech1695`.`Customer` (`CustomerID`),
  CONSTRAINT `Sale_ibfk_2`
    FOREIGN KEY (`SoldByEmployeeID`)
    REFERENCES `bech1695`.`Employee` (`EmployeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bech1695`.`SaleItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bech1695`.`SaleItem` ;

CREATE TABLE IF NOT EXISTS `bech1695`.`SaleItem` (
  `SaleItemID` INT NOT NULL AUTO_INCREMENT,
  `SaleID` INT NULL DEFAULT NULL,
  `ItemSKU` VARCHAR(20) NULL DEFAULT NULL,
  `Quantity` INT NULL DEFAULT NULL,
  `UnitPrice` DECIMAL(10,2) NULL DEFAULT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`SaleItemID`),
  INDEX `SaleID` (`SaleID` ASC) VISIBLE,
  INDEX `ItemSKU` (`ItemSKU` ASC) VISIBLE,
  INDEX `EmployeeID` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `SaleItem_ibfk_1`
    FOREIGN KEY (`SaleID`)
    REFERENCES `bech1695`.`Sale` (`SaleID`),
  CONSTRAINT `SaleItem_ibfk_2`
    FOREIGN KEY (`ItemSKU`)
    REFERENCES `bech1695`.`InventoryItem` (`ItemSKU`),
  CONSTRAINT `SaleItem_ibfk_3`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `bech1695`.`Employee` (`EmployeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
