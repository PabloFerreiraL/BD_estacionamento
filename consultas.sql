
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

ola


