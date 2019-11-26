-- -------------------------------------------------------------
-- Consulta 1: Seleccionar todos los campos de la tabla Familia
-- -------------------------------------------------------------
SELECT * FROM farmacia.FAMILIA;

-- -------------------------------------------------------------
-- Consulta 2: Códigos de los distintos laboratorios
-- -------------------------------------------------------------
SELECT Codigo_Lab FROM farmacia.LABORATORIO;

-- -------------------------------------------------------------
-- Consulta 3: Laboratorios cuyo código es "1"
-- -------------------------------------------------------------
SELECT Nombre FROM farmacia.LABORATORIO
WHERE Codigo_Lab = 1;

-- -------------------------------------------------------------
-- Consulta 4: Medicamentos que cuestan menos de 10 euros
-- -------------------------------------------------------------
SELECT Nombre_Med, Precio FROM farmacia.MEDICAMENTOS
WHERE Precio < 10;

-- -------------------------------------------------------------
-- Consulta 5: Medicamentos con un importe mínimo de 5 euros
-- -------------------------------------------------------------
SELECT Nombre_Med FROM farmacia.MEDICAMENTOS
WHERE Codigo IN 
(SELECT Codigo FROM farmacia.COMPRA_MEDICAMENTO
WHERE Importe >= 5);