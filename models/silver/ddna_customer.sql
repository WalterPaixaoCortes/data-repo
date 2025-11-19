select *
from {{ source('bronze', 'ddna_customer') }}