-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bazar_digital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bazar_digital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bazar_digital` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema bazar_digital
-- -----------------------------------------------------
USE `bazar_digital` ;

-- -----------------------------------------------------
-- Table `bazar_digital`.`products_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`products_categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`articles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(9,2) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `stock` TINYINT(10) NOT NULL,
  `profesional_use` INT NOT NULL,
  `typeId` INT NOT NULL,
  `productCategoryId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_category_articles_idx` (`productCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_category_articles`
    FOREIGN KEY (`productCategoryId`)
    REFERENCES `bazar_digital`.`products_categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `dni` TINYINT(10) NOT NULL,
  `salary` TINYINT(10) NOT NULL,
  `rolId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employees_rol_idx` (`rolId` ASC) VISIBLE,
  CONSTRAINT `fk_employees_rol`
    FOREIGN KEY (`rolId`)
    REFERENCES `bazar_digital`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `article` VARCHAR(45) NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `total_amount` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`employees_access`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`employees_access` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `saleId` INT NOT NULL,
  `articlesId` INT NOT NULL,
  `rolId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employees_access_idx` (`rolId` ASC) VISIBLE,
  INDEX `fk_employees_sales_idx` (`saleId` ASC) VISIBLE,
  INDEX `fk_employees_articles_idx` (`articlesId` ASC) VISIBLE,
  CONSTRAINT `fk_employees_access`
    FOREIGN KEY (`rolId`)
    REFERENCES `bazar_digital`.`employees` (`rolId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_sales`
    FOREIGN KEY (`saleId`)
    REFERENCES `bazar_digital`.`sales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_articles`
    FOREIGN KEY (`articlesId`)
    REFERENCES `bazar_digital`.`articles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
