select *
from {{ source('bronze', '2022_Billionaire_List') }}