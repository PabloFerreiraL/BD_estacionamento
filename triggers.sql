--TRIGGER FUNCTION
CREATE OR REPLACE FUNCTION verificaData() RETURNS trigger AS $testeTrigger$
BEGIN

	IF new.dataHora_entrada > current_timestamp THEN 
	RAISE EXCEPTION 'Data inválida';
    END IF;

RETURN NEW;
END;
$testeTrigger$ LANGUAGE plpgsql;


--TRIGGER

CREATE TRIGGER verificaData 
AFTER INSERT OR UPDATE ON cadastra
FOR EACH ROW
EXECUTE PROCEDURE verificaData();
