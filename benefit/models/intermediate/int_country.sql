select 
    distinct country_name
from {{ ref('stg_commerce')}}
