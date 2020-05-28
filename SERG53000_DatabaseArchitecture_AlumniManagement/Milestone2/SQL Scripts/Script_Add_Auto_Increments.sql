-- MySQL Workbench Synchronization
-- Generated: 2019-05-30 20:15
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Sanyukta Ghai

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `segr5300`.`all_events` 
CHANGE COLUMN `all_events_id` `all_events_id` INT(6) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `segr5300`.`alum_events` 
CHANGE COLUMN `alum_events_id` `alum_events_id` INT(6) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `segr5300`.`alum_program` 
CHANGE COLUMN `alum_program_id` `alum_program_id` INT(6) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `segr5300`.`alumni` 
CHANGE COLUMN `alumni_id` `alumni_id` INT(6) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `segr5300`.`alumni_donation` 
CHANGE COLUMN `alumni_donation_id` `alumni_donation_id` INT(6) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `segr5300`.`department` 
CHANGE COLUMN `department_id` `department_id` INT(6) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `segr5300`.`program` 
CHANGE COLUMN `program_id` `program_id` INT(6) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `segr5300`.`program_categories` 
CHANGE COLUMN `program_categories_id` `program_categories_id` INT(6) NOT NULL AUTO_INCREMENT ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
