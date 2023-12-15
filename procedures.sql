
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

------------------------------------------------------------------------------------------------

create or replace function passageiroexiste(cpf_passageiro text) returns boolean as $$
declare
    existe boolean;
begin

    select exists (select 1 from passageiro where cpf = cpf_passageiro) into existe;

    return existe;
end;
$$ language plpgsql;

------------------------------------------------------------------------------------------------

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


------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------

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