-- -----------------------------------------------------
-- Schema Farmacia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS farmacia;

-- -----------------------------------------------------
-- Table farmacia.FAMILIA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.FAMILIA 
(
  Nombre VARCHAR(45) NOT NULL,
  Incompatibilidad VARCHAR(45) NULL,
  PRIMARY KEY (Nombre)
);

-- -----------------------------------------------------
-- Table farmacia.ENFERMEDAD
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.ENFERMEDAD 
(
  Nombre VARCHAR(45) NOT NULL,
  Sintoma VARCHAR(45) NULL,
  PRIMARY KEY (Nombre)
);

-- -----------------------------------------------------
-- Table farmacia.FAMILIA_ENFERMEDAD
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.FAMILIA_ENFERMEDAD 
(
  ENFERMEDAD_Nombre VARCHAR(45) NOT NULL,
  FAMILIA_Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (ENFERMEDAD_Nombre, FAMILIA_Nombre),
  CONSTRAINT fk_FAMILIA_ENFERMEDAD_ENFERMEDAD
    FOREIGN KEY (ENFERMEDAD_Nombre)
    REFERENCES farmacia.ENFERMEDAD (Nombre)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_FAMILIA_ENFERMEDAD_FAMILIA
    FOREIGN KEY (FAMILIA_Nombre)
    REFERENCES farmacia.FAMILIA (Nombre)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table farmacia.LABORATORIO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.LABORATORIO 
(
  Codigo_Lab INT NOT NULL,
  Nombre VARCHAR(45) NULL,
  Tlfn INT NULL,
  Contacto VARCHAR(45) NULL,
  Direccion VARCHAR(45) NULL,
  PRIMARY KEY (Codigo_Lab)
);

-- -----------------------------------------------------
-- Table farmacia.MEDICAMENTOS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.MEDICAMENTOS 
(
  Codigo INT NOT NULL,
  Nombre_med VARCHAR(45) NULL,
  Igic FLOAT NULL,
  Precio FLOAT NULL,
  Posologia VARCHAR(45) NULL,
  Tipo VARCHAR(45) NOT NULL,
  LABORATORIO VARCHAR(45) NOT NULL,
  LABORATORIO_Codigo INT NOT NULL,
  CONSTRAINT pk_MEDICAMENTOS
  UNIQUE (Codigo),
  PRIMARY KEY (Codigo),
  CONSTRAINT fk_MEDICAMENTOS_LABORATORIO
    UNIQUE (LABORATORIO_Codigo),
    FOREIGN KEY (LABORATORIO_Codigo)
    REFERENCES farmacia.LABORATORIO (Codigo_Lab)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table farmacia.FAMILIA_MEDICAMENTOS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.FAMILIA_MEDICAMENTOS 
(
  FAMILIA_Nombre VARCHAR(45) NOT NULL,
  MEDICAMENTOS_Codigo INT NOT NULL,
  PRIMARY KEY (FAMILIA_Nombre, MEDICAMENTOS_Codigo),
  CONSTRAINT fk_FAMILIA_MEDICAMENTOS_FAMILIA
    FOREIGN KEY (FAMILIA_Nombre)
    REFERENCES farmacia.FAMILIA (Nombre)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_FAMILIA_MEDICAMENTOS
    FOREIGN KEY (MEDICAMENTOS_Codigo)
    REFERENCES farmacia.MEDICAMENTOS (Codigo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table farmacia.COMPRA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.COMPRA 
(
  Fecha_Actual DATE NOT NULL,
  Importe FLOAT NULL,
  PRIMARY KEY (Fecha_Actual)
);

-- -----------------------------------------------------
-- Table farmacia.COMPRA_MEDICAMENTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.COMPRA_MEDICAMENTO 
(
  idCOMPRA_MEDICAMENTO INT NOT NULL,
  MEDICAMENTOS_Cod INT NOT NULL,
  Fecha_COMPRA DATE NOT NULL,
  Unidades INT NULL,
  Igic FLOAT NULL,
  Importe FLOAT NULL,
  PRIMARY KEY (idCOMPRA_MEDICAMENTO, MEDICAMENTOS_Cod, Fecha_COMPRA),
  CONSTRAINT fk_COMPRA_MEDICAMENTO
    FOREIGN KEY (MEDICAMENTOS_Cod)
    REFERENCES farmacia.MEDICAMENTOS (Codigo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_Fecha_COMPRA
    FOREIGN KEY (Fecha_COMPRA)
    REFERENCES farmacia.COMPRA (Fecha_Actual)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table farmacia.PAGO_CREDITO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS farmacia.PAGO_CREDITO 
(
  Cantidad FLOAT NULL,
  Fecha_Pago DATE NULL,
  Mes_Año DATE NOT NULL,
  Fecha_COMPRA DATE NOT NULL,
  PRIMARY KEY (Mes_Año, Fecha_COMPRA),
  CONSTRAINT fk_Mes_Año
    FOREIGN KEY (Mes_Año)
    REFERENCES farmacia.COMPRA (Fecha_Actual)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Data for table farmacia.FAMILIA
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.FAMILIA (Nombre, Incompatibilidad) VALUES ('Antidepresivos', 'Alcohol');
INSERT INTO farmacia.FAMILIA (Nombre, Incompatibilidad) VALUES ('Antibioticos', NULL);
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.ENFERMEDAD
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.ENFERMEDAD (Nombre, Sintoma) VALUES ('Faringitis', 'Dolor de garganta');
INSERT INTO farmacia.ENFERMEDAD (Nombre, Sintoma) VALUES ('Depresión', 'Insomnio o hipersomnia');
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.FAMILIA_ENFERMEDAD
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.FAMILIA_ENFERMEDAD (ENFERMEDAD_Nombre, FAMILIA_Nombre) VALUES ('Faringitis', 'Antibioticos');
INSERT INTO farmacia.FAMILIA_ENFERMEDAD (ENFERMEDAD_Nombre, FAMILIA_Nombre) VALUES ('Depresión', 'Antidepresivos');
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.LABORATORIO
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.LABORATORIO (Codigo_Lab, Nombre, Tlfn, Contacto, Direccion) VALUES (01, 'Sanofi', 66677788, 'aaaaaaaaa', 'aaaa');
INSERT INTO farmacia.LABORATORIO (Codigo_Lab, Nombre, Tlfn, Contacto, Direccion) VALUES (02, 'Saval', 666111222, 'bbbbbbbbbbbbb', 'bbbb');
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.MEDICAMENTOS
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.MEDICAMENTOS (Codigo, Nombre_med, Igic, Precio, Posologia, Tipo, LABORATORIO, LABORATORIO_Codigo) VALUES (0001, 'Lizipadol', 3.5, 9, 'Pastillas', 'Receta', 'Sanofi', 01);
INSERT INTO farmacia.MEDICAMENTOS (Codigo, Nombre_med, Igic, Precio, Posologia, Tipo, LABORATORIO, LABORATORIO_Codigo) VALUES (0002, 'Deprax', 4.5, 8.5, 'Pastillas', 'Receta', 'Saval', 02);
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.FAMILIA__MEDICAMENTOS
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.FAMILIA_MEDICAMENTOS (FAMILIA_Nombre, MEDICAMENTOS_Codigo) VALUES ('Antibioticos', 0001);
INSERT INTO farmacia.FAMILIA_MEDICAMENTOS (FAMILIA_Nombre, MEDICAMENTOS_Codigo) VALUES ('Antidepresivos', 0002);
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.COMPRA
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.COMPRA (Fecha_Actual, Importe) VALUES ('2019-11-11', 10);
INSERT INTO farmacia.COMPRA (Fecha_Actual, Importe) VALUES ('2019-11-12', 16);
COMMIT;

-- -----------------------------------------------------
-- Data for table farmacia.COMPRA_MEDICAMENTO
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO farmacia.COMPRA_MEDICAMENTO (idCOMPRA_MEDICAMENTO, MEDICAMENTOS_Cod, Fecha_COMPRA, Unidades, Igic, Importe) VALUES (11, 0001, '2019-11-11', 1, 3.5, 10);
INSERT INTO farmacia.COMPRA_MEDICAMENTO (idCOMPRA_MEDICAMENTO, MEDICAMENTOS_Cod, Fecha_COMPRA, Unidades, Igic, Importe) VALUES (22, 00002, '2019-11-12', 2, 3.5, 16);
COMMIT;
