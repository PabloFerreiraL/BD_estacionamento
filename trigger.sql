/* Verifica se a data de entrada de um veiculo no estacionamento é válida */

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



/* Antes de inserir um carro, verifica se o mesmo ja saiu do estacionamento */

--TRIGGER FUNCTION
CREATE OR REPLACE FUNCTION verificaEntrada() RETURNS trigger AS $testeTrigger$
BEGIN
	
	IF NEW.placa_veiculo in (select permanencia.placa_veiculo
					from permanencia
					where permanencia.dataHora_saida is null)
	THEN
	RAISE EXCEPTION 'Veículo ainda está estacionado!';
    END IF;

RETURN NEW;
END;
$testeTrigger$ LANGUAGE plpgsql;

--TRIGGER
CREATE TRIGGER testeTrigger
BEFORE INSERT OR UPDATE ON cadastra
FOR EACH ROW EXECUTE PROCEDURE verificaEntrada();


