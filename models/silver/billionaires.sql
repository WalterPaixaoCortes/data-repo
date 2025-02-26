select 2022 as year, b.*
from {{ref("billionaires_2022")}} b
union all
select 2024 as year, 
	   b2.rank, 
	   b2."Name", 
	   b2.networthnbr as networth, 
	   replace(b2."Age",'N/A','-1')::int, 
	   split_part(b2."Residence",',',2) as country, 
	   b2."Source of Wealth" as source, 
	   b2."Industry" 
from {{ref("billionaires_2024")}} b2