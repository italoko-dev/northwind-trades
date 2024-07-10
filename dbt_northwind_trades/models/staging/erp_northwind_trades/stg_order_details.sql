with 
    src_orders_details as (
        select 
            cast(order_id as int) as order_id
            , cast(product_id as int) as product_id
            , cast(unit_price as decimal) as order_unit_price
            , cast(quantity as int) as quantity
            , cast(discount as decimal) as discount
        from {{ source('erp_northwind_trades', 'order_details') }}
    )
select *  
from src_orders_details
