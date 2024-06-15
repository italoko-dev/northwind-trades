with 
    src_categories as (
        select 
            cast(category_id as int) as category_id
            , cast(category_name as varchar) as category_name
            , cast(description as varchar) as description
            -- , picture 
        from {{ source('erp_northwind_trades', 'categories') }}
    )
select *  
from src_categories
