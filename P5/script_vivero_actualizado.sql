-- -----------------------------------------------------
-- Schema vivero
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS vivero DEFAULT CHARACTER SET utf8 ;
USE vivero;

-- -----------------------------------------------------
-- Table vivero.VIVERO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.VIVERO (
  coordenadas FLOAT NOT NULL,
  localidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (coordenadas));


-- -----------------------------------------------------
-- Table vivero.ZONA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.ZONA (
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (nombre));


-- -----------------------------------------------------
-- Table vivero.PRODUCTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.PRODUCTO (
  codigo_prod VARCHAR(45) NOT NULL,
  stock INT NULL,
  precio DECIMAL NOT NULL,
  PRIMARY KEY (codigo_prod));


-- -----------------------------------------------------
-- Table vivero.EMPLEADO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.EMPLEADO (
  dni VARCHAR(9) NOT NULL,
  sueldo DECIMAL NOT NULL,
  css VARCHAR(11) NOT NULL,
  antiguedad VARCHAR(45) NULL,
  PRIMARY KEY (dni));


-- -----------------------------------------------------
-- Table vivero.CLIENTE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.CLIENTE (
  dni VARCHAR(9) NOT NULL,
  bonificacion DECIMAL NULL,
  total_mensual DECIMAL NULL,
  PRIMARY KEY (dni));


-- -----------------------------------------------------
-- Table vivero.VIVERO_ZONA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.VIVERO_ZONA (
  VIVERO_coordenadas FLOAT NOT NULL,
  ZONA_nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (VIVERO_coordenadas, ZONA_nombre),
  CONSTRAINT fk_VIVERO_ZONA_VIVERO
    FOREIGN KEY (VIVERO_coordenadas)
    REFERENCES vivero.VIVERO (coordenadas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_VIVERO_ZONA_ZONA1
    FOREIGN KEY (ZONA_nombre)
    REFERENCES vivero.ZONA (nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table vivero.ZONA_EMPLEADO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.ZONA_EMPLEADO (
  ZONA_nombre VARCHAR(45) NOT NULL,
  EMPLEADO_dni VARCHAR(9) NOT NULL,
  PRIMARY KEY (ZONA_nombre, EMPLEADO_dni),
  CONSTRAINT fk_ZONA_EMPLEADO_ZONA1
    FOREIGN KEY (ZONA_nombre)
    REFERENCES vivero.ZONA (nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ZONA_EMPLEADO_EMPLEADO1
    FOREIGN KEY (EMPLEADO_dni)
    REFERENCES vivero.EMPLEADO (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table vivero.PRODUCTO_ZONA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.PRODUCTO_ZONA (
  PRODUCTO_codigo_prod VARCHAR(45) NOT NULL,
  ZONA_nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (PRODUCTO_codigo_prod, ZONA_nombre),
  CONSTRAINT fk_PRODUCTO_ZONA_PRODUCTO1
    FOREIGN KEY (PRODUCTO_codigo_prod)
    REFERENCES vivero.PRODUCTO (codigo_prod)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PRODUCTO_ZONA_ZONA1
    FOREIGN KEY (ZONA_nombre)
    REFERENCES vivero.ZONA (nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table vivero.PRODUCTO_CLIENTE_EMPLEADO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero.PRODUCTO_CLIENTE_EMPLEADO (
  PRODUCTO_codigo_prod VARCHAR(45) NOT NULL,
  CLIENTE_dni VARCHAR(9) NOT NULL,
  EMPLEADO_dni VARCHAR(9) NOT NULL,
  PRIMARY KEY (PRODUCTO_codigo_prod, CLIENTE_dni, EMPLEADO_dni),
  CONSTRAINT fk_PRODUCTO_CLIENTE_EMPLEADO_PRODUCTO1
    FOREIGN KEY (PRODUCTO_codigo_prod)
    REFERENCES vivero.PRODUCTO (codigo_prod)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PRODUCTO_CLIENTE_EMPLEADO_CLIENTE1
    FOREIGN KEY (CLIENTE_dni)
    REFERENCES vivero.CLIENTE (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PRODUCTO_CLIENTE_EMPLEADO_EMPLEADO1
    FOREIGN KEY (EMPLEADO_dni)
    REFERENCES vivero.EMPLEADO (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Data for table vivero.VIVERO
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO vivero.VIVERO (coordenadas, localidad) VALUES (28.9167, 'La Cuesta');
INSERT INTO vivero.VIVERO (coordenadas, localidad) VALUES (28.1167, 'La Laguna');
COMMIT;

-- -----------------------------------------------------
-- Data for table vivero.ZONA
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO vivero.ZONA (nombre) VALUES ('Zona exterior');
INSERT INTO vivero.ZONA (nombre) VALUES ('Cajas');
INSERT INTO vivero.ZONA (nombre) VALUES ('Almacen');
COMMIT;

-- -----------------------------------------------------
-- Data for table vivero.PRODUCTO
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO vivero.PRODUCTO (codigo_prod, stock, precio) VALUES ('9654158633604619', 6, 55);
INSERT INTO vivero.PRODUCTO (codigo_prod, stock, precio) VALUES ('0636937512193258', 10, 23);
COMMIT;

-- -----------------------------------------------------
-- Data for table vivero.EMPLEADO
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO vivero.EMPLEADO (dni, sueldo, css, antiguedad) VALUES ('43841764S', 800, '26801685401', '2 años');
INSERT INTO vivero.EMPLEADO (dni, sueldo, css, antiguedad) VALUES ('42356732J', 1280, '86319609215', '5 años');
COMMIT;

-- -----------------------------------------------------
-- Data for table vivero.CLIENTE
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO vivero.CLIENTE (dni, bonificacion, total_mensual) VALUES ('53691594F', 15.05, 331);
INSERT INTO vivero.CLIENTE (dni, bonificacion, total_mensual) VALUES ('41599623M', 12.25, 245);
COMMIT;