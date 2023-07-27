-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_Drogueria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_Drogueria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_Drogueria` DEFAULT CHARACTER SET utf8 ;
USE `db_Drogueria` ;

-- -----------------------------------------------------
-- Table `db_Drogueria`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Drogueria`.`persona` (
  `idpersona` INT NOT NULL,
  `identificacion` VARCHAR(45) NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NULL,
  PRIMARY KEY (`idpersona`),
  UNIQUE INDEX `identificacion_UNIQUE` (`identificacion` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Drogueria`.`compania`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Drogueria`.`compania` (
  `idcompania` SMALLINT NOT NULL,
  `nit` VARCHAR(45) NOT NULL,
  `companina` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcompania`),
  UNIQUE INDEX `nit_UNIQUE` (`nit` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Drogueria`.`termino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Drogueria`.`termino` (
  `idtermino` TINYINT NOT NULL,
  `termino` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtermino`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Drogueria`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Drogueria`.`factura` (
  `idfactura` BIGINT NOT NULL,
  `persona_idpersona` INT NOT NULL,
  `compania_idcompania` SMALLINT NULL,
  `termino_idtermino` TINYINT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  PRIMARY KEY (`idfactura`),
  INDEX `fk_factura_persona_idx` (`persona_idpersona` ASC) VISIBLE,
  INDEX `fk_factura_compania1_idx` (`compania_idcompania` ASC) VISIBLE,
  INDEX `fk_factura_termino1_idx` (`termino_idtermino` ASC) VISIBLE,
  CONSTRAINT `fk_factura_persona`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `db_Drogueria`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_compania1`
    FOREIGN KEY (`compania_idcompania`)
    REFERENCES `db_Drogueria`.`compania` (`idcompania`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_termino1`
    FOREIGN KEY (`termino_idtermino`)
    REFERENCES `db_Drogueria`.`termino` (`idtermino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Drogueria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Drogueria`.`categoria` (
  `idcategoria` SMALLINT NOT NULL,
  `termino` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Drogueria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Drogueria`.`producto` (
  `id_producto` INT NOT NULL,
  `producto` VARCHAR(45) NOT NULL,
  `existencia` INT NOT NULL DEFAULT 0,
  `valor_unitario_venta` FLOAT NOT NULL,
  `valor_unitario_compra` FLOAT NOT NULL,
  `categoria_idcategoria` SMALLINT NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `fk_producto_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `db_Drogueria`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Drogueria`.`factura_has_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Drogueria`.`factura_has_producto` (
  `factura_idfactura` BIGINT NOT NULL,
  `producto_id_producto` INT NOT NULL,
  PRIMARY KEY (`factura_idfactura`, `producto_id_producto`),
  INDEX `fk_factura_has_producto_producto1_idx` (`producto_id_producto` ASC) VISIBLE,
  INDEX `fk_factura_has_producto_factura1_idx` (`factura_idfactura` ASC) VISIBLE,
  CONSTRAINT `fk_factura_has_producto_factura1`
    FOREIGN KEY (`factura_idfactura`)
    REFERENCES `db_Drogueria`.`factura` (`idfactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_has_producto_producto1`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `db_Drogueria`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
