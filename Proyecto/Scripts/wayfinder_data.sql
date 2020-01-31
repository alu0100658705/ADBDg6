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

