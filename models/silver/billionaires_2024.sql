with raw_data as (
  select b.*, replace(replace("2024 Net Worth", '$', ''),'B','')::float as NetWorthNbr
from {{ source('bronze', '2024_Billionaire_List') }} b
)
select 
rank() over (order by NetWorthNbr DESC) as Rank,
b.*
from raw_data b