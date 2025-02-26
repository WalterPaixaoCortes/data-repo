select to_date(concat(replace("Dia",'out','oct'),'/2024'), 'DD/Mon/YYYY') as dia,
       to_timestamp(concat(replace("Dia",'out','oct'),'/2024 ',"Hora Início"),'DD/Mon/YYYY HH24:MI') as hora_inicio,
       to_timestamp(concat(replace("Dia",'out','oct'),'/2024 ',Case
          When "Hora Fim" = '00:00' Then '23:59'
          Else "Hora Fim" 
        end), 'DD/Mon/YYYY HH24:MI') as hora_fim,
       "Atividade" as atividade,
       "Tipo de Atividade" as tipo_atividade
from {{ source('bronze', '9dias')}}
where "Dia" is not null