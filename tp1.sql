-- MySQL Script generated by MySQL Workbench
-- mié 17 oct 2018 14:59:57 -03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema mdyb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mdyb` ;

-- -----------------------------------------------------
-- Schema mdyb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mdyb` ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Departamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `idDepartamento` INT NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Oficial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Oficial` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Oficial` (
  `num` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `FechaIngreso` VARCHAR(45) NULL,
  `Rango` VARCHAR(45) NULL,
  `idDepartamento` INT NOT NULL,
  `Apellido` VARCHAR(45) NULL,
  PRIMARY KEY (`num`),
  INDEX `fk_Oficial_Departamento1_idx` (`idDepartamento` ASC),
  CONSTRAINT `fk_Oficial_Departamento1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `mydb`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoDesignacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TipoDesignacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TipoDesignacion` (
  `idTipo` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Designacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Designacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Designacion` (
  `idDesignacion` INT NOT NULL,
  `num` INT NOT NULL,
  `Fecha` DATETIME NULL,
  `idTipo` INT NOT NULL,
  PRIMARY KEY (`idDesignacion`),
  INDEX `fk_Designacion_Oficial_idx` (`num` ASC),
  INDEX `fk_Designacion_TipoDesignacion1_idx` (`idTipo` ASC),
  CONSTRAINT `fk_Designacion_Oficial`
    FOREIGN KEY (`num`)
    REFERENCES `mydb`.`Oficial` (`num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Designacion_TipoDesignacion1`
    FOREIGN KEY (`idTipo`)
    REFERENCES `mydb`.`TipoDesignacion` (`idTipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EstadoSumario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EstadoSumario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EstadoSumario` (
  `idEstado` INT NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AsuntosInternos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AsuntosInternos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`AsuntosInternos` (
  `Oficial_num` INT NOT NULL,
  PRIMARY KEY (`Oficial_num`),
  CONSTRAINT `fk_AsuntosInternos_Oficial1`
    FOREIGN KEY (`Oficial_num`)
    REFERENCES `mydb`.`Oficial` (`num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sumario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sumario` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Sumario` (
  `idSumario` INT NOT NULL,
  `Fecha` DATETIME NULL,
  `Descripcion` VARCHAR(45) NULL,
  `idDesignacion` INT NOT NULL,
  `Resultado` VARCHAR(45) NULL,
  `EstadoSumario` INT NOT NULL,
  `OficialQueInvestiga` INT NOT NULL,
  PRIMARY KEY (`idSumario`),
  INDEX `fk_Sumario_Designacion1_idx` (`idDesignacion` ASC),
  INDEX `fk_Sumario_EstadoSumario1_idx` (`EstadoSumario` ASC),
  INDEX `fk_Sumario_AsuntosInternos1_idx` (`OficialQueInvestiga` ASC),
  CONSTRAINT `fk_Sumario_Designacion1`
    FOREIGN KEY (`idDesignacion`)
    REFERENCES `mydb`.`Designacion` (`idDesignacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sumario_EstadoSumario1`
    FOREIGN KEY (`EstadoSumario`)
    REFERENCES `mydb`.`EstadoSumario` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sumario_AsuntosInternos1`
    FOREIGN KEY (`OficialQueInvestiga`)
    REFERENCES `mydb`.`AsuntosInternos` (`Oficial_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Barrio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Barrio` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Barrio` (
  `idBarrio` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idBarrio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Calle` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Calle` (
  `idCalle` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCalle`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Direccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Direccion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Direccion` (
  `idDireccion` INT NOT NULL,
  `calle` INT NOT NULL,
  `Altura` INT NOT NULL,
  `Barrio_idBarrio` INT NOT NULL,
  `calleAledaña1` INT NULL,
  `calleAledaña2` INT NULL,
  PRIMARY KEY (`idDireccion`),
  INDEX `fk_Direccion_Barrio1_idx` (`Barrio_idBarrio` ASC),
  INDEX `fk_Direccion_Calle2_idx` (`calle` ASC),
  INDEX `fk_Direccion_Calle3_idx` (`calleAledaña1` ASC),
  INDEX `fk_Direccion_Calle1_idx` (`calleAledaña2` ASC),
  CONSTRAINT `fk_Direccion_Barrio1`
    FOREIGN KEY (`Barrio_idBarrio`)
    REFERENCES `mydb`.`Barrio` (`idBarrio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Direccion_Calle2`
    FOREIGN KEY (`calle`)
    REFERENCES `mydb`.`Calle` (`idCalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Direccion_Calle3`
    FOREIGN KEY (`calleAledaña1`)
    REFERENCES `mydb`.`Calle` (`idCalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Direccion_Calle1`
    FOREIGN KEY (`calleAledaña2`)
    REFERENCES `mydb`.`Calle` (`idCalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Incidente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Incidente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Incidente` (
  `idIncidente` INT NOT NULL,
  `idDireccion` INT NOT NULL,
  `Numero` INT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Fecha` DATETIME NULL,
  PRIMARY KEY (`idIncidente`, `idDireccion`),
  INDEX `fk_Incidente_Direccion1_idx` (`idDireccion` ASC),
  CONSTRAINT `fk_Incidente_Direccion1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `mydb`.`Direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Interviene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Interviene` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Interviene` (
  `num` INT NOT NULL,
  `idIncidente` INT NOT NULL,
  `Rol` VARCHAR(45) NULL,
  PRIMARY KEY (`num`, `idIncidente`),
  INDEX `fk_Oficial_has_Incidente_Incidente1_idx` (`idIncidente` ASC),
  INDEX `fk_Oficial_has_Incidente_Oficial1_idx` (`num` ASC),
  CONSTRAINT `fk_Oficial_has_Incidente_Oficial1`
    FOREIGN KEY (`num`)
    REFERENCES `mydb`.`Oficial` (`num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Oficial_has_Incidente_Incidente1`
    FOREIGN KEY (`idIncidente`)
    REFERENCES `mydb`.`Incidente` (`idIncidente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Superheroe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Superheroe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Superheroe` (
  `idSuperheroe` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `ColorDisfraz` VARCHAR(45) NULL,
  PRIMARY KEY (`idSuperheroe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Participa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Participa` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Participa` (
  `idSuperheroe` INT NOT NULL,
  `idIncidente` INT NOT NULL,
  PRIMARY KEY (`idSuperheroe`, `idIncidente`),
  INDEX `fk_Superheroe_has_Incidente_Incidente1_idx` (`idIncidente` ASC),
  INDEX `fk_Superheroe_has_Incidente_Superheroe1_idx` (`idSuperheroe` ASC),
  CONSTRAINT `fk_Superheroe_has_Incidente_Superheroe1`
    FOREIGN KEY (`idSuperheroe`)
    REFERENCES `mydb`.`Superheroe` (`idSuperheroe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Superheroe_has_Incidente_Incidente1`
    FOREIGN KEY (`idIncidente`)
    REFERENCES `mydb`.`Incidente` (`idIncidente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrganizacionDelictiva`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`OrganizacionDelictiva` ;

CREATE TABLE IF NOT EXISTS `mydb`.`OrganizacionDelictiva` (
  `idOrganizacionDelictiva` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idOrganizacionDelictiva`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Persona` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Persona` (
  `idPersona` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  `idOrganizacionDelictiva` INT NULL,
  `Direccion_idDireccion` INT NOT NULL,
  PRIMARY KEY (`idPersona`, `Direccion_idDireccion`),
  INDEX `fk_Persona_OrganizacionDelictiva1_idx` (`idOrganizacionDelictiva` ASC),
  INDEX `fk_Persona_Direccion1_idx` (`Direccion_idDireccion` ASC),
  CONSTRAINT `fk_Persona_OrganizacionDelictiva1`
    FOREIGN KEY (`idOrganizacionDelictiva`)
    REFERENCES `mydb`.`OrganizacionDelictiva` (`idOrganizacionDelictiva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persona_Direccion1`
    FOREIGN KEY (`Direccion_idDireccion`)
    REFERENCES `mydb`.`Direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Involucra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Involucra` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Involucra` (
  `idIncidente` INT NOT NULL,
  `idPersona` INT NOT NULL,
  `Rol` VARCHAR(45) NULL,
  PRIMARY KEY (`idIncidente`, `idPersona`),
  INDEX `fk_Incidente_has_Persona_Persona1_idx` (`idPersona` ASC),
  INDEX `fk_Incidente_has_Persona_Incidente1_idx` (`idIncidente` ASC),
  CONSTRAINT `fk_Incidente_has_Persona_Incidente1`
    FOREIGN KEY (`idIncidente`)
    REFERENCES `mydb`.`Incidente` (`idIncidente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incidente_has_Persona_Persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Serelacionacon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Serelacionacon` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Serelacionacon` (
  `idPersona` INT NOT NULL,
  `idPersona1` INT NOT NULL,
  `ClaseDeVinculo` VARCHAR(45) NULL,
  `Fecha` DATETIME NULL,
  PRIMARY KEY (`idPersona`, `idPersona1`),
  INDEX `fk_Persona_has_Persona_Persona2_idx` (`idPersona1` ASC),
  INDEX `fk_Persona_has_Persona_Persona1_idx` (`idPersona` ASC),
  CONSTRAINT `fk_Persona_has_Persona_Persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persona_has_Persona_Persona2`
    FOREIGN KEY (`idPersona1`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contacta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Contacta` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Contacta` (
  `idSuperheroe` INT NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idSuperheroe`, `idPersona`),
  INDEX `fk_Superheroe_has_Persona_Persona1_idx` (`idPersona` ASC),
  INDEX `fk_Superheroe_has_Persona_Superheroe1_idx` (`idSuperheroe` ASC),
  CONSTRAINT `fk_Superheroe_has_Persona_Superheroe1`
    FOREIGN KEY (`idSuperheroe`)
    REFERENCES `mydb`.`Superheroe` (`idSuperheroe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Superheroe_has_Persona_Persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Archienemigo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Archienemigo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Archienemigo` (
  `idSuperheroe` INT NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idSuperheroe`, `idPersona`),
  INDEX `fk_Superheroe_has_Persona_Persona2_idx` (`idPersona` ASC),
  INDEX `fk_Superheroe_has_Persona_Superheroe2_idx` (`idSuperheroe` ASC),
  CONSTRAINT `fk_Superheroe_has_Persona_Superheroe2`
    FOREIGN KEY (`idSuperheroe`)
    REFERENCES `mydb`.`Superheroe` (`idSuperheroe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Superheroe_has_Persona_Persona2`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Conocido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Conocido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Conocido` (
  `idSuperheroe` INT NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idSuperheroe`, `idPersona`),
  INDEX `fk_Conocido_Superheroe1_idx` (`idSuperheroe` ASC),
  INDEX `fk_Conocido_Persona1_idx` (`idPersona` ASC),
  CONSTRAINT `fk_Conocido_Superheroe1`
    FOREIGN KEY (`idSuperheroe`)
    REFERENCES `mydb`.`Superheroe` (`idSuperheroe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Conocido_Persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Habilidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Habilidad` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Habilidad` (
  `idHabilidad` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idHabilidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proceso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Proceso` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Proceso` (
  `idIncidente` INT NOT NULL,
  `FechaUltSeguimiento` VARCHAR(45) NULL,
  PRIMARY KEY (`idIncidente`),
  INDEX `fk_Proceso_Incidente1_idx` (`idIncidente` ASC),
  CONSTRAINT `fk_Proceso_Incidente1`
    FOREIGN KEY (`idIncidente`)
    REFERENCES `mydb`.`Incidente` (`idIncidente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cerrado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cerrado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cerrado` (
  `idIncidente` INT NOT NULL,
  PRIMARY KEY (`idIncidente`),
  INDEX `fk_Cerrado_Incidente1_idx` (`idIncidente` ASC),
  CONSTRAINT `fk_Cerrado_Incidente1`
    FOREIGN KEY (`idIncidente`)
    REFERENCES `mydb`.`Incidente` (`idIncidente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pendiente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pendiente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pendiente` (
  `idIncidente` INT NOT NULL,
  PRIMARY KEY (`idIncidente`),
  CONSTRAINT `fk_Pendiente_Incidente1`
    FOREIGN KEY (`idIncidente`)
    REFERENCES `mydb`.`Incidente` (`idIncidente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EsCapazDe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EsCapazDe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EsCapazDe` (
  `idSuperheroe` INT NOT NULL,
  `idHabilidad` INT NOT NULL,
  PRIMARY KEY (`idSuperheroe`, `idHabilidad`),
  INDEX `fk_Superheroe_has_Habilidad_Habilidad1_idx` (`idHabilidad` ASC),
  INDEX `fk_Superheroe_has_Habilidad_Superheroe1_idx` (`idSuperheroe` ASC),
  CONSTRAINT `fk_Superheroe_has_Habilidad_Superheroe1`
    FOREIGN KEY (`idSuperheroe`)
    REFERENCES `mydb`.`Superheroe` (`idSuperheroe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Superheroe_has_Habilidad_Habilidad1`
    FOREIGN KEY (`idHabilidad`)
    REFERENCES `mydb`.`Habilidad` (`idHabilidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seguimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Seguimiento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Seguimiento` (
  `idSeguimiento` INT NOT NULL,
  `Fecha` TIMESTAMP NULL,
  `Descripcion` VARCHAR(45) NULL,
  `idIncidente` INT NOT NULL,
  `Oficial_num` INT NOT NULL,
  PRIMARY KEY (`idSeguimiento`),
  INDEX `fk_Seguimiento_Proceso1_idx` (`idIncidente` ASC),
  INDEX `fk_Seguimiento_Oficial1_idx` (`Oficial_num` ASC),
  CONSTRAINT `fk_Seguimiento_Proceso1`
    FOREIGN KEY (`idIncidente`)
    REFERENCES `mydb`.`Proceso` (`idIncidente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seguimiento_Oficial1`
    FOREIGN KEY (`Oficial_num`)
    REFERENCES `mydb`.`Oficial` (`num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mdyb` ;
USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Direccion_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Direccion_BEFORE_INSERT` BEFORE INSERT ON `Direccion` FOR EACH ROW
BEGIN
	if new.calleAledaña1 = new.calleAledaña2 then
                   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Una Calle no puede ser aledaña de si misma';
    end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Direccion_BEFORE_UPDATE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Direccion_BEFORE_UPDATE` BEFORE UPDATE ON `Direccion` FOR EACH ROW
BEGIN
	if new.calleAledaña1 = new.calleAledaña2 then
                   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Una Calle no puede ser aledaña de si misma';
    end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Interviene_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Interviene_BEFORE_INSERT` BEFORE INSERT ON `Interviene` FOR EACH ROW
BEGIN
 if(new.Rol != 'Investigador' && new.Rol != 'Designado en manzana' && new.Rol != 'Patrullero' && new.Rol != 'Seguridad asignada'&& new.Rol != 'Oficial de civil'&& new.Rol != 'Guardia en comisaría') then
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Atributo ROL es incorrecto';
end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Interviene_BEFORE_UPDATE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Interviene_BEFORE_UPDATE` BEFORE UPDATE ON `Interviene` FOR EACH ROW
BEGIN
if(new.Rol != 'Designado en manzana' || new.Rol != 'Patrullero' || new.Rol != 'Seguridad asignada'|| new.Rol != 'Oficial de civil'|| new.Rol != 'Guardia en comisaría') then
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Atributo ROL es incorrecto';
end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Superheroe_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Superheroe_BEFORE_INSERT` BEFORE INSERT ON `Superheroe` FOR EACH ROW
BEGIN
if(new.ColorDisfraz != '' && new.ColorDisfraz != 'Azul/Rojo' && new.ColorDisfraz != 'Varios' && new.ColorDisfraz != 'Azul' && new.ColorDisfraz != 'Verde' && new.ColorDisfraz != 'Gris' && new.ColorDisfraz != 'Rojo'&& new.ColorDisfraz != 'Blanco/Verde'&& new.ColorDisfraz != 'Rojo/Azul'&& new.ColorDisfraz != 'Blanco'&& new.ColorDisfraz != 'Negro'&& new.ColorDisfraz != 'Azul/Blanco'&& new.ColorDisfraz != 'Negro/Rojo'&& new.ColorDisfraz != 'Amarillo/Rojo') then
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Atributo ColorDisfraz no es correcto';
end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Superheroe_BEFORE_UPDATE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Superheroe_BEFORE_UPDATE` BEFORE UPDATE ON `Superheroe` FOR EACH ROW
BEGIN
if(new.ColorDisfraz != 'Verde' || new.ColorDisfraz != 'Gris' || new.ColorDisfraz != 'Rojo'|| new.ColorDisfraz != 'Blanco/Verde'|| new.ColorDisfraz != 'Rojo/Azul'|| new.ColorDisfraz != 'Blanco'|| new.ColorDisfraz != 'Negro'|| new.ColorDisfraz != 'Azul/Blanco'|| new.ColorDisfraz != 'Negro/Rojo'|| new.ColorDisfraz != 'Amarillo/Rojo') then
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Atributo ColorDisfraz no es correcto';
end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Involucra_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Involucra_BEFORE_INSERT` BEFORE INSERT ON `Involucra` FOR EACH ROW
BEGIN
 if(new.Rol != 'Testigo' && new.Rol != 'Víctima' && new.Rol != 'Instigador'&& new.Rol != 'Sospechoso') then
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Atributo ROL debe ser Testigo||Victima||Instigador||Sospechoso';
end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Involucra_BEFORE_UPDATE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Involucra_BEFORE_UPDATE` BEFORE UPDATE ON `Involucra` FOR EACH ROW
BEGIN
 if(new.Rol != 'Testigo' || new.Rol != 'Víctima' || new.Rol != 'Instigador'|| new.Rol != 'Sospechoso') then
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Atributo ROL debe ser Testigo||Victima||Instigador||Sospechoso';
end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Serelacionacon_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Serelacionacon_BEFORE_INSERT` BEFORE INSERT ON `Serelacionacon` FOR EACH ROW
BEGIN
 if(new.ClaseDeVinculo != 'Ex-compañero de colegio' && new.ClaseDeVinculo != 'Socios comerciales' && new.ClaseDeVinculo != 'Asociado al mismo club' && new.ClaseDeVinculo != 'Afiliacion politica comun' && new.ClaseDeVinculo != 'Familiar'&& new.ClaseDeVinculo != 'Vecino'&& new.ClaseDeVinculo != 'Indeterminado'&& new.ClaseDeVinculo != 'Amigo') then
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Atributo Tipo debe ser Ex-compañero de colegio||Socios comerciales||Asociado al mismo club||Afiliacion politica comun||Familiar||Vecino||Indeterminado||Amigo';
end if;
if new.idPersona=new.idPersona1 then
                  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No puede haber una relacion de una persona con si mismo';
    end if; 
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;