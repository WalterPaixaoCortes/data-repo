select show_id, regexp_split_to_table(director, E',') as director
from {{ ref('netflix_titles_norm')}}