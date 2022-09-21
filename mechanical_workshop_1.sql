-- -----------------------------------------------------
-- Schema mechanic_workshop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mechanic_workshop` DEFAULT CHARACTER SET utf8 ;
USE `mechanic_workshop` ;

-- -----------------------------------------------------
-- Table `mechanic_workshop`.`custommer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`custommer` (
  `id_custommer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `client_since` DATE NOT NULL,
  `phone_1` VARCHAR(45) NOT NULL,
  `phone_2` VARCHAR(45) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`id_custommer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mechanic_workshop`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`staff` (
  `id_member` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `function` VARCHAR(100) NOT NULL,
  `birth_date` DATE NULL,
  `ssn` VARCHAR(45) NOT NULL,
  `salary_base` INT NOT NULL,
  `phone_1` VARCHAR(45) NOT NULL,
  `phone_2` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `employment_date` DATE NOT NULL,
  PRIMARY KEY (`id_member`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mechanic_workshop`.`box`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`box` (
  `id_box` INT NOT NULL AUTO_INCREMENT,
  `manager_id` INT NOT NULL,
  PRIMARY KEY (`id_box`),
  INDEX `fk_box_staff1_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_box_staff1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `mechanic_workshop
  `.`staff` (`id_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mechanic_workshop`.`service_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`service_order` (
  `id_service_order` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `deadline` DATE NOT NULL,
  `value` FLOAT NOT NULL,
  `description` TEXT NOT NULL,
  `car_model` VARCHAR(45) NOT NULL,
  `car_manufacturer` VARCHAR(45) NOT NULL,
  `car_year` VARCHAR(45) NOT NULL,
  `created_by` INT NOT NULL,
  `box_id` INT NOT NULL,
  `custommer_id` INT NOT NULL,
  PRIMARY KEY (`id_service_order`, `created_by`, `box_id`, `custommer_id`),
  INDEX `fk_service_order_custommer_idx` (`custommer_id` ASC) VISIBLE,
  INDEX `fk_service_order_staff1_idx` (`created_by` ASC) VISIBLE,
  INDEX `fk_service_order_box1_idx` (`box_id` ASC) VISIBLE,
  CONSTRAINT `fk_service_order_custommer`
    FOREIGN KEY (`custommer_id`)
    REFERENCES `mechanic_workshop
  `.`custommer` (`id_custommer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_order_staff1`
    FOREIGN KEY (`created_by`)
    REFERENCES `mechanic_workshop
  `.`staff` (`id_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_order_box1`
    FOREIGN KEY (`box_id`)
    REFERENCES `mechanic_workshop
  `.`box` (`id_box`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mechanic_workshop`.`box_has_staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`box_has_staff` (
  `staff_id_member` INT NOT NULL,
  `box_id_box` INT NOT NULL,
  PRIMARY KEY (`staff_id_member`, `box_id_box`),
  INDEX `fk_box_has_staff_staff1_idx` (`staff_id_member` ASC) VISIBLE,
  INDEX `fk_box_has_staff_box1_idx` (`box_id_box` ASC) VISIBLE,
  CONSTRAINT `fk_box_has_staff_box1`
    FOREIGN KEY (`box_id_box`)
    REFERENCES `mechanic_workshop
  `.`box` (`id_box`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_box_has_staff_staff1`
    FOREIGN KEY (`staff_id_member`)
    REFERENCES `mechanic_workshop
  `.`staff` (`id_member`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mechanic_workshop`.`parts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`parts` (
  `id_object` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  `description` TEXT NULL,
  `stock_ammount` INT NOT NULL,
  PRIMARY KEY (`id_object`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mechanic_workshop`.`service_has_parts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`service_has_parts` (
  `parts_id` INT NOT NULL,
  `service_order_id` INT NOT NULL,
  PRIMARY KEY (`parts_id`, `service_order_id`),
  INDEX `fk_service_order_has_parts_parts1_idx` (`parts_id` ASC) VISIBLE,
  INDEX `fk_service_order_has_parts_service_order1_idx` (`service_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_service_order_has_parts_service_order1`
    FOREIGN KEY (`service_order_id`)
    REFERENCES `mechanic_workshop
  `.`service_order` (`id_service_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_order_has_parts_parts1`
    FOREIGN KEY (`parts_id`)
    REFERENCES `mechanic_workshop
  `.`parts` (`id_object`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mechanic_workshop`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`supplier` (
  `id_supplier` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `phone_1` VARCHAR(45) NOT NULL,
  `phone_2` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_supplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mechanic_workshop`.`parts_has_supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mechanic_workshop`.`parts_has_supplier` (
  `parts_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  PRIMARY KEY (`parts_id`, `supplier_id`),
  INDEX `fk_parts_has_supplier_supplier1_idx` (`supplier_id` ASC) VISIBLE,
  INDEX `fk_parts_has_supplier_parts1_idx` (`parts_id` ASC) VISIBLE,
  CONSTRAINT `fk_parts_has_supplier_parts1`
    FOREIGN KEY (`parts_id`)
    REFERENCES `mechanic_workshop
  `.`parts` (`id_object`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_parts_has_supplier_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `mechanic_workshop
  `.`supplier` (`id_supplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;