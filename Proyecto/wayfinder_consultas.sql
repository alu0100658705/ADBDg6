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