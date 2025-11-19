select *
from {{ source('bronze', 'ddna_event') }}