-- -----------------------------------------------------
-- Schema Farmacia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS farmacia DEFAULT CHARACTER SET utf8 ;

-- -----------------------------------------------------
-- Table farmacia.Familia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Familia (
  Nombre VARCHAR(45) NULL,
  Incompatibilidad VARCHAR(45) NULL,
  PRIMARY KEY (Nombre));

-- -----------------------------------------------------
-- Table farmacia.Enfermedad
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Enfermedad (
  Nombre VARCHAR(45) NULL,
  Síntoma VARCHAR(45) NULL,
  PRIMARY KEY (Nombre));

-- -----------------------------------------------------
-- Table farmacia.Familia_Enfermedad
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Familia_Enfermedad (
  Enfermedad_Nombre VARCHAR(45) NOT NULL,
  Familia_Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (Enfermedad_Nombre, Familia_Nombre),
  CONSTRAINT fk_Familia_Enfermedad_Enfermedad
    FOREIGN KEY (Enfermedad_Nombre)
    REFERENCES farmacia.Enfermedad (Nombre)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_Familia_Enfermedad_Familia
    FOREIGN KEY (Familia_Nombre)
    REFERENCES farmacia.Familia (Nombre)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table farmacia.Laboratorio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Laboratorio (
  Codigo INT NOT NULL,
  Nombre VARCHAR(45) NULL,
  Tlfn INT NULL,
  Contacto VARCHAR(45) NULL,
  Direccion VARCHAR(45) NULL,
  PRIMARY KEY (Codigo));

-- -----------------------------------------------------
-- Table farmacia.Medicamentos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Medicamentos (
  Codigo INT NOT NULL,
  Nombre VARCHAR(45) NULL,
  Igic FLOAT NULL,
  Precio FLOAT NULL,
  Posologia VARCHAR(45) NULL,
  Tipo VARCHAR(45) NOT NULL,
  Laboratorio VARCHAR(45) NULL,
  Laboratorio_Codigo INT NOT NULL,
  PRIMARY KEY (Codigo, Laboratorio_Codigo),
  CONSTRAINT fk_Medicamentos_Laboratorio
    FOREIGN KEY (Laboratorio_Codigo)
    REFERENCES farmacia.Laboratorio (Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table farmacia.Familia_Medicamentos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Familia_Medicamentos (
  Familia_Nombre VARCHAR(45) NOT NULL,
  Medicamentos_Codigo INT NOT NULL,
  PRIMARY KEY (Familia_Nombre, Medicamentos_Codigo),
  CONSTRAINT fk_Familia_Medicamentos_Familia1
    FOREIGN KEY (Familia_Nombre)
    REFERENCES farmacia.Familia (Nombre)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_Familia_Medicamentos_Medicamentos1
    FOREIGN KEY (Medicamentos_Codigo)
    REFERENCES farmacia.Medicamentos (Codigo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table farmacia.Compra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Compra (
  Fecha_Actual DATE NOT NULL,
  Importe FLOAT NULL,
  PRIMARY KEY (Fecha_Actual));

-- -----------------------------------------------------
-- Table farmacia.Compra_Medicamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Compra_Medicamento (
  idCompra_Medicamento INT NOT NULL,
  Medicamentos_Codigo INT NOT NULL,
  Fecha_Compra DATE NOT NULL,
  Unidades INT NULL,
  Igic FLOAT NULL,
  Importe FLOAT NULL,
  PRIMARY KEY (idCompra_Medicamento, Medicamentos_Codigo, Fecha_Compra),
  CONSTRAINT fk_Compra_Medicamento
    FOREIGN KEY (Medicamentos_Codigo)
    REFERENCES farmacia.Medicamentos (Codigo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_Fecha_Compra
    FOREIGN KEY (Fecha_Compra)
    REFERENCES farmacia.Compra (Fecha_Actual)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table farmacia.Pago_Credito
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.Pago_Credito (
  Cantidad FLOAT NULL,
  Fecha_Pago DATE NULL,
  Mes_Año DATE NOT NULL,
  Fecha_Compra DATE NOT NULL,
  PRIMARY KEY (Mes_Año, Fecha_Compra),
  CONSTRAINT fk_Mes_Año
    FOREIGN KEY (Mes_Año)
    REFERENCES farmacia.Compra (Fecha_Actual)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Data for table farmacia.Familia
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.Familia (Nombre, Incompatibilidad) VALUES ('Antidepresivos', 'Alcohol');
INSERT INTO farmacia.Familia (Nombre, Incompatibilidad) VALUES ('Antibioticos', NULL);
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.Enfermedad
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.Enfermedad (Nombre, Síntoma) VALUES ('Faringitis', 'Dolor de garganta');
INSERT INTO farmacia.Enfermedad (Nombre, Síntoma) VALUES ('Depresión', 'Insomnio o hipersomnia');
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.Familia_Enfermedad
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.Familia_Enfermedad (Enfermedad_Nombre, Familia_Nombre) VALUES ('Faringitis', 'Antibioticos');
INSERT INTO farmacia.Familia_Enfermedad (Enfermedad_Nombre, Familia_Nombre) VALUES ('Depresión', 'Antidepresivos');
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.Laboratorio
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.Laboratorio (Codigo, Nombre, Tlfn, Contacto, Direccion) VALUES (01, 'Sanofi', 66677788, 'aaaaaaaaa', 'aaaa');
INSERT INTO farmacia.Laboratorio (Codigo, Nombre, Tlfn, Contacto, Direccion) VALUES (02, 'Saval', 666111222, 'bbbbbbbbbbbbb', 'bbbb');
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.Medicamentos
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.Medicamentos (Codigo, Nombre, Igic, Precio, Posologia, Tipo, Laboratorio, Laboratorio_Codigo) VALUES (0001, 'Lizipadol', 3.5, 9, 'Pastillas', 'Receta', 'Sanofi', 01);
INSERT INTO farmacia.Medicamentos (Codigo, Nombre, Igic, Precio, Posologia, Tipo, Laboratorio, Laboratorio_Codigo) VALUES (0002, 'Deprax', 4.5, 8.5, 'Pastillas', 'Receta', 'Saval', 02);
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.Familia__Medicamentos
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.Familia_Medicamentos (Familia_Nombre, Medicamentos_Codigo) VALUES ('Antibioticos', 0001);
INSERT INTO farmacia.Familia_Medicamentos (Familia_Nombre, Medicamentos_Codigo) VALUES ('Antidepresivos', 0002);
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.Compra
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.Compra (Fecha_Actual, Importe) VALUES ('2019-11-11', 10);
INSERT INTO farmacia.Compra (Fecha_Actual, Importe) VALUES ('2019-11-12', 16);
COMMIT;


-- -----------------------------------------------------
-- Data for table farmacia.Compra_Medicamento
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.Compra_Medicamento (idCompra_Medicamento, Medicamentos_Codigo, Fecha_Compra, Unidades, Igic, Importe) VALUES (11, Deprax, '2019-11-11', 1, 3.5, 10);
INSERT INTO farmacia.Compra_Medicamento (idCompra_Medicamento, Medicamentos_Codigo, Fecha_Compra, Unidades, Igic, Importe) VALUES (22, Lizipadol, '2019-11-12', 2, 3.5, 16);
COMMIT;