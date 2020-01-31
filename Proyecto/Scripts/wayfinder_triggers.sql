-- -----------------------------------------------------
-- TRIGGER 1: Tras insertar en COMPRAS_TIENDA actualiza
--            los platines en la tabla PJ correspondiente
--            al uid del usuario que está comprando.
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION ctrl_compra() 
RETURNS TRIGGER 
LANGUAGE plpgsql AS
$$ BEGIN
    
	SELECT TIENDAS_OBJETO.precio AS cosa, TIENDAS_OBJETO.OBJETO_cod
	FROM TIENDAS_OBJETO
	INNER JOIN inserted i
	ON TIENDAS_OBJETO.OBJETO_cod = i.OBJETO_cod;
	
    UPDATE PJ
    SET PJ.platines = old.platines - (cosa * i.cantidad)
    FROM PJ
	WHERE PJ.uid = i.uid;
		
END $$;

CREATE TRIGGER ctrl_compra 
AFTER INSERT ON wayfinder."COMPRAS_TIENDA"
FOR EACH ROW EXECUTE PROCEDURE ctrl_compra();

-- -------------------------------------------------------------
-- TRIGGER 2: Si un personaje compra un objeto en el MERCADILLO,
--            este se borra del MERCADILLO y se
--            añade al BAUL del personaje en cuestión
-- -------------------------------------------------------------
SELECT * FROM wayfinder."MERCADILLO";
SELECT * FROM wayfinder."BAUL";

CREATE OR REPLACE FUNCTION insercion_tras_compra() 
RETURNS TRIGGER AS $insercion$
SET SCHEMA wayfinder
DECLARE BEGIN
    INSERT INTO "BAUL" VALUES(OLD.PJ_uid, OLD.OBJETO_cod, OLD.cantidad);
    RETURN NULL;
END;
$insercion$ LANGUAGE plpgsql;

CREATE TRIGGER insercion_baul AFTER DELETE
ON "MERCADILLO" FOR EACH ROW
EXECUTE PROCEDURE insercion_tras_compra();

DELETE FROM wayfinder."MERCADILLO" WHERE PJ_uid = 5;