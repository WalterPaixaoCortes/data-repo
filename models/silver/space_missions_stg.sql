select *
from {{ source('bronze', 'space_missions') }}