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


------------------------------------------------------------------------------------------------


create or replace trigger triggerverificacupom
before insert or update on pagamentocorrida for each row
execute procedure verificacupom();
