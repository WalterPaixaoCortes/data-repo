with raw_data as (
select id,
       nome,
       nivel,
       sexo,
       string_to_array(replace(replace(replace(tipos,'[',''),']',''), '''',''),',') as tipos,
       string_to_array(replace(replace(replace(movimentos,'[',''),']',''), '''',''),',') as movimentos,
       habilidade,
       natureza,
       string_to_array(replace(replace(stats,'[',''),']',''),',') as stats,
       imagem,
       legendario,
       mitico,
       geracao,
       replace(danos,'''','"')::json as danos

from {{ source('src','pokemons')}})
select id,
       nome,
       nivel,
       sexo,
       tipos[1] as tipo_1,
       tipos[2] as tipo_2,
       movimentos,
       habilidade,
       natureza,
       stats[1] as hp,
       stats[2] as ataque,
       stats[3] as defesa,
       stats[4] as defesa_especial, 
       stats[5] as ataque_especial,
       stats[6] as velocidade,      
       imagem,
       legendario,
       mitico,
       geracao,
       danos->'recebe_dano_duplo' as recebe_dano_duplo,
       danos->'recebe_dano_metade' as recebe_dano_metade,
       danos->'recebe_dano_zero' as recebe_dano_zero,
       danos->'causa_dano_duplo' as causa_dano_duplo,
       danos->'causa_dano_metade' as causa_dano_metade,
       danos->'causa_dano_zero' as causa_dano_zero
from raw_data