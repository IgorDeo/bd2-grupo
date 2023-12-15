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
   