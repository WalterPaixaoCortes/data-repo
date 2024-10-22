select show_id, regexp_split_to_table(country, E',') as country
from {{ ref('netflix_titles_norm')}}