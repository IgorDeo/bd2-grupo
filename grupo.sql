-- Trabalho em grupo

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
cpf char(11), 
hora_inicio time,
hora_fim time,
preco_passageiro float,
data_inicio date,
data_fim date,
destino varchar(100),
foreign key (cpf) references motorista(cpf)
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



-- Novas tabelas
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
    tipo_avaliador int, -- Passageiro ou Motorista
    avaliacao int, -- Pode ser uma pontuação de 1 a 5, por exemplo
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

insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf1', '09:23:17', '09:43:34', 50.00, '2022-01-01', '2022-01-01', 'destino 1');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf1', '10:03:22', '10:33:42', 45.00, '2022-02-02', '2022-02-02', 'destino 2');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf2', '23:50:27', '01:12:34', 32.00, '2022-01-01', '2022-01-02','destino 3');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf2', '02:22:13', '02:43:01', 24.00, '2022-01-02', '2022-01-02', 'destino 4');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf2', '02:50:02', '03:05:43', 50.00, '2022-01-02', '2022-01-02', 'destino 5');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf2', '03:23:17', '03:33:34', 55.00, '2022-01-02', '2022-01-02', 'destino 6');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf3', '16:23:22', '16:35:34', 54.00, '2022-03-03', '2022-03-03', 'destino 7');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf3', '16:53:17', '17:23:34', 23.00, '2022-03-03', '2022-03-03', 'destino 8');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf3', '17:50:17', '18:23:34', 17.00, '2022-03-03', '2022-03-03', 'destino 9');
insert into corrida (cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values ('cpf4', '12:23:17', '13:01:34', 25.00, '2022-03-03', '2022-03-03', 'destino 10');

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

-- Inserção na tabela tipos_avaliador
INSERT INTO tipos_avaliador (id_tipo, descricao) VALUES(1, 'Passageiro');
INSERT INTO tipos_avaliador (id_tipo, descricao) VALUES(2, 'Motorista');


-- Inserção na tabela avaliacaocorrida
INSERT INTO avaliacaocorrida (nro_corrida, cpf_avaliador, tipo_avaliador, avaliacao, comentario) VALUES (1, 'cpf4', 1, 4, 'Ótima corrida');

INSERT INTO avaliacaocorrida (nro_corrida, cpf_avaliador, tipo_avaliador, avaliacao, comentario) VALUES (2, 'cpf5', 2, 5, 'Motorista muito educado');

INSERT INTO avaliacaocorrida (nro_corrida, cpf_avaliador, tipo_avaliador, avaliacao, comentario) VALUES (3, 'cpf6', 1, 3, 'Corrida com atraso');


-- Inserção na tabela localizacaoveiculo
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (1, 1, '2023-01-01 10:00:00', -23.550520, -46.633308);
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (2, 1, '2023-01-01 10:15:00', -23.545743, -46.636815);
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (3, 2, '2023-01-02 08:30:00', -23.567383, -46.654244);
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (1,3, '2023-01-01 10:00:00', -46.550520, -23.633308);
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (2,3, '2023-01-01 10:15:00', -47.545743, -24.636815);
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (3,3, '2023-01-02 08:30:00', -48.567383, -25.654244);
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (4,3, '2023-01-01 10:00:00', -49.550520, -26.633308);
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (5,3, '2023-01-01 10:15:00', -50.545743, -27.636815);
INSERT INTO localizacaoveiculo (id_localizacao, nro_corrida, momento_registro, latitude, longitude) VALUES (6, 3, '2023-01-02 08:30:00', -51.567383, -28.654244);



-- Inserção na tabela promocao
INSERT INTO promocao (codigo, descricao, desconto, data_inicio, data_fim) VALUES ('cod1', 'Desconto 10%', 10.0, '2023-01-01', '2023-01-31');
INSERT INTO promocao (codigo, descricao, desconto, data_inicio, data_fim) VALUES ('cod2', 'Desconto 20%', 20.0, '2023-02-01', '2023-02-28');

insert into statuspagamento (id_status,tipo_status) values (1,'pendente');
insert into statuspagamento(id_status,tipo_status) values (2,'concluido');

insert into metodopagamento (id_pagamento,tipo_pagamento) values (1,'Cartão de Credito');
insert into metodopagamento (id_pagamento,tipo_pagamento) values (2,'Cartão de Débito');
insert into metodopagamento (id_pagamento,tipo_pagamento) values (3,'Dinheiro');

INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf4', 1, 30.0, 'cod1', 1, 1, '2023-01-02 12:00:00');
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf2', 2, 25.0, 'cod2', 3, 2, NULL);
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf6', 3, 15.0, NULL, 2, 1, '2023-01-03 14:30:00');
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf3', 1, 30.0, 'cod1', 1, 1, '2023-01-02 12:00:00');
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf3', 2, 25.0, 'cod2', 3, 2, NULL);
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf8', 4, 15.0, NULL, 2, 1, '2023-01-03 14:30:00');
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf9', 4, 30.0, 'cod1', 1, 1, '2023-01-02 12:00:00');
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf11', 4, 25.0, 'cod2', 3, 2, NULL);
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf7', 5, 15.0, NULL, 2, 1, '2023-01-03 14:30:00');
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf4', 6, 30.0, 'cod1', 1, 1, '2023-01-02 12:00:00');
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf3', 7, 25.0, 'cod2', 3, 2, NULL);
INSERT INTO pagamentocorrida (cpf_passageiro, nro_corrida, valor, codigo_promocao, metodo_pagamento, status_pagamento, data_pagamento) VALUES ('cpf8', 8, 15.0, NULL, 2, 1, '2023-01-03 14:30:00');







-- Inserções para a tabela apolice
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

--Consultas


--Consulta 1 e seus indices
--dado uma motorista quantas corridas ele fez e quanto faturou no total

explain analyse SELECT motorista.cpf, COUNT(DISTINCT c.nro_corrida) as quantidade_corridas, SUM(preco_passageiro)as faturamento_total
FROM corrida c
JOIN passageirocorrida ON c.nro_corrida = passageirocorrida.nro_corrida
JOIN motorista ON c.cpf = motorista.cpf
WHERE motorista.cpf = 'cpf3'
GROUP BY motorista.cpf;

CREATE INDEX idx_passageirocorrida_nro_corrida ON passageirocorrida using hash(nro_corrida);


--Consulta 2 e seus indices
--dado um passageiro quantas corridas ele já fez e quanto ele gastou no total
explain analyse SELECT p.cpf, COUNT(c.nro_corrida) as quantidade_corridas, SUM(c.preco_passageiro) as gasto_total
FROM corrida c
JOIN passageirocorrida ON c.nro_corrida = passageirocorrida.nro_corrida
JOIN passageiro p ON p.cpf = passageirocorrida.cpf
WHERE passageirocorrida.cpf = 'cpf2'
GROUP BY p.cpf;

-- como estamos usando nro_corrida da tabela passageiro corrida novamente e ja criamos o indice na consulta anterior nao ciramos dnv
CREATE INDEX idx_passageiro_corrida_cpf ON passageirocorrida using hash(cpf);


--Consulta 3 e seus indices
--Dado um passageiro qual a media de gasto dele em corridas
--nao precisar criar novos indices pois ja temos os necessarios criados
SELECT p.cpf, COUNT(c.nro_corrida) as quantidade_corridas, AVG(c.preco_passageiro) as media_valor_corrida
FROM corrida c
JOIN passageirocorrida ON c.nro_corrida = passageirocorrida.nro_corrida
JOIN passageiro p ON p.cpf = passageirocorrida.cpf
WHERE passageirocorrida.cpf = 'cpf2'
GROUP BY p.cpf;


--Consulta 4 e seus indices
--todos o veiculos com seguro vigente
explain analyse SELECT renavam_veiculo, vigencia_ano
FROM apolice
JOIN veiculo ON veiculo.renavam = apolice.renavam_veiculo
WHERE apolice.vigencia_ano >= EXTRACT(YEAR FROM CURRENT_DATE);

CREATE INDEX idx_apolice_vigencia_ano ON apolice USING BTREE(vigencia_ano);
create index idx_apolice_renavam on apolice using hash(renavam_veiculo);

--consulta 5 e seus indices
-- Retorna a latitude e longitude de inicio e o fim de uma corrida.
explain analyse SELECT
    c.nro_corrida,
    c.destino,
    lc_inicio.latitude AS latitude_inicio,
    lc_inicio.longitude AS longitude_inicio,
    lc_fim.latitude AS latitude_fim,
    lc_fim.longitude AS longitude_fim
FROM corrida c
JOIN localizacaoveiculo lc_inicio ON c.nro_corrida = lc_inicio.nro_corrida
JOIN localizacaoveiculo lc_fim ON c.nro_corrida = lc_fim.nro_corrida
WHERE lc_inicio.id_localizacao = (
    SELECT MIN(id_localizacao) FROM localizacaoveiculo WHERE nro_corrida = c.nro_corrida
)
AND lc_fim.id_localizacao = (
    SELECT MAX(id_localizacao) FROM localizacaoveiculo WHERE nro_corrida = c.nro_corrida
);

create index idx_localizacaoveiculo_nro_corrida on localizacaoveiculo using hash(nro_corrida);



--consulta 6 e seus indices
--Dado que a plataforma aceita somente carros com no maximo 10 anos de uso 
--retorne os carros em ordem do mais proximos do tempo de vencimento
SELECT
    renavam,
    marca,
    modelo,
    ano,
    EXTRACT(YEAR FROM AGE(NOW(), data_compra::timestamp)) AS idade_carro
FROM
    veiculo
WHERE
    EXTRACT(YEAR FROM AGE(NOW(), data_compra::timestamp)) <= 10
ORDER BY
    idade_carro DESC;
   
CREATE INDEX idx_data_compra ON veiculo using btree(data_compra);


--consulta 7 e seus indices
--dado uma corrida, quanto tempo ela durou, quanto cada passageiro pagou e qual foi o destino final
-- para esta consulta ja temos os indices criados anteriormente

explain analyse SELECT
    corrida.nro_corrida,
    count(pc.cpf) AS quantidade_passageiro,
    CASE
WHEN hora_fim < hora_inicio THEN (hora_fim - hora_inicio) + INTERVAL '24
hours'
 ELSE (hora_fim - hora_inicio)
 END AS duracao,
    corrida.destino,
 	sum(corrida.preco_passageiro) as preco_corrida
FROM
    corrida 
JOIN
    passageirocorrida pc ON corrida.nro_corrida = pc.nro_corrida
WHERE
    corrida.nro_corrida = pc.nro_corrida
group by corrida.nro_corrida
order by corrida.nro_corrida;

   
-- consulta 8 e seus indices
--Todas as corridas que o pagamento foi concluidoi e foi utiliado um cupom de desconto\
SELECT c.nro_corrida, sp.tipo_status, promocao.descricao, p.cpf_passageiro 
FROM corrida c
JOIN pagamentocorrida p ON c.nro_corrida = p.nro_corrida
JOIN statuspagamento sp ON p.status_pagamento = sp.id_status
JOIN promocao ON p.codigo_promocao = promocao.codigo
WHERE p.status_pagamento = 2;

create index idx_pagamentocorrida_nro_corrida on pagamentocorrida using hash(nro_corrida);
create index idx_pagamentocorrida_id_status on pagamentocorrida using hash(status_pagamento);
create index idx_pagamentocorrida_codigo on pagamentocorrida using hash(codigo_promocao);


--consulta 9
WITH MotoristaAvaliacao AS (
    SELECT
        m.cpf AS cpf_motorista,
        AVG(ac.avaliacao) AS media_avaliacao
    FROM
        motorista m
    JOIN avaliacaocorrida ac ON m.cpf = ac.cpf_avaliador
    WHERE
        ac.tipo_avaliador = 2
    GROUP BY
        m.cpf
)
SELECT
    p.cpf,
    p.nome,
    ma.media_avaliacao,
    COUNT(c.nro_corrida) AS total_corridas
FROM
    motorista p
JOIN motorista m ON p.cpf = m.cpf
JOIN corrida c ON m.cpf = c.cpf
JOIN MotoristaAvaliacao ma ON m.cpf = ma.cpf_motorista
GROUP BY
    p.cpf, p.nome, ma.media_avaliacao
ORDER BY
    ma.media_avaliacao DESC
LIMIT 3;




--consulta 10











--procedure + trigger	

create or replace
function verificaCupom()
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
        raise exception 'Cupom inválido';

elsif data_expiracao < CURRENT_DATE then
        raise exception 'Cupom expirado';
end if;

return new;
end;

$$ language plpgsql;
CREATE or replace TRIGGER triggerVerificaCupom
BEFORE INSERT OR UPDATE ON pagamentocorrida FOR EACH ROW
EXECUTE PROCEDURE verificaCupom();

---FALTA DUAS QUERYS 3 PROCEDURES 2 VIEWS
-- PROCEDURE DE VEICULO DEVE TER QUE ALTERAR A TABELA DE VEICULO PARA FAZE FUNCIONAR.
--CRIAR PROCEDURE PARA CRIAR VEICULO JUNTO DE UMA APOLICE
--CRIAR TRIGGER E PROCEDURE PARA ATUALIZAR MEDIA DE AVALIACAO 


CREATE OR REPLACE FUNCTION passageiroExiste(cpf_passageiro TEXT) RETURNS BOOLEAN AS $$
DECLARE
    existe BOOLEAN;
BEGIN

    SELECT EXISTS (SELECT 1 FROM passageiro WHERE cpf = cpf_passageiro) INTO existe;

    RETURN existe;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION criaCorrida(cpf_passageiros TEXT[], valor_passageiro FLOAT, destino TEXT) RETURNS VOID AS $$
DECLARE
    len_lista INT;
    errs TEXT[] := '{}';
    motorista_corrida motorista%rowtype;
    nro_nova_corrida INT;
BEGIN 
    len_lista := array_length(cpf_passageiros, 1);
   
   	if len_lista > 4 then
   		raise exception 'Uma corrida não pode ter mais de 4 passageiros';
   	end if;
   
  	if len_lista = 0 or len_lista is null then
   		raise exception 'Uma corrida precisa de pelo menos um passageiro';
   	end if;


    -- Para cada CPF na lista de passageiros, verificar se o passageiro está cadastrado
    FOR i IN 1..len_lista LOOP
        IF NOT passageiroExiste(cpf_passageiros[i]) then
            errs := errs || FORMAT('%s', cpf_passageiros[i]);
        END IF;
    END LOOP;

    -- Se algum deles não for passageiro, acontecerá um erro
    IF array_length(errs, 1) > 0 THEN
        RAISE EXCEPTION 'CPFs não encontrados: %', errs;
    END IF;

    -- Seleciona um motorista aleatoriamente para a corrida
    SELECT * FROM motorista INTO motorista_corrida
    ORDER BY RANDOM()
    LIMIT 1;


    INSERT INTO corrida (cpf, hora_inicio, preco_passageiro, data_inicio, destino)
    VALUES (motorista_corrida.cpf, CURRENT_TIME, valor_passageiro, current_date, destino)
    RETURNING nro_corrida INTO nro_nova_corrida;

    FOR i IN 1..len_lista LOOP
        INSERT INTO passageirocorrida (nro_corrida, cpf)
        VALUES (nro_nova_corrida, cpf_passageiros[i]);
    END LOOP;



    RAISE NOTICE 'Corrida nro: % criada com sucesso. Boa viagem!', nro_nova_corrida;


END;
$$ LANGUAGE plpgsql;





-- Deve falhar pois cpf1 não é um passageiro
DO $$
BEGIN
    PERFORM criaCorrida(ARRAY['cpf1', 'cpf1322', 'cpf14243', 'cpf12'], 50.00,'Universidade Federal Fluminense');
END;
$$;


-- Deve falhar pois tem mais de 4 passageiros
DO $$
BEGIN
    PERFORM criaCorrida(ARRAY['cpf1', 'cpf1322', 'cpf14243', 'cpf12', 'cpf13'], 50.00, 'Universidade Federal Fluminense');
END;
$$;

-- Deve falhar pois não tem passageiros
DO $$
BEGIN
    PERFORM criaCorrida('{}', 50.00, 'Universidade Federal Fluminense');
END;
$$;



-- Deve criar corrida com sucesso;
DO $$
BEGIN
    PERFORM criaCorrida(ARRAY[ 'cpf12', 'cpf13'], 50.00, 'Universidade Federal Fluminense');
END;
$$;

select * from corrida;
select * from passageirocorrida;


create or replace
function validarSeguro()
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
        raise exception 'Nao podemos criar um carro sem uma apolice de seguro';

elsif vigencia_apolice < EXTRACT(YEAR FROM CURRENT_DATE) then
        raise exception 'Apolice expirada viculo precisa estar com a apolice em dia';
end if;
return new;
end;
$$ language plpgsql;



CREATE or replace TRIGGER triggerValidarSeguro
BEFORE INSERT OR UPDATE ON veiculo FOR EACH ROW
EXECUTE PROCEDURE validarSeguro();

--deve falhar pois nao existe apolice valida para o renavam deste veiculo
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam11', 'cnpj1', 'cpf1', '2021', '2021-01-01', 25000.00, 'marca1', 'caracteristica1', 'modelo1',  'numero1');

--deve falhar pois o ano de vigencia e menor que a data atual
insert into apolice (nr_apolice,valor_apolice,vigencia_ano,cnpj_seguradora,renavam_veiculo) values(13,2000,2020,'cnpj2','renavam22');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam22', 'cnpj1', 'cpf1', '2021', '2021-01-01', 25000.00, 'marca1', 'caracteristica1', 'modelo1',  'numero1');

--Deve funcionar pois a apolice esta com a vigencia em dia
insert into apolice (nr_apolice,valor_apolice,vigencia_ano,cnpj_seguradora,renavam_veiculo) values(15,2000,2023,'cnpj2','renavam14');
insert into veiculo (renavam, cnpj, cpf, ano, data_compra, preco, marca, caracteristica, modelo,  numero) values ('renavam14', 'cnpj1', 'cpf1', '2021', '2021-01-01', 25000.00, 'marca1', 'caracteristica1', 'modelo1',  'numero1');









