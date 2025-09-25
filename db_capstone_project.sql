-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`book_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`book_table` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `sit_capacity` INT NOT NULL,
  `avilable_status` BLOB NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`castomers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`castomers` (
  `castomer_id` INT NOT NULL,
  `castomer_name` VARCHAR(45) NOT NULL,
  `castomer_phon_no` VARCHAR(45) NOT NULL,
  `castomer_email` VARCHAR(45) NULL,
  PRIMARY KEY (`castomer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staffs` (
  `staff_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `address` VARCHAR(300) NOT NULL,
  `phone_no` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `salary` DECIMAL NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `book_table_id` INT NOT NULL,
  `booking_date` TIMESTAMP NOT NULL,
  `book_by_casotmer_id` INT NOT NULL,
  `assign_to_staff_id` INT NULL DEFAULT 0,
  PRIMARY KEY (`booking_id`),
  INDEX `table_id_fk_idx` (`book_table_id` ASC) VISIBLE,
  INDEX `castomer_id_fk_idx` (`book_by_casotmer_id` ASC) VISIBLE,
  INDEX `staff_fk_idx` (`assign_to_staff_id` ASC) VISIBLE,
  CONSTRAINT `table_id_fk`
    FOREIGN KEY (`book_table_id`)
    REFERENCES `LittleLemonDB`.`book_table` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `castomer_id_fk`
    FOREIGN KEY (`book_by_casotmer_id`)
    REFERENCES `LittleLemonDB`.`castomers` (`castomer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `staff_fk`
    FOREIGN KEY (`assign_to_staff_id`)
    REFERENCES `LittleLemonDB`.`staffs` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menu_name` VARCHAR(45) NOT NULL,
  `menu_type` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`orders` (
  `orders_id` INT NOT NULL AUTO_INCREMENT,
  `menu_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  `quantity` CHAR(45) NOT NULL,
  `price` DECIMAL NULL,
  `order_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`orders_id`),
  INDEX `booking_fk_idx` (`booking_id` ASC) VISIBLE,
  INDEX `menu_fk_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `booking_fk`
    FOREIGN KEY (`booking_id`)
    REFERENCES `LittleLemonDB`.`bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menu_fk`
    FOREIGN KEY (`menu_id`)
    REFERENCES `LittleLemonDB`.`menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`order_delivary_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`order_delivary_status` (
  `order_delivary_status_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `order_delivary_status` BLOB NOT NULL,
  PRIMARY KEY (`order_delivary_status_id`),
  INDEX `order_id_fk_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `order_id_fk`
    FOREIGN KEY (`order_id`)
    REFERENCES `LittleLemonDB`.`orders` (`orders_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
