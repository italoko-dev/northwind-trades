with 
    src_employee_territories as (
        select 
            cast(employee_id as int) as employee_id
            , cast(territory_id as varchar) as territory_id
        from {{ source('erp_northwind_trades', 'employee_territories') }}
    )
select *  
from src_employee_territories
