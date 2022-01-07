-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema playground
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema playground
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `playground` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `playground` ;

-- -----------------------------------------------------
-- Table `playground`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`courses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `quota` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`units`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`units` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `start_date` DATE NOT NULL,
  `courseId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_units_courses_idx` (`courseId` ASC) VISIBLE,
  CONSTRAINT `fk_units_courses`
    FOREIGN KEY (`courseId`)
    REFERENCES `playground`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(500) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `categoryId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_categories_idx` (`categoryId` ASC) VISIBLE,
  CONSTRAINT `fk_users_categories`
    FOREIGN KEY (`categoryId`)
    REFERENCES `playground`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`courses_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`courses_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `courseId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_courses_users_users_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_users_courses`
    FOREIGN KEY (`userID`)
    REFERENCES `playground`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_users`
    FOREIGN KEY (`courseId`)
    REFERENCES `playground`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`lessons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`lessons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `start_date` DATE NOT NULL,
  `visible` TINYINT NOT NULL,
  `unitId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lessons_units_idx` (`unitId` ASC) VISIBLE,
  CONSTRAINT `fk_lessons_units`
    FOREIGN KEY (`unitId`)
    REFERENCES `playground`.`units` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`blocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`blocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(255) NOT NULL,
  `visible` TINYINT NOT NULL,
  `typeId` INT NOT NULL,
  `lessonId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blocks_lessons_idx` (`lessonId` ASC) VISIBLE,
  INDEX `fk_blocks_types_idx` (`typeId` ASC) VISIBLE,
  CONSTRAINT `fk_blocks_lessons`
    FOREIGN KEY (`lessonId`)
    REFERENCES `playground`.`lessons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blocks_types`
    FOREIGN KEY (`typeId`)
    REFERENCES `playground`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
