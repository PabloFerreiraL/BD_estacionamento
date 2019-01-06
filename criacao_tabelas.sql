
/* CRIACAO DAS TABELAS */

CREATE TABLE cliente(
	CPF_cliente		varchar(11) PRIMARY KEY,
	nome_cliente	text NOT NULL,
	tipo_cliente	char NOT NULL /* Comum(C) ou Mensalista(M) */
);

CREATE TABLE telefone(
	telefone_cliente	varchar(15),
	CPF_cliente			varchar(11),

	PRIMARY KEY(CPF_cliente, telefone_cliente),

	FOREIGN KEY(CPF_cliente) REFERENCES cliente(CPF_cliente) ON DELETE CASCADE
);

CREATE TABLE funcionario(
	login_funcionario	text PRIMARY KEY,
	senha_funcionario	text NOT NULL,
	nome_funcionario	text NOT NULL
);

CREATE TABLE vaga(
	codigo_vaga		varchar(3) PRIMARY KEY, /* Ex: B01 */
	setor_vaga		char NOT NULL /* Comum(C) ou Mensalista(M) */
);

CREATE TABLE veiculo(
	placa_veiculo	varchar(10) PRIMARY KEY,
	tipo_veiculo	varchar(5), /* carro ou moto */
	marca_veiculo	text,
	cor_veiculo		text,
	modelo_veiculo	text,
	CPF_cliente		varchar(11),

	FOREIGN KEY(CPF_cliente) REFERENCES cliente(CPF_cliente) ON DELETE SET NULL,
);

CREATE TABLE cadastra(
	dataHora_entrada	timestamp PRIMARY KEY,
	placa_veiculo		varchar(10),
	login_funcionario	text,

	PRIMARY KEY(placa_veiculo, login_funcionario),

	FOREIGN KEY(placa_veiculo) REFERENCES veiculo(placa_veiculo) ON DELETE CASCADE,
	FOREIGN KEY(login_funcionario) REFERENCES funcionario(login_funcionario) ON DELETE CASCADE
);

CREATE TABLE permanencia(
	dataHora_saida		timestamp NOT NULL,
	codigo_vaga			varchar(5),
	placa_veiculo		varchar(10),
	login_funcionario	text,

	PRIMARY KEY(placa_veiculo, codigo_vaga, login_funcionario),

	FOREIGN KEY(placa_veiculo) REFERENCES veiculo(placa_veiculo) ON DELETE CASCADE,
	FOREIGN KEY(codigo_vaga) REFERENCES vaga(codigo_vaga) ON DELETE CASCADE,
	FOREIGN KEY(login_funcionario) REFERENCES funcionario(login_funcionario) ON DELETE CASCADE
);

CREATE TABLE preco(
	id_preco		smallint PRIMARY KEY,
	tipo_preco		char NOT NULL, /* Comum(C) ou Mensalista(M) */
	tempo_preco		time NOT NULL
);

CREATE TABLE preco_comum(
	quinzeMin		smallint,
	trintaMin		smallint,
	umaHora			smallint,
	horaAdicional	smallint
)inherits(preco);

CREATE TABLE preco_mensalista(
	valorFixo	smallint
)inherits(preco);