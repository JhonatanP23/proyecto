-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema caso2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema caso2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `caso2` DEFAULT CHARACTER SET utf8 ;
USE `caso2` ;

-- -----------------------------------------------------
-- Table `caso2`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Persona` (
  `idPersona` INT NOT NULL,
  `Identificacion` VARCHAR(50) NOT NULL,
  `Nombres` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `Correo` VARCHAR(250) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `Personacol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Profesor` (
  `idProfesor` INT NOT NULL,
  `titulacion` VARCHAR(45) NOT NULL,
  `fecha_titulacion` DATE NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idProfesor`, `Persona_idPersona`),
  INDEX `fk_Profesor_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Profesor_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `caso2`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`estudiante` (
  `idestudiante` INT NOT NULL,
  `Fecha_nacimiento` DATE NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idestudiante`, `Persona_idPersona`),
  INDEX `fk_estudiante_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_estudiante_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `caso2`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`programa` (
  `idprograma` SMALLINT NOT NULL,
  `programa` VARCHAR(150) NOT NULL,
  `nivel` VARCHAR(45) NOT NULL,
  `semestres` TINYINT NOT NULL,
  PRIMARY KEY (`idprograma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`Inscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`Inscripcion` (
  `idInscripcion` INT NOT NULL,
  `FECHA_INSCRIPCION` DATE NOT NULL,
  `fecha_graduacion` DATE NULL,
  `estudiante_idestudiante` INT NOT NULL,
  `estudiante_Persona_idPersona` INT NOT NULL,
  `programa_idprograma` SMALLINT NOT NULL,
  PRIMARY KEY (`idInscripcion`),
  INDEX `fk_Inscripcion_estudiante1_idx` (`estudiante_idestudiante` ASC, `estudiante_Persona_idPersona` ASC) VISIBLE,
  INDEX `fk_Inscripcion_programa1_idx` (`programa_idprograma` ASC) VISIBLE,
  CONSTRAINT `fk_Inscripcion_estudiante1`
    FOREIGN KEY (`estudiante_idestudiante` , `estudiante_Persona_idPersona`)
    REFERENCES `caso2`.`estudiante` (`idestudiante` , `Persona_idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inscripcion_programa1`
    FOREIGN KEY (`programa_idprograma`)
    REFERENCES `caso2`.`programa` (`idprograma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`matricula` (
  `idmatricula` INT NOT NULL,
  `periodo` TINYINT NOT NULL,
  `anio` SMALLINT NOT NULL,
  `Inscripcion_idInscripcion` INT NOT NULL,
  PRIMARY KEY (`idmatricula`),
  INDEX `fk_matricula_Inscripcion1_idx` (`Inscripcion_idInscripcion` ASC) VISIBLE,
  CONSTRAINT `fk_matricula_Inscripcion1`
    FOREIGN KEY (`Inscripcion_idInscripcion`)
    REFERENCES `caso2`.`Inscripcion` (`idInscripcion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`materia` (
  `idmateria` INT NOT NULL,
  `materia` VARCHAR(45) NOT NULL,
  `semestre` VARCHAR(45) NULL,
  PRIMARY KEY (`idmateria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`materia_has_Profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`materia_has_Profesor` (
  `materia_idmateria` INT NOT NULL,
  `Profesor_idProfesor` INT NOT NULL,
  PRIMARY KEY (`materia_idmateria`, `Profesor_idProfesor`),
  INDEX `fk_materia_has_Profesor_Profesor1_idx` (`Profesor_idProfesor` ASC) VISIBLE,
  INDEX `fk_materia_has_Profesor_materia_idx` (`materia_idmateria` ASC) VISIBLE,
  CONSTRAINT `fk_materia_has_Profesor_materia`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `caso2`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_has_Profesor_Profesor1`
    FOREIGN KEY (`Profesor_idProfesor`)
    REFERENCES `caso2`.`Profesor` (`idProfesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `caso2`.`matricula_has_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `caso2`.`matricula_has_materia` (
  `matricula_idmatricula` INT NOT NULL,
  `materia_idmateria` INT NOT NULL,
  PRIMARY KEY (`matricula_idmatricula`, `materia_idmateria`),
  INDEX `fk_matricula_has_materia_materia1_idx` (`materia_idmateria` ASC) VISIBLE,
  INDEX `fk_matricula_has_materia_matricula1_idx` (`matricula_idmatricula` ASC) VISIBLE,
  CONSTRAINT `fk_matricula_has_materia_matricula1`
    FOREIGN KEY (`matricula_idmatricula`)
    REFERENCES `caso2`.`matricula` (`idmatricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_has_materia_materia1`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `caso2`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
