select show_id, regexp_split_to_table(movie_cast, E',') as actor
from {{ ref('netflix_titles_norm')}}