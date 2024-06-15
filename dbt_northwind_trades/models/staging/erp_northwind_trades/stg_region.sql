with 
    src_region as (
        select 
            cast(region_id as int) as region_id
            , cast(region_description as varchar) as region_description
        from {{ source('erp_northwind_trades', 'region') }}
    )
select *  
from src_region
