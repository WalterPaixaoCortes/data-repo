select show_id, type, title, date_added, release_year, rating, duration
from {{ source('src', 'netflix_titles') }}