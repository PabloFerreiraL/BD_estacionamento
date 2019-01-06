
/* Veiculos de cada cliente */
select nome_cliente, marca_veiculo, modelo_veiculo 
from veiculo, cliente 
where veiculo.cpf_cliente = cliente.cpf_cliente
group by cliente.nome_cliente, veiculo.marca_veiculo, veiculo.modelo_veiculo
order by cliente.nome_cliente

