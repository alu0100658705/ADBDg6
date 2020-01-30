-- -----------------------------------------------------
-- Schema wayfinder
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS wayfinder;

-- -----------------------------------------------------
-- Table wayfinder."PJ"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."PJ"
(
  uid INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  vit INT NOT NULL,
  mag INT NOT NULL,
  atk INT NOT NULL,
  def INT NOT NULL,
  afinidad VARCHAR(45) NULL,
  platines INT NOT NULL,
  exp_actual INT NOT NULL,
  exp_siguiente INT NOT NULL,
  nivel INT NOT NULL,
  PRIMARY KEY (uid)
);

-- -----------------------------------------------------
-- Table wayfinder."TIENDAS"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."TIENDAS"
(
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (nombre)
);

-- -----------------------------------------------------
-- Table wayfinder."OBJETOS"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."OBJETOS"
(
  cod VARCHAR(45) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  descripcion VARCHAR(45) NOT NULL,
  cd INT NULL,
  efecto VARCHAR(45) NULL,
  zona VARCHAR(45) NULL,
  bon_mag INT NULL,
  bon_atk INT NULL,
  bon_vit INT NULL,
  bon_def INT NULL,
  PRIMARY KEY (cod)
);

-- -----------------------------------------------------
-- Table wayfinder."TIENDAS_OBJETO"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."TIENDAS_OBJETO"
(
  TIENDA_nombre VARCHAR(45) NOT NULL,
  OBJETO_cod VARCHAR(45) NOT NULL,
  precio INT NOT NULL,
  PRIMARY KEY (OBJETO_cod),
  CONSTRAINT fk_TIENDAS_OBJETO_TIENDAS
    FOREIGN KEY (TIENDA_nombre)
    REFERENCES wayfinder."TIENDAS" (nombre)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_TIENDAS_OBJETO_OBJETO1
    FOREIGN KEY (OBJETO_cod)
    REFERENCES wayfinder."OBJETOS" (cod)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table wayfinder."DADOS"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."DADOS"
(
  OBJETO_cod VARCHAR(45) NOT NULL,
  color VARCHAR(45) NOT NULL,
  PRIMARY KEY (OBJETO_cod),
  CONSTRAINT fk_DADOS_OBJETOS1
    FOREIGN KEY (OBJETO_cod)
    REFERENCES wayfinder."OBJETOS" (cod)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table wayfinder."EQUIPO"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."EQUIPO"
(
  PJ_uid INT NOT NULL,
  OBJETO_cod VARCHAR(45) NOT NULL,
  cod INT NOT NULL,
  PRIMARY KEY (cod),
  CONSTRAINT fk_EQUIPO_PJ1
    FOREIGN KEY (PJ_uid)
    REFERENCES wayfinder."PJ" (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_EQUIPO_OBJETOS1
    FOREIGN KEY (OBJETO_cod)
    REFERENCES wayfinder."OBJETOS" (cod)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table wayfinder."DUELOS"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."DUELOS"
(
  PJ_uid INT NOT NULL,
  PJ_uid1 INT NOT NULL,
  PRIMARY KEY (PJ_uid, PJ_uid1),
  CONSTRAINT fk_PJ_has_PJ_PJ1
    FOREIGN KEY (PJ_uid)
    REFERENCES wayfinder."PJ" (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_PJ_has_PJ_PJ2
    FOREIGN KEY (PJ_uid1)
    REFERENCES wayfinder."PJ" (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table wayfinder."BAUL"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."BAUL" (
  PJ_uid INT NOT NULL,
  OBJETO_cod VARCHAR(45) NOT NULL,
  cantidad INT NOT NULL,
  cod VARCHAR(45) NOT NULL,
  PRIMARY KEY (cod),
  CONSTRAINT fk_PJ_has_OBJETOS_PJ2
    FOREIGN KEY (PJ_uid)
    REFERENCES wayfinder."PJ" (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_PJ_has_OBJETOS_OBJETOS2
    FOREIGN KEY (OBJETO_cod)
    REFERENCES wayfinder."OBJETOS" (cod)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table wayfinder."MERCADILLO"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."MERCADILLO" (
  PJ_uid INT NOT NULL,
  OBJETO_cod VARCHAR(45) NOT NULL,
  cod INT NOT NULL,
  cantidad INT NOT NULL,
  precio_ud INT NULL,
  PRIMARY KEY (cod),
  CONSTRAINT fk_PJ_has_OBJETOS_PJ1
    FOREIGN KEY (PJ_uid)
    REFERENCES wayfinder."PJ" (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_PJ_has_OBJETOS_OBJETOS1
    FOREIGN KEY (OBJETO_cod)
    REFERENCES wayfinder."OBJETOS" (cod)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table wayfinder."COMPRAS_MERCADILLO"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."COMPRAS_MERCADILLO" (
  PJ_comprador_uid INT NOT NULL,
  MERCADILLO_vendedor_uid INT NOT NULL,
  MERCADILLO_OBJETO_cod VARCHAR(45) NOT NULL,
  cod_compra VARCHAR(45) NOT NULL,
  PRIMARY KEY (cod_compra),
  CONSTRAINT fk_PJ_has_MERCADILLO_PJ1
    FOREIGN KEY (PJ_comprador_uid)
    REFERENCES wayfinder."PJ" (uid)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_PJ_has_MERCADILLO_MERCADILLO1
    FOREIGN KEY (MERCADILLO_vendedor_uid)
    REFERENCES wayfinder."PJ" (uid)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_PJ_has_MERCADILLO_MERCADILLO2
    FOREIGN KEY (MERCADILLO_OBJETO_cod)
    REFERENCES wayfinder."OBJETOS" (cod)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table wayfinder."COMPRAS_TIENDA"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS wayfinder."COMPRAS_TIENDA" (
  PJ_comprador_uid INT NOT NULL,
  OBJETO_cod VARCHAR(45) NOT NULL,
  cantidad VARCHAR(45) NOT NULL,
  cod_compra VARCHAR(45) NOT NULL,
  PRIMARY KEY (cod_compra),
  CONSTRAINT fk_PJ_has_TIENDAS_OBJETO_PJ1
    FOREIGN KEY (PJ_comprador_uid)
    REFERENCES wayfinder."PJ" (uid)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_PJ_has_TIENDAS_OBJETO_TIENDAS_OBJETO1
    FOREIGN KEY (OBJETO_cod)
    REFERENCES wayfinder."TIENDAS_OBJETO" (OBJETO_cod)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);