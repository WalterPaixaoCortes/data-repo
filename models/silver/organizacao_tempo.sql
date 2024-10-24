select rd.*, 
       round(extract(epoch from (hora_fim - hora_inicio))/3600,2) as duracao,
       Case when atividade in ('Reservado Família','Tarefas Famíliua') then 1
            else 0 
       end as tempo_familia
from {{ ref("9dias_norm")}} rd