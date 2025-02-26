select  upper(show_id) as show_id, 
        upper(type) as type, 
        upper(title) as title,
        upper(coalesce(nullif(director,'-'),'not informed')) as director,
        upper("cast") as movie_cast,
        upper(coalesce(nullif(country,'-'),'not informed')) as country,
        to_date(date_added,'Month dd, yyyy') as date_added, 
        release_year, 
        upper(rating) as rating, 
        upper(duration) as duration,
        upper(listed_in) as listed_in,
        upper(description) as description
from {{ source('bronze', 'netflix_titles') }}