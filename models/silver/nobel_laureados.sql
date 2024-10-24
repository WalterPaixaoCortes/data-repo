select distinct id_laureado,
       nome_laureado,
       nullif(data_nascimento,'NA') as data_nascimento,
       nullif(cidade_nascimento,'NA') as cidade_nascimento,
       nullif(pais_nascimento,'NA') as pais_nascimento,
       nullif(sexo, 'NA') as sexo,
       nullif(data_morte,'NA') as data_morte,
       nullif(cidade_morte,'NA') as cidade_morte,
       nullif(pais_morte,'NA') as pais_morte,
       tipo_laureado
from {{ ref("nobel_norm")}}
