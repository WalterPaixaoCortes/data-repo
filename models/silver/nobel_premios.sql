select ano_premiacao,
       categoria,
       premio,
       motivo,
       compartilhamento,
       id_laureado
from {{ ref("nobel_norm")}}