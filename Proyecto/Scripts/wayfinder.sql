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
  MERCADILLO_lote_cod INT NOT NULL,
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
    FOREIGN KEY (MERCADILLO_lote_cod)
    REFERENCES wayfinder."MERCADILLO" (cod)
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

-- -----------------------------------------------------
-- Data for table wayfinder."PJ"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."PJ" (uid, nombre, vit, mag, atk, def, afinidad, platines, exp_actual, exp_siguiente, nivel) 
VALUES ('001', 'Aphelios', '100', '20', '10', '60', 'equilibrio', '500', '2150', '350', '2'),
       ('002', 'Darius', '75', '30', '30', '55', 'inteligencia', '350', '3500', '1500', '4'),
       ('003', 'Evelynn', '50', '70', '60', '25', 'equilibrio', '400', '1600', '900', '2'),
       ('004', 'Jax', '80', '40', '60', '50', 'fuerza', '150', '5400', '2100', '5'),
       ('005', 'Karma', '40', '60', '80', '15', 'destreza', '200', '200', '300', '1');
COMMIT;       

-- -----------------------------------------------------
-- Data for table wayfinder."DUELOS"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."DUELOS" (PJ_uid, PJ_uid1)
VALUES ('001', '004'),
       ('002', '003');
COMMIT;       

-- -----------------------------------------------------
-- Data for table wayfinder."TIENDAS"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."TIENDAS" (nombre)
VALUES ('armas'),
       ('armaduras'),
       ('consumibles'),
       ('comandos');
COMMIT;       

-- -----------------------------------------------------
-- Data for table wayfinder."OBJETOS"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."OBJETOS" (cod, nombre, tipo, descripcion, cd, efecto, zona, bon_mag, bon_atk, bon_vit, bon_def)
VALUES ('e001', 'espada de hierro', 'arma', 'espada básica para principiantes', NULL, NULL, 'manos', '0', '5', '0', '1'),
       ('c135', 'casco de metal', 'armadura', 'casco resistente', NULL, NULL, 'cabeza', '0', '0', '2', '4'),
       ('b569', 'botas mágicas', 'armadura', 'botas de nivel avanzado', NULL, NULL, 'pies', '3', '0', '1', '1'),
       ('p703', 'poción azul', 'consumible', 'ideal para aguantar', '5', 'sube la defensa', NULL, '0', '0', '0', '5'),
       ('h341', 'hechizo bola de fuego', 'consumible', 'daño mortal', '8', NULL, NULL, '0', '0', '4', '0');
COMMIT;       

-- -----------------------------------------------------
-- Data for table wayfinder."EQUIPO"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."EQUIPO" (PJ_uid, OBJETO_cod, cod)
VALUES ('001', 'e001', '001'),
       ('002', 'c135', '002'),
       ('003', 'b569', '003'),
       ('004', 'p703', '004');
COMMIT;

-- -----------------------------------------------------
-- Data for table wayfinder."BAUL"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."BAUL" (PJ_uid, OBJETO_cod, cantidad, cod)
VALUES ('001', 'e001', '2', 'b1'),
       ('001', 'c135', '1', 'b1_1'),
       ('002', 'c135', '1', 'b2'),
       ('003', 'b569', '1', 'b3'),
       ('004', 'p703', '5', 'b4');
COMMIT;       

-- -----------------------------------------------------
-- Data for table wayfinder."MERCADILLO"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."MERCADILLO" (PJ_uid, OBJETO_cod, cod, cantidad, precio_ud)
VALUES ('001', 'e001', '001', '5', '50'),
       ('002', 'c135', '002', '2', '40'),
       ('003', 'b569', '003', '2', '25'),
       ('004', 'p703', '004', '10', '10');
COMMIT;       

-- -----------------------------------------------------
-- Data for table wayfinder."DADOS"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."DADOS" (OBJETO_cod, color)
VALUES ('h341', 'rojo');
COMMIT;       

-- -----------------------------------------------------
-- Data for table wayfinder."TIENDAS_OBJETO"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."TIENDAS_OBJETO" (TIENDA_nombre, OBJETO_cod, precio)
VALUES ('armas', 'e001', '60'),
       ('armaduras', 'c135', '45'),
       ('armaduras', 'b569', '35'),
       ('consumibles', 'p703', '20'),
       ('consumibles', 'h341', '30');
COMMIT;  

-- -----------------------------------------------------
-- Data for table wayfinder."COMPRAS_MERCADILLO"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."COMPRAS_MERCADILLO" (PJ_comprador_uid, MERCADILLO_vendedor_uid, MERCADILLO_lote_cod, cod_compra)
VALUES ('001', '003', '003', 'cm001'),
       ('002', '004', '004', 'cm002');
COMMIT;       

-- -----------------------------------------------------
-- Data for table wayfinder."COMPRAS_TIENDA"
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO wayfinder."COMPRAS_TIENDA" (PJ_comprador_uid, OBJETO_cod, cantidad, cod_compra)
VALUES ('003', 'e001', '1', 'ct001'),
       ('004', 'c135', '1', 'ct002');
COMMIT;

-- -------------------------------------------------------------
-- Consulta 1: Seleccionar el nombre de los distintos personajes
-- -------------------------------------------------------------
SELECT nombre FROM wayfinder."PJ";

-- -------------------------------------------------------------
-- Consulta 2: Seleccionar los jugadores que han realidado
--             compras en el mercadillo
-- -------------------------------------------------------------
SELECT p.nombre, p.platines, p.nivel
FROM wayfinder."PJ" AS p 
JOIN wayfinder."COMPRAS_MERCADILLO" AS cm
ON cm.PJ_comprador_uid = p.uid;

-- -------------------------------------------------------------
-- Consulta 3: Cuenta el nº de objetos distintos que cada 
-- 			   usuario tiene en su baúl            
-- -------------------------------------------------------------
SELECT p.nombre, COUNT(*)
FROM wayfinder."PJ" AS p 
JOIN wayfinder."BAUL" AS b
ON b.PJ_uid = p.uid
GROUP BY p.nombre
ORDER BY COUNT(*) DESC;

-- -------------------------------------------------------------
-- Consulta 4: Ordena los objetos existentes en la tienda según 
--             su precio de forma ascendente
-- -------------------------------------------------------------
SELECT o.nombre, o.tipo, o.descripcion, t.precio
FROM wayfinder."OBJETOS" AS o 
INNER JOIN wayfinder."TIENDAS_OBJETO" AS t
ON o.cod = t.OBJETO_cod
ORDER BY t.precio DESC;

-- -------------------------------------------------------------
-- Consulta 5: Muestra los personajes que tengan equipada la
--             espada de hierro
-- -------------------------------------------------------------
SELECT p.nombre, p.afinidad, p.nivel, o.tipo, o.descripcion
FROM wayfinder."PJ" AS p 
JOIN wayfinder."EQUIPO" AS e
ON e.PJ_uid = p.uid
JOIN wayfinder."OBJETOS" AS o
ON o.cod = e.OBJETO_cod
WHERE o.nombre = 'espada de hierro';