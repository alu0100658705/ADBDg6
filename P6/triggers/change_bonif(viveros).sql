CREATE OR REPLACE FUNCTION bonif_calc() RETURNS TRIGGER AS $bonif_calc$
DECLARE
  vol_compras CONSTANT FLOAT := 0;
  x CONSTANT FLOAT := 0.035;
  y CONSTANT FLOAT := 3.41;
  resultado DECIMAL;
BEGIN
  resultado := (vol_compras * x) + y;
  RETURN resultado;
END;
$bonif_calc$ LANGUAGE plpgsql;

CREATE TRIGGER change_bonif 
AFTER INSERT ON vivero.cliente
FOR EACH ROW
EXECUTE PROCEDURE bonif_calc();
