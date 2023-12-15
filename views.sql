
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

------------------------------------------------------------------------------------------------


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