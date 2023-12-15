
create table pessoa (
cpf char(11) primary key,
rg char(9),
endereco varchar(50),
datanascimento date
);

create table motorista(
cpf char(11) primary key,
conta_corrente varchar,
cnh char(10),
foreign key (cpf) references pessoa(cpf)
);

create table passageiro(
cpf char(11) primary key,
cartao_credito varchar(16),
foreign key (cpf) references pessoa(cpf) );

create table atendente(
cpf char(11) primary key,
formacao_escolar varchar,
foreign key (cpf) references pessoa(cpf) );

create table seguradora(
cnpj char(14) primary key,
telefone varchar (20),
nome varchar(100),
cep varchar(8)
);

create table veiculo(
renavam char(9) primary key,
cnpj char(14),
cpf char(11),
ano char(4),
data_compra date,
preco float,
marca varchar(50),
caracteristica varchar(50),
modelo varchar(50),
numero varchar(20),
foreign key(cpf) references motorista(cpf));

create table corrida(
nro_corrida serial primary key,
cpf_motorista char(11), 
hora_inicio time,
hora_fim time,
preco_passageiro float,
data_inicio date,
data_fim date,
destino varchar(100),
foreign key (cpf_motorista) references motorista(cpf)
);

create table questionamento(
nro_sequencial int,
nro_corrida int,
pergunta varchar(100),
resposta varchar(100),
primary key (nro_corrida,
nro_sequencial),
foreign key (nro_corrida) references corrida(nro_corrida)
);

create table passageirocorrida(
nro_corrida int,
cpf char(11),
primary key(nro_corrida,
cpf),
foreign key (cpf) references passageiro(cpf),
foreign key (nro_corrida) references corrida(nro_corrida)
);



-- novas tabelas
create table suporteatendente(
nro_corrida int primary key,
cpf char(11),
foreign key (nro_corrida) references corrida(nro_corrida),
foreign key (cpf) references atendente(cpf)
);



create table tipos_avaliador(
id_tipo int primary key,
descricao varchar(15)
);



create table avaliacaocorrida(
    nro_corrida int,
    cpf_avaliador char(11),
    tipo_avaliador int, -- passageiro ou motorista
    avaliacao int, -- pode ser uma pontuação de 1 a 5, por exemplo
    comentario text,
    primary key (nro_corrida, cpf_avaliador),
    foreign key (nro_corrida) references corrida(nro_corrida),
    foreign key (cpf_avaliador) references pessoa(cpf),
    foreign key (tipo_avaliador) references tipos_avaliador(id_tipo)
);

create table localizacaoveiculo(
    id_localizacao int,
    nro_corrida int,
    momento_registro timestamp,
    latitude decimal(10, 8),
    longitude decimal(11, 8),
    primary key (id_localizacao, nro_corrida),
    foreign key (nro_corrida) references corrida(nro_corrida)
);


create table promocao(
    codigo varchar(20) primary key,
    descricao text,
    desconto float,
    data_inicio date,
    data_fim date
);
create table statuspagamento(
id_status int,
tipo_status varchar(20),
primary key (id_status)

);
create table metodopagamento(
	id_pagamento int,
	tipo_pagamento varchar(30),
	primary key (id_pagamento)
);

create table pagamentocorrida(
   	cpf_passageiro varchar(11),
    nro_corrida int,
    valor float,
    codigo_promocao varchar(20),
    metodo_pagamento int,
    status_pagamento int,
    data_pagamento timestamp,
    primary key (cpf_passageiro, nro_corrida),
    foreign key (codigo_promocao) references promocao(codigo),
    foreign key (status_pagamento) references statuspagamento(id_status),
    foreign key (metodo_pagamento) references metodopagamento(id_pagamento),
    foreign key (cpf_passageiro, nro_corrida) references passageirocorrida(cpf, nro_corrida)
);


create table apolice(
	nr_apolice int,
	valor_apolice float,
	vigencia_ano int,
	cnpj_seguradora varchar(14),
	renavam_veiculo varchar(9),
	primary key (nr_apolice),
	foreign key (renavam_veiculo) references veiculo(renavam),
	foreign key (cnpj_seguradora) references seguradora(cnpj)
);