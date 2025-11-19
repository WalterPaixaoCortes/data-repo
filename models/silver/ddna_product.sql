select *
from {{ source('bronze', 'ddna_product') }}