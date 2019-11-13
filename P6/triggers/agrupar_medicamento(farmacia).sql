CREATE OR REPLACE FUNCTION agrupar_medicamento() RETURNS trigger AS $agrupar_medicamento$
	BEGIN
        UPDATE farmacia.medicamentos
        SET posologia = farmacia.medicamentos
              WHERE farmacia.medicamentos.codigo = codigo;
        RETURN NULL;
    END;
$agrupar_medicamento$ LANGUAGE plpgsql;


CREATE TRIGGER reducir_stock BEFORE INSERT ON farmacia.familia
    FOR EACH ROW EXECUTE PROCEDURE agrupar_medicamento();
