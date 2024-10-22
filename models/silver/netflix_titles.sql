select show_id, type, title, date_added, release_year, rating, duration
from {{ ref('netflix_titles_norm') }}