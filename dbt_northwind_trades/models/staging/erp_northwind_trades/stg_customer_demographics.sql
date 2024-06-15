with 
    src_customer_demographics as (
        select 
            *
        from {{ source('erp_northwind_trades', 'customer_demographics') }}
    )
select *  
from src_customer_demographics
