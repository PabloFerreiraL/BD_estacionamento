
/* Veiculos de cada cliente */
select nome_cliente, marca_veiculo, modelo_veiculo
from veiculo, cliente 
where veiculo.cpf_cliente = cliente.cpf_cliente
group by cliente.nome_cliente, veiculo.marca_veiculo, veiculo.modelo_veiculo
order by cliente.nome_cliente


/* veiculos estacionados no momento */
select cliente.CPF_cliente, nome_cliente, veiculo.placa_veiculo, vaga.codigo_vaga, datahora_entrada
from cliente, veiculo, cadastra, permanencia, vaga
where veiculo.CPF_cliente = cliente.CPF_cliente and cadastra.placa_veiculo = permanencia.placa_veiculo and cadastra.placa_veiculo = veiculo.placa_veiculo 
	and permanencia.codigo_vaga = vaga.codigo_vaga and datahora_saida is null
group by cliente.CPF_cliente, cliente.nome_cliente, veiculo.placa_veiculo, vaga.codigo_vaga, cadastra.datahora_entrada
order by nome_cliente

/* historico completo de horarios de entrada e saida dos veiculos */
select nome_cliente, veiculo.placa_veiculo, datahora_entrada, datahora_saida
from cliente, veiculo, cadastra, permanencia
where veiculo.CPF_cliente = cliente.CPF_cliente and cadastra.placa_veiculo = permanencia.placa_veiculo and cadastra.placa_veiculo = veiculo.placa_veiculo
group by cliente.nome_cliente, veiculo.placa_veiculo, cadastra.datahora_entrada, permanencia.datahora_saida
order by nome_cliente


/*vagas livres*/
SELECT COUNT(*) from vaga where vaga.codigo_vaga NOT IN (SELECT codigo_vaga from permanencia)


/* calculo do preco */
CREATE OR REPLACE FUNCTION calculaPreco(placa varchar(10)) RETURNS double precision AS $$
DECLARE
	tempo double precision;
	precoValor double precision;
	tipo_cli varchar;
BEGIN
	select tipo_cli into tipo_cli
	from cliente, veiculo
	where placa = veiculo.placa_veiculo and veiculo.CPF_cliente = cliente.CPF_cliente;

	IF tipo_cli = 'M' THEN
		select valorfixo into precoValor
		from preco;
		return precoValor;
	ELSE
		SELECT (EXTRACT(EPOCH FROM permanencia.datahora_saida) -
		EXTRACT(EPOCH FROM cadastra.datahora_entrada)) / 3600 into tempo
		from permanencia, cadastra
		where permanencia.placa_veiculo = cadastra.placa_veiculo and placa = permanencia.placa_veiculo;
		
		if tempo < 0.25 then precoValor := (select preco.quinzemin from preco);
		elsif tempo < 0.5 then precoValor := (select preco.trintamin from preco);
		elsif tempo < 1 then precoValor := (select preco.umahora from preco);
		else precoValor := ceil(tempo-1) * (select preco.horaAdicional from preco) + (select preco.umahora from preco);
		end if;
		
		return precoValor;
		
	END IF;
END;
$$ LANGUAGE plpgsql;


/* jeito facil de testar a consulta do preco */
SELECT(
	CAST(to_char(('20:00:00' - interval '1 hour'), 'HH') as real) * 5 + 7
);
