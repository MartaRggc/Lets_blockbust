-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blockbuster` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `blockbuster` ;

-- -----------------------------------------------------
-- Table `blockbuster`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lan` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`film` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `description` VARCHAR(150) NULL,
  `release_year` YEAR(4) NULL,
  `rental_duration` INT NULL,
  `rental_rate` FLOAT NULL,
  `length` INT NULL,
  `replacement_cost` FLOAT NULL,
  `rating` VARCHAR(5) NULL,
  `deleted_scenes` TINYINT NULL,
  `behind_scenes` TINYINT NULL,
  `trailer` TINYINT NULL,
  `commentaries` TINYINT NULL,
  `original_language_id` INT NOT NULL,
  PRIMARY KEY (`id`, `original_language_id`),
  INDEX `fk_film_language1_idx` (`original_language_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_language1`
    FOREIGN KEY (`original_language_id`)
    REFERENCES `blockbuster`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`actor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`actorfilm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`actorfilm` (
  `film_id` INT NOT NULL,
  `actor_id` INT NOT NULL,
  PRIMARY KEY (`film_id`, `actor_id`),
  INDEX `fk_film_has_actor_actor1_idx` (`actor_id` ASC) VISIBLE,
  INDEX `fk_film_has_actor_film_idx` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_has_actor_film`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_film_has_actor_actor1`
    FOREIGN KEY (`actor_id`)
    REFERENCES `blockbuster`.`actor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cat` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`catfilm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`catfilm` (
  `film_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`film_id`, `category_id`),
  INDEX `fk_film_has_category_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_film_has_category_film1_idx` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_has_category_film1`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_film_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `blockbuster`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`inventory` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `film_id` INT NOT NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`id`, `film_id`, `language_id`),
  INDEX `fk_inventory_film1_idx` (`film_id` ASC) VISIBLE,
  INDEX `fk_inventory_language1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_film1`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `blockbuster`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `sex` VARCHAR(45) NULL,
  `age` INT NULL,
  `phone` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  `postal` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`staff` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`rental` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rental_time` INT NULL,
  `rental_date` DATETIME NULL,
  `return_date` DATETIME NULL,
  `inventory_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`id`, `inventory_id`, `customer_id`, `staff_id`),
  INDEX `fk_rental_inventory1_idx` (`inventory_id` ASC) VISIBLE,
  INDEX `fk_rental_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_rental_staff1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_inventory1`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `blockbuster`.`inventory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `blockbuster`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `blockbuster`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blockbuster`.`updates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`updates` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tab` VARCHAR(45) NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
