select show_id, regexp_split_to_table(listed_in, E',') as category
from {{ ref('netflix_titles_norm')}}