-- trabalho em grupo

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

	
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf1', 'rg1','rua 1','1999-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf2', 'rg2','rua 2','1998-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf3', 'rg3','rua 3','1997-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf4', 'rg4','rua 4','1996-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf5', 'rg5','rua 5','1995-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf6', 'rg6','rua 6','1994-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf7', 'rg7','rua 7','1994-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf8', 'rg8','rua 8','1994-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf9', 'rg9','rua 9','1994-12-08');
insert into pessoa (cpf,rg, endereco, datanascimento) values('cpf10', 'rg10','rua 10','1994-12-08');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf11', 'rg11', 'rua 11', '1999-11-11');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf12', 'rg12', 'rua 12', '2000-12-12');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf13', 'rg13', 'rua 13', '2001-01-13');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf14', 'rg14', 'rua 14', '2002-02-14');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf15', 'rg15', 'rua 15', '2003-03-15');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf16', 'rg16', 'rua 16', '2004-04-16');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf17', 'rg17', 'rua 17', '2005-05-17');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf18', 'rg18', 'rua 18', '2006-06-18');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf19', 'rg19', 'rua 19', '2007-07-19');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf20', 'rg20', 'rua 20', '2008-08-20');
insert into pessoa (cpf, rg, endereco, datanascimento) values ('cpf21', 'rg21', 'rua 21', '2009-09-21');


insert into motorista(cpf, conta_corrente, cnh ) values('cpf1', '1', '123'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf2', '2', '456'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf3', '3', '789'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf4', '4', '012'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf5', '5', '345'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf6', '6', '678'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf7', '7', '901'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf8', '8', '234'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf9', '9', '567'); 
insert into motorista (cpf, conta_corrente, cnh) values ('cpf10', '10', '890');

insert into atendente (cpf, formacao_escolar) values ('cpf11', 'formacao2'); 
insert into atendente (cpf, formacao_escolar) values ('cpf12', 'formacao3'); 
insert into atendente (cpf, formacao_escolar) values ('cpf13', 'formacao4'); 
insert into atendente (cpf, formacao_escolar) values ('cpf14', 'formacao5'); 
insert into atendente (cpf, formacao_escolar) values ('cpf15', 'formacao6'); 
insert into atendente (cpf, formacao_escolar) values ('cpf16', 'formacao7'); 
insert into atendente (cpf, formacao_escolar) values ('cpf1', 'formacao8'); 
insert into atendente (cpf, formacao_escolar) values ('cpf2', 'formacao9'); 
insert into atendente (cpf, formacao_escolar) values ('cpf6', 'formacao10'); 

insert into passageiro (cpf, cartao_credito) values ('cpf2', '67890');
insert into passageiro (cpf, cartao_credito) values ('cpf3', '24680');
insert into passageiro (cpf, cartao_credito) values ('cpf4', '13579');
insert into passageiro (cpf, cartao_credito) values ('cpf5', '86420');
insert into passageiro (cpf, cartao_credito) values ('cpf6', '97531');
insert into passageiro (cpf, cartao_credito) values ('cpf7', '123456');
insert into passageiro (cpf, cartao_credito) values ('cpf8', '654321');
insert into passageiro (cpf, cartao_credito) values ('cpf9', '987654');
insert into passageiro (cpf, cartao_credito) values ('cpf11', '123123');
insert into passageiro (cpf, cartao_credito) values ('cpf12', '123456');
insert into passageiro (cpf, cartao_credito) values ('cpf13', '654321');
insert into passageiro (cpf, cartao_credito) values ('cpf14', '987654');
insert into passageiro (cpf, cartao_credito) values ('cpf15', '123123');


insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj1','21', 'seguradora1','20540');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj2','22', 'seguradora2','20641');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj3','23', 'seguradora3','20642');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj4','24', 'seguradora4','20643');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj5','25', 'seguradora5','20644');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj6','26', 'seguradora6','20645');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj7','27', 'seguradora7','20646');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj8','28', 'seguradora8','20647');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj9','29', 'seguradora9','20648');
insert into seguradora(cnpj, telefone, nome, cep) values ('cnpj10','30', 'seguradora10','20649');


insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam1', 'cnpj1', 'cpf1', '2021', '2021-01-01', 25000.00, 'marca1', 'caracteristica1', 'modelo1',  'numero1');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam2', 'cnpj1', 'cpf1', '2020', '2020-02-02', 20000.00, 'marca2', 'caracteristica2', 'modelo2',  'numero2');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam3', 'cnpj1', 'cpf2', '2019', '2019-03-03', 18000.00, 'marca3', 'caracteristica3', 'modelo3','numero3');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam4', 'cnpj1', 'cpf3', '2018', '2018-04-04', 22000.00, 'marca4', 'caracteristica4', 'modelo4',  'numero4');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam5', 'cnpj2', 'cpf3', '2017', '2017-05-05', 27000.00, 'marca5', 'caracteristica5', 'modelo5',  'numero5');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam6', 'cnpj2', 'cpf4', '2016', '2016-06-06', 19000.00, 'marca6', 'caracteristica6', 'modelo6',  'numero6');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam7', 'cnpj3', 'cpf5', '2015', '2015-07-07', 24000.00, 'marca7', 'caracteristica7', 'modelo7',  'numero7');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam8', 'cnpj3', 'cpf6', '2014', '2014-08-08', 21000.00, 'marca8', 'caracteristica8', 'modelo8',  'numero8');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam9', 'cnpj3', 'cpf7', '2013', '2013-09-09', 26000.00, 'marca9', 'caracteristica9', 'modelo9',  'numero9');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam10', 'cnpj3', 'cpf8', '2012', '2012-10-10', 23000.00, 'marca10', 'caracteristica10', 'modelo10',  'numero10');

insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf1', '09:23:17', '09:43:34', 50.00, '2022-01-01', '2022-01-01', 'destino 1');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf1', '10:03:22', '10:33:42', 45.00, '2022-02-02', '2022-02-02', 'destino 2');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf2', '23:50:27', '01:12:34', 32.00, '2022-01-01', '2022-01-02','destino 3');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf2', '02:22:13', '02:43:01', 24.00, '2022-01-02', '2022-01-02', 'destino 4');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf2', '02:50:02', '03:05:43', 50.00, '2022-01-02', '2022-01-02', 'destino 5');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf2', '03:23:17', '03:33:34', 55.00, '2022-01-02', '2022-01-02', 'destino 6');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf3', '16:23:22', '16:35:34', 54.00, '2022-03-03', '2022-03-03', 'destino 7');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf3', '16:53:17', '17:23:34', 23.00, '2022-03-03', '2022-03-03', 'destino 8');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf3', '17:50:17', '18:23:34', 17.00, '2022-03-03', '2022-03-03', 'destino 9');
insert into corrida (cpf_motorista, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf4', '12:23:17', '13:01:34', 25.00, '2022-03-03', '2022-03-03', 'destino 10');

insert into passageirocorrida (nro_corrida, cpf) values (1, 'cpf4');
insert into passageirocorrida (nro_corrida, cpf) values (1, 'cpf3');
insert into passageirocorrida (nro_corrida, cpf) values (1, 'cpf2');
insert into passageirocorrida (nro_corrida, cpf) values (2, 'cpf2');
insert into passageirocorrida (nro_corrida, cpf) values (2, 'cpf3');
insert into passageirocorrida (nro_corrida, cpf) values (3, 'cpf6');
insert into passageirocorrida (nro_corrida, cpf) values (4, 'cpf8');
insert into passageirocorrida (nro_corrida, cpf) values (4, 'cpf9');
insert into passageirocorrida (nro_corrida, cpf) values (4, 'cpf11');
insert into passageirocorrida (nro_corrida, cpf) values (4, 'cpf5');
insert into passageirocorrida (nro_corrida, cpf) values (5, 'cpf4');
insert into passageirocorrida (nro_corrida, cpf) values (5, 'cpf7');
insert into passageirocorrida (nro_corrida, cpf) values (6, 'cpf4');
insert into passageirocorrida (nro_corrida, cpf) values (6, 'cpf3');
insert into passageirocorrida (nro_corrida, cpf) values (7, 'cpf7');
insert into passageirocorrida (nro_corrida, cpf) values (7, 'cpf3');
insert into passageirocorrida (nro_corrida, cpf) values (8, 'cpf8');
insert into passageirocorrida (nro_corrida, cpf) values (9, 'cpf9');
insert into passageirocorrida (nro_corrida, cpf) values (10, 'cpf5');

insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(1, 1 , 'pergunta1', 'resposta1' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(2, 1 , 'pergunta2', 'resposta2' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(3, 1 , 'pergunta3', 'resposta3' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(1, 2 , 'pergunta1', 'resposta1' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(2, 2 , 'pergunta2', 'resposta2' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(1, 3 , 'pergunta1', 'resposta1' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(1, 4 , 'pergunta1', 'resposta1' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(2, 4 , 'pergunta2', 'resposta2' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(3, 4 , 'pergunta3', 'resposta3' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(1, 5 , 'pergunta1', 'resposta1' );
insert into questionamento(nro_sequencial, nro_corrida, pergunta, resposta) values(2, 5 , 'pergunta2', 'resposta2' );

insert into suporteatendente(nro_corrida, cpf) values(1, 'cpf11');
insert into suporteatendente(nro_corrida, cpf) values(2, 'cpf12');
insert into suporteatendente(nro_corrida, cpf) values(3, 'cpf13');
insert into suporteatendente(nro_corrida, cpf) values(4, 'cpf14');
insert into suporteatendente(nro_corrida, cpf) values(5, 'cpf15');
insert into suporteatendente(nro_corrida, cpf) values(6, 'cpf16');
insert into suporteatendente(nro_corrida, cpf) values(7, 'cpf2');
insert into suporteatendente(nro_corrida, cpf) values(8, 'cpf2');
insert into suporteatendente(nro_corrida, cpf) values(9, 'cpf6');
insert into suporteatendente(nro_corrida, cpf) values(10, 'cpf11');

-- inserção na tabela tipos_avaliador
insert into tipos_avaliador (id_tipo, descricao) values(1, 'passageiro');
insert into tipos_avaliador (id_tipo, descricao) values(2, 'motorista');


-- inserção na tabela avaliacaocorrida
insert into avaliacaocorrida (nro_corrida, cpf_avaliador, tipo_avaliador, avaliacao, comentario) values (1, 'cpf4', 1, 4, 'ótima corrida');
insert into avaliacaocorrida (nro_corrida, cpf_avaliador, tipo_avaliador, avaliacao, comentario) values (2, 'cpf5', 2, 5, 'passageiro muito educado');
insert into avaliacaocorrida (nro_corrida, cpf_avaliador, tipo_avaliador, avaliacao, comentario) values (3, 'cpf6', 1, 3, 'corrida com atraso');
insert into avaliacaocorrida (nro_corrida, cpf_avaliador, tipo_avaliador, avaliacao, comentario) values (4, 'cpf12', 1, 3, 'corrida com atraso');


-- inserção na tabela localizacaoveiculo
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (1, 1, '2023-01-01 10:00:00', -23.550520, -46.633308);
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (2, 1, '2023-01-01 10:15:00', -23.545743, -46.636815);
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (3, 2, '2023-01-02 08:30:00', -23.567383, -46.654244);
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (1,3, '2023-01-01 10:00:00', -46.550520, -23.633308);
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (2,3, '2023-01-01 10:15:00', -47.545743, -24.636815);
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (3,3, '2023-01-02 08:30:00', -48.567383, -25.654244);
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (4,3, '2023-01-01 10:00:00', -49.550520, -26.633308);
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (5,3, '2023-01-01 10:15:00', -50.545743, -27.636815);
insert into localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) values (6, 3, '2023-01-02 08:30:00', -51.567383, -28.654244);


-- inserção na tabela promocao
insert into promocao (codigo, descricao, desconto, data_inicio, data_fim) values ('cod1', 'desconto 10%', 10.0, '2023-01-01', '2023-01-31');
insert into promocao (codigo, descricao, desconto, data_inicio, data_fim) values ('cod2', 'desconto 20%', 20.0, '2023-02-01', '2023-02-28');

insert into statuspagamento (id_status,tipo_status) values (1,'pendente');
insert into statuspagamento(id_status,tipo_status) values (2,'concluido');

insert into metodopagamento (id_pagamento,tipo_pagamento) values (1,'cartão de credito');
insert into metodopagamento (id_pagamento,tipo_pagamento) values (2,'cartão de débito');
insert into metodopagamento (id_pagamento,tipo_pagamento) values (3,'dinheiro');

insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf4', 1, 30.0, 'cod1', 1, 1, '2023-01-02 12:00:00');
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf2', 2, 25.0, 'cod2', 3, 2, null);
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf6', 3, 15.0, null, 2, 1, '2023-01-03 14:30:00');
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf3', 1, 30.0, 'cod1', 1, 1, '2023-01-02 12:00:00');
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf3', 2, 25.0, 'cod2', 3, 2, null);
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf8', 4, 15.0, null, 2, 1, '2023-01-03 14:30:00');
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf9', 4, 30.0, 'cod1', 1, 1, '2023-01-02 12:00:00');
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf11', 4, 25.0, 'cod2', 3, 2, null);
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf7', 5, 15.0, null, 2, 1, '2023-01-03 14:30:00');
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf4', 6, 30.0, 'cod1', 1, 1, '2023-01-02 12:00:00');
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf3', 7, 25.0, 'cod2', 3, 2, null);
insert into pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) values ('cpf8', 8, 15.0, null, 2, 1, '2023-01-03 14:30:00');




-- inserções para a tabela apolice
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (1, 1500.00, 2023, 'cnpj1', 'renavam1');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (2, 1200.00, 2023, 'cnpj2', 'renavam2');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (3, 1300.00, 2023, 'cnpj3', 'renavam3');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (4, 1400.00, 2023, 'cnpj4', 'renavam4');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (5, 1600.00, 2023, 'cnpj5', 'renavam5');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (6, 1100.00, 2023, 'cnpj6', 'renavam6');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (7, 1200.00, 2023, 'cnpj7', 'renavam7');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (8, 1300.00, 2022, 'cnpj8', 'renavam8');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (9, 1400.00, 2020, 'cnpj9', 'renavam9');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (10, 1500.00, 2021, 'cnpj10', 'renavam10');

--consultas


--consulta 1 e seus indices
--dado uma motorista quantas corridas ele fez e quanto faturou no total

explain analyse select motorista.cpf, count(distinct c.nro_corrida) as quantidade_corridas, sum(preco_passageiro)as faturamento_total
from corrida c
join passageirocorrida on c.nro_corrida = passageirocorrida.nro_corrida
join motorista on c.cpf = motorista.cpf
where motorista.cpf = 'cpf3'
group by motorista.cpf;

create index idx_passageirocorrida_nro_corrida on passageirocorrida using hash(nro_corrida);


--consulta 2 e seus indices
--dado um passageiro quantas corridas ele já fez e quanto ele gastou no total
explain analyse select p.cpf, count(c.nro_corrida) as quantidade_corridas, sum(c.preco_passageiro) as gasto_total
from corrida c
join passageirocorrida on c.nro_corrida = passageirocorrida.nro_corrida
join passageiro p on p.cpf = passageirocorrida.cpf
where passageirocorrida.cpf = 'cpf2'
group by p.cpf;

-- como estamos usando nro_corrida da tabela passageiro corrida novamente e ja criamos o indice na consulta anterior nao ciramos dnv
create index idx_passageiro_corrida_cpf on passageirocorrida using hash(cpf);


--consulta 3 e seus indices
--dado um passageiro qual a media de gasto dele em corridas
--nao precisar criar novos indices pois ja temos os necessarios criados
select p.cpf, count(c.nro_corrida) as quantidade_corridas, avg(c.preco_passageiro) as media_valor_corrida
from corrida c
join passageirocorrida on c.nro_corrida = passageirocorrida.nro_corrida
join passageiro p on p.cpf = passageirocorrida.cpf
where passageirocorrida.cpf = 'cpf2'
group by p.cpf;


--consulta 4 e seus indices
--todos o veiculos com seguro vigente
explain analyse select renavam_veiculo, vigencia_ano
from apolice
join veiculo on veiculo.renavam = apolice.renavam_veiculo
where apolice.vigencia_ano >= extract(year from current_date);

create index idx_apolice_vigencia_ano on apolice using btree(vigencia_ano);
create index idx_apolice_renavam on apolice using hash(renavam_veiculo);

--consulta 5 e seus indices
-- retorna a latitude e longitude de inicio e o fim de uma corrida.
explain analyse select
    c.nro_corrida,
    c.destino,
    lc_inicio.latitude as latitude_inicio,
    lc_inicio.longitude as longitude_inicio,
    lc_fim.latitude as latitude_fim,
    lc_fim.longitude as longitude_fim
from corrida c
join localizacaoveiculo lc_inicio on c.nro_corrida = lc_inicio.nro_corrida
join localizacaoveiculo lc_fim on c.nro_corrida = lc_fim.nro_corrida
where lc_inicio.id_localizacao = (
    select min(id_localizacao) from localizacaoveiculo where nro_corrida = c.nro_corrida
)
and lc_fim.id_localizacao = (
    select max(id_localizacao) from localizacaoveiculo where nro_corrida = c.nro_corrida
);

create index idx_localizacaoveiculo_nro_corrida on localizacaoveiculo using hash(nro_corrida);



--consulta 6 e seus indices
--dado que a plataforma aceita somente carros com no maximo 10 anos de uso 
--retorne os carros em ordem do mais proximos do tempo de vencimento
select
    renavam,
    marca,
    modelo,
    ano,
    extract(year from age(now(), data_compra::timestamp)) as idade_carro
from
    veiculo
where
    extract(year from age(now(), data_compra::timestamp)) <= 10
order by
    idade_carro desc;
   
create index idx_data_compra on veiculo using btree(data_compra);


--consulta 7 e seus indices
--dado uma corrida, quanto tempo ela durou, quanto cada passageiro pagou e qual foi o destino final
-- para esta consulta ja temos os indices criados anteriormente

explain analyse select
    corrida.nro_corrida,
    count(pc.cpf) as quantidade_passageiro,
    case
when hora_fim < hora_inicio then (hora_fim - hora_inicio) + interval '24
hours'
 else (hora_fim - hora_inicio)
 end as duracao,
    corrida.destino,
 	sum(corrida.preco_passageiro) as preco_corrida
from
    corrida 
join
    passageirocorrida pc on corrida.nro_corrida = pc.nro_corrida
where
    corrida.nro_corrida = pc.nro_corrida
group by corrida.nro_corrida
order by corrida.nro_corrida;

   
-- consulta 8 e seus indices
--todas as corridas que o pagamento foi concluidoi e foi utiliado um cupom de desconto\
select c.nro_corrida, sp.tipo_status, promocao.descricao, p.cpf_passageiro 
from corrida c
join pagamentocorrida p on c.nro_corrida = p.nro_corrida
join statuspagamento sp on p.status_pagamento = sp.id_status
join promocao on p.codigo_promocao = promocao.codigo
where p.status_pagamento = 2;

create index idx_pagamentocorrida_nro_corrida on pagamentocorrida using hash(nro_corrida);
create index idx_pagamentocorrida_id_status on pagamentocorrida using hash(status_pagamento);
create index idx_pagamentocorrida_codigo on pagamentocorrida using hash(codigo_promocao);

--consulta 9
select
    cast(t1.ticket_medio as numeric(10, 2)) as ticket_medio,
    t2.duracao_media
from
    (
        select
            round(avg(preco_passageiro)::numeric, 2) as ticket_medio
        from
            corrida
        join
            passageirocorrida on corrida.nro_corrida = passageirocorrida.nro_corrida
    ) as t1
cross join
    (
        select
            avg(duracao) as duracao_media
        from
            (
                select
                    extract(epoch from (
                        case
                            when hora_fim < hora_inicio then (hora_fim - hora_inicio) + interval '24 hours'
                            else (hora_fim - hora_inicio)
                        end
                    )) / 3600 as duracao
                from
                    corrida
            ) as d
    ) as t2;




--consulta 10: média de avaliacao de todos os motoristas
select
    c.cpf_motorista as cpf_motorista,
    avg(ac.avaliacao) as media_avaliacao
from
    corrida c
join
    avaliacaocorrida ac on c.nro_corrida = ac.nro_corrida
                      and ac.tipo_avaliador = 1 -- assuming id_tipo '1' corresponds to passageiro
group by
    c.cpf_motorista;
   

--procedure + trigger	

create or replace
function verificacupom()
returns trigger as $$
declare
    data_expiracao promocao.data_fim%type;
    cod_promocao promocao.codigo%type;

begin
	cod_promocao := new.codigo_promocao;

select
	data_fim
into
	data_expiracao
from
	promocao
where
	promocao.codigo = cod_promocao;

if data_expiracao is null then
        raise exception 'cupom inválido';

elsif data_expiracao < current_date then
        raise exception 'cupom expirado';
end if;

return new;
end;

$$ language plpgsql;



create or replace trigger triggerverificacupom
before insert or update on pagamentocorrida for each row
execute procedure verificacupom();

--procedure + trigger


	
create or replace function passageiroexiste(cpf_passageiro text) returns boolean as $$
declare
    existe boolean;
begin

    select exists (select 1 from passageiro where cpf = cpf_passageiro) into existe;

    return existe;
end;
$$ language plpgsql;


create or replace function criacorrida(cpf_passageiros text[], valor_passageiro float, destino text) returns void as $$
declare
    len_lista int;
    errs text[] := '{}';
    motorista_corrida motorista%rowtype;
    nro_nova_corrida int;
begin 
    len_lista := array_length(cpf_passageiros, 1);
   
   	if len_lista > 4 then
   		raise exception 'uma corrida não pode ter mais de 4 passageiros';
   	end if;
   
  	if len_lista = 0 or len_lista is null then
   		raise exception 'uma corrida precisa de pelo menos um passageiro';
   	end if;


    -- para cada cpf na lista de passageiros, verificar se o passageiro está cadastrado
    for i in 1..len_lista loop
        if not passageiroexiste(cpf_passageiros[i]) then
            errs := errs || format('%s', cpf_passageiros[i]);
        end if;
    end loop;

    -- se algum deles não for passageiro, acontecerá um erro
    if array_length(errs, 1) > 0 then
        raise exception 'cpfs não encontrados: %', errs;
    end if;

    -- seleciona um motorista aleatoriamente para a corrida
    select * from motorista into motorista_corrida
    order by random()
    limit 1;


    insert into corrida (cpf_motorista, hora_inicio, preco_passageiro, data_inicio, destino)
    values (motorista_corrida.cpf, current_time, valor_passageiro, current_date, destino)
    returning nro_corrida into nro_nova_corrida;

    for i in 1..len_lista loop
        insert into passageirocorrida (nro_corrida, cpf)
        values (nro_nova_corrida, cpf_passageiros[i]);
    end loop;



    raise notice 'corrida nro: % criada com sucesso. boa viagem!', nro_nova_corrida;


end;
$$ language plpgsql;





-- deve falhar pois cpf1 não é um passageiro
do $$
begin
    perform criacorrida(array['cpf1', 'cpf1322', 'cpf14243', 'cpf12'], 50.00,'universidade federal fluminense');
end;
$$;


-- deve falhar pois tem mais de 4 passageiros
do $$
begin
    perform criacorrida(array['cpf1', 'cpf1322', 'cpf14243', 'cpf12', 'cpf13'], 50.00, 'universidade federal fluminense');
end;
$$;

-- deve falhar pois não tem passageiros
do $$
begin
    perform criacorrida('{}', 50.00, 'universidade federal fluminense');
end;
$$;



-- deve criar corrida com sucesso;
do $$
begin
    perform criacorrida(array[ 'cpf12', 'cpf13'], 50.00, 'universidade federal fluminense');
end;
$$;

create or replace
function validarseguro()
returns trigger as $$
declare
    renavam_carro  veiculo.renavam%type;
	vigencia_apolice apolice.vigencia_ano%type;   	
begin
	renavam_carro := new.renavam;
	
select
	vigencia_ano
from
	apolice
	into vigencia_apolice
where
	apolice.renavam_veiculo = renavam_carro;

if vigencia_apolice is null then
        raise exception 'nao podemos criar um carro sem uma apolice de seguro';

elsif vigencia_apolice < extract(year from current_date) then
        raise exception 'apolice expirada viculo precisa estar com a apolice em dia';
end if;
return new;
end;
$$ language plpgsql;



create or replace trigger triggervalidarseguro
before insert or update on veiculo for each row
execute procedure validarseguro();

--deve falhar pois nao existe apolice valida para o renavam deste veiculo
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam11', 'cnpj1', 'cpf1', '2021', '2021-01-01', 25000.00, 'marca1', 'caracteristica1', 'modelo1',  'numero1');

--deve falhar pois o ano de vigencia e menor que a data atual
insert into apolice (nr_apolice,valor_apolice,vigencia_ano,cnpj_seguradora,renavam_veiculo) values(13,2000,2020,'cnpj2','renavam22');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam22', 'cnpj1', 'cpf1', '2021', '2021-01-01', 25000.00, 'marca1', 'caracteristica1', 'modelo1',  'numero1');

--Deve funcionar pois a apolice esta com a vigencia em dia
insert into apolice (nr_apolice,valor_apolice,vigencia_ano,cnpj_seguradora,renavam_veiculo) values(13,2000,2020,'cnpj2','renavam14');


create or replace function pagarcorrida(n_cpf_passageiro text, n_nro_corrida int, n_codigo_promocao text, n_metodo_pagamento int) returns void as $$
declare
    valor_pago float;
   	valor_original float;
   	desconto_cupom float; 	
begin	
	select desconto into desconto_cupom from promocao p where p.codigo = n_codigo_promocao;
	select preco_passageiro into valor_original from corrida c where c.nro_corrida = n_nro_corrida;
	perform p.cpf from corrida c join passageirocorrida p on p.nro_corrida = c.nro_corrida where p.cpf = n_cpf_passageiro and c.nro_corrida = n_nro_corrida;
	if not found then
		raise exception 'passageiro % nao participou da corrida %', n_cpf_passageiro, n_nro_corrida;
	end if;

	valor_pago := valor_original;
	if desconto_cupom >= 0 then
		valor_pago := valor_original * (1 - (desconto_cupom/100));
	end if;
	
	insert into pagamentocorrida (cpf_passageiro, nro_corrida, codigo_promocao, metodo_pagamento, valor) values (n_cpf_passageiro, n_nro_corrida, n_codigo_promocao, n_metodo_pagamento, valor_pago);   
	
	raise notice 'pagamento criado com sucesso';
end;
$$ language plpgsql;

do $$
begin
    perform pagarcorrida('cpf12', 11, 'cod1',1);
end;
$$;


-- view 1:
create view detalhescorridas as select
      c.nro_corrida,
    c.cpf_motorista as motorista_cpf,
    c.destino,
    sum(c.preco_passageiro) as preco_da_corrida,
    case
        when hora_fim < hora_inicio then (hora_fim - hora_inicio) + interval '24 hours'
        else (hora_fim - hora_inicio)
    end as duracao,
    count(pc.cpf) as quantidade_passageiro,
    array_agg(pc.cpf) as passageiros,
    ac.avaliacao,
    ac.comentario,
    m2.tipo_pagamento  
from
    corrida c
join
    motorista m on c.cpf_motorista = m.cpf
join
    passageirocorrida pc on c.nro_corrida = pc.nro_corrida
join
    passageiro p2 on pc.cpf = p2.cpf
join pagamentocorrida p on p.nro_corrida = c.nro_corrida
join metodopagamento m2 on m2.id_pagamento = p.metodo_pagamento 
left join
    avaliacaocorrida ac on c.nro_corrida = ac.nro_corrida
group by
    c.nro_corrida, c.cpf_motorista, c.destino, hora_fim, hora_inicio, ac.avaliacao, ac.comentario, m2.tipo_pagamento 
order by nro_corrida;



-- view 2
create or replace view corridasemandamento as select 
   m.cpf as cpf__motorista,
    m.conta_corrente as conta_corrente_motorista,
    c.nro_corrida,
    c.hora_inicio,
    c.data_inicio,
    c.destino,
    array_agg(pc.cpf) as quantidade_passageiros
from
    motorista m
join
    pessoa p on m.cpf = p.cpf
join
    corrida c on m.cpf = c.cpf_motorista
join
    passageirocorrida pc on c.nro_corrida = pc.nro_corrida
join
    passageiro p_pass on pc.cpf = p_pass.cpf
where
    c.data_fim is null
group by m.cpf,c.nro_corrida;