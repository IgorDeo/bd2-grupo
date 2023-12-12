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
nro_corrida int primary key,
cpf char(11), --Cpf motorista
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
    id_localizacao int primary key,
    nro_corrida int,
    momento_registro timestamp,
    latitude decimal(10, 8),
    longitude decimal(11, 8),
    foreign key (nro_corrida) references corrida(nro_corrida)
);

create table promocao(
    codigo varchar(20) primary key,
    descricao text,
    desconto float,
    data_inicio date,
    data_fim date
);

create table pagamentocorrida(
   	cpf_passageiro varchar(11),
    nro_corrida int,
    valor float,
    codigo_promocao varchar(20),
    metodo_pagamento varchar(50),
    status_pagamento varchar(20), -- Pendente, Concluído, Cancelado, etc.
    data_pagamento timestamp,
    primary key (cpf_passageiro, nro_corrida),
    foreign key (nro_corrida) references corrida(nro_corrida),
    foreign key (codigo_promocao) references promocao(codigo),
    foreign key (cpf_passageiro) references passageiro(cpf)
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


insert into tipos_avaliador(id_tipo, descricao) values (1, 'Motorista');
insert into tipos_avaliador(id_tipo, descricao) values (2, 'Passageiro');
	
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

insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (1, 'cpf1', '09:23:17', '09:43:34', 50.00, '2022-01-01', '2022-01-01', 'destino 1');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (2, 'cpf1', '10:03:22', '10:33:42', 45.00, '2022-02-02', '2022-02-02', 'destino 2');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (3, 'cpf2', '23:50:27', '01:12:34', 32.00, '2022-01-01', '2022-01-02','destino 3');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (4, 'cpf2', '02:22:13', '02:43:01', 24.00, '2022-01-02', '2022-01-02', 'destino 4');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (5, 'cpf2', '02:50:02', '03:05:43', 50.00, '2022-01-02', '2022-01-02', 'destino 5');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (6, 'cpf2', '03:23:17', '03:33:34', 55.00, '2022-01-02', '2022-01-02', 'destino 6');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (7, 'cpf3', '16:23:22', '16:35:34', 54.00, '2022-03-03', '2022-03-03', 'destino 7');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (8, 'cpf3', '16:53:17', '17:23:34', 23.00, '2022-03-03', '2022-03-03', 'destino 8');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (9, 'cpf3', '17:50:17', '18:23:34', 17.00, '2022-03-03', '2022-03-03', 'destino 9');
insert into corrida (nro_corrida, cpf, hora_inicio, hora_fim, preco_passageiro, data_inicio, data_fim, destino) values (10, 'cpf4', '12:23:17', '13:01:34', 25.00, '2022-03-03', '2022-03-03', 'destino 10');

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




-- Inserções para a tabela apolice
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (1, 1500.00, 2023, 'cnpj1', 'renavam1');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (2, 1200.00, 2023, 'cnpj2', 'renavam2');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (3, 1300.00, 2023, 'cnpj3', 'renavam3');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (4, 1400.00, 2023, 'cnpj4', 'renavam4');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (5, 1600.00, 2023, 'cnpj5', 'renavam5');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (6, 1100.00, 2023, 'cnpj6', 'renavam6');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (7, 1200.00, 2023, 'cnpj7', 'renavam7');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (8, 1300.00, 2023, 'cnpj8', 'renavam8');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (9, 1400.00, 2023, 'cnpj9', 'renavam9');
insert into apolice (nr_apolice, valor_apolice, vigencia_ano, cnpj_seguradora, renavam_veiculo) values (10, 1500.00, 2023, 'cnpj10', 'renavam10');













