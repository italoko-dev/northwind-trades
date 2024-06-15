with
    src_territories as (
        select 
            cast(territory_id as int) as territory_id
            , cast(territory_description as varchar) as territory_description
            , cast(region_id as int) as region_id
        from {{ source('erp_northwind_trades', 'territories') }}
    )
select *
from src_territories
