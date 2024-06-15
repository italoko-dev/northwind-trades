with 
    src_customer_customer_demo as (
        select 
            *
        from {{ source('erp_northwind_trades', 'customer_customer_demo') }}
    )
select *  
from src_customer_customer_demo
